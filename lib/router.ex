defmodule LinkShortener.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  post "/make_short_link" do
    {:ok, url, conn} = read_body(conn)

    code = LinkShortener.LinkDatabase.code(url)
    LinkShortener.LinkDatabase.add_link(code, url)

    base_url = Application.get_env(:link_shortener, :base_url)
    short_url = base_url <> "/#{code}"

    send_resp(conn, 200, short_url)
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
end
