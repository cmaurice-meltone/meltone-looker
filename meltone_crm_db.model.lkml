connection: "m1_azure_db"

# include all the views
include: "*.view"

datagroup: meltone_crm_db_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: meltone_crm_db_default_datagroup

explore: deals {
  join: phases {
    type: left_outer
    sql_on: ${deals.phase_id} = ${phases.id} ;;
    relationship: many_to_one
  }

  join: sources {
    type: left_outer
    sql_on: ${deals.source_id} = ${sources.id} ;;
    relationship: many_to_one
  }

  join: users{
    type: left_outer
    sql_on: ${deals.responsible_user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: phases {
  join: deals {
    type: left_outer
    sql_on: ${phases.id} = ${deals.phase_id} ;;
    relationship: one_to_many
  }
}

explore: sources {
  join: deals {
    type: left_outer
    sql_on: ${sources.id} = ${deals.source_id} ;;
    relationship: one_to_many
  }
}

explore: users {
  join: deals {
    type: left_outer
    sql_on: ${users.id} = ${deals.responsible_user_id} ;;
    relationship: one_to_many
  }
}
