connection: "thelook"

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project


explore: city_and_state_table {
  hidden: no
}

view: city_and_state_table {
  derived_table: {
    sql:
          (select 'NYC' as city, 'New York' as state, 55 as users) union all
          (select 'Buffalo' as city, 'New York' as state, 5 as users) union all
          (select 'Jersey City' as city, 'New Jersey' as state, 12 as users) union all
          (select 'Hoboken' as city, 'New Jersey' as state, 12 as users)
         ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: users {
    type: number
    sql: ${TABLE}.users ;;
  }


  measure: count {
    type: number
    sql: ${TABLE}.users ;;
  }


}
