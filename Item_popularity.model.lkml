connection: "thelook"

# include all the views
include: "*.view"

# include all the dashboards
#include: "*.dashboard"

explore: product_details_pdt {}

explore: users_join_test{
  from: users
  join: orders{
    type: left_outer
    sql_on: ${users_join_test.id}=${orders.user_id} ;;
    relationship: one_to_many
  }
  sql_always_where:  ${yesno_test} = 'Yes' ;;

}
