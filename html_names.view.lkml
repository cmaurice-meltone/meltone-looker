view: html_names {
  sql_table_name: dbo.htmlNames ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: html_name {
    type: string
    sql: ${TABLE}.htmlName ;;
  }

  measure: count {
    type: count
    drill_fields: [id, html_name]
  }
}
