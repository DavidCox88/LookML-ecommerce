connection: "thelook_ecommerce"

label: "E-commerce Sandbox"

include: "/business_explores.explore.lkml"
include: "/datagroups.lkml"

datagroup: thelook_ecommerce_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: thelook_ecommerce_default_datagroup
