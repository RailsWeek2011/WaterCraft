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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110725170921) do

  create_table "fish", :force => true do |t|
    t.string   "name",       :default => "Peter"
    t.integer  "race",       :default => 0
    t.integer  "dev",        :default => 1
    t.integer  "con",        :default => 1
    t.integer  "init",       :default => 1
    t.integer  "dex",        :default => 1
    t.integer  "str",        :default => 1
    t.integer  "lvl",        :default => 1
    t.integer  "hp",         :default => 6
    t.integer  "exp",        :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fish_skills", :force => true do |t|
    t.integer  "fish_id"
    t.integer  "skill_id"
    t.integer  "points"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fish_skills", ["fish_id"], :name => "index_fish_skills_on_fish_id"
  add_index "fish_skills", ["skill_id"], :name => "index_fish_skills_on_skill_id"

  create_table "messages", :force => true do |t|
    t.integer  "from_id"
    t.integer  "to_id"
    t.text     "body"
    t.string   "betreff"
    t.string   "to_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skills", :force => true do |t|
    t.string   "name"
    t.integer  "race"
    t.integer  "lvl"
    t.text     "beschreibung"
    t.string   "when"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "",    :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "fish_id"
    t.string   "nick"
    t.string   "image"
    t.integer  "win",                                   :default => 0
    t.integer  "lose",                                  :default => 0
    t.boolean  "isAdmin",                               :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
