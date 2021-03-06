view: order_items {
  sql_table_name: demo_db.order_items ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  filter: category_count_picker {
    description: "Use with the Category Count measure"
    type: string
    suggest_dimension: products.category
  }

  measure: category_count {
    description: "Use with the Category Count Picker filter-only field"
    type: sum
    sql:
      CASE
        WHEN {% condition category_count_picker %} ${products.category} {% endcondition %}
        THEN 1
        ELSE 0
      END
    ;;
  }


  dimension_group: returned {
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
    sql: DATE_FORMAT(${TABLE}.returned_at, "%m%d%Y") ;;
  }


  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  measure: count {
    type: count
    drill_fields: [id, inventory_items.id, orders.id]
  }

  measure: cheapest_item {
    type: min
    sql: ${sale_price} ;;
    value_format_name: usd
    drill_fields: [products.id, products.item_name, products.retail_price] #still need to work on
  }

  measure: most_expensive_item {
    type: max
    sql: ${sale_price} ;;
    value_format_name: usd
  }

  measure: total_sales {
    description: "Total Sales"
    type: sum
    sql: ${TABLE}.sale_price ;;
    value_format_name: usd
  }

  measure: total_cost {
    type: sum
    sql: ${inventory_items.cost} ;;
    value_format_name: usd
  }

  measure: avg_revenue {
    type:  average
    sql: ${TABLE}.sale_price - ${inventory_items.cost} ;;
    value_format_name: usd
  }


  measure: profit {
    type:  sum
    sql: ${TABLE}.sale_price - ${inventory_items.cost} ;;
  }

  measure: total_profit {
    description: "All dat Money"
    type: number
    sql: ${total_sales}-${total_cost} ;;
    value_format_name: usd
  }

#   measure: west_revenue {
#     type: sum
#     sql: ${TABLE}.sale_price;;
#     filters: {
#       field: users.region
#       value: "West"
#     }
#     value_format_name: usd
#   }

#   measure: west_percent_of_rev {
#     description: "The West Percent of Total Revenue"
#     type: number
#     sql: ${west_revenue} / ${total_profit} ;;
#     value_format_name: percent_2
#   }


}
