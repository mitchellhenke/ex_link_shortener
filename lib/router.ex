defmodule LinkShortener.Router do
  use Plug.Router

  plug Plug.Parsers, parsers: [:urlencoded, :multipart]
  plug :match
  plug :dispatch

  post "/shorten_url" do
    base_url = Application.get_env(:link_shortener, :base_url)
    url = Dict.get(conn.params, "url", base_url)
    |> make_url

    code = LinkShortener.LinkDatabase.code(url)
    LinkShortener.LinkDatabase.add_link(code, url)

    short_url = base_url <> "/#{code}"

    send_resp(conn, 200, short_url)
  end

  get "/" do
    send_resp(conn, 200, index_html)
  end

  get "/:code" do
    LinkShortener.LinkDatabase.get(code)
    |> handle_redirect(conn)
  end

  match _ do
    send_resp(conn, 404, "Not Found :(")
  end

  defp handle_redirect(link, conn) when is_binary(link) do
    put_resp_header(conn, "location", link)
    |> send_resp(301, "")
  end

  defp handle_redirect(_, conn) do
    send_resp(conn, 404, "Not Found :(")
  end

  defp index_html do
    """
    <!DOCTYPE html>
    <html>
    <body>
      <form action="/shorten_url" method="post">
        Link to be shortened:<br>
        <input name="url" type="text"><br>
        <input type="submit" value="Submit">
      </form>
   </body>
    """
  end

  defp make_url("http" <> _rest = url), do: url
  defp make_url(url), do: "http://" <> url
end
