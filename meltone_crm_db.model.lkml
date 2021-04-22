connection: "m1_azure_db"

# include all the views
include: "*.view"

datagroup: meltone_crm_db_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "24 hours"
}

persist_with: meltone_crm_db_default_datagroup

explore: deals {
  label: "Activity Monitoring"
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

explore: staffing{}
