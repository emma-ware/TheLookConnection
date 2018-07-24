view: products {
#  sql_table_name: demo_db.products ;;
  derived_table: {
    sql: select *, (select count(*) from demo_db.products) as the_count
    from demo_db.products
    ;;
  }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    drill_fields: [brand, retail_price]
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }

dimension: filter_null_test {
  type: string
  sql: CASE WHEN id > 100 THEN ${brand}
  ELSE NULL END
  ;;
}

filter: test_filter {
  type: string
  suggest_dimension: brand
}

measure: price_test {
  type: number
  sql:${TABLE}.retail_price ;;
  }


measure: running_total{
  type: running_total
  sql: ${price_test} ;;
}

  dimension: category {
    label: "cATEGORY'S category"
    type: string
    sql: ${TABLE}.category ;;
    html:
    <p style="font-size:100px; font-family:monotype"> {{value}} </p> ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
    }

  dimension: item_name {
    type: string
    sql: ${TABLE}.item_name ;;
    html: {{rendered_value}} ;;
    link: {
      label: "the link"
      url: "http://www.google.com/search?q={{ category._value }}"
    }
  }

  dimension: rank {
    type: number
    sql: ${TABLE}.rank ;;
  }

  dimension: retail_price {
    type: number
    sql: CASE WHEN ${TABLE}.retail_price < 900 then ${TABLE}.retail_price
          else 900 end;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
  }

  dimension: total_num_of_products {
    type: number
    sql: ${TABLE}.the_count ;;
  }

  dimension: drill_test {
    type: string
    sql: ${TABLE}.category
    html: {% if products.retail_price._in_query %}
    <a href="Google.com"> "Google" </a>
    {% else %} "other"
    {% endif %}
    ;;
  }

  measure: count_of_socks {
    type: count
    filters: {
      field: category
      value: "Socks"
    }
    html:
    {% if inventory_items._in_query  %} <a href ="https://www.google.com/">{{rendered_value}}</a>
    {% else %}  <a href ="https://www.bing.com/">{{rendered_value}}</a>
    {% endif %}
    ;;
  }

  measure: percent_products {
    type: number
    sql: ${count}/${total_num_of_products} ;;
    value_format_name: percent_1
  }

  measure: brand_count {
    type: count_distinct
    sql: ${TABLE}.brand ;;
    drill_fields: [brand]
  }

  measure: count {
    type: count
    drill_fields: [id, item_name, inventory_items.count]
  }
}
