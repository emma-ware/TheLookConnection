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
    sql: ${TABLE}.state ;;
  }

  dimension: age_tier {
    type: tier
    tiers: [0, 10, 20, 30, 40, 50, 60, 70, 80]
    style: integer
    sql: ${age} ;;
  }

  dimension: zip {
    type: zipcode
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
