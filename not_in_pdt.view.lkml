view: not_in_pdt {


  derived_table: {
    sql:
    select * from demo_db.users where id NOT IN (select id from demo_db.users where state in ('Texas', 'California'))

    ;;
  }



dimension: name{
  type: string
  sql: ${TABLE}.first_name ;;
}

dimension: gender {
  type: string
  sql: ${TABLE}.gender ;;
}

dimension: state {
  type: string
  sql: ${TABLE}.state ;;
}

}
