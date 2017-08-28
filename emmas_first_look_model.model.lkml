connection: "thelook"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

datagroup: orders_datagroup {
  sql_trigger: SELECT count(*) FROM order_items ;;
  max_cache_age: "4 hours"
}


#########
#EXPLORE INVENTORY ITEMS
#########

explore: inventory_items {
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}


#########
#EXPLORE ORDER ITEMS
#########


explore: order_items {
  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

#########
#EXPLORE ORDERS
#########


explore: orders {
  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

#########
#EXPLORE PRODUCTS
#########


explore: products {
  sql_always_where: ${products.brand} <> 'CB' ;;
  always_filter: {                    #turns on filter to exclude
    filters: {
      field: brand
      value: "-NULL"
    }
  }
  join: inventory_items {
    fields: [inventory_items.cost]
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: one_to_many
  }

}

#explore: schema_migrations {}


#####
#EXPLORE USERS
#########


explore: users {
  join: orders{
    type: left_outer
    sql_on: ${users.id}=${orders.user_id} ;;
    relationship: one_to_many
  }

  join: order_items {
    type: left_outer
    sql_on: ${orders.id}=${order_items.order_id} ;;
    relationship: one_to_many
  }

  join: inventory_items {
    view_label: "Items In Inventory"
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id}=${products.id} ;;
    relationship: many_to_one
  }



}










#explore: users_nn {}
