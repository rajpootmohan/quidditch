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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20141115220810) do

  create_table "players", :force => true do |t|
    t.string   "name"
    t.string   "role"
    t.integer  "team_id"
    t.boolean  "active"
    t.integer  "score"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "states", :force => true do |t|
    t.string   "snitch"
    t.string   "quaffle"
    t.string   "reset"
    t.string   "bludger"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "score1"
    t.integer  "score2"
  end

  create_table "teams", :force => true do |t|
    t.integer  "no_of_players"
    t.integer  "score"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

end
