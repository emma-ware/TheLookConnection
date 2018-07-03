# - dashboard: date
#   title: Date
#   layout: tile
#   tile_size: 100
# - dashboard: custom_viz
#   title: Custom Viz
#   layout: newspaper
#   elements:
#   - title: allo
#     name: New Tile
#     model: emmas_first_look_model
#     explore: orders
#     type: sunburst
#     fields:
#     - orders.created_year
#     - users.count
#     - orders.count
#     - orders.status
#     sorts:
#     - orders.created_year desc
#     limit: 500
#     dynamic_fields:
#     - table_calculation: calculation_1
#       label: Calculation 1
#       expression: "${orders.count}/sum(${orders.count})"
#       value_format:
#       value_format_name: percent_0
#       _kind_hint: measure
#       _type_hint: number
#     query_timezone: America/Los_Angeles
#     stacking: ''
#     show_value_labels: false
#     label_density: 25
#     legend_position: center
#     x_axis_gridlines: false
#     y_axis_gridlines: true
#     show_view_names: true
#     limit_displayed_rows: false
#     y_axis_combined: true
#     show_y_axis_labels: true
#     show_y_axis_ticks: true
#     y_axis_tick_density: default
#     y_axis_tick_density_custom: 5
#     show_x_axis_label: true
#     show_x_axis_ticks: true
#     x_axis_scale: auto
#     y_axis_scale_mode: linear
#     x_axis_reversed: false
#     y_axis_reversed: false
#     ordering: none
#     show_null_labels: false
#     show_totals_labels: false
#     show_silhouette: false
#     totals_color: "#808080"
#     series_types: {}
#     hidden_fields:
#     - users.count
#     - orders.count
#     listen:
#       Untitled Filter 2: orders.created_date
#     row: 0
#     col: 16
#     width: 8
#     height: 6
#   - title: yis
#     name: New Tile
#     model: emmas_first_look_model
#     explore: orders
#     type: chord
#     fields:
#     - orders.created_year
#     - orders.created_quarter
#     - orders.count
#     sorts:
#     - orders.created_year desc
#     limit: 500
#     query_timezone: America/Los_Angeles
#     stacking: ''
#     show_value_labels: false
#     label_density: 25
#     legend_position: center
#     x_axis_gridlines: false
#     y_axis_gridlines: true
#     show_view_names: true
#     limit_displayed_rows: false
#     y_axis_combined: true
#     show_y_axis_labels: true
#     show_y_axis_ticks: true
#     y_axis_tick_density: default
#     y_axis_tick_density_custom: 5
#     show_x_axis_label: true
#     show_x_axis_ticks: true
#     x_axis_scale: auto
#     y_axis_scale_mode: linear
#     x_axis_reversed: false
#     y_axis_reversed: false
#     ordering: none
#     show_null_labels: false
#     show_totals_labels: false
#     show_silhouette: false
#     totals_color: "#808080"
#     series_types: {}
#     listen:
#       Untitled Filter 2: orders.created_date
#     row: 0
#     col: 0
#     width: 8
#     height: 6
#   - title: New Tile
#     name: New Tile
#     model: emmas_first_look_model
#     explore: orders
#     type: gauge
#     fields:
#     - orders.created_year
#     - users.count
#     - orders.count
#     fill_fields:
#     - orders.created_year
#     sorts:
#     - orders.created_year desc
#     limit: 500
#     dynamic_fields:
#     - table_calculation: calculation_1
#       label: Calculation 1
#       expression: "${users.count}/${orders.count}*100"
#       value_format:
#       value_format_name: percent_0
#       _kind_hint: measure
#       _type_hint: number
#     query_timezone: America/Los_Angeles
#     stacking: ''
#     show_value_labels: false
#     label_density: 25
#     legend_position: center
#     x_axis_gridlines: false
#     y_axis_gridlines: true
#     show_view_names: true
#     limit_displayed_rows: false
#     y_axis_combined: true
#     show_y_axis_labels: true
#     show_y_axis_ticks: true
#     y_axis_tick_density: default
#     y_axis_tick_density_custom: 5
#     show_x_axis_label: true
#     show_x_axis_ticks: true
#     x_axis_scale: auto
#     y_axis_scale_mode: linear
#     x_axis_reversed: false
#     y_axis_reversed: false
#     ordering: none
#     show_null_labels: false
#     show_totals_labels: false
#     show_silhouette: false
#     totals_color: "#808080"
#     series_types: {}
#     hidden_fields:
#     - users.count
#     - orders.count
#     listen:
#       Untitled Filter 2: orders.created_date
#     row: 0
#     col: 8
#     width: 8
#     height: 6
#   filters:
#   - name: Untitled Filter 2
#     title: Untitled Filter 2
#     type: field_filter
#     default_value: 7 days
#     allow_multiple_values: true
#     required: false
#     model: emmas_first_look_model
#     explore: orders
#     listens_to_filters: []
#     field: orders.created_date
