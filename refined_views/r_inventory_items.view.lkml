include: "/views/inventory_items.view.lkml"
view: +inventory_items {

  dimension: product_category {
    link: {
      label: "Details"
      url: "/explore/thelook_ecommerce/inventory_items?fields=inventory_items.product_category,inventory_items.product_name,inventory_items.count&f[inventory_items.product_category]={{value | url_encode}}"
    }
  }

  parameter: select_product_details {
    type: unquoted
    default_value: "product_department"
    allowed_value: {
      value: "product_department"
      label: "Department"
    }
    allowed_value: {
      value: "product_category"
      label: "Category"
    }
    allowed_value: {
      value: "product_brand"
      label: "Brand"
    }
  }

  dimension: product_hierarchy {
    description: "To use with the select_product_details parameter"
    label_from_parameter: select_product_details
    type: string
    sql: {% if select_product_details._parameter_value == 'product_department' %} ${product_department}
    {% elsif select_product_details._parameter_value == 'product_category' %} ${product_category}
    {% else %} ${product_brand}
    {% endif %};;
  }
}
