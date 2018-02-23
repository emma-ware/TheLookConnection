view: users_max_date {
  #sql_table_name: demo_db.users ;;
  derived_table: {
    sql:
    SELECT users.id as id, orders.created_at as created_at, MAX(orders.created_at) as max_date_order FROM demo_db.users as users
    LEFT JOIN demo_db.orders  AS orders ON users.id=orders.user_id
group by id
    ;; }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: max_date_order {
    type: date
    sql: ${TABLE}.max_date_order ;;
  }

  dimension_group: order_created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      time_of_day,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  measure: count {
    type: count
  }


  }
