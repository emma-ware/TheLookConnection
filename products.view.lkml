view: products {
  sql_table_name: demo_db.products ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    drill_fields: [brand, retail_price]
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
    html: <p style="font-size:30px"> {{value}} </p> ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: item_name {
    type: string
    sql: ${TABLE}.item_name ;;
  }

  dimension: rank {
    type: number
    sql: ${TABLE}.rank ;;
  }

  dimension: retail_price {
    type: number
    sql: CASE WHEN ${TABLE}.retail_price < 900 then ${TABLE}.retail_price
          else 900 end;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
  }

  measure: brand_count {
    type: count_distinct
    sql: ${TABLE}.brand ;;
    drill_fields: [brand]
  }

  measure: count {
    type: count
    drill_fields: [id, item_name, inventory_items.count]
  }
}
