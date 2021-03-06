view: users {
  sql_table_name: dbo.users ;;

  dimension: id {
    primary_key: yes
    hidden: yes
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
    label: "Complete Name"
    type: string
    sql: cast(${TABLE}.name as NVARCHAR(max)) ;;
  }

  dimension: trigram {
    type: string
    label: "Resp."
    sql: CONCAT(UPPER(LEFT(cast(${TABLE}.name as NVARCHAR(max)), 1)), UPPER(SUBSTRING(cast(${TABLE}.name as NVARCHAR(max)), CHARINDEX(' ', cast(${TABLE}.name as NVARCHAR(max)))+1, 2)));;
  }

  dimension: team_id {
    hidden: yes
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
    label: "Nb of Users"
    type: count
    drill_fields: [id, name]
  }
}
