view: deals {
  sql_table_name: dbo.deals ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: bu {
    label: "BU"
    view_label: "BU"
    type: string
    sql: cast(${TABLE}.bu as NVARCHAR(3)) ;;
  }

  dimension_group: close {
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
    sql: ${TABLE}.close_date ;;
  }

  dimension: competitor {
    type: string
    sql: cast(${TABLE}.competitor as NVARCHAR(max)) ;;
  }

  dimension: customer_name {
    type: string
    sql: cast(${TABLE}.customer_name as NVARCHAR(max)) ;;
  }

  dimension_group: date_lost {
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
    sql: ${TABLE}.date_lost ;;
  }

  dimension_group: entry {
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
    sql: ${TABLE}.entry_date ;;
  }

  dimension_group: expected_decision {
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
    sql: ${TABLE}.expected_decision_date ;;
  }

  dimension: fees {
    type: number
    sql: ${TABLE}.fees ;;
  }

  dimension: for_id {
    type: number
    sql: ${TABLE}.for_id ;;
  }

  dimension: for_txt {
    type: string
    sql: cast(${TABLE}.for_txt as NVARCHAR(max)) ;;
  }

  dimension_group: latest_activity {
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
    sql: ${TABLE}.latest_activity_date ;;
  }

  dimension: phase_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.phase_id ;;
  }

  dimension: probability {
    type: number
    sql: ${TABLE}.probability ;;
  }

  dimension: quotation_nr {
    type: number
    sql: ${TABLE}.quotation_nr ;;
  }

  dimension: reason_refused {
    type: string
    sql: cast(${TABLE}.reason_refused as NVARCHAR(max)) ;;
  }

  dimension: responsible_user_id {
    type: number
    sql: ${TABLE}.responsible_user_id ;;
  }

  dimension: source_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.source_id ;;
  }

  dimension: title {
    type: string
    sql: cast(${TABLE}.title as NVARCHAR(max)) ;;
  }

  dimension: total_price_excl_vat {
    type: number
    sql: ${TABLE}.total_price_excl_vat ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      customer_name,
      phases.id,
      phases.name,
      sources.id,
      sources.name
    ]
  }
}
