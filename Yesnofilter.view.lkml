view: yesnofilter {
derived_table: {
  sql:
  SELECT * FROM demo_db.users
  {% if yesnofilter.filter_field == 'Yes' %}
  WHERE age > 50
  {% else %}
  UNION
  SELECT * FROM demo_db.orders
  {% endif %}
  ;;
}

filter: filter_field {
  type: yesno
}

dimension: age {
  type: number
  sql: ${TABLE}.age ;;
}



}
