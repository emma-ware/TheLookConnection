view: user_order_facts {

 derived_table: {
  persist_for: "4 hours"
  indexes: ["user_id", "order_count","lifetime_orders"]
   sql:
   select orderst.user_id,
          order_count,
          usr.first_name,
          usr.last_name,
          usr.gender,
          usr.zip,
          usr.country,
          usr.state,
          usr.city,
          usr.age,
          orderst.created_at,
          o.id as order_id,
          case
              when order_count between 0 and 2 then 'New Customer'
              when order_count between 3 and 9 then 'Loyal Customer'
              when order_count >= 10 then 'Extremely Loyal Customer'
              end as lifetime_orders
   from (select user_id, id, created_at, count(id) as order_count from demo_db.orders group by 1) as orderst
      join demo_db.users usr on orderst.user_id = usr.id
      join demo_db.orders o on usr.id = o.user_id

      ;;
 }
#from (demo_db) straight from the connection - raw sql
#native derived table - specify lookml

dimension: user_full_name {
  type: string
  sql: concat(${TABLE}.first_name, ' ', ${TABLE}.last_name);;
}

measure: count_measure_number {
  type: number
  sql: ${TABLE}.order_count ;;
}

#   measure: count_measure_count {
#     type: count
#     sql: ${TABLE}.order_count ;;
#   }

  measure: count_measure_sum {
    type: sum
    sql: ${TABLE}.order_count ;;
  }

dimension: user_type {
  type: string
  description: "0-2 orders is a New Customer, 3-9 is a Loyal Customer, 10+ orders is an Extremely Loyal Customer"
  sql: ${TABLE}.lifetime_orders ;;
}

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

dimension: user_id {
  type: number
  sql: ${TABLE}.user_id ;;
}

dimension: positive_negative {
  type: number
  sql: CASE WHEN  ${TABLE}.user_id < 500 THEN ${TABLE}.user_id
  ELSE (${TABLE}.user_id * -1) END
  ;;
}

measure: negative_numbers {
  type: sum
  sql: ${positive_negative} ;;
}

dimension: full_size_image {
  type: number
  sql: ${user_id} ;;
  html: <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/3d/LARGE_elevation.jpg/800px-LARGE_elevation.jpg" /> ;;
}

dimension: user_order_count {
  type: number
  sql: ${TABLE}.order_count ;;
}


  dimension: order_created {
    type: date
    sql: ${TABLE}.created_at ;;
  }

  measure: first_order {
    type: date
    sql: min(${order_created}) ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: state {
    type: string
    map_layer_name: us_states
    sql: ${TABLE}.state ;;
  }

  dimension: age_tier {
    type: tier
    tiers: [10, 20, 30, 40, 50, 60, 70, 80]
    style: integer
    sql: ${age} ;;
  }

  dimension: zip {
    type: zipcode
    map_layer_name: us_zipcode_tabulation_areas
    sql: ${TABLE}.zip ;;
  }


measure: count {
  type: count
  drill_fields: [user_id]
}

  measure: extra_loyal_users_count {
    type: count
    filters: {
      field: user_type
      value: "Extremely Loyal Customer"
    }
  }

  measure: new_users_count {
    type: count
    filters: {
      field: user_type
      value: "New Customer"
    }
  }

  measure: loyal_users_count {
    type: count
    filters: {
      field: user_type
      value: "Loyal Customer"
    }
  }

  measure: total_users {
    type: count_distinct
    sql: ${user_id} ;;
  }

  measure: percent_extremely_loyal{
    type: number
    value_format_name: percent_2
    sql: ${extra_loyal_users_count}/${total_users} ;;
  }

  measure: percent_new{
    type: number
    value_format_name: percent_2
    sql: ${new_users_count}/${total_users} ;;
  }

  measure: percent_loyal{
    type: number
    value_format_name: percent_2
    sql: ${loyal_users_count}/${total_users} ;;
  }



measure: html_test {
  type: number
  sql: ${age} ;;
  html:
{% if value > 50 %}


<div class="image">

      <img src="https://upload.wikimedia.org/wikipedia/en/1/1f/Green_Arrow_Up%28new%29.png" height=60 width=60 alt="" />

    {{rendered_value}}

</div>


  {% elsif value < 50 %}
  <p><img src="https://upload.wikimedia.org/wikipedia/commons/0/04/Red_Arrow_Down.svg" height=60 width=60>{{rendered_value}}</p>
  {% else %}
  <p>{{rendered_value}}</p>
  {% endif %}

  </body>;;
}


#
#   measure: html_test {
#     type: number
#     sql: ${age} ;;
#     html:
#     {% if value > 50 %}
#        <p><img src="https://upload.wikimedia.org/wikipedia/en/1/1f/Green_Arrow_Up%28new%29.png" height=60 width=60>{{rendered_value}}</p>
#
#       {% elsif value < 50 %}
#       <p><img src="https://upload.wikimedia.org/wikipedia/commons/0/04/Red_Arrow_Down.svg" height=60 width=60>{{rendered_value}}</p>
#       {% else %}
#       <p>{{rendered_value}}</p>
#       {% endif %}
#
#       </body>;;
#   }



#   <p><img src="https://upload.wikimedia.org/wikipedia/en/1/1f/Green_Arrow_Up%28new%29.png" height=60 width=60>{{rendered_value}}</p>

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
