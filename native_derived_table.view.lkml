# include: "order_items_ndt.explore"
#
# explore: user_order_sequence {}
# view: user_order_sequence {
#   derived_table: {
#     #persist_for: "2 hours"
#     explore_source: order_items_ndt {
#       column: user_id { field: orders.user_id}
#       column: order_id {field: order_items_ndt.order_id}
#       column: created_time {field: orders.created_time}
#       derived_column: user_sequence { sql: ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY created_time) ;;}
#     }
#   }
#   dimension: order_id {hidden:yes}
#   dimension: user_sequence {type:number}
# }
