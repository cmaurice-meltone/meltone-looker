view: deals {
  sql_table_name: dbo.deals ;;

  dimension: id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: bu {
    label: "BU"
    type: string
    sql: CAST(${TABLE}.bu AS NVARCHAR(3)) ;;
  }

  dimension_group: close {
    type: time
    label: "Closed on"
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
    sql: CAST(${TABLE}.competitor AS NVARCHAR(max)) ;;
  }

  dimension: customer_name {
    type: string
    label: "Customer"
    sql: CAST(${TABLE}.customer_name AS NVARCHAR(max)) ;;
  }

  dimension_group: date_lost {
    type: time
    label: "Lost on"
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
    label: "Created on"
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

  dimension_group: close_date {
    type: time
    label: "Close date"
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

  dimension: fees {
    type: number
    sql: ${TABLE}.fees ;;
  }

  dimension: for_id {
    type: number
    hidden: yes
    sql: ${TABLE}.for_id ;;
  }

  dimension: for_txt {
    type: string
    sql: CAST(${TABLE}.for_txt AS NVARCHAR(max)) ;;
  }

  dimension_group: latest_activity {
    type: time
    label: "Update on"
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
    hidden: yes
    sql: ${TABLE}.phase_id ;;
  }

  measure: probability {
    type: average
    sql: ${TABLE}.probability / 100.0;;
    value_format_name: percent_2
  }

  dimension: quotation_nr {
    type: number
    sql: ${TABLE}.quotation_nr ;;
  }

  dimension: reason_refused {
    type: string
    sql: CAST(${TABLE}.reason_refused AS NVARCHAR(max)) ;;
  }

  dimension: responsible_user_id {
    type: number
    hidden: yes
    sql: ${TABLE}.responsible_user_id ;;
  }

  dimension: source_id {
    type: number
    hidden: yes
    sql: ${TABLE}.source_id ;;
  }

  dimension: title {
    type: string
    sql: CAST(${TABLE}.title AS NVARCHAR(max)) ;;

    link: {
      label: "See in Teamleader"
      url: "https://app.teamleader.eu/sale_detail.php?id={{ deals.id._value }}"
      icon_url: "https://app.teamleader.eu/favicon.ico"
    }
  }

  measure: total_price_excl_vat {
    type: sum
    sql: ${TABLE}.total_price_excl_vat ;;
    value_format_name: eur_0
    drill_fields: [drill_details*]
  }

  measure: weighted_total_price_excl_vat {
    type: sum
    sql: ${TABLE}.total_price_excl_vat * ${TABLE}.probability / 100.0 ;;
    value_format_name: eur_0
    drill_fields: [drill_details*]
  }

  parameter: calculation_mode {
    type: unquoted
    allowed_value: {
      value: "absolute"
      label: "Absolute"
    }
    allowed_value: {
      value: "weighted"
      label: "Weighted"
    }
  }

  measure: price {
    type: sum
    sql: {% if calculation_mode._parameter_value == 'absolute' %}
      ${TABLE}.total_price_excl_vat
    {% elsif calculation_mode._parameter_value == 'weighted' %}
       ${TABLE}.total_price_excl_vat * ${TABLE}.probability / 100.0
    {% else %}
      0
    {% endif %} ;;
    value_format_name: eur_0
    drill_fields: [drill_details*]
  }

  measure: inactive_days {
    type: sum

    sql: DATEDIFF(day, ${TABLE}.latest_activity_date, GETDATE())  ;;

    label: "#Days of inactivity"

    value_format_name: decimal_0
    drill_fields: [drill_details*]
  }

  measure: days_to_decision {
    type: sum

    sql: DATEDIFF(day, GETDATE(), ${TABLE}.close_date)  ;;

    label: "#Days until decision"

    value_format_name: decimal_0
    drill_fields: [drill_details*]
  }

  measure: count {
    type: count
    drill_fields: [drill_details*]
  }

  # ----- Sets of fields for drilling ------
  set: drill_details {
    fields: [
      entry_date,
      bu,
      customer_name,
      title,
      phases.name,
      sources.name,
      users.trigram,
      close_date,
      total_price_excl_vat,
      weighted_total_price_excl_vat,
      competitor
    ]
  }
}
