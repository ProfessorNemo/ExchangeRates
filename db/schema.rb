# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_11_08_230551) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "exchange_rates", force: :cascade do |t|
    t.integer "currency", null: false
    t.datetime "rate_at", null: false
    t.float "rate_value", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["currency", "rate_at", "rate_value"], name: "index_exchange_rates_on_currency_and_rate_at_and_rate_value", unique: true
  end

end
