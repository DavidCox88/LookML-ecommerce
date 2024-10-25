include: "/views/products.view.lkml"
view: +products {

  dimension: brand {
    link: {
      label: "Google"
      url: "https://www.google.com/search?q={{value}}"
      icon_url: "https://google.com/favicon.ico"
    }
  }
}
