view: native_derived_table_demo {
  derived_table: {
    explore_source: order_items {
      column: m_avg_sales_price {}
      column: order_id {}
      derived_column: window_function {
        sql:  ;;
      }
    }
  }
  dimension: m_avg_sales_price {
    label: "Order Items Average Sales Price"
    description: ""
    value_format: "$0.00"
    type: number
  }
  dimension: order_id {
    description: ""
    type: number
  }

  dimension: window_function {
    label: " added some sql"
  }

  measure: some_measure {
    sql: ${window_function} ;;
  }
}
