view: staffing {
  sql_table_name: dbo.staffing ;;

  dimension: employee_code {
    type: string
    hidden: yes
    sql: ${TABLE}.employee_code ;;
  }

  dimension: employee {
    type: string
    label: "Employee"
    sql: CAST(${TABLE}.employee AS NVARCHAR(60)) ;;
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
    sql: CAST(${TABLE}.project AS NVARCHAR(60));;
  }

  dimension: staffed {
    type: yesno
    label: "Staffed ?"
    sql: CAST(${TABLE}.staffed AS NVARCHAR(5)) = 'true';;
  }

  dimension: period {
    type: string
    sql: ${TABLE}.period ;;
  }

  dimension: year {
    type: number
    sql: CAST(LEFT(${TABLE}.period, 4) AS INTEGER) ;;
    value_format_name: decimal_0
  }

  dimension: month {
    type: number
    sql: CAST(RIGHT(${TABLE}.period, 2) AS INTEGER) ;;
    value_format_name: decimal_0
  }

  dimension: week {
    type: number
    label: "Week #"
    sql: CAST(${TABLE}.week AS INTEGER);;
  }

  dimension_group: week_start_date {
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
    sql: CAST(CONCAT( LEFT(${TABLE}.period, 4), '-', RIGHT(${TABLE}.period, 2), '-', CAST( (CAST(${TABLE}.week AS INTEGER) - 1) * 7 + 1 AS NVARCHAR(2)) ) AS DATE);;
  }

  dimension: max_availability {
    type: number
    sql: ${TABLE}.max_availability ;;
    value_format_name: decimal_2
  }

  measure: staffing_request {
    type: sum
    label: "Staffing request"
    sql: ${TABLE}.staffing_request ;;
    value_format_name: percent_2
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
