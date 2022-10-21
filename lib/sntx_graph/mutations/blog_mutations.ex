defmodule SntxGraph.BlogMutations do
  use Absinthe.Schema.Notation

  alias SntxGraph.Middleware.Authorize
  alias SntxGraph.BlogResolver

  object :blog_mutations do
    field :blog_post_create, :blog_post_payload do
      arg :input, non_null(:blog_post_input)

      middleware(Authorize)
      resolve(&BlogResolver.create_post/2)
    end

    field :blog_post_update, :blog_post_payload do
      arg :id, non_null(:uuid4)
      arg :input, non_null(:blog_post_input)

      middleware(Authorize)
      resolve(&BlogResolver.update_post/2)
    end

    field :blog_post_delete, :boolean_payload do
      arg :id, non_null(:uuid4)

      middleware(Authorize)
      resolve(&BlogResolver.delete_post/2)
    end
  end
end
