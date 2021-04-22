view: phases {
  sql_table_name: dbo.phases ;;

  dimension: id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: name {
    type: string
    label: "Phase"
    sql: cast(${TABLE}.name as NVARCHAR(max)) ;;
    drill_fields: [phase_details*]
  }

  measure: count {
    label: "Nb of Phases"
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      deals.count,
      id,
      name,
      deals.count
    ]
  }

  set: phase_details{
    fields: [
      deals.count,
      deals.bu,
      deals.customer_name
    ]
  }

}
