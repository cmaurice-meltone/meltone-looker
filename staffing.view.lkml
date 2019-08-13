view: staffing {
  sql_table_name: dbo.staffing ;;

  dimension: staffingKey {
    primary_key: yes
    hidden: yes
    type: string
    sql: CONCAT(${TABLE}.period, CAST(${TABLE}.week AS NVARCHAR(max)), CAST(${TABLE}.project AS NVARCHAR(max)), ${TABLE}.employee_code);;
  }

  dimension: employee_code {
    type: string
    hidden: yes
    sql: ${TABLE}.employee_code ;;
  }

  dimension: employee {
    type: string
    label: "Employee"
    sql: CAST(${TABLE}.employee AS NVARCHAR(max)) ;;
  }

  dimension_group: start {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    label: "Employee Start"
    sql: ${TABLE}.start_date ;;
  }

  dimension_group: end {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    label: "Employee Leave"
    sql: ${TABLE}.end_date ;;
  }

  dimension: project {
    type: string
    sql: CAST(${TABLE}.project AS NVARCHAR(max));;
  }

  dimension: staffed {
    type: yesno
    label: "Staffed ?"
    sql: CAST(${TABLE}.staffed AS NVARCHAR(max)) = 'true';;
  }

  dimension: period {
    type: string
    sql: ${TABLE}.period ;;
  }

  dimension: week {
    type: string
    label: "Week #"
    sql: CAST(${TABLE}.week AS NVARCHAR(max));;
  }

  dimension: max_availability {
    type: number
    sql: ${TABLE}.max_availability ;;
    value_format_name: decimal_2
  }

  dimension: staffing {
    type: number
    sql: ${TABLE}.staffing_request ;;
    value_format_name: decimal_2
  }

  measure: staffing_request {
    type: sum_distinct
    label: "Staffing request"
    sql_distinct_key: ${staffingKey};;
    sql: ${TABLE}.staffing_request ;;
    value_format_name: percent_2
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
