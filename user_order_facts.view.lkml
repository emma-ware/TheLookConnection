view: user_order_facts {

 derived_table: {
   sql:
   select user_id, order_count, case
       when order_count between 0 and 2 then 'New Customer'
       when order_count between 3 and 9 then 'Loyal Customer'
       when order_count >= 10 then 'Extremely Loyal Customer'
       end as lifetime_orders
   from (select user_id, count(id) as order_count
       from demo_db.orders
       group by 1) as orderst;;
 }
#from (demo_db) straight from the connection - raw sql
#native derived table - specify lookml


dimension: user_type {
  description: "0-2 orders is a New Customer, 3-9 is a Loyal Customer, 10+ orders is an Extremely Loyal Customer"
  sql: ${TABLE}.lifetime_orders ;;
}

dimension: user_id {
  sql: ${TABLE}.user_id ;;
}

dimension: user_order_count {
  sql: ${TABLE}.order_count ;;
}

measure: count {
  type: count
  drill_fields: [user_id]
}

#   derived_table: {
#     sql:
#       SELECT
#         user_id,
#         MIN(DATE(created_at)) AS first_order_date
#       FROM
#         orders
#       GROUP BY
#         user_id ;;
#   }


  # # You can specify the table name if it's different from the view name:
  # sql_table_name: my_schema_name.tester ;;
  #
  # # Define your dimensions and measures here, like this:
  # dimension: user_id {
  #   description: "Unique ID for each user that has ordered"
  #   type: number
  #   sql: ${TABLE}.user_id ;;
  # }
  #
  # dimension: lifetime_orders {
  #   description: "The total number of orders for each user"
  #   type: number
  #   sql: ${TABLE}.lifetime_orders ;;
  # }
  #
  # dimension_group: most_recent_purchase {
  #   description: "The date when each user last ordered"
  #   type: time
  #   timeframes: [date, week, month, year]
  #   sql: ${TABLE}.most_recent_purchase_at ;;
  # }
  #
  # measure: total_lifetime_orders {
  #   description: "Use this for counting lifetime orders across many users"
  #   type: sum
  #   sql: ${lifetime_orders} ;;
  # }
}

# view: user_order_facts {
#   # Or, you could make this view a derived table, like this:
#   derived_table: {
#     sql: SELECT
#         user_id as user_id
#         , COUNT(*) as lifetime_orders
#         , MAX(orders.created_at) as most_recent_purchase_at
#       FROM orders
#       GROUP BY user_id
#       ;;
#   }
#
#   # Define your dimensions and measures here, like this:
#   dimension: user_id {
#     description: "Unique ID for each user that has ordered"
#     type: number
#     sql: ${TABLE}.user_id ;;
#   }
#
#   dimension: lifetime_orders {
#     description: "The total number of orders for each user"
#     type: number
#     sql: ${TABLE}.lifetime_orders ;;
#   }
#
#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }
#
#   measure: total_lifetime_orders {
#     description: "Use this for counting lifetime orders across many users"
#     type: sum
#     sql: ${lifetime_orders} ;;
#   }
# }
