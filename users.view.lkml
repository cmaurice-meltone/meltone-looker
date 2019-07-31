view: users {
  sql_table_name: dbo.users ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: active {
    type: string
    sql: cast(${TABLE}.active as NVARCHAR(max)) ;;
  }

  dimension: email {
    type: string
    sql: cast(${TABLE}.email as NVARCHAR(max)) ;;
  }

  dimension: gsm {
    type: string
    sql: cast(${TABLE}.gsm as NVARCHAR(max)) ;;
  }

  dimension: name {
    type: string
    sql: cast(${TABLE}.name as NVARCHAR(max)) ;;
  }

  dimension: trigram {
    type: string
    sql: cast(LEFT(${TABLE}.name, 3) as NVARCHAR(max)) ;;
  }

  dimension: team_id {
    type: string
    sql: cast(${TABLE}.team_id as NVARCHAR(max)) ;;
  }

  dimension: telephone {
    type: string
   sql: cast(${TABLE}.telephone as NVARCHAR(max)) ;;
  }

  dimension: title {
    type: string
    sql: cast(${TABLE}.title as NVARCHAR(max)) ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name]
  }
}
