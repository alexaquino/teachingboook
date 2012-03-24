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

ActiveRecord::Schema.define(:version => 20120127153129) do

  create_table "alunos_turmas", :id => false, :force => true do |t|
    t.integer "aluno_id", :limit => 8
    t.integer "turma_id", :limit => 8
  end

  add_index "alunos_turmas", ["aluno_id", "turma_id"], :name => "index_alunos_turmas_on_aluno_id_and_turma_id", :unique => true

  create_table "documents", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mensagens", :force => true do |t|
    t.text     "conteudo"
    t.integer  "autor_id",       :limit => 8
    t.integer  "recebedor_id",   :limit => 8
    t.string   "recebedor_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "post_id"
    t.float    "nota"
  end

  add_index "mensagens", ["recebedor_id"], :name => "index_mensagens_on_recebedor_id"
  add_index "mensagens", ["recebedor_type"], :name => "index_mensagens_on_recebedor_type"

  create_table "questoes", :force => true do |t|
    t.text     "pergunta"
    t.integer  "autor_id",   :limit => 8
    t.integer  "turma_id",   :limit => 8
    t.string   "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "turmas", :force => true do |t|
    t.string   "disciplina"
    t.integer  "professor_id", :limit => 8
    t.integer  "group_id",     :limit => 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "usuarios", :force => true do |t|
    t.integer  "fb_id",           :limit => 8
    t.string   "nome"
    t.date     "data_nascimento"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
