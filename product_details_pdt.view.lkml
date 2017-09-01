view: product_details_pdt {
  view_label: "Product Details"

  derived_table: {
   sql:
       select orderst.product_id,
              order_count,
              p.category,
              p.item_name,
              p.brand,
              p.retail_price,
              p.department,
              ii.id,
              ii.created_at,
              ii.sold_at,
              ii.cost,
              oi.order_id,
              oi.returned_at,
              case
                  when order_count between 0 and 2 then 'Unpopular'
                  when order_count between 3 and 14 then 'Common'
                  when order_count between 15 and 30 then 'Popular'
                  when order_count >= 31 then 'Extremely Popular'
                  end as product_popularity
       from (select ii.product_id, count(o.id) as order_count from demo_db.orders o
            join demo_db.order_items oi on oi.order_id = o.id
            join demo_db.inventory_items ii on ii.id = oi.inventory_item_id
      group by 1) as orderst
              join products p on orderst.product_id = p.id
              join inventory_items ii on p.id = ii.product_id
              join order_items oi on oi.inventory_item_id = ii.id
          ;;
  }

  dimension: item_name {
    type: string
    sql: ${TABLE}.item_name ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: product_id {
    type: number
    sql: ${TABLE}.product_id ;;
  }

  dimension: product_order_count{
    type: number
    sql: ${TABLE}.order_count ;;
  }

  dimension: product_popularity {
    type: string
    sql: ${TABLE}.product_popularity ;;
  }


  }
