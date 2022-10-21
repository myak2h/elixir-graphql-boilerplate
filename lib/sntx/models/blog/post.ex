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

  def create(attrs) do
    %Post{}
    |> changeset(attrs)
    |> Repo.insert()
  end

  def update(post, attrs) do
    post
    |> changeset(attrs)
    |> Repo.update()
  end

  def get(id) do
    case Repo.get_by(Post, id: id) do
      nil -> {:error, dgettext("global", "Post not found")}
      post -> {:ok, post}
    end
  end
end
