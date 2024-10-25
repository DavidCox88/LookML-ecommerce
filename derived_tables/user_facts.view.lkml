
view: user_facts {
  derived_table: {
    sql: SELECT
      user_id,
      count (order_id) as lifetime_orders,
      sum(sale_price) as lifetime_revenue,
      min(created_at) as first_order,
      max(created_at) as latest_order
      FROM order_items
      GROUP BY user_id ;;
  }

  measure: count {
    type: count
    hidden:  yes
    drill_fields: [detail*]
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: lifetime_orders {
    type: number
    sql: ${TABLE}.lifetime_orders ;;
  }

  dimension: lifetime_revenue {
    type: number
    sql: ${TABLE}.lifetime_revenue ;;
  }

  dimension_group: first_order {
    type: time
    sql: ${TABLE}.first_order ;;
  }

  dimension_group: latest_order {
    type: time
    sql: ${TABLE}.latest_order ;;
  }

  set: detail {
    fields: [
        user_id,
  lifetime_orders,
  lifetime_revenue,
  first_order_time,
  latest_order_time
    ]
  }
}
