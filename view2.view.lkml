view: view2 {
derived_table: {
  sql:
  SELECT *
  FROM
  ${view1.SQL_TABLE_NAME}

  ;;
}

dimension: new_name {
  type: string
  sql: ${TABLE}.name ;;
}


}
