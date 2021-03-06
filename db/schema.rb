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

ActiveRecord::Schema.define(version: 20170209120426) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "benefit_years", force: :cascade do |t|
    t.date     "fy_end_date"
    t.integer  "target_value_cents", limit: 8
    t.integer  "benefit_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "benefit_years", ["benefit_id"], name: "index_benefit_years_on_benefit_id", using: :btree

  create_table "benefits", force: :cascade do |t|
    t.integer  "department_id"
    t.integer  "organisation_id"
    t.integer  "product_id"
    t.string   "location"
    t.text     "original_offering"
    t.text     "non_cts_alternative"
    t.text     "cts_proposal"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.text     "notes"
    t.text     "evidence"
    t.string   "name"
    t.integer  "state_id"
    t.string   "owner"
  end

  add_index "benefits", ["department_id"], name: "index_benefits_on_department_id", using: :btree
  add_index "benefits", ["organisation_id"], name: "index_benefits_on_organisation_id", using: :btree
  add_index "benefits", ["product_id"], name: "index_benefits_on_product_id", using: :btree
  add_index "benefits", ["state_id"], name: "index_benefits_on_state_id", using: :btree

  create_table "contracts", force: :cascade do |t|
    t.string   "reference"
    t.string   "source"
    t.integer  "department_id"
    t.string   "supplier_name"
    t.date     "end_date"
    t.integer  "organisation_id"
    t.string   "project"
    t.string   "product"
    t.integer  "value_cents",        limit: 8
    t.date     "start_date"
    t.float    "years"
    t.string   "sector"
    t.integer  "annual_value_cents", limit: 8
    t.string   "category"
    t.string   "sub_contractors"
    t.text     "notes"
    t.string   "status"
    t.integer  "year_awarded"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "contracts", ["department_id"], name: "index_contracts_on_department_id", using: :btree
  add_index "contracts", ["organisation_id"], name: "index_contracts_on_organisation_id", using: :btree

  create_table "departments", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "total_value_cents", limit: 8
  end

  create_table "deployments", force: :cascade do |t|
    t.integer  "portfolio_id"
    t.integer  "person_id"
    t.integer  "department_id"
    t.integer  "organisation_id"
    t.string   "location"
    t.string   "tech_layer"
    t.text     "existing_solution"
    t.text     "alternative_solution"
    t.text     "cts_solution"
    t.string   "benefit_type"
    t.string   "state"
    t.text     "comments"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "cts_initiative"
  end

  add_index "deployments", ["department_id"], name: "index_deployments_on_department_id", using: :btree
  add_index "deployments", ["organisation_id"], name: "index_deployments_on_organisation_id", using: :btree
  add_index "deployments", ["person_id"], name: "index_deployments_on_person_id", using: :btree
  add_index "deployments", ["portfolio_id"], name: "index_deployments_on_portfolio_id", using: :btree

  create_table "organisations", force: :cascade do |t|
    t.string   "name"
    t.integer  "department_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "organisations", ["department_id"], name: "index_organisations_on_department_id", using: :btree

  create_table "people", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "portfolios", force: :cascade do |t|
    t.string   "name"
    t.integer  "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "portfolios", ["person_id"], name: "index_portfolios_on_person_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "project_code"
  end

  create_table "states", force: :cascade do |t|
    t.string   "name"
    t.integer  "position"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "color"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.boolean  "admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "benefit_years", "benefits"
  add_foreign_key "benefits", "departments"
  add_foreign_key "benefits", "organisations"
  add_foreign_key "benefits", "products"
  add_foreign_key "contracts", "departments"
  add_foreign_key "contracts", "organisations"
  add_foreign_key "deployments", "departments"
  add_foreign_key "deployments", "organisations"
  add_foreign_key "deployments", "people"
  add_foreign_key "deployments", "portfolios"
  add_foreign_key "organisations", "departments"
  add_foreign_key "portfolios", "people"
end
