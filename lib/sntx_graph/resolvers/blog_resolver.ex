defmodule SntxGraph.BlogResolver do
  import SntxWeb.Payload

  alias Sntx.{Repo, Guardian, UserMailer}
  alias Sntx.Models.User.{Account, Activations, Auth, Passwords}
  alias Sntx.Models.Blog.Post

  def list_posts(args, _), do: {:ok, Post.list()}
  def get_post(%{id: id}, _), do: {:ok, Post.get(id)}
end
