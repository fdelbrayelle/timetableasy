# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100604114319) do

  create_table "campus", :force => true do |t|
    t.string   "nom"
    t.string   "pays"
    t.integer  "user_id"
    t.integer  "espace_id"
    t.integer  "classe_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "classes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "etudiant_id"
    t.integer  "periode_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cours", :force => true do |t|
    t.string   "nom"
    t.integer  "heures_total"
    t.integer  "heures_reste"
    t.integer  "evaluation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cursus", :force => true do |t|
    t.string   "nom"
    t.integer  "periode_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "espaces", :force => true do |t|
    t.string   "code"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "evaluations", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "evenements", :force => true do |t|
    t.string   "nom"
    t.text     "description"
    t.boolean  "readonly"
    t.datetime "debut"
    t.integer  "duree"
    t.integer  "campu_id"
    t.integer  "espace_id"
    t.integer  "intervenant_id"
    t.integer  "user_id"
    t.integer  "role_id"
    t.integer  "classe_id"
    t.integer  "cour_id"
    t.integer  "evaluation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "periodes", :force => true do |t|
    t.string   "nom"
    t.date     "début"
    t.date     "fin"
    t.integer  "cour_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.string   "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_sessions", :force => true do |t|
    t.string   "username"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "password"
    t.string   "password_confirmation"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.string   "nom"
    t.string   "prénom"
    t.string   "email"
    t.date     "date_naissance"
    t.string   "alias"
    t.integer  "evenement_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id"
  end

end
