view: ndt_brands {
  derived_table: {
    explore_source: order_items {
      column: brand { field: products.brand }
      column: total_sale_price {}
      derived_column: brand_rank {
        sql: row_number() over (order by total_sales_price desc) ;;
      }
    }
  }
  dimension: brand {
    description: ""
  }
  dimension: total_sale_price {
    description: "Sum of sale price"
    type: number
  }
  dimension: brand_rank {
    label: "this is some sql"
  }

}
