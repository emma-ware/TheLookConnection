view: view1 {
derived_table: {
  sql:
  SELECT
  concat(first_name, ' ', last_name) AS name,
  created_at, DATE_ADD(created_at, INTERVAL 20 DAY) as ending_date

  FROM
  demo_db.users
  WHERE
  {% condition start_date %} created_at {% endcondition  %} AND
  {% condition end_date %} DATE_ADD(created_at, INTERVAL 20 DAY) {% endcondition  %}

  ;;
}

filter: start_date {
  type: date
}

filter: end_date {
  type: date
}

dimension: name {
  type: string
  sql: ${TABLE}.name ;;
}

dimension: starting_date {
  type: date
  sql: ${TABLE}.created_at ;;
}

dimension: ending_date {
  type: date
  sql: ${TABLE}.ending_date ;;
}

measure: count {
  type: count
}

 }
