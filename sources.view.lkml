view: sources {
  sql_table_name: dbo.sources ;;

  dimension: id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: name {
    type: string
    label: "Source"
    sql: cast(${TABLE}.name as NVARCHAR(max)) ;;
    drill_fields: [source_details*]
  }

  measure: count {
    label: "Nb of Sources"
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      name,
      deals.count
    ]
  }

  set: source_details{
    fields: [
      name,
      deals.count
    ]
  }

}
