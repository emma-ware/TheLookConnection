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

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [id, users.last_name, users.first_name, users.id, order_items.count]
  }
}
