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

ActiveRecord::Schema.define(version: 20160622205323) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "job_activities", force: :cascade do |t|
    t.integer  "job_id"
    t.string   "name",                      null: false
    t.boolean  "active",     default: true, null: false
    t.integer  "created_by",                null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "job_activities", ["job_id"], name: "index_job_activities_on_job_id", using: :btree

  create_table "job_statuses", force: :cascade do |t|
    t.string   "key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jobs", force: :cascade do |t|
    t.integer  "project_id"
    t.string   "title",         default: "",   null: false
    t.text     "description",   default: "",   null: false
    t.datetime "start_at",                     null: false
    t.datetime "finish_at",                    null: false
    t.integer  "milestone",     default: 0,    null: false
    t.integer  "rate",          default: 0,    null: false
    t.integer  "job_status_id"
    t.boolean  "active",        default: true, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "jobs", ["job_status_id"], name: "index_jobs_on_job_status_id", using: :btree
  add_index "jobs", ["project_id"], name: "index_jobs_on_project_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "name",                      null: false
    t.string   "price",      default: "0",  null: false
    t.datetime "start_at",                  null: false
    t.datetime "finish_at",                 null: false
    t.boolean  "active",     default: true, null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "key"
    t.integer  "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.integer  "job_id"
    t.string   "name",        default: "",   null: false
    t.string   "description", default: "",   null: false
    t.boolean  "status",      default: true, null: false
    t.integer  "created_by",                 null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "tasks", ["job_id"], name: "index_tasks_on_job_id", using: :btree

  create_table "user_jobs", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "job_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_jobs", ["job_id"], name: "index_user_jobs_on_job_id", using: :btree
  add_index "user_jobs", ["user_id"], name: "index_user_jobs_on_user_id", using: :btree

  create_table "user_projects", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.integer  "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_projects", ["project_id"], name: "index_user_projects_on_project_id", using: :btree
  add_index "user_projects", ["role_id"], name: "index_user_projects_on_role_id", using: :btree
  add_index "user_projects", ["user_id"], name: "index_user_projects_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
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
    t.string   "username",                            null: false
    t.string   "fullname",                            null: false
    t.string   "initial",                             null: false
    t.boolean  "gender",                              null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "job_activities", "jobs"
  add_foreign_key "jobs", "job_statuses"
  add_foreign_key "jobs", "projects"
  add_foreign_key "tasks", "jobs"
  add_foreign_key "user_jobs", "jobs"
  add_foreign_key "user_jobs", "users"
  add_foreign_key "user_projects", "projects"
  add_foreign_key "user_projects", "roles"
  add_foreign_key "user_projects", "users"
end
