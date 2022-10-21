defmodule SntxGraph.BlogQueries do
  use Absinthe.Schema.Notation

  alias SntxGraph.BlogResolver

  object :blog_queries do
    @desc "Current account. Null when user is guest/banned/deleted"
    field :blog_posts, list_of(:blog_post) do
      resolve(&BlogResolver.list_posts/2)
    end

    field :blog_post, :blog_post do
      arg :id, :uuid4
      resolve(&BlogResolver.get_post/2)
    end
  end
end
