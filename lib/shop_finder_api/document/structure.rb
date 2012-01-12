# coding: UTF-8

# field定義
# @author Nozomu Kanechika
# @since 0.0.1
module ShopFinderApi
  module Document
    module Structure
      extend ActiveSupport::Concern
      included do

        # fields
        field :product_id
        field :name
        field :description
        field :price
        field :code
        field :jan
        field :isbn
        field :point
        field :url

        ## images
        field :images ,type: Hash # small ,medium ,large

        ## category
        field :category ,type: Hash # id ,name

        ## store
        field :store ,type: Hash # id ,name ,url

        ## other
        field :other ,type: Hash # その他詰め込む

      end
    end
  end
end
