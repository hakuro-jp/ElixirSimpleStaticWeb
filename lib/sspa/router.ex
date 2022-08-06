defmodule Sspa.Router do
  use Plug.Router

  plug(Plug.Logger)
  plug(:redirect_index)
  plug(:match)
  plug(:dispatch)

  forward("/static", to: Sspa.StaticResources)

  match _ do
    send_resp(conn, 404, "not found")
  end

  def redirect_index(%Plug.Conn{path_info: path} = conn, _opts) do
    case path do
      [] ->
        %{conn | path_info: ["static", "index.html"]}

      ["app.js"] ->
                %{conn | path_info: ["static", "app.js"]}

      ["vendor.js"] ->
                %{conn | path_info: ["static", "vendor.js"]}
      _ ->
        conn
    end
  end
end
