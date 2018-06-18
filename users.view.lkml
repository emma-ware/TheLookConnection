view: users {
  sql_table_name: demo_db.users ;;
#   derived_table: {
#     sql:
#     SELECT *, MAX(orders.created_at) as max_date_order FROM demo_db.users as users
#     LEFT JOIN demo_db.orders  AS orders ON users.id=orders.user_id
#
#     ;;
#   }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age;;
    html: <p style="color: black; background-color: lightblue; font-size:100%; text-align:center">{{ rendered_value }}</p> ;;
  }

  filter: names_in {
    type: string
    suggest_dimension: first_name
  }

# dimension: name_filters {
#   type: string
#   sql: CASE WHEN {% condition filtername %} field_we're_applying_to {% endcondition %} ${name_field} else 'others' ;;
# }


  measure: age_count {
    type: count
    filters: {
      field: orders.id
      value: ">5000"
    }
    drill_fields: [orders.id]
  }

  dimension: yesno_test {
    type: yesno
    sql: ${age} > ${orders.id} ;;
  }

measure: sum_in_sql {
  type: number
  sql: sum(${age_count}) ;;
}

# dimension: max_date_order {
#   type: date
#   sql: ${TABLE}.max_date_order ;;
# }

filter: suggestion_filter_example {
  type: string
  suggestions: ["Suggestion A", "Suggestion B"]
}

measure: user_maximum_order {
  type: date
  sql: MAX(${orders.created_raw}) ;;
}

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
    html: <p style="color: black; background-color: lightblue; font-size:100%; text-align:center">{{ rendered_value }}</p> ;;
  }

#
#   filter: date_start {
#     type: date
#   }
#
#   filter: date_end {
#     type: date
#   }
#
#
#   measure: date_sum {
#     type: sum
#     sql: CASE WHEN {% condition date_start %} ${created_date} {% endcondition %}
#         THEN 1 else 0 END
#         ;;
#   }

  dimension: case_test {
    type: string
    case: {
      when: {
        sql: ${state} = 'New York' ;;
        label: "Foo"
      }
      when: {
        sql: ${state} = 'California'  ;;
        label: "Bar"
      }

      else: "Foo"
    }
  }

  measure: count_or {
    type: count
    filters: {
      field: state
      value: "CA, NY"
    }
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
      time_of_day,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

dimension: formatted_date {
  type: date
  sql: DATE_FORMAT(${TABLE}.created_at, '%Y')  ;;
}

dimension: quarter_dim {
  type: string
  sql: CAST(${created_quarter} as CHAR) ;;
}

  dimension: ordered_date {
    type: date
    order_by_field: id
    sql: ${created_date} ;;

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
  drill_fields: [id, age, age_tier]
}

  dimension: state {
    type: string
    map_layer_name: us_states
   #sql: ${TABLE}.state ;;
    sql:
      {% if state._is_filtered %}
      ${TABLE}.state
      {% else %}
        NULL
      {% endif %} ;;
  }

  dimension: age_tier {
    type: tier
    tiers: [10,20,30,40,50,60,70,80,90]
    style: integer
    sql: ${age} ;;
  }
#
#   dimension_group: in_query_test {
#     type: time
#     timeframes: [raw, time, date, month]
#     sql: {% if orders.status._in_query %} COALESCE(${TABLE}.created_at_raw, ${orders.created_at_raw})
#     {% else %} ${TABLE}.created_at_raw
#     {% endif %}
#     ;;
#   }


  dimension: zip {
    type: zipcode
    group_label: "TEST GROUP"
    label: "{% if _user_attributes['is_me'] == 'No' %} Employee Name {% else %} Customer Name {% endif %}"
    map_layer_name: us_zipcode_tabulation_areas
    sql: ${TABLE}.zip ;;
  }

  dimension: zippy {
    type: zipcode
    group_label: "TEST GROUP"
    label: "{% if _user_attributes['is_me'] == 'No' %} Name {% else %} LNAME Name {% endif %}"
    map_layer_name: us_zipcode_tabulation_areas
    sql: ${TABLE}.zip ;;
  }

#  dimension: profit {
#    type: number
#    sql: ${order_items.sale_price} - ${inventory_items.cost}. ;;
#  }

  measure: count_test {
    type: number
   # html: {% if state._value == 'California' %}<b><span style="color: black;">{{ rendered_value }}</span></b>{% else %} {{rendered_value}} {% endif %} ;;
    drill_fields: [detail*]
    sql: {% if state._is_filtered %}
      count(id)
      {% else %}
        NULL
      {% endif %} ;;
  }

measure: count {
  type: count
}

#   measure: max_date {
#     type: time
#     sql:DATE_ADD(max(${created_time_of_day}), INTERVAL 2 HOUR) ;;
#   }

#  dimension: max_date_dim {
#    type: date
#   sql: max(${created_date}) ;;
#  }

  measure: new_england_population {
    type: count_distinct
    sql: ${TABLE}.id  ;;
    filters: {
      field:  region
      value:  "New England"
    }
  }

  dimension: id_html {
    type: number
    sql: ${TABLE}.id ;;
    html:
            <div>
        <p style="font-size: 14px;font-weight:600;"><a href= {{value}} target="new" >{{linked_value}}</a></p>
        </div>

    ;;
  }

measure: unique_user_drill {
  type: count_distinct
  sql: ${id_html} ;;
  drill_fields: [id_html]
  html: <a href="#drillmenu" target="_self"> {{rendered_value}} ;;
}


  measure: west_population {
    label: "percent #"
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

  measure: count_diff {
    type: number
    sql: ${count} - ${age_count} ;;
  }

measure: west_percent_of_pop {
  description: "Percent of total population in the west"
  type:  number
  sql: ${west_population} / ${total_population} ;;
  value_format_name: percent_2
}

  dimension: region {
    hidden: yes
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

#   measure: count_age {
#     type: count
#     sql: ${TABLE}.id ;;
#
#     filters: {
#       field: age
#       value: ">50"
#     }
#   }


#   filter: parameter_filter {
#     type: string
#     suggest_explore: users
#     suggest_dimension: region
#
#
#   }
#
#   filter: state_filter {
#     type: string
#     suggest_explore: users
#     suggest_dimension: state
#     sql: {% condition %} ${state_filter} {% endcondition %}  ;;
#   }
#
#   dimension: test {
#     type: string
#     sql: ${TABLE}.state ;;
#
#   }



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
    sql: ${TABLE}.state  ;;
    drill_fields: []
  link: {label: "Explore 5000 Results" url: "{{ link }}&limit=5000" }
  }

  measure: state_count_avg {
    type: number
    sql: ${state_count}/10 ;;
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
