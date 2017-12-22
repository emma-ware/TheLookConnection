view: templated_filter_dt {
  derived_table: {
    sql: select category, id, department, item_name, brand
          from demo_db.products
          where
          ( {% condition related_category_name_filter %} department {% endcondition %})
;;
}

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    drill_fields: [brand]
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: item_name {
    type: string
    sql: ${TABLE}.item_name ;;
  }

  dimension: rank {
    type: number
    sql: ${TABLE}.rank ;;
  }

  filter: related_category_name_filter {
    type: string
    suggest_dimension: category
  }


}
