# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150818104330) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bonds", force: :cascade do |t|
    t.integer  "citizen_id"
    t.integer  "value",      limit: 8
    t.integer  "issued_on"
    t.integer  "matures_on"
    t.integer  "interest"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "bonds", ["citizen_id", "issued_on", "matures_on"], name: "idx_bonds", using: :btree

  create_table "citizen_careers", force: :cascade do |t|
    t.integer  "citizen_id"
    t.integer  "profession_id"
    t.integer  "career_index",  default: 0
    t.integer  "term_length",   default: 0
    t.boolean  "current",       default: true
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "citizen_careers", ["citizen_id", "current"], name: "index_citizen_careers_on_citizen_id_and_current", using: :btree
  add_index "citizen_careers", ["citizen_id", "profession_id", "career_index"], name: "idx_career_mapping", using: :btree

  create_table "citizen_equipments", force: :cascade do |t|
    t.integer  "citizen_id"
    t.integer  "equipment_type_id"
    t.integer  "quantity",          default: 0
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "citizen_equipments", ["citizen_id", "equipment_type_id"], name: "index_citizen_equipments_on_citizen_id_and_equipment_type_id", using: :btree

  create_table "citizen_skills", force: :cascade do |t|
    t.integer  "citizen_id"
    t.integer  "skill_id"
    t.integer  "rank",       default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "citizen_skills", ["citizen_id", "skill_id"], name: "index_citizen_skills_on_citizen_id_and_skill_id", using: :btree

  create_table "citizen_stories", force: :cascade do |t|
    t.integer  "citizen_id"
    t.integer  "story_id"
    t.boolean  "finished",      default: false
    t.integer  "story_node_id"
    t.integer  "challenges",    default: 0
    t.integer  "threats",       default: 0
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "citizen_stories", ["citizen_id", "story_id", "finished"], name: "idx_citizen_stories", using: :btree

  create_table "citizen_trade_goods", force: :cascade do |t|
    t.integer  "citizen_id"
    t.integer  "trade_good_id"
    t.integer  "quantity",      default: 0
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "citizen_trade_goods", ["citizen_id", "trade_good_id"], name: "index_citizen_trade_goods_on_citizen_id_and_trade_good_id", using: :btree

  create_table "citizens", force: :cascade do |t|
    t.integer  "credits",               limit: 8, default: 0
    t.integer  "home_district_id"
    t.integer  "current_profession_id"
    t.integer  "profession_rank",                 default: 0
    t.integer  "current_project_id"
    t.string   "icon"
    t.integer  "user_id"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "citizens", ["current_project_id"], name: "index_citizens_on_current_project_id", using: :btree
  add_index "citizens", ["home_district_id"], name: "index_citizens_on_home_district_id", using: :btree
  add_index "citizens", ["user_id"], name: "index_citizens_on_user_id", using: :btree

  create_table "commontator_comments", force: :cascade do |t|
    t.string   "creator_type"
    t.integer  "creator_id"
    t.string   "editor_type"
    t.integer  "editor_id"
    t.integer  "thread_id",                     null: false
    t.text     "body",                          null: false
    t.datetime "deleted_at"
    t.integer  "cached_votes_up",   default: 0
    t.integer  "cached_votes_down", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "commontator_comments", ["cached_votes_down"], name: "index_commontator_comments_on_cached_votes_down", using: :btree
  add_index "commontator_comments", ["cached_votes_up"], name: "index_commontator_comments_on_cached_votes_up", using: :btree
  add_index "commontator_comments", ["creator_id", "creator_type", "thread_id"], name: "index_commontator_comments_on_c_id_and_c_type_and_t_id", using: :btree
  add_index "commontator_comments", ["thread_id", "created_at"], name: "index_commontator_comments_on_thread_id_and_created_at", using: :btree

  create_table "commontator_subscriptions", force: :cascade do |t|
    t.string   "subscriber_type", null: false
    t.integer  "subscriber_id",   null: false
    t.integer  "thread_id",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "commontator_subscriptions", ["subscriber_id", "subscriber_type", "thread_id"], name: "index_commontator_subscriptions_on_s_id_and_s_type_and_t_id", unique: true, using: :btree
  add_index "commontator_subscriptions", ["thread_id"], name: "index_commontator_subscriptions_on_thread_id", using: :btree

  create_table "commontator_threads", force: :cascade do |t|
    t.string   "commontable_type"
    t.integer  "commontable_id"
    t.datetime "closed_at"
    t.string   "closer_type"
    t.integer  "closer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "commontator_threads", ["commontable_id", "commontable_type"], name: "index_commontator_threads_on_c_id_and_c_type", unique: true, using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "district_effects", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "district_id"
    t.integer  "started_on"
    t.integer  "expires_on"
    t.boolean  "active",             default: true
    t.string   "name"
    t.text     "description"
    t.string   "icon"
    t.integer  "total_land",         default: 0
    t.integer  "transport_capacity", default: 0
    t.integer  "civilians",          default: 0
    t.integer  "automatons",         default: 0
    t.integer  "unrest",             default: 0
    t.integer  "health",             default: 0
    t.integer  "policing",           default: 0
    t.integer  "social",             default: 0
    t.integer  "environment",        default: 0
    t.integer  "housing",            default: 0
    t.integer  "education",          default: 0
    t.integer  "community",          default: 0
    t.integer  "creativity",         default: 0
    t.integer  "aesthetics",         default: 0
    t.integer  "crime",              default: 0
    t.integer  "corruption",         default: 0
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "district_effects", ["district_id", "active"], name: "index_district_effects_on_district_id_and_active", using: :btree
  add_index "district_effects", ["district_id", "started_on", "expires_on"], name: "idx_district_effects_turn", using: :btree

  create_table "district_snapshots", force: :cascade do |t|
    t.integer  "district_id"
    t.integer  "turn"
    t.integer  "total_land",         default: 0
    t.integer  "free_land",          default: 0
    t.integer  "transport_capacity", default: 0
    t.integer  "civilians",          default: 0
    t.integer  "automatons",         default: 0
    t.integer  "unrest",             default: 0
    t.integer  "health",             default: 0
    t.integer  "policing",           default: 0
    t.integer  "social",             default: 0
    t.integer  "environment",        default: 0
    t.integer  "housing",            default: 0
    t.integer  "education",          default: 0
    t.integer  "community",          default: 0
    t.integer  "creativity",         default: 0
    t.integer  "aesthetics",         default: 0
    t.integer  "crime",              default: 0
    t.integer  "corruption",         default: 0
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "district_snapshots", ["district_id", "turn"], name: "index_district_snapshots_on_district_id_and_turn", using: :btree

  create_table "districts", force: :cascade do |t|
    t.string   "name"
    t.integer  "skill_id"
    t.integer  "total_land",         default: 0
    t.integer  "free_land",          default: 0
    t.integer  "transport_capacity", default: 0
    t.integer  "civilians",          default: 0
    t.integer  "automatons",         default: 0
    t.integer  "unrest",             default: 0
    t.integer  "health",             default: 0
    t.integer  "policing",           default: 0
    t.integer  "social",             default: 0
    t.integer  "environment",        default: 0
    t.integer  "housing",            default: 0
    t.integer  "education",          default: 0
    t.integer  "community",          default: 0
    t.integer  "creativity",         default: 0
    t.integer  "aesthetics",         default: 0
    t.integer  "crime",              default: 0
    t.integer  "corruption",         default: 0
    t.text     "description"
    t.string   "icon"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "districts", ["name"], name: "index_districts_on_name", using: :btree

  create_table "equipment_raw_materials", force: :cascade do |t|
    t.integer  "equipment_type_id"
    t.integer  "trade_good_id"
    t.integer  "quantity",          default: 0
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "equipment_raw_materials", ["equipment_type_id", "trade_good_id"], name: "idx_erm_mapping", using: :btree

  create_table "equipment_types", force: :cascade do |t|
    t.string   "name"
    t.integer  "facility_type_id"
    t.text     "description"
    t.string   "icon"
    t.integer  "skill_id"
    t.integer  "skill_modifier",   default: 0
    t.integer  "exchange_price",   default: 0
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "equipment_types", ["facility_type_id"], name: "index_equipment_types_on_facility_type_id", using: :btree

  create_table "event_resource_costs", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "trade_good_id"
    t.integer  "cost",          default: 0
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "event_resource_costs", ["event_id", "trade_good_id"], name: "index_event_resource_costs_on_event_id_and_trade_good_id", using: :btree

  create_table "event_rewards", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "trade_good_id"
    t.integer  "equipment_type_id"
    t.integer  "facility_type_id"
    t.boolean  "credits",           default: false
    t.integer  "quantity",          default: 0
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "event_rewards", ["event_id"], name: "index_event_rewards_on_event_id", using: :btree

  create_table "event_skill_costs", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "skill_id"
    t.integer  "cost",       default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "event_skill_costs", ["event_id", "skill_id"], name: "index_event_skill_costs_on_event_id_and_skill_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.string   "event_type"
    t.integer  "trigger_after_event_id"
    t.integer  "started_on"
    t.integer  "finished_on"
    t.integer  "max_duration",           default: 0
    t.boolean  "current",                default: true
    t.boolean  "success",                default: false
    t.text     "summary"
    t.text     "description"
    t.integer  "winning_project_id"
    t.string   "icon"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "events", ["event_type", "current"], name: "index_events_on_event_type_and_current", using: :btree
  add_index "events", ["started_on", "finished_on", "success"], name: "index_events_on_started_on_and_finished_on_and_success", using: :btree

  create_table "exchange_equipments", force: :cascade do |t|
    t.integer  "equipment_type_id"
    t.integer  "citizen_id"
    t.integer  "turn"
    t.integer  "price"
    t.integer  "quantity"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "exchange_equipments", ["equipment_type_id", "citizen_id", "turn"], name: "idx_exchange_equipment", using: :btree

  create_table "exchange_trade_goods", force: :cascade do |t|
    t.integer  "trade_good_id"
    t.integer  "citizen_id"
    t.integer  "turn"
    t.integer  "price"
    t.integer  "quantity"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "exchange_trade_goods", ["trade_good_id", "citizen_id", "turn"], name: "idx_exchange_goods", using: :btree

  create_table "facilities", force: :cascade do |t|
    t.integer  "citizen_id"
    t.integer  "facility_type_id"
    t.boolean  "powered",                     default: true
    t.boolean  "maintained",                  default: true
    t.integer  "level",                       default: 1
    t.integer  "producing_trade_good_id"
    t.integer  "producing_equipment_type_id"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "facilities", ["citizen_id", "facility_type_id"], name: "index_facilities_on_citizen_id_and_facility_type_id", using: :btree

  create_table "facility_types", force: :cascade do |t|
    t.string   "name"
    t.integer  "district_id"
    t.text     "description"
    t.string   "icon"
    t.integer  "build_cost",        default: 1000
    t.integer  "maintenance_cost",  default: 100
    t.integer  "employees",         default: 10
    t.integer  "automation",        default: 50
    t.integer  "power_consumption", default: 1
    t.integer  "power_generation",  default: 0
    t.integer  "pollution",         default: 0
    t.integer  "housing_mod",       default: 0
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "facility_types", ["district_id"], name: "index_facility_types_on_district_id", using: :btree

  create_table "financial_transactions", force: :cascade do |t|
    t.integer  "citizen_id"
    t.integer  "turn"
    t.integer  "amount"
    t.string   "reason"
    t.integer  "other_party_id"
    t.string   "other_party_class"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "financial_transactions", ["citizen_id", "turn"], name: "index_financial_transactions_on_citizen_id_and_turn", using: :btree

  create_table "global_effects", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "started_on"
    t.integer  "expires_on"
    t.boolean  "active",         default: true
    t.string   "name"
    t.text     "description"
    t.string   "icon"
    t.integer  "infrastructure", default: 0
    t.integer  "grid",           default: 0
    t.integer  "power",          default: 0
    t.integer  "stability",      default: 0
    t.integer  "climate",        default: 0
    t.integer  "liberty",        default: 0
    t.integer  "security",       default: 0
    t.integer  "borders",        default: 0
    t.integer  "inflation",      default: 0
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "global_effects", ["active"], name: "index_global_effects_on_active", using: :btree
  add_index "global_effects", ["started_on", "expires_on"], name: "index_global_effects_on_started_on_and_expires_on", using: :btree

  create_table "global_snapshots", force: :cascade do |t|
    t.integer  "infrastructure",           default: 0
    t.integer  "grid",           limit: 8, default: 0
    t.integer  "power",          limit: 8, default: 0
    t.integer  "stability",                default: 0
    t.integer  "climate",                  default: 0
    t.integer  "liberty",                  default: 0
    t.integer  "security",                 default: 0
    t.integer  "borders",                  default: 0
    t.integer  "turn",                     default: 0
    t.integer  "inflation",                default: 0
    t.integer  "citizens",                 default: 0
    t.integer  "gdp",            limit: 8, default: 0
    t.integer  "interest",                 default: 0
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "global_snapshots", ["turn"], name: "index_global_snapshots_on_turn", using: :btree

  create_table "globals", force: :cascade do |t|
    t.integer  "infrastructure",           default: 0
    t.integer  "grid",           limit: 8, default: 0
    t.integer  "power",          limit: 8, default: 0
    t.integer  "stability",                default: 0
    t.integer  "climate",                  default: 0
    t.integer  "liberty",                  default: 0
    t.integer  "security",                 default: 0
    t.integer  "borders",                  default: 0
    t.integer  "turn",                     default: 0
    t.integer  "inflation",                default: 0
    t.integer  "citizens",                 default: 0
    t.integer  "gdp",            limit: 8, default: 0
    t.integer  "interest",                 default: 0
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "help_topics", force: :cascade do |t|
    t.string   "name"
    t.integer  "topic_index"
    t.text     "summary"
    t.text     "body"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "loans", force: :cascade do |t|
    t.integer  "citizen_id"
    t.integer  "value",      limit: 8
    t.integer  "issued_on"
    t.integer  "matures_on"
    t.integer  "interest"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "loans", ["citizen_id", "issued_on", "matures_on"], name: "idx_loans", using: :btree

  create_table "petitions", force: :cascade do |t|
    t.integer  "citizen_id"
    t.string   "name"
    t.text     "summary"
    t.boolean  "accepted",                default: false
    t.integer  "turn"
    t.integer  "cached_votes_up",         default: 0
    t.integer  "cached_votes_down",       default: 0
    t.integer  "cached_votes_total",      default: 0
    t.integer  "cached_votes_score",      default: 0
    t.integer  "cached_weighted_score",   default: 0
    t.integer  "cached_weighted_total",   default: 0
    t.float    "cached_weighted_average", default: 0.0
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  create_table "professions", force: :cascade do |t|
    t.string   "name"
    t.string   "profession_group"
    t.text     "description"
    t.string   "icon"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "professions", ["name", "profession_group"], name: "index_professions_on_name_and_profession_group", using: :btree

  create_table "project_members", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "citizen_id"
    t.integer  "joined_on"
    t.boolean  "sabotaging"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "project_members", ["project_id", "citizen_id"], name: "index_project_members_on_project_id_and_citizen_id", using: :btree

  create_table "project_resources", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "trade_good_id"
    t.integer  "quantity",      default: 0
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "project_resources", ["project_id", "trade_good_id"], name: "index_project_resources_on_project_id_and_trade_good_id", using: :btree

  create_table "project_skill_points", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "skill_id"
    t.integer  "points",     default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "project_skill_points", ["project_id", "skill_id"], name: "index_project_skill_points_on_project_id_and_skill_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.integer  "leader_id"
    t.integer  "event_id"
    t.integer  "began_on"
    t.integer  "finished_on"
    t.string   "status",      default: "Started"
    t.integer  "wages"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "projects", ["event_id", "status"], name: "index_projects_on_event_id_and_status", using: :btree
  add_index "projects", ["leader_id"], name: "index_projects_on_leader_id", using: :btree

  create_table "skills", force: :cascade do |t|
    t.string   "name"
    t.string   "skill_group"
    t.text     "description"
    t.string   "icon"
    t.integer  "primary_profession_id"
    t.integer  "secondary_profession_id"
    t.integer  "tertiary_profession_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "skills", ["name", "skill_group"], name: "index_skills_on_name_and_skill_group", using: :btree
  add_index "skills", ["primary_profession_id"], name: "index_skills_on_primary_profession_id", using: :btree
  add_index "skills", ["secondary_profession_id"], name: "index_skills_on_secondary_profession_id", using: :btree
  add_index "skills", ["tertiary_profession_id"], name: "index_skills_on_tertiary_profession_id", using: :btree

  create_table "stories", force: :cascade do |t|
    t.integer  "first_node_id"
    t.integer  "created_by_id"
    t.string   "name"
    t.boolean  "active",        default: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "stories", ["created_by_id", "active"], name: "index_stories_on_created_by_id_and_active", using: :btree

  create_table "story_choices", force: :cascade do |t|
    t.integer  "story_node_id"
    t.text     "description"
    t.string   "choice_type",     default: "Choice"
    t.integer  "success_node_id"
    t.integer  "failure_node_id"
    t.string   "skill_group",     default: ""
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "story_choices", ["failure_node_id"], name: "index_story_choices_on_failure_node_id", using: :btree
  add_index "story_choices", ["story_node_id"], name: "index_story_choices_on_story_node_id", using: :btree
  add_index "story_choices", ["success_node_id"], name: "index_story_choices_on_success_node_id", using: :btree

  create_table "story_node_flags", force: :cascade do |t|
    t.integer  "story_node_id"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "story_node_flags", ["story_node_id", "user_id"], name: "idx_node_flags", using: :btree

  create_table "story_nodes", force: :cascade do |t|
    t.integer  "story_id"
    t.string   "name"
    t.text     "narrative"
    t.string   "icon_css",      default: ""
    t.integer  "created_by_id"
    t.boolean  "active",        default: false
    t.integer  "flagged",       default: 0
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "story_nodes", ["created_by_id"], name: "index_story_nodes_on_created_by_id", using: :btree
  add_index "story_nodes", ["story_id"], name: "index_story_nodes_on_story_id", using: :btree

  create_table "trade_good_raw_materials", force: :cascade do |t|
    t.integer  "trade_good_id"
    t.integer  "raw_material_id"
    t.integer  "quantity",        default: 0
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "trade_good_raw_materials", ["trade_good_id", "raw_material_id"], name: "idx_tgrm_mapping", using: :btree

  create_table "trade_goods", force: :cascade do |t|
    t.string   "name"
    t.integer  "facility_type_id"
    t.integer  "exchange_price",   default: 0
    t.text     "description"
    t.string   "icon"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "trade_goods", ["facility_type_id"], name: "index_trade_goods_on_facility_type_id", using: :btree

  create_table "turn_reports", force: :cascade do |t|
    t.integer  "turn"
    t.integer  "citizen_id"
    t.integer  "district_id"
    t.text     "summary"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "turn_reports", ["turn", "citizen_id"], name: "index_turn_reports_on_turn_and_citizen_id", using: :btree
  add_index "turn_reports", ["turn", "district_id"], name: "index_turn_reports_on_turn_and_district_id", using: :btree
  add_index "turn_reports", ["turn"], name: "index_turn_reports_on_turn", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",       null: false
    t.string   "encrypted_password",     default: "",       null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "failed_attempts",        default: 0,        null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "role",                   default: "player"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree

end
