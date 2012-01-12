Shop Finder Api
====================

How To
---------------------

Model

> 
> class Item
>   include Mongoid::Document
>   include ShopFinderApi::Document
> 
> 
> Item.search keyword : ShopFinder から検索
>   -> { items: items, total_pages: total_pages, total_results: total_results }
> 
> Item.find_by_product_id(product_id): プロダクトIDから検索 -> なければShopFinderから検索して作成
>   -> item
> 

