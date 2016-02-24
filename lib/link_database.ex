defmodule LinkShortener.LinkDatabase do
  @code_length 12
  @con_cache_table :link_cache

  def get(code) do
    ConCache.get(@con_cache_table, code)
  end

  def add_link(code, url) do
    ConCache.dirty_put(@con_cache_table, code, url)
  end

  def code(url) do
    :erlang.md5(url)
    |> Base.encode16(case: :lower)
    |> String.slice(0, @code_length)
  end
end
