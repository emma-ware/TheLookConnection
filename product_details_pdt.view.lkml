view: product_details_pdt {

  derived_table: {
    persist_for: "4 hours"
    indexes: ["order_count"]
    sql:
       select orderst.product_id,
              order_count,
              case
                  when order_count between 0 and 2 then 'Unpopular'
                  when order_count between 3 and 18 then 'Common'
                  when order_count between 19 and 30 then 'Popular'
                  when order_count >= 31 then 'Extremely Popular'
                  end as product_popularity
       from (select ii.product_id, count(o.id) as order_count from demo_db.orders o
            join demo_db.order_items oi on oi.order_id = o.id
            join demo_db.inventory_items ii on ii.id = oi.inventory_item_id
      group by 1) as orderst
          ;;
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
