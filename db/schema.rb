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

ActiveRecord::Schema.define(version: 20160823014139) do

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.integer  "failed_attempts",        limit: 4,   default: 0,  null: false
    t.string   "unlock_token",           limit: 255
    t.datetime "locked_at"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "unique_session_id",      limit: 20
  end

  add_index "admins", ["confirmation_token"], name: "index_admins_on_confirmation_token", unique: true, using: :btree
  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree
  add_index "admins", ["unlock_token"], name: "index_admins_on_unlock_token", unique: true, using: :btree

  create_table "answers", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "display_order", limit: 4
    t.integer  "point",         limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "question_id",   limit: 4
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id", using: :btree

  create_table "evaluation_results", force: :cascade do |t|
    t.integer  "staff_id",   limit: 4
    t.integer  "period_id",  limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.float    "score",      limit: 24
  end

  add_index "evaluation_results", ["period_id"], name: "index_evaluation_results_on_period_id", using: :btree
  add_index "evaluation_results", ["staff_id"], name: "index_evaluation_results_on_staff_id", using: :btree

  create_table "evaluation_weights", force: :cascade do |t|
    t.float    "normal_self",                    limit: 24, default: 0.1,  null: false
    t.float    "normal_peer",                    limit: 24, default: 0.15, null: false
    t.float    "normal_manager",                 limit: 24, default: 0.45, null: false
    t.float    "normal_supervisor",              limit: 24, default: 0.3,  null: false
    t.float    "without_peer_self",              limit: 24, default: 0.1,  null: false
    t.float    "without_peer_manager",           limit: 24, default: 0.6,  null: false
    t.float    "without_peer_supervisor",        limit: 24, default: 0.3,  null: false
    t.float    "without_super_self",             limit: 24, default: 0.1,  null: false
    t.float    "without_super_manager",          limit: 24, default: 0.75, null: false
    t.float    "without_super_peer",             limit: 24, default: 0.15, null: false
    t.float    "without_peer_and_super_self",    limit: 24, default: 0.1,  null: false
    t.float    "without_peer_and_super_manager", limit: 24, default: 0.9,  null: false
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
  end

  create_table "evaluations", force: :cascade do |t|
    t.integer  "peer_selection_id", limit: 4
    t.integer  "reviewer_id",       limit: 4
    t.integer  "staff_id",          limit: 4
    t.integer  "period_id",         limit: 4
    t.string   "type",              limit: 255
    t.float    "score",             limit: 24
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "status",            limit: 4
  end

  add_index "evaluations", ["peer_selection_id"], name: "index_evaluations_on_peer_selection_id", using: :btree
  add_index "evaluations", ["period_id"], name: "index_evaluations_on_period_id", using: :btree
  add_index "evaluations", ["reviewer_id"], name: "index_evaluations_on_reviewer_id", using: :btree
  add_index "evaluations", ["staff_id"], name: "index_evaluations_on_staff_id", using: :btree

  create_table "managers", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",   null: false
    t.string   "encrypted_password",     limit: 255, default: "",   null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.integer  "failed_attempts",        limit: 4,   default: 0,    null: false
    t.string   "unlock_token",           limit: 255
    t.datetime "locked_at"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "display_password",       limit: 255
    t.string   "name",                   limit: 255
    t.integer  "job",                    limit: 4
    t.boolean  "active",                             default: true
    t.string   "unique_session_id",      limit: 20
  end

  add_index "managers", ["email"], name: "index_managers_on_email", unique: true, using: :btree
  add_index "managers", ["reset_password_token"], name: "index_managers_on_reset_password_token", unique: true, using: :btree
  add_index "managers", ["unlock_token"], name: "index_managers_on_unlock_token", unique: true, using: :btree

  create_table "peer_selections", force: :cascade do |t|
    t.integer  "period_id",  limit: 4
    t.integer  "staff_id",   limit: 4
    t.string   "reason",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "peer_selections", ["period_id"], name: "index_peer_selections_on_period_id", using: :btree
  add_index "peer_selections", ["staff_id"], name: "index_peer_selections_on_staff_id", using: :btree

  create_table "periods", force: :cascade do |t|
    t.date     "start_time"
    t.date     "end_time"
    t.string   "participant", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "phase",       limit: 4
  end

  create_table "question_groups", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "questions", force: :cascade do |t|
    t.text     "name",              limit: 65535
    t.integer  "display_order",     limit: 4
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.boolean  "active",                          default: true
    t.integer  "question_group_id", limit: 4
    t.string   "short_description", limit: 255
  end

  add_index "questions", ["question_group_id"], name: "index_questions_on_question_group_id", using: :btree

  create_table "rel_evaluation_answers", force: :cascade do |t|
    t.integer  "evaluation_id", limit: 4
    t.string   "comment",       limit: 255
    t.integer  "question_id",   limit: 4
    t.integer  "point",         limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rel_evaluation_answers", ["evaluation_id"], name: "index_rel_evaluation_answers_on_evaluation_id", using: :btree
  add_index "rel_evaluation_answers", ["question_id"], name: "index_rel_evaluation_answers_on_question_id", using: :btree

  create_table "staffs", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.integer  "failed_attempts",        limit: 4,   default: 0,     null: false
    t.string   "unlock_token",           limit: 255
    t.datetime "locked_at"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.string   "display_password",       limit: 255
    t.string   "name",                   limit: 255
    t.integer  "job",                    limit: 4
    t.boolean  "active",                             default: true
    t.string   "unique_session_id",      limit: 20
    t.date     "date_start_work"
    t.boolean  "is_senior",                          default: false, null: false
    t.boolean  "is_supervisor",                      default: false, null: false
    t.integer  "supervisor_id",          limit: 4
  end

  add_index "staffs", ["email"], name: "index_staffs_on_email", unique: true, using: :btree
  add_index "staffs", ["reset_password_token"], name: "index_staffs_on_reset_password_token", unique: true, using: :btree
  add_index "staffs", ["supervisor_id"], name: "index_staffs_on_supervisor_id", using: :btree
  add_index "staffs", ["unlock_token"], name: "index_staffs_on_unlock_token", unique: true, using: :btree

  add_foreign_key "answers", "questions"
  add_foreign_key "evaluation_results", "periods"
  add_foreign_key "evaluation_results", "staffs"
  add_foreign_key "evaluations", "peer_selections"
  add_foreign_key "evaluations", "periods"
  add_foreign_key "evaluations", "staffs"
  add_foreign_key "evaluations", "staffs", column: "reviewer_id"
  add_foreign_key "peer_selections", "periods"
  add_foreign_key "peer_selections", "staffs"
  add_foreign_key "questions", "question_groups"
  add_foreign_key "rel_evaluation_answers", "evaluations"
  add_foreign_key "rel_evaluation_answers", "questions"
end
