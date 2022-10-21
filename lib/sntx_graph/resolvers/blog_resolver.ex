defmodule SntxGraph.BlogResolver do
  import SntxWeb.Payload

  alias Sntx.Models.Blog.Post

  def list_posts(_args, _), do: {:ok, Post.list()}

  def get_post(%{id: id}, _), do: Post.get(id) |> validate_found()

  def create_post(%{input: input}, %{context: ctx}) do
    case Post.create(ctx.user.id, input) do
      {:ok, post} -> {:ok, post}
      error -> mutation_error_payload(error)
    end
  end

  def update_post(%{id: id, input: input}, %{context: ctx}) do
    with {:ok, post} <- Post.get(id) |> validate_found(),
         :ok <- authorize_post(post, ctx.user.id),
         {:ok, post} <- Post.update(post, input) do
      {:ok, post}
    else
      error -> mutation_error_payload(error)
    end
  end

  def delete_post(%{id: id}, %{context: ctx}) do
    with {:ok, post} <- Post.get(id) |> validate_found(),
         :ok <- authorize_post(post, ctx.user.id),
         {:ok, _post} <- Post.delete(post) do
      {:ok, true}
    else
      error -> mutation_error_payload(error)
    end
  end

  defp authorize_post(post, user_id) do
    if post.author_id == user_id do
      :ok
    else
      {:error, default_error(:no_access)}
    end
  end
end
