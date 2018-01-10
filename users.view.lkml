view: users {
  sql_table_name: demo_db.users ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: google {
    type: string
    sql: 'Google' ;;
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

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

dimension:  full_name{
  description: "first and last name"
  sql: concat(${TABLE}.first_name, ' ', ${TABLE}.last_name) ;;
}

  dimension: state {
    type: string
    map_layer_name: us_states
    sql: ${TABLE}.state ;;
  }

  dimension: age_tier {
    type: tier
    tiers: [10,20,30,40,50,60,70,80,90]
    style: integer
    sql: ${age} ;;
  }


  dimension: zip {
    type: zipcode
    map_layer_name: us_zipcode_tabulation_areas
    sql: ${TABLE}.zip ;;
  }

#  dimension: profit {
#    type: number
#    sql: ${order_items.sale_price} - ${inventory_items.cost}. ;;
#  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: new_england_population {
    type: count_distinct
    sql: ${TABLE}.id  ;;
    filters: {
      field:  region
      value:  "New England"
    }
  }

  measure:west_population {
    type: count_distinct
    sql: ${TABLE}.id  ;;
    filters: {
      field:  region
      value:  "West"
    }
  }

  measure: total_population {
    type: count_distinct
    sql: ${TABLE}.id ;;
  }

measure: west_percent_of_pop {
  description: "Percent of total population in the west"
  type:  number
  sql: ${west_population} / ${total_population} ;;
  value_format_name: percent_2
}

  dimension: region {
    type: string
    sql:
      CASE WHEN ${state} IN ('California', 'Washington', 'Oregon', 'Hawaii', 'Alaska') THEN 'West'
           WHEN ${state} IN ('New York', 'New Jersey', 'Delaware') THEN 'East'
           WHEN ${state} IN ('Arizona', 'Colorado', 'Idaho', 'Montana', 'Nevada', 'New Mexico', 'Utah', 'Wyoming') THEN 'Southwest'
           WHEN ${state} in ('Illinois', 'Indiana', 'Michigan', 'Ohio', 'Wisconsin', 'Iowa', 'Kansas', 'Minnesota', 'Missouri', 'Nebraska', 'North Dakota', 'South Dakota') THEN 'Midwest'
           WHEN ${state} in ('Connecticut', 'Maine', 'Massachusetts', 'New Hampshire', 'Rhode Island', 'Vermont') THEN 'New England'
           When ${state} in ('New Jersey', 'New York', 'Pennsylvania', 'Delaware',  'Maryland', 'District of Columbia', 'Virginia') THEN 'Mid-Atlantic'
           WHEN ${state} in ( 'Florida', 'Georgia', 'North Carolina', 'South Carolina',  'West Virginia', 'Alabama', 'Kentucky', 'Mississippi', 'Tennessee', 'Arkansas', 'Louisiana', 'Oklahoma', 'Texas') THEN 'South'
          ELSE NULL END;;
  }

  dimension: time_as_a_customer {
    type: string
    sql:
        CASE WHEN timestampdiff(day,${created_date},now()) <= 30 then 'Under 1 Month'
            WHEN timestampdiff(day,${created_date},now()) between 31 and 182 then '1 - 6 Months'
            WHEN timestampdiff(day,${created_date},now()) between 182 and 365 then '6 - 12 Months'
        ELSE 'Over 1 Year' end
        ;;
  }






  #dimension: latitude {
  #  type: number
  #  sql: ${TABLE}.latitude ;;
  #}

  #dimension: longitude {
  #  type: number
  #  sql: ${TABLE}.longitude ;;
  #}

  #dimension: location {
  #  type: location
  #  sql_latitude: ${latitude} ;;
  #  sql_longitude: ${longitude} ;;
  #}

  measure: state_count {
    type: count_distinct
    sql: ${TABLE}.state ;;
    drill_fields: [state]
  }


  measure: big_id {
    type: count_distinct
    sql: case when ${id} > 12000 then 1
      else 0 end;;

#     filters: {
#       field: users.id
#       value: "> 12000"
#     }
  }



  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      last_name,
      first_name,
      events.count,
      orders.count,
      user_data.count
    ]
  }
}
