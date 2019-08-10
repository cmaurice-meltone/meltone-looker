view: funnel {
  derived_table: {
    sql:
        --Identify
        SELECT
          '258248' AS 'funnel_id',
          '1-Identify' AS 'funnel_phase',
          dbo.deals.id AS 'deals_id'
        FROM dbo.deals
        WHERE dbo.deals.phase_id = 258248
              OR dbo.deals.phase_id = 258249
              OR dbo.deals.phase_id = 258250
              OR dbo.deals.phase_id = 258251
              OR dbo.deals.phase_id = 258252
              OR dbo.deals.phase_id = 258253

        UNION

        --Qualify
        SELECT
          '258249' AS 'funnel_id',
          '2-Qualify' AS 'funnel_phase',
          dbo.deals.id AS 'deals_id'
        FROM dbo.deals
        WHERE dbo.deals.phase_id = 258249
              OR dbo.deals.phase_id = 258250
              OR dbo.deals.phase_id = 258251
              OR dbo.deals.phase_id = 258252
              OR dbo.deals.phase_id = 258253

        UNION

        --BID Review
        SELECT
          '258250' AS 'funnel_id',
          '3-BID Review' AS 'funnel_phase',
          dbo.deals.id AS 'deals_id'
        FROM dbo.deals
        WHERE dbo.deals.phase_id = 258250
              OR dbo.deals.phase_id = 258251
              OR dbo.deals.phase_id = 258252
              OR dbo.deals.phase_id = 258253

        UNION

        --Propal Sent
        SELECT
          '258251' AS 'funnel_id',
          '4-Propal Sent' AS 'funnel_phase',
          dbo.deals.id AS 'deals_id'
        FROM dbo.deals
        WHERE dbo.deals.phase_id = 258251
              OR dbo.deals.phase_id = 258252
              OR dbo.deals.phase_id = 258253

        UNION

        --Won
        SELECT
          '258252' AS 'funnel_id',
          '5-Won' AS 'funnel_phase',
          dbo.deals.id AS 'deals_id'
        FROM dbo.deals
        WHERE dbo.deals.phase_id = 258252

        UNION

        --Lost
        SELECT
          '258253' AS 'funnel_id',
          '6-Lost' AS 'funnel_phase',
          dbo.deals.id AS 'deals_id'
        FROM dbo.deals
        WHERE dbo.deals.phase_id = 258253;;
  }

  dimension: funnel_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.funnel_id ;;
  }

  dimension: funnel_phase {
    type: string
    label: "Funnel Phase"
    sql: ${TABLE}.funnel_phase ;;
  }

  dimension: deals_id {
    hidden: yes
    type: number
    sql: ${TABLE}.deals_id ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  set: detail {
    fields: [
      deals.bu,
      deals.customer_name,
      deals.title,
      phases.name,
      sources.name,
      users.trigram,
      deals.expected_decision_date,
      deals.total_price_excl_vat,
      deals.weighted_total_price_excl_vat
      ]
  }
}
