include: "/views/users.view.lkml"

view: +users {

  dimension: full_name {
    type: string
    sql: concat(${first_name}," ", ${last_name}) ;;
  }

  dimension_group: since_signup {
    type: duration
    sql_start: ${created_date} ;;
    sql_end: current_date() ;;
    intervals: [day]
  }

  dimension: is_new_customer {
    type: yesno
    sql: ${days_since_signup} < 90 ;;
  }

  dimension: days_since_signup_tier {
    type:  tier
    sql:  ${days_since_signup} ;;
    tiers: [0, 30, 90, 180, 360, 720]
    style: integer
  }

  dimension: is_email_source {
    type: yesno
    sql:  ${traffic_source} = "Email" ;;
  }

  dimension: age_tier {
    type: tier
    sql:  ${age} ;;
    tiers: [18, 25, 35, 45, 55, 65, 75, 90]
    style: integer
  }

  dimension: city {
    link: {
      label: "Google"
      url: "https://www.google.com/search?q={{value}}"
      icon_url: "https://google.com/favicon.ico"
      }
  }
}
