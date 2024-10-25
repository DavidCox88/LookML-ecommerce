include: "/views/events.view.lkml"
view: +events {

  measure: m_sessions_facebook {
    group_label: "Sessions"
    label: "Sessions Facebook"
    description: "Sessions that come from Facebook"
    type: count_distinct
    sql: ${session_id}  ;;
    filters: [traffic_source: "Facebook"]
  }

  measure: m_sessions_adwords {
    group_label: "Sessions"
    label: "Sessions Adwords"
    description: "Sessions that comes from Adwords"
    type: count_distinct
    sql: ${session_id}  ;;
    filters: [traffic_source: "Adwords"]
  }
}
