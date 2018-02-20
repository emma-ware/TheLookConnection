view: aggregate_dt {
  derived_table: {
    sql:
    select company, sum(upload_size_gb) as total_uploads


    FROM
    ((SELECT 'company_A' as company, 1 as upload_rank, 0.25 as upload_size_gb) UNION ALL
    (SELECT 'company_A' as company, 2 as upload_rank, 1.25 as upload_size_gb) UNION ALL
    (SELECT 'company_A' as company, 3 as upload_rank, 0.05 as upload_size_gb) UNION ALL
    (SELECT 'company_A' as company, 4 as upload_rank, 0.015 as upload_size_gb) UNION ALL
    (SELECT 'company_A' as company, 5 as upload_rank, 0.35 as upload_size_gb) UNION ALL
    (SELECT 'company_A' as company, 6 as upload_rank, 0.25 as upload_size_gb) UNION ALL
    (SELECT 'company_A' as company, 7 as upload_rank, 0.025 as upload_size_gb) UNION ALL
    (SELECT 'company_A' as company, 8 as upload_rank, 0.045 as upload_size_gb) UNION ALL
    (SELECT 'company_A' as company, 9 as upload_rank, 0.35 as upload_size_gb) UNION ALL
    (SELECT 'company_A' as company, 10 as upload_rank, 0.095 as upload_size_gb) UNION ALL
    (SELECT 'company_B' as company, 1 as upload_rank, 2.25 as upload_size_gb) UNION ALL
    (SELECT 'company_B' as company, 2 as upload_rank, 1.25 as upload_size_gb) UNION ALL
    (SELECT 'company_B' as company, 3 as upload_rank, 5.05 as upload_size_gb) UNION ALL
    (SELECT 'company_B' as company, 4 as upload_rank, 7.015 as upload_size_gb) UNION ALL
    (SELECT 'company_B' as company, 5 as upload_rank, 1.35 as upload_size_gb) UNION ALL
    (SELECT 'company_B' as company, 6 as upload_rank, 0.95 as upload_size_gb) UNION ALL
    (SELECT 'company_B' as company, 7 as upload_rank, 0.025 as upload_size_gb) UNION ALL
    (SELECT 'company_B' as company, 8 as upload_rank, 0.045 as upload_size_gb) UNION ALL
    (SELECT 'company_B' as company, 9 as upload_rank, 0.35 as upload_size_gb) UNION ALL
    (SELECT 'company_B' as company, 10 as upload_rank, 0.095 as upload_size_gb)) as testtable
    ;;


  }


dimension: company {
  type: string
  sql: ${TABLE}.company ;;
}

dimension: sum_aggregate_tier {
  type: string
  sql: CASE WHEN total_uploads <= 5.0 THEN 'Less than 5 GB'
  ELSE 'Greater than 5 GB' END;;
}

# dimension: upload_rank  {
#   type: number
#   sql: ${TABLE}.upload_rank ;;
# }
#
# dimension: upload_size_gb {
#   type: number
#   sql: ${TABLE}.upload_size_gb;;}


# measure: total_upload {
#   type: sum
#   sql: ${TABLE}.total_upload ;;
# }

# dimension: aggregate_size {
#   type: string
#   sql: ${TABLE}.aggregate_size ;;
# }

measure: count {
  type: count
}



# measure: sum_measure {
#   type: sum
#   sql:  ${TABLE}.upload_size_gb ;;
# }


  }
