defmodule SntxGraph.BlogTypes do
  use Absinthe.Schema.Notation

  import AbsintheErrorPayload.Payload
  alias Sntx.Models.Blog.Post

  payload_object(:blog_post_payload, :blog_post)

  object :blog_post do
    field :title, :string
    field :body, :string
    field :author, :string, resolve: &Post.public_author/3
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
  end
end
