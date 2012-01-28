# coding: UTF-8

# クラスメソッド
# @aurhor Nozomu Kanechika
# @since 0.0.1

require 'shop_finder_api/vendor/wrapper'

module ShopFinderApi
  module Document
    module Klass
      extend ActiveSupport::Concern
      module ClassMethods

        # ShopFinder から検索
        # @aurhor Nozomu Kanechika
        # @since 0.0.1
        def search k
          ShopFinderApi::Vendor::Wrapper.search(k)
        end


        # プロダクトIDから検索 -> なければShopFinderから検索して作成
        # @aurhor Nozomu Kanechika
        # @since 0.0.1
        def find_by_product_id p_id,s_id
          item = where(product_id: p_id, service_id: s_id).first
          return item unless item.nil?
          item = ShopFinderApi::Vendor::Wrapper.find_by_product_id(p_id,s_id)
          return item.nil? ? nil : create(item)
        end


      end
    end
  end
end
