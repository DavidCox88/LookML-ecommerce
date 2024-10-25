
view: brand_rank {
  derived_table: {
    sql: SELECT *,
      ROW_NUMBER() OVER(ORDER BY total_cost desc) Rank
      FROM
      (
      SELECT
      product_brand,
      sum(cost) as total_cost,
      from inventory_items
      group by product_brand
      ) AS t1
      limit 10 ;;
  }

  measure: count {
    type: count
    hidden: yes
    drill_fields: [detail*]
  }

  dimension: product_brand {
    type: string
    sql: ${TABLE}.product_brand ;;
  }

  dimension: total_cost {
    type: number
    sql: ${TABLE}.total_cost ;;
  }

  dimension: rank {
    type: number
    sql: ${TABLE}.Rank ;;
  }

  set: detail {
    fields: [
        product_brand,
  total_cost,
  rank
    ]
  }
}
