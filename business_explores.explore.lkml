
include: "/views/distribution_centers.view.lkml"
include: "/views/events.view.lkml"
include: "/views/inventory_items.view.lkml"
include: "/views/order_items.view.lkml"
include: "/views/orders.view.lkml"
include: "/views/products.view.lkml"
include: "/views/users.view.lkml"
include: "/views/*.view" # include all the views
include: "/refined_views/*.view"
include: "/derived_tables/*.view"


explore: order_items {
  label: "Orders"
  description: "This explore allows you to analyse sales orders"
  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${order_items.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: products {
    type:  left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: distribution_centers {
    type:  left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}

explore: users {
}

explore: inventory_items {
}

explore: products {
}

explore: distribution_centers {
}

explore: events {

}

# explore: +order_items {
#   aggregate_table: rollup__created_date {
#     query: {
#       dimensions: [created_date]
#       measures: [count]
#       timezone: "UTC"
#     }

#     materialization: {
#       datagroup_trigger: orders_datagroup
#     }
#   }
# }
