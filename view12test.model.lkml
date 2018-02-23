connection: "thelook"

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project

explore: view1 {
  join: view2 {
    type: left_outer
    relationship: one_to_one
    sql_on: ${view1.name} = ${view2.new_name} ;;
  }
}

explore: view2 {}
