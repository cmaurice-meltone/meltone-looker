view: phases {
  sql_table_name: dbo.phases ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      name,
      deals.count,
      t_027794304eaf45bebcc306558f085b46.count,
      t_244964b4793246dd8bd9bd8739433146.count,
      t_24f995a9bbd249e6bd4f43d437699ae8.count,
      t_3469566e2ec941eda8662fcda1abb09b.count,
      t_3c112e4055ca4e8fad107103d22b6e98.count,
      t_3e99a08a2bfe41d29755c04489c4d882.count,
      t_489179747420499fa502f3483416500b.count,
      t_5963f831b25e46dc8557a40d637b02e0.count,
      t_59ba144ec9e44d468750c63b0b43a8cb.count,
      t_6408adeeb42043b79682580b7f26e531.count,
      t_64437da0441549219a5bb91b7bae1229.count,
      t_6f72077cf24044838364c77244ae3575.count,
      t_95f19ec45ac1475b8b224f28afeafd65.count,
      t_b92c1e4ab8994e7dafe30664ae3e8f7f.count,
      t_c7c226523b3c4fa096f0c64adfe48610.count,
      t_f37aa068a864459380225c67fd3eca2e.count,
      t_f58129fb61994e089bc1fb07fe089efd.count
    ]
  }
}
