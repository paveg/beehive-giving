class InitSchema < ActiveRecord::Migration[5.0]
  def up

    # These are extensions that must be enabled in order to support this database
    enable_extension "plpgsql"

    create_table "active_admin_comments", force: :cascade do |t|
      t.string   "namespace"
      t.text     "body"
      t.string   "resource_id",   null: false
      t.string   "resource_type", null: false
      t.string   "author_type"
      t.integer  "author_id"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
      t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
      t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
    end

    create_table "admin_users", force: :cascade do |t|
      t.string   "email",                  default: "", null: false
      t.string   "encrypted_password",     default: "", null: false
      t.string   "reset_password_token"
      t.datetime "reset_password_sent_at"
      t.datetime "remember_created_at"
      t.integer  "sign_in_count",          default: 0,  null: false
      t.datetime "current_sign_in_at"
      t.datetime "last_sign_in_at"
      t.inet     "current_sign_in_ip"
      t.inet     "last_sign_in_ip"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.index ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
      t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree
    end

    create_table "age_groups", force: :cascade do |t|
      t.string   "label"
      t.integer  "age_from"
      t.integer  "age_to"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "age_groups_funder_attributes", force: :cascade do |t|
      t.integer "age_group_id"
      t.integer "funder_attribute_id"
      t.index ["age_group_id", "funder_attribute_id"], name: "index_age_groups_funder_attributes", using: :btree
    end

    create_table "age_groups_profiles", force: :cascade do |t|
      t.integer "age_group_id"
      t.integer "profile_id"
      t.index ["age_group_id", "profile_id"], name: "index_age_groups_profiles_on_age_group_id_and_profile_id", using: :btree
    end

    create_table "age_groups_proposals", force: :cascade do |t|
      t.integer "age_group_id"
      t.integer "proposal_id"
      t.index ["age_group_id", "proposal_id"], name: "index_age_groups_proposals_on_age_group_id_and_proposal_id", using: :btree
    end

    create_table "approval_months", force: :cascade do |t|
      t.string "month"
    end

    create_table "approval_months_funder_attributes", force: :cascade do |t|
      t.integer "funder_attribute_id"
      t.integer "approval_month_id"
      t.index ["approval_month_id", "funder_attribute_id"], name: "index_approval_months_funder_attributes", using: :btree
      t.index ["approval_month_id"], name: "index_approval_months_funder_attributes_on_approval_month_id", using: :btree
      t.index ["funder_attribute_id"], name: "index_approval_months_funder_attributes_on_funder_attribute_id", using: :btree
    end

    create_table "beneficiaries", force: :cascade do |t|
      t.string   "label"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string   "category"
      t.string   "sort"
    end

    create_table "beneficiaries_funder_attributes", force: :cascade do |t|
      t.integer  "funder_attribute_id"
      t.integer  "beneficiary_id"
      t.datetime "created_at",          null: false
      t.datetime "updated_at",          null: false
      t.index ["beneficiary_id", "funder_attribute_id"], name: "index_beneficiaries_funder_attributes", using: :btree
      t.index ["beneficiary_id"], name: "index_beneficiaries_funder_attributes_on_beneficiary_id", using: :btree
    end

    create_table "beneficiaries_profiles", force: :cascade do |t|
      t.integer "beneficiary_id"
      t.integer "profile_id"
      t.index ["beneficiary_id", "profile_id"], name: "index_beneficiaries_profiles_on_beneficiary_id_and_profile_id", using: :btree
      t.index ["beneficiary_id"], name: "index_beneficiaries_profiles_on_beneficiary_id", using: :btree
      t.index ["profile_id"], name: "index_beneficiaries_profiles_on_profile_id", using: :btree
    end

    create_table "beneficiaries_proposals", force: :cascade do |t|
      t.integer "beneficiary_id"
      t.integer "proposal_id"
      t.index ["beneficiary_id"], name: "index_beneficiaries_proposals_on_beneficiary_id", using: :btree
      t.index ["proposal_id"], name: "index_beneficiaries_proposals_on_proposal_id", using: :btree
    end

    create_table "countries", force: :cascade do |t|
      t.string  "name"
      t.string  "alpha2"
      t.integer "priority", default: 0
      t.index ["name", "alpha2"], name: "index_countries_on_name_and_alpha2", unique: true, using: :btree
    end

    create_table "countries_funder_attributes", force: :cascade do |t|
      t.integer "funder_attribute_id"
      t.integer "country_id"
      t.index ["country_id", "funder_attribute_id"], name: "index_countries_funder_attributes", using: :btree
      t.index ["country_id"], name: "index_countries_funder_attributes_on_country_id", using: :btree
      t.index ["funder_attribute_id"], name: "index_countries_funder_attributes_on_funder_attribute_id", using: :btree
    end

    create_table "countries_funds", force: :cascade do |t|
      t.integer  "country_id"
      t.integer  "fund_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["country_id"], name: "index_countries_funds_on_country_id", using: :btree
      t.index ["fund_id"], name: "index_countries_funds_on_fund_id", using: :btree
    end

    create_table "countries_grants", force: :cascade do |t|
      t.integer  "country_id"
      t.integer  "grant_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["country_id", "grant_id"], name: "index_countries_grants_on_country_id_and_grant_id", using: :btree
      t.index ["country_id"], name: "index_countries_grants_on_country_id", using: :btree
      t.index ["grant_id"], name: "index_countries_grants_on_grant_id", using: :btree
    end

    create_table "countries_profiles", force: :cascade do |t|
      t.integer "country_id"
      t.integer "profile_id"
      t.index ["country_id", "profile_id"], name: "index_countries_profiles_on_country_id_and_profile_id", using: :btree
      t.index ["country_id"], name: "index_countries_profiles_on_country_id", using: :btree
      t.index ["profile_id"], name: "index_countries_profiles_on_profile_id", using: :btree
    end

    create_table "countries_proposals", force: :cascade do |t|
      t.integer "country_id"
      t.integer "proposal_id"
      t.index ["country_id"], name: "index_countries_proposals_on_country_id", using: :btree
      t.index ["proposal_id"], name: "index_countries_proposals_on_proposal_id", using: :btree
    end

    create_table "deadlines", force: :cascade do |t|
      t.integer  "fund_id"
      t.datetime "deadline"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["fund_id"], name: "index_deadlines_on_fund_id", using: :btree
    end

    create_table "decision_makers", force: :cascade do |t|
      t.string   "name"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "decision_makers_funds", force: :cascade do |t|
      t.integer  "decision_maker_id"
      t.integer  "fund_id"
      t.datetime "created_at",        null: false
      t.datetime "updated_at",        null: false
      t.index ["decision_maker_id"], name: "index_decision_makers_funds_on_decision_maker_id", using: :btree
      t.index ["fund_id"], name: "index_decision_makers_funds_on_fund_id", using: :btree
    end

    create_table "districts", force: :cascade do |t|
      t.integer "country_id"
      t.string  "name"
      t.string  "subdivision"
      t.text    "geometry"
      t.string  "slug"
      t.string  "indices_year"
      t.integer "indices_rank"
      t.float   "indices_rank_proportion_most_deprived_ten_percent"
      t.integer "indices_income_rank"
      t.float   "indices_income_proportion_most_deprived_ten_percent"
      t.integer "indices_employment_rank"
      t.float   "indices_employment_proportion_most_deprived_ten_percent"
      t.integer "indices_education_rank"
      t.float   "indices_education_proportion_most_deprived_ten_percent"
      t.integer "indices_health_rank"
      t.float   "indices_health_proportion_most_deprived_ten_percent"
      t.integer "indices_crime_rank"
      t.float   "indices_crime_proportion_most_deprived_ten_percent"
      t.integer "indices_barriers_rank"
      t.float   "indices_barriers_proportion_most_deprived_ten_percent"
      t.integer "indices_living_rank"
      t.float   "indices_living_proportion_most_deprived_ten_percent"
      t.string  "region"
      t.string  "sub_country"
      t.index ["country_id"], name: "index_districts_on_country_id", using: :btree
    end

    create_table "districts_funder_attributes", force: :cascade do |t|
      t.integer  "funder_attribute_id"
      t.integer  "district_id"
      t.datetime "created_at",          null: false
      t.datetime "updated_at",          null: false
      t.index ["district_id", "funder_attribute_id"], name: "index_districts_funder_attributes", using: :btree
      t.index ["district_id"], name: "index_districts_funder_attributes_on_district_id", using: :btree
      t.index ["funder_attribute_id"], name: "index_districts_funder_attributes_on_funder_attribute_id", using: :btree
    end

    create_table "districts_funds", force: :cascade do |t|
      t.integer  "district_id"
      t.integer  "fund_id"
      t.datetime "created_at",  null: false
      t.datetime "updated_at",  null: false
      t.index ["district_id"], name: "index_districts_funds_on_district_id", using: :btree
      t.index ["fund_id"], name: "index_districts_funds_on_fund_id", using: :btree
    end

    create_table "districts_grants", force: :cascade do |t|
      t.integer  "district_id"
      t.integer  "grant_id"
      t.datetime "created_at",  null: false
      t.datetime "updated_at",  null: false
      t.index ["district_id", "grant_id"], name: "index_districts_grants_on_district_id_and_grant_id", using: :btree
      t.index ["district_id"], name: "index_districts_grants_on_district_id", using: :btree
      t.index ["grant_id"], name: "index_districts_grants_on_grant_id", using: :btree
    end

    create_table "districts_profiles", force: :cascade do |t|
      t.integer "district_id"
      t.integer "profile_id"
      t.index ["district_id", "profile_id"], name: "index_districts_profiles_on_district_id_and_profile_id", using: :btree
      t.index ["district_id"], name: "index_districts_profiles_on_district_id", using: :btree
      t.index ["profile_id"], name: "index_districts_profiles_on_profile_id", using: :btree
    end

    create_table "districts_proposals", force: :cascade do |t|
      t.integer "district_id"
      t.integer "proposal_id"
      t.index ["district_id"], name: "index_districts_proposals_on_district_id", using: :btree
      t.index ["proposal_id"], name: "index_districts_proposals_on_proposal_id", using: :btree
    end

    create_table "documents", force: :cascade do |t|
      t.string   "name"
      t.string   "link"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "documents_funds", force: :cascade do |t|
      t.integer  "document_id"
      t.integer  "fund_id"
      t.datetime "created_at",  null: false
      t.datetime "updated_at",  null: false
      t.index ["document_id"], name: "index_documents_funds_on_document_id", using: :btree
      t.index ["fund_id"], name: "index_documents_funds_on_fund_id", using: :btree
    end

    create_table "eligibilities", force: :cascade do |t|
      t.integer  "category_id",                         null: false
      t.integer  "restriction_id",                      null: false
      t.boolean  "eligible",                            null: false
      t.datetime "created_at",                          null: false
      t.datetime "updated_at",                          null: false
      t.string   "category_type",  default: "Proposal", null: false
      t.index ["category_id"], name: "index_eligibilities_on_category_id", using: :btree
      t.index ["category_type"], name: "index_eligibilities_on_category_type", using: :btree
      t.index ["restriction_id"], name: "index_eligibilities_on_restriction_id", using: :btree
    end

    create_table "enquiries", force: :cascade do |t|
      t.integer  "recipient_id"
      t.integer  "funder_id"
      t.boolean  "new_project"
      t.boolean  "new_location"
      t.integer  "amount_seeking"
      t.integer  "duration_seeking"
      t.datetime "created_at",                        null: false
      t.datetime "updated_at",                        null: false
      t.integer  "approach_funder_count", default: 0
      t.string   "funding_stream"
      t.integer  "fund_id"
      t.integer  "proposal_id"
      t.index ["fund_id"], name: "index_enquiries_on_fund_id", using: :btree
      t.index ["funder_id"], name: "index_enquiries_on_funder_id", using: :btree
      t.index ["proposal_id"], name: "index_enquiries_on_proposal_id", using: :btree
      t.index ["recipient_id"], name: "index_enquiries_on_recipient_id", using: :btree
    end

    create_table "features", force: :cascade do |t|
      t.integer  "funder_id"
      t.integer  "recipient_id"
      t.boolean  "data_requested"
      t.datetime "created_at",                 null: false
      t.datetime "updated_at",                 null: false
      t.boolean  "request_amount_awarded"
      t.boolean  "request_funding_dates"
      t.boolean  "request_funding_countries"
      t.boolean  "request_grant_count"
      t.boolean  "request_applications_count"
      t.boolean  "request_enquiry_count"
      t.boolean  "request_funding_types"
      t.boolean  "request_funding_streams"
      t.boolean  "request_approval_months"
      t.index ["funder_id"], name: "index_features_on_funder_id", using: :btree
      t.index ["recipient_id"], name: "index_features_on_recipient_id", using: :btree
    end

    create_table "feedbacks", force: :cascade do |t|
      t.integer  "user_id"
      t.integer  "nps"
      t.integer  "taken_away"
      t.integer  "informs_decision"
      t.text     "other"
      t.datetime "created_at",            null: false
      t.datetime "updated_at",            null: false
      t.string   "application_frequency"
      t.string   "grant_frequency"
      t.string   "marketing_frequency"
      t.integer  "price"
      t.string   "most_useful"
      t.integer  "suitable"
      t.index ["user_id"], name: "index_feedbacks_on_user_id", using: :btree
    end

    create_table "funder_attributes", force: :cascade do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "funder_id"
      t.string   "period"
      t.integer  "grant_count"
      t.integer  "application_count"
      t.integer  "enquiry_count"
      t.string   "non_financial_support"
      t.decimal  "funding_size_average"
      t.decimal  "funding_size_min"
      t.decimal  "funding_size_max"
      t.decimal  "funding_duration_average"
      t.decimal  "funding_duration_min"
      t.decimal  "funding_duration_max"
      t.decimal  "funded_average_age"
      t.decimal  "funded_average_income"
      t.decimal  "funded_average_paid_staff"
      t.string   "funding_stream"
      t.integer  "year"
      t.integer  "beneficiary_min_age"
      t.integer  "beneficiary_max_age"
      t.decimal  "funded_age_temp"
      t.decimal  "funded_income_temp"
      t.string   "application_link"
      t.string   "application_details"
      t.text     "soft_restrictions"
      t.text     "approval_months_by_count"
      t.string   "approval_months_by_giving"
      t.string   "countries_by_count"
      t.string   "countries_by_giving"
      t.string   "regions_by_count"
      t.string   "regions_by_giving"
      t.string   "funding_streams_by_count"
      t.string   "funding_streams_by_giving"
      t.text     "description"
      t.text     "map_data"
      t.text     "shared_recipient_ids"
      t.integer  "no_of_recipients_funded"
      t.index ["funder_id"], name: "index_funder_attributes_on_funder_id", using: :btree
    end

    create_table "funder_attributes_funding_types", force: :cascade do |t|
      t.integer "funder_attribute_id"
      t.integer "funding_type_id"
      t.index ["funder_attribute_id", "funding_type_id"], name: "index_funder_attributes_funding_types", using: :btree
      t.index ["funder_attribute_id"], name: "index_funder_attributes_funding_types_on_funder_attribute_id", using: :btree
      t.index ["funding_type_id"], name: "index_funder_attributes_funding_types_on_funding_type_id", using: :btree
    end

    create_table "funding_streams", force: :cascade do |t|
      t.string   "label"
      t.string   "group"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "funding_streams_organisations", force: :cascade do |t|
      t.integer  "funder_id"
      t.integer  "funding_stream_id"
      t.datetime "created_at",        null: false
      t.datetime "updated_at",        null: false
      t.index ["funder_id", "funding_stream_id"], name: "index_funding_streams_organisations", using: :btree
      t.index ["funder_id"], name: "index_funding_streams_organisations_on_funder_id", using: :btree
      t.index ["funding_stream_id"], name: "index_funding_streams_organisations_on_funding_stream_id", using: :btree
    end

    create_table "funding_streams_restrictions", force: :cascade do |t|
      t.integer  "funding_stream_id"
      t.integer  "restriction_id"
      t.datetime "created_at",        null: false
      t.datetime "updated_at",        null: false
      t.index ["funding_stream_id", "restriction_id"], name: "index_funding_streams_restrictions", using: :btree
      t.index ["funding_stream_id"], name: "index_funding_streams_restrictions_on_funding_stream_id", using: :btree
      t.index ["restriction_id"], name: "index_funding_streams_restrictions_on_restriction_id", using: :btree
    end

    create_table "funding_types", force: :cascade do |t|
      t.string "label"
      t.index ["label"], name: "index_funding_types_on_label", unique: true, using: :btree
    end

    create_table "funding_types_funds", force: :cascade do |t|
      t.integer  "funding_type_id"
      t.integer  "fund_id"
      t.datetime "created_at",      null: false
      t.datetime "updated_at",      null: false
      t.index ["fund_id"], name: "index_funding_types_funds_on_fund_id", using: :btree
      t.index ["funding_type_id"], name: "index_funding_types_funds_on_funding_type_id", using: :btree
    end

    create_table "funds", force: :cascade do |t|
      t.integer  "funder_id"
      t.string   "type_of_fund"
      t.string   "name"
      t.text     "description"
      t.string   "slug"
      t.boolean  "open_call"
      t.boolean  "active"
      t.text     "key_criteria"
      t.string   "currency"
      t.string   "application_link"
      t.boolean  "amount_known"
      t.boolean  "amount_min_limited"
      t.boolean  "amount_max_limited"
      t.integer  "amount_min"
      t.integer  "amount_max"
      t.text     "amount_notes"
      t.boolean  "duration_months_known"
      t.boolean  "duration_months_min_limited"
      t.boolean  "duration_months_max_limited"
      t.integer  "duration_months_min"
      t.integer  "duration_months_max"
      t.text     "duration_months_notes"
      t.boolean  "deadlines_known"
      t.boolean  "deadlines_limited"
      t.integer  "decision_in_months"
      t.boolean  "stages_known"
      t.integer  "stages_count"
      t.text     "match_funding_restrictions"
      t.text     "payment_procedure"
      t.boolean  "accepts_calls_known"
      t.boolean  "accepts_calls"
      t.string   "contact_number"
      t.string   "contact_email"
      t.integer  "geographic_scale"
      t.boolean  "geographic_scale_limited"
      t.boolean  "restrictions_known"
      t.boolean  "outcomes_known"
      t.boolean  "documents_known"
      t.boolean  "decision_makers_known"
      t.datetime "created_at",                                           null: false
      t.datetime "updated_at",                                           null: false
      t.boolean  "open_data",                            default: false
      t.date     "period_start"
      t.date     "period_end"
      t.integer  "grant_count"
      t.integer  "recipient_count"
      t.float    "amount_awarded_sum"
      t.float    "amount_awarded_mean"
      t.float    "amount_awarded_median"
      t.float    "amount_awarded_min"
      t.float    "amount_awarded_max"
      t.jsonb    "amount_awarded_distribution",          default: {},    null: false
      t.float    "duration_awarded_months_mean"
      t.float    "duration_awarded_months_median"
      t.float    "duration_awarded_months_min"
      t.float    "duration_awarded_months_max"
      t.jsonb    "duration_awarded_months_distribution", default: {},    null: false
      t.jsonb    "award_month_distribution",             default: {},    null: false
      t.jsonb    "org_type_distribution",                default: {},    null: false
      t.jsonb    "operating_for_distribution",           default: {},    null: false
      t.jsonb    "income_distribution",                  default: {},    null: false
      t.jsonb    "employees_distribution",               default: {},    null: false
      t.jsonb    "volunteers_distribution",              default: {},    null: false
      t.jsonb    "gender_distribution",                  default: {},    null: false
      t.jsonb    "age_group_distribution",               default: {},    null: false
      t.jsonb    "beneficiary_distribution",             default: {},    null: false
      t.jsonb    "geographic_scale_distribution",        default: {},    null: false
      t.jsonb    "country_distribution",                 default: {},    null: false
      t.jsonb    "district_distribution",                default: {},    null: false
      t.jsonb    "tags",                                 default: [],    null: false
      t.jsonb    "restriction_ids",                      default: [],    null: false
      t.jsonb    "sources",                              default: {},    null: false
      t.index ["funder_id"], name: "index_funds_on_funder_id", using: :btree
      t.index ["slug"], name: "index_funds_on_slug", using: :btree
      t.index ["tags"], name: "index_funds_on_tags", using: :gin
    end

    create_table "funds_outcomes", force: :cascade do |t|
      t.integer  "fund_id"
      t.integer  "outcome_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["fund_id"], name: "index_funds_outcomes_on_fund_id", using: :btree
      t.index ["outcome_id"], name: "index_funds_outcomes_on_outcome_id", using: :btree
    end

    create_table "funds_restrictions", force: :cascade do |t|
      t.integer  "fund_id"
      t.integer  "restriction_id"
      t.datetime "created_at",     null: false
      t.datetime "updated_at",     null: false
      t.index ["fund_id"], name: "index_funds_restrictions_on_fund_id", using: :btree
      t.index ["restriction_id"], name: "index_funds_restrictions_on_restriction_id", using: :btree
    end

    create_table "grants", force: :cascade do |t|
      t.integer  "funder_id"
      t.integer  "recipient_id"
      t.string   "funding_stream"
      t.string   "grant_type"
      t.string   "attention_how"
      t.integer  "amount_awarded"
      t.integer  "amount_applied"
      t.integer  "installments"
      t.date     "approved_on"
      t.date     "start_on"
      t.date     "end_on"
      t.date     "attention_on"
      t.date     "applied_on"
      t.datetime "created_at",                     null: false
      t.datetime "updated_at",                     null: false
      t.integer  "days_from_attention_to_applied"
      t.integer  "days_from_applied_to_approved"
      t.integer  "days_form_approval_to_start"
      t.integer  "days_from_start_to_end"
      t.boolean  "open_call"
      t.index ["funder_id", "recipient_id"], name: "index_grants_on_funder_id_and_recipient_id", using: :btree
      t.index ["funder_id"], name: "index_grants_on_funder_id", using: :btree
      t.index ["recipient_id"], name: "index_grants_on_recipient_id", using: :btree
    end

    create_table "implementations", force: :cascade do |t|
      t.string   "label"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "implementations_profiles", force: :cascade do |t|
      t.integer "implementation_id"
      t.integer "profile_id"
      t.index ["implementation_id", "profile_id"], name: "index_implementations_profiles", using: :btree
      t.index ["implementation_id"], name: "index_implementations_profiles_on_implementation_id", using: :btree
      t.index ["profile_id"], name: "index_implementations_profiles_on_profile_id", using: :btree
    end

    create_table "implementations_proposals", force: :cascade do |t|
      t.integer "implementation_id"
      t.integer "proposal_id"
      t.index ["implementation_id", "proposal_id"], name: "index_implementations_proposals", using: :btree
    end

    create_table "implementors", force: :cascade do |t|
      t.string   "label"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "implementors_profiles", force: :cascade do |t|
      t.integer "implementor_id"
      t.integer "profile_id"
      t.index ["implementor_id", "profile_id"], name: "index_implementors_profiles_on_implementor_id_and_profile_id", using: :btree
      t.index ["implementor_id"], name: "index_implementors_profiles_on_implementor_id", using: :btree
      t.index ["profile_id"], name: "index_implementors_profiles_on_profile_id", using: :btree
    end

    create_table "organisations", force: :cascade do |t|
      t.string   "name"
      t.string   "contact_number"
      t.string   "website"
      t.string   "street_address"
      t.string   "city"
      t.string   "region"
      t.string   "postal_code"
      t.string   "country"
      t.string   "charity_number"
      t.string   "company_number"
      t.string   "slug"
      t.string   "type"
      t.text     "mission"
      t.string   "status",                          default: "Active - currently operational"
      t.date     "founded_on"
      t.date     "registered_on"
      t.boolean  "registered"
      t.boolean  "active_on_beehive"
      t.datetime "created_at",                                                                 null: false
      t.datetime "updated_at",                                                                 null: false
      t.integer  "recipient_funder_accesses_count"
      t.integer  "org_type"
      t.float    "latitude"
      t.float    "longitude"
      t.string   "contact_email"
      t.string   "charity_name"
      t.string   "charity_status"
      t.float    "charity_income"
      t.float    "charity_spending"
      t.string   "charity_recent_accounts_link"
      t.string   "charity_trustees"
      t.string   "charity_employees"
      t.string   "charity_volunteers"
      t.string   "charity_year_ending"
      t.string   "charity_days_overdue"
      t.string   "charity_registered_date"
      t.string   "company_name"
      t.string   "company_type"
      t.string   "company_status"
      t.date     "company_incorporated_date"
      t.date     "company_last_accounts_date"
      t.date     "company_next_accounts_date"
      t.date     "company_next_returns_date"
      t.date     "company_last_returns_date"
      t.text     "company_sic",                                                                             array: true
      t.string   "company_recent_accounts_link"
      t.integer  "grants_count",                    default: 0
      t.integer  "operating_for"
      t.boolean  "multi_national"
      t.integer  "income"
      t.integer  "employees"
      t.integer  "volunteers"
      t.integer  "funds_checked",                   default: 0,                                null: false
      t.index ["id", "type"], name: "index_organisations_on_id_and_type", using: :btree
      t.index ["slug"], name: "index_organisations_on_slug", unique: true, using: :btree
    end

    create_table "outcomes", force: :cascade do |t|
      t.string   "outcome"
      t.string   "link"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "profiles", force: :cascade do |t|
      t.integer  "organisation_id"
      t.string   "gender"
      t.string   "currency"
      t.integer  "year"
      t.integer  "min_age"
      t.integer  "max_age"
      t.integer  "income"
      t.integer  "expenditure"
      t.integer  "volunteer_count"
      t.integer  "staff_count"
      t.integer  "job_role_count"
      t.integer  "department_count"
      t.integer  "goods_count"
      t.integer  "units_count"
      t.integer  "services_count"
      t.integer  "beneficiaries_count"
      t.boolean  "income_actual"
      t.boolean  "expenditure_actual"
      t.boolean  "beneficiaries_count_actual"
      t.boolean  "units_count_actual"
      t.datetime "created_at",                     null: false
      t.datetime "updated_at",                     null: false
      t.boolean  "does_sell"
      t.integer  "trustee_count"
      t.string   "state"
      t.boolean  "beneficiaries_other_required"
      t.string   "beneficiaries_other"
      t.boolean  "implementors_other_required"
      t.string   "implementors_other"
      t.boolean  "implementations_other_required"
      t.string   "implementations_other"
      t.boolean  "affect_people"
      t.boolean  "affect_other"
      t.index ["organisation_id"], name: "index_profiles_on_organisation_id", using: :btree
      t.index ["state"], name: "index_profiles_on_state", using: :btree
    end

    create_table "proposals", force: :cascade do |t|
      t.integer  "recipient_id"
      t.string   "title"
      t.string   "tagline"
      t.string   "gender"
      t.string   "outcome1"
      t.string   "outcome2"
      t.string   "outcome3"
      t.string   "outcome4"
      t.string   "outcome5"
      t.string   "beneficiaries_other"
      t.integer  "min_age"
      t.integer  "max_age"
      t.integer  "beneficiaries_count"
      t.integer  "funding_duration"
      t.float    "activity_costs"
      t.float    "people_costs"
      t.float    "capital_costs"
      t.float    "other_costs"
      t.float    "total_costs"
      t.boolean  "activity_costs_estimated",       default: false
      t.boolean  "people_costs_estimated",         default: false
      t.boolean  "capital_costs_estimated",        default: false
      t.boolean  "other_costs_estimated",          default: false
      t.boolean  "all_funding_required"
      t.boolean  "beneficiaries_other_required"
      t.datetime "created_at",                                         null: false
      t.datetime "updated_at",                                         null: false
      t.string   "type_of_support"
      t.string   "state",                          default: "initial"
      t.boolean  "affect_people"
      t.boolean  "affect_other"
      t.integer  "affect_geo"
      t.boolean  "total_costs_estimated",          default: false
      t.string   "funding_type"
      t.boolean  "private"
      t.boolean  "implementations_other_required"
      t.string   "implementations_other"
      t.jsonb    "recommended_funds",              default: []
      t.jsonb    "eligible_funds",                 default: []
      t.jsonb    "ineligible_funds",               default: []
      t.jsonb    "eligibility",                    default: {},        null: false
      t.index ["recipient_id"], name: "index_proposals_on_recipient_id", using: :btree
      t.index ["state"], name: "index_proposals_on_state", using: :btree
    end

    create_table "recipient_funder_accesses", force: :cascade do |t|
      t.integer  "recipient_id"
      t.integer  "funder_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "recommendations", force: :cascade do |t|
      t.integer  "funder_id"
      t.integer  "recipient_id"
      t.float    "score",                         default: 0.0
      t.datetime "created_at",                                  null: false
      t.datetime "updated_at",                                  null: false
      t.string   "recommendation_quality"
      t.string   "eligibility"
      t.float    "grant_amount_recommendation",   default: 0.0
      t.float    "grant_duration_recommendation", default: 0.0
      t.float    "total_recommendation",          default: 0.0
      t.float    "org_type_score"
      t.float    "beneficiary_score"
      t.float    "location_score"
      t.integer  "proposal_id"
      t.integer  "fund_id"
      t.string   "fund_slug"
      t.index ["funder_id"], name: "index_recommendations_on_funder_id", using: :btree
      t.index ["proposal_id", "fund_id"], name: "index_recommendations_on_proposal_id_and_fund_id", unique: true, using: :btree
      t.index ["proposal_id", "fund_slug"], name: "index_recommendations_on_proposal_id_and_fund_slug", unique: true, using: :btree
      t.index ["recipient_id"], name: "index_recommendations_on_recipient_id", using: :btree
    end

    create_table "restrictions", force: :cascade do |t|
      t.string   "details",                            null: false
      t.datetime "created_at",                         null: false
      t.datetime "updated_at",                         null: false
      t.boolean  "invert",        default: false,      null: false
      t.string   "category",      default: "Proposal", null: false
      t.boolean  "has_condition", default: false,      null: false
      t.string   "condition"
    end

    create_table "stages", force: :cascade do |t|
      t.integer  "fund_id"
      t.string   "name"
      t.integer  "position"
      t.boolean  "feedback_provided"
      t.string   "link"
      t.datetime "created_at",        null: false
      t.datetime "updated_at",        null: false
      t.index ["fund_id"], name: "index_stages_on_fund_id", using: :btree
    end

    create_table "subscriptions", force: :cascade do |t|
      t.integer  "organisation_id"
      t.datetime "created_at",                      null: false
      t.datetime "updated_at",                      null: false
      t.string   "stripe_user_id"
      t.boolean  "active",          default: false, null: false
      t.date     "expiry_date"
      t.integer  "percent_off",     default: 0,     null: false
      t.index ["organisation_id"], name: "index_subscriptions_on_organisation_id", using: :btree
      t.index ["stripe_user_id"], name: "index_subscriptions_on_stripe_user_id", unique: true, using: :btree
    end

    create_table "users", force: :cascade do |t|
      t.integer  "organisation_id"
      t.string   "first_name"
      t.string   "last_name"
      t.string   "job_role"
      t.string   "email"
      t.string   "password_digest"
      t.string   "auth_token"
      t.string   "password_reset_token"
      t.string   "role",                   default: "User"
      t.datetime "password_reset_sent_at"
      t.datetime "last_seen"
      t.integer  "sign_in_count",          default: 0
      t.datetime "created_at",                              null: false
      t.datetime "updated_at",                              null: false
      t.boolean  "agree_to_terms"
      t.boolean  "authorised",             default: true
      t.string   "unlock_token"
      t.index ["organisation_id"], name: "index_users_on_organisation_id", using: :btree
    end

    add_foreign_key "deadlines", "funds"
    add_foreign_key "enquiries", "funds"
    add_foreign_key "enquiries", "proposals"
    add_foreign_key "stages", "funds"
  end

  def down
    raise ActiveRecord::IrreversibleMigration, "The initial migration is not revertable"
  end
end
