view: orders {
  sql_table_name: demo_db.orders ;;

#  derived_table: {
#    sql:
#    select case
#        when order_count between 0 and 2 then 'New Customer'
#        when order_count >= 4 then 'Loyal Customer'
#        end as lifetime_orders
#    from (select user_id, count(id) as order_count
#        from demo_db.orders
#        group by 1) as orderst;;
#  }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: orders_yesno {
    type: yesno
    sql: ${id} > 100 ;;
  }

  dimension: explore_drill {
    type: string
    sql: ${status} ;;
    link: {
      label: "YEE"
      url: "/explore/emmas_first_look_model/orders?fields=orders.id,orders.created_date&f[orders.status]={{rendered_value}}&limit=500&query_timezone=America%2FLos_Angeles&vis=%7B%22type%22%3A%22table%22%2C%22show_view_names%22%3Atrue%2C%22show_row_numbers%22%3Atrue%2C%22truncate_column_names%22%3Afalse%2C%22hide_totals%22%3Afalse%2C%22hide_row_totals%22%3Afalse%2C%22table_theme%22%3A%22editable%22%2C%22limit_displayed_rows%22%3Afalse%2C%22enable_conditional_formatting%22%3Afalse%2C%22conditional_formatting_include_totals%22%3Afalse%2C%22conditional_formatting_include_nulls%22%3Afalse%7D&filter_config=%7B%22orders.status%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%22{{rendered_value}}%22%7D%2C%7B%7D%5D%2C%22id%22%3A1%2C%22error%22%3Afalse%7D%5D%7D&origin=share-expanded"
    }
#     link: {
#       url: ""
#     }
#     html: <a href="https://localhost:9999/explore/emmas_first_look_model/orders?fields=orders.id,orders.created_date&f[orders.status]={{rendered_value}}&limit=500&query_timezone=America%2FLos_Angeles&vis=%7B%7D&filter_config=%7B%22orders.status%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%22{{rendered_value}}%22%7D%2C%7B%7D%5D%2C%22id%22%3A1%2C%22error%22%3Afalse%7D%5D%7D&origin=share-expanded">{{rendered_value}}</a> ;;
   }


dimension: double_if_html {
  type: string
  sql: ${status} ;;
  html:
  {% if orders.user_id._value > 100 %}
  <a href="https://www.google.com/">
  {% endif %}
  {% if value == 'complete' %}
      <font color="#ff0000"> {{rendered_value}} </font>
    {% endif %} </a> ;;

}

  parameter: orders_param {
    type: number
  }

dimension: param_test {
  type: string
  sql: {% parameter orders_param  %} ;;
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
      year,
      week_of_year,
      hour_of_day,
      day_of_week,
      day_of_week_index
    ]
    sql: ${TABLE}.created_at ;;
 # sql: DATE(CONVERT_TZ(${TABLE}.created_at ,'UTC','America/Los_Angeles')) ;;
  }

filter: date_start {
  type: date
}

filter: date_end {
  type: date
}

dimension: hour_of_day_and_day_of_week {
  order_by_field: created_day_of_week_index
  sql: concat(${created_day_of_week}, ' - ', ${created_hour_of_day}) ;;
}

dimension: repeating_weeks {
  sql: ${created_date} ;;
  html: {{ hour_of_day_and_day_of_week._rendered_value }} ;;
  }

measure: date_sum {
  type: sum
  sql: CASE WHEN {% condition date_start %} ${created_date} {% endcondition %}
  THEN 1 else 0 END
  ;;
}

 measure: first_day_of_week {
   type: number
  sql: CASE WHEN ${created_date} = ${created_week} then ${count}
  else null end;;
  }



  dimension: time_period {
    type: string
    sql: CASE WHEN ${created_date} >= (TIMESTAMP '2017-05-15') AND ${created_date} < (TIMESTAMP '2017-06-18')) THEN 'bin1 name'
              WHEN ${created_date} >= (TIMESTAMP '2017-06-19') AND ${created_date} < (TIMESTAMP '2017-07-23') THEN 'Bin2 name'
              End
    ;;
  }




  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  dimension: days_since_order {
    type: number
    sql: datediff('Day',convert_timezone('UTC','PST',getdate()),${created_date}) ;;
  }

  measure: average_test {
    type: average
    sql: ${TABLE}.id ;;
    value_format_name: decimal_1
  }

  measure: count {
    type: count
    link: {label: "Explore 5000 Results" url: "{{ link }}&limit=5000" }
    drill_fields: [id, users.last_name, users.first_name, users.id, order_items.count]
  }
}
