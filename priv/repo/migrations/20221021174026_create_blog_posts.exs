defmodule Sntx.Repo.Migrations.CreateBlogPosts do
  use Ecto.Migration

  def change do
    create table(:blog_posts, primary_key: false) do
      add :id, :binary_id, primary_key: true, default: fragment("gen_random_uuid()")
      add :title, :string, null: false
      add :body, :string, null: false

      add :author, references(:user_accounts, type: :binary_id)
    end
  end
end
