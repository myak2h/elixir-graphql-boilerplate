defmodule Sntx.Models.Blog.Post do
  use Sntx.Models
  use Waffle.Ecto.Schema

  import Ecto.Changeset
  import SntxWeb.Gettext

  alias __MODULE__, as: Post
  alias Sntx.Models.User.Account
  alias Sntx.Repo

  schema "blog_posts" do
    field :title, :string
    field :body, :string
    belongs_to :author, Account

    timestamps()
  end

  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :body])
    |> validate_required([:title, :body])
  end

  def create(author_id, attrs) do
    %Post{author_id: author_id}
    |> changeset(attrs)
    |> Repo.insert()
  end

  def update(post, attrs) do
    post
    |> changeset(attrs)
    |> Repo.update()
  end

  def delete(post) do
    post
    |> Repo.delete()
  end

  def list(), do: Repo.all(Post)

  def get(id), do: Repo.get(Post, id)

  def public_author(post, _args, _ctx) do
    %Post{author: author} = Repo.preload(post, [:author])

    {:ok, "#{author.first_name} #{author.last_name}"}
  end
end
