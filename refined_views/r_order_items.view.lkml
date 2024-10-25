include: "/views/order_items.view.lkml"
include: "/period_over_period.view.lkml"
view: +order_items {
  extends: [period_over_period]
  measure:m_sum_sale_price{
    label: "Total Revenue"
    value_format: "$0.00"
    type: sum
    sql: ${sale_price} ;;
}

  measure: m_avg_sales_price {
    label: "Average Sales Price"
    value_format: "$0.00"
    type: average
    sql: ${sale_price} ;;
  }

  dimension: profit {
    description: "Profit made on any one item"
    value_format: "$0.00"
    type: number
    sql: ${sale_price} - ${inventory_items.cost} ;;
  }

  measure: total_profit {
    description: "Sum of profit"
    type:  sum
    value_format_name: usd
    sql:  ${profit} ;;
  }

  measure: total_sale_price {
    description: "Sum of sale price"
    type: sum
    sql: ${sale_price} ;;
  }

  measure: profit_margin {
    description: "Profit margin"
    type:  number
    sql: ${total_profit} / ${total_sale_price} ;;
    value_format_name: percent_2
  }

  dimension_group: shipping_time {
    description: "Shipping time in days"
    type: duration
    sql_start: ${created_date} ;;
    sql_end: ${shipped_month}  ;;
    intervals: [day]
  }


  parameter: select_timeframe {
    type: unquoted
    default_value: "day"
    allowed_value: {
      value: "day"
      label: "Day"
    }
    allowed_value: {
      value: "month"
      label: "Month"
    }
    allowed_value: {
      value: "year"
      label: "Year"
    }
  }

  dimension: dynamic_timeframe {
    description: "To use with the select_timeframe parameter"
    label_from_parameter: select_timeframe
    type: string
    sql: {% if select_timeframe._parameter_value == 'day' %} ${created_date}
          {% elsif select_timeframe._parameter_value == 'month' %} ${created_month}
          {% else %} ${created_year}
          {% endif %};;
  }

}
