# coding: UTF-8

# モデルに ShopFinder 機能を追加
# @author Nozomu Kanechika
# @since 0.0.1

require 'shop_finder_api/document/structure'
require 'shop_finder_api/document/klass'

module ShopFinderApi
  module Document
    extend ActiveSupport::Concern

    # includes
    # @author Nozomu Kanechika
    # @since 0.0.1
    include ShopFinderApi::Document::Structure # field定義
    include ShopFinderApi::Document::Klass # クラスメソッド

  end
end
