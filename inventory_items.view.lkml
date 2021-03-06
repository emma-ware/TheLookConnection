view: inventory_items {
  sql_table_name: demo_db.inventory_items ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
  }

  measure: median_cost {
    type: median
    sql: ${cost} ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: product_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.product_id ;;
  }

  #dimension: time_in_inventory {
  #  type:  date_hour
  #  sql:  ${sold_raw} - ${created_raw};;
  #}

  dimension: days_in_inventory {
    description: "Number of Days an item has been in inventory, null if unsold"
    type: number
    sql: DATEDIFF(${sold_raw}, ${created_date});;
  }

  dimension_group: sold {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.sold_at ;;
  }

  dimension: is_sold {
    type: yesno
    sql: ${TABLE}.sold_at IS NOT NULL ;;
  }

#   measure: transaction_count {
#     type: sum
#     sql: CASE WHEN ${TABLE}.sold_at > ${TABLE}.created_at THEN 1
#     else null end;;
#   }

  measure: count {
    type: count
    drill_fields: [order_items.count, orders.product_id]
  }

  measure: average_days_in_inventory {
  type: average
  sql: ${days_in_inventory} ;;
  value_format: "00.0"
  }

}
