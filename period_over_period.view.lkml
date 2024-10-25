view: period_over_period {

  extension: required

  dimension_group: period_to_compare {
    hidden: yes
    label: "Selected Period"
    view_label: "_PoP"
    type: time
    timeframes: [
      raw,
      time,
      date,
      day_of_week,
      day_of_month,
      day_of_year,
      week,
      month,
      month_name,
      month_num,
      quarter,
      year
    ]
    sql: ${created_raw} ;;
  }

  parameter: choose_breakdown {
    type: unquoted
    view_label: "_PoP"
    label: "Choose Grouping (Rows)"
    default_value: "month"
    allowed_value: {
      value: "month_name"
      label: "Month"
    }
    allowed_value: {
      value: "week"
      label: "Week"
    }
    allowed_value: {
      value: "date"
      label: "Date"
    }
  }

  parameter: choose_comparison {
    type: unquoted
    view_label: "_PoP"
    label: "Choose Grouping (Pivot)"
    default_value: "year"
    allowed_value: {
      value: "year"
      label: "Year"
    }
    allowed_value: {
      value: "month_name"
      label: "Month"
    }
    allowed_value: {
      value: "week"
      label: "Week"
    }
  }

  dimension: pop_row {
    view_label: "_PoP"
    label_from_parameter: choose_breakdown
    type: string
    order_by_field: sort_by1
    sql: {% if choose_breakdown._parameter_value == 'month_name' %} ${period_to_compare_month_name}
          {% elsif choose_breakdown._parameter_value == 'week' %} ${period_to_compare_day_of_week}
          {% elsif choose_breakdown._parameter_value == 'date' %} ${period_to_compare_date}
          {% else %} NULL
          {% endif %};;
  }

  dimension: pop_pivot {
    view_label: "_PoP"
    label_from_parameter: choose_comparison
    type: string
    order_by_field: sort_by2
    sql: {% if choose_comparison._parameter_value == 'year' %} ${period_to_compare_year}
          {% elsif choose_comparison._parameter_value == 'month_name' %} ${period_to_compare_month_name}
          {% elsif choose_comparison._parameter_value == 'week' %} ${period_to_compare_week}
          {% else %} null
          {% endif %};;
  }

  dimension: sort_by1 {
    hidden: yes
    type: number
    sql: {% if choose_breakdown._parameter_value == 'month_name' %} ${period_to_compare_month_num}
          {% elsif choose_breakdown._parameter_value == 'week' %} ${period_to_compare_day_of_week}
          {% elsif choose_breakdown._parameter_value == 'date' %} ${period_to_compare_date}
          {% else %} NULL
          {% endif %}
    ;;

  }

  dimension: sort_by2 {
    hidden: yes
    type: number
    sql: {% if choose_comparison._parameter_value == 'year' %} ${period_to_compare_year}
          {% elsif choose_comparison._parameter_value == 'month_name' %} ${period_to_compare_month_num}
          {% elsif choose_comparison._parameter_value == 'week' %} ${period_to_compare_week}
          {% else %} null
          {% endif %} ;;
  }

  }
