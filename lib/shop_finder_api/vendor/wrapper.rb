# coding: UTF-8

# Shop Finder Wrapper
# @aurhor Nozomu Kanechika
# @since 0.0.1

# 必要ライブラリをrequire 
require 'nokogiri'
require 'uri'
require 'net/http'
module ShopFinderApi
  module Vendor
    module Wrapper

      # 基本定数
      SHOP_FINDER_SEARCH_URL  = 'http://www.shoppingfinder.jp/product-search/xml'
      SHOP_FINDER_PRODUCT_URL = 'http://ln.shoppingfinder.jp/product-search/xml'
      SERVICE_ID      = 'RI,YA,YS,AJ,VA'
      #SERVICE_ID      = 'AJ,VA'

      class << self

        # 検索
        # @author Nozomu Kanechika
        # @since 0.0.1
        def search keyword
          return '' if keyword.blank?
          # データ取得
          xml = Nokogiri::XML(http_request('get',SHOP_FINDER_SEARCH_URL,{ keyword: keyword, serviceId: SERVICE_ID }).body)
          
          # hash 作成 { items: items, total_pages: total_pages, total_results: total_results }
          ## header 情報
          total_results = xml.search("//Service/TotalResults").text
          total_pages   = xml.search("//Service/TotalPages").text
          ## product 情報
          items = []
          xml.search("//Product").each do |x|
            items << xml_to_item_hash(x)
          end
          return { items: items ,total_results: total_results ,total_pages: total_pages }
        end

        # プロダクトIDから検索
        # @author Nozomu Kanechika
        # @since 0.0.1
        def find_by_product_id p_id,s_id
          return nil if p_id.blank?
          xml = Nokogiri::XML(http_request('get',SHOP_FINDER_PRODUCT_URL,{ productId: p_id, serviceId: s_id }).body)

          # hash 作成（Item の fields { product_id: ....,  } ）
          return xml_to_item_hash(xml.search("//Product"))
        end


        # http://d.hatena.ne.jp/koseki2/20090903/RubyHttp
        # @author こせきさん
        # @since 0.0.1
        def http_request(method, uri, query_hash = {}, user = nil, pass = nil)
          uri = URI.parse(uri) if uri.is_a? String
          method = method.to_s.strip.downcase
          query_string = (query_hash||{}).map{|k,v|
            URI.encode(k.to_s) + "=" + URI.encode(v.to_s)
          }.join("&")

          if method == "post"
            args = [Net::HTTP::Post.new(uri.path), query_string]
          else
            args = [Net::HTTP::Get.new(uri.path + (query_string.empty? ? "" : "?#{query_string}"))]
          end
          args[0].basic_auth(user, pass) if user

          Net::HTTP.start(uri.host, uri.port) do |http|
            return http.request(*args)
          end
        end

        # xml to item fields
        # @author Nozomu Kanechika
        # @since 0.0.1
        def xml_to_item_hash x
          #{ :product_id  => "#{x.search("./Id")[0]["s"]}-#{x.search("./Code").text}",
          { :product_id  => x.search("./Id").text,
            :service_id  => x.search("./Id")[0]["s"],
            :name        => x.search("./Name").text,
            :description => x.search("./Description").text,
            :price       => x.search("./Price").text,
            :code        => x.search("./Code").text,
            :jan         => x.search("./Jan").text,
            :isbn        => x.search("./Isbn").text,
            :asin        => x.search("./Id").text, # 後で変更
            :point       => x.search("./Point").text,
            :url         => x.search("./Url").text,
            :images      => { :small  => x.search("./Image/Small").text,
                              :medium => x.search("./Image/Medium").text,
                              :large  => x.search("./Image/Large").text },
            :category    => { :id   => x.search("./Category/Id").text,
                              :name => x.search("./Category/Name").text },
            :store       => { :id   => x.search("./Store/Id").text,
                              :name => x.search("./Store/Name").text,
                              :url  => x.search("./Store/Url").text },
            :other       => {}  }
        end

      end

    end
  end
end
