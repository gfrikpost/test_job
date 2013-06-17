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

ActiveRecord::Schema.define(:version => 20130615092610) do

  create_table "evaluations", :force => true do |t|
    t.integer  "student_id"
    t.integer  "subject_id"
    t.integer  "semestr"
    t.integer  "evaluation"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "students", :force => true do |t|
    t.string   "name"
    t.string   "surname"
    t.integer  "group_id"
    t.date     "dob"
    t.string   "email"
    t.string   "ip"
    t.decimal  "gpa",              :precision => 8, :scale => 2
    t.text     "characterization"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
  end

  add_index "students", ["characterization"], :name => "index_students_on_characterization", :length => {"characterization"=>100}
  add_index "students", ["ip"], :name => "index_students_on_ip", :length => {"ip"=>20}
  add_index "students", ["name"], :name => "index_students_on_name", :length => {"name"=>50}

  create_table "subjects", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
