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

  measure: count {
    type: count
    drill_fields: [id, users.last_name, users.first_name, users.id, order_items.count]
  }
}
