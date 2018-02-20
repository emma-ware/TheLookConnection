# include: "users.view"
# include: "inventory_items.view"
# include: "products.view"
# include: "order_items.view"
# include: "orders.view"
#
# #explore: order_items {}
#
#
# explore: order_items_ndt {
#   from: order_items
#    join: orders {sql_on: ${order_items_ndt.order_id} = ${orders.id} ;; relationship: many_to_one}
#    join: users {relationship:many_to_one  sql_on: ${orders.user_id} = ${users.id} ;;}
#    join: inventory_items {relationship:many_to_one  sql_on: ${order_items_ndt.inventory_item_id} = ${inventory_items.id} ;;}
#    join: products {relationship:many_to_one  sql_on: ${inventory_items.product_id} = ${products.id} ;;}
#
#  }
#
# explore: users_ndt {
#   from: users
# }
