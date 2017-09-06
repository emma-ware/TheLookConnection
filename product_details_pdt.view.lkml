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
              ord.created_at as order_created,
              case
                  when order_count between 0 and 2 then 'Unpopular'
                  when order_count between 3 and 14 then 'Common'
                  when order_count between 15 and 30 then 'Popular'
                  when order_count >= 31 then 'Extremely Popular'
                  end as product_popularity
       from (select ii.product_id, count(oi.id) as order_count from demo_db.orders o
            join demo_db.order_items oi on oi.order_id = o.id
            join demo_db.inventory_items ii on ii.id = oi.inventory_item_id
      group by 1) as orderst
              join products p on orderst.product_id = p.id
              join inventory_items ii on p.id = ii.product_id
              join order_items oi on oi.inventory_item_id = ii.id
              join orders ord on oi.order_id = ord.id
          ;;
  }

  dimension: created_at {
    type: date
    sql: ${TABLE}.created_at ;;
  }

  dimension: order_created {
    type: date
    sql: ${TABLE}.order_created ;;
  }

  dimension: first_order {
    type: date
    sql: min(${order_created}) ;;
  }

  dimension: returned_at {
    type: date
    sql: ${TABLE}.returned_at ;;
  }

  dimension: order_id {
    type: date
    sql: ${TABLE}.order_id ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
    value_format_name: usd
  }

  dimension: sold_at {
    type: date
    sql: ${TABLE}.sold_at ;;
  }

  dimension: inventory_item_id {
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
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
    drill_fields: [item_name, category, product_order_count]
  }

  dimension: profit {
    type: number
    description: "Item profit"
    sql: ${retail_price} - ${cost} ;;
    value_format_name: usd
  }

  dimension: product_order_count{
    type: number
    sql: ${TABLE}.order_count ;;
  }

  dimension: product_popularity {
    type: string
    sql: ${TABLE}.product_popularity ;;
  }

  measure: count{
    type: count
  }

  }
