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

ActiveRecord::Schema.define(:version => 20110915134323) do

  create_table "mensagens", :force => true do |t|
    t.text     "conteudo"
    t.integer  "usuario_id"
    t.integer  "turma_id"
    t.boolean  "resposta"
    t.integer  "resposta_para_mensagem_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "turmas", :force => true do |t|
    t.string   "disciplina"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "professor_id"
  end

  create_table "turmas_alunos", :id => false, :force => true do |t|
    t.integer "turma_id"
    t.integer "aluno_id"
  end

  create_table "usuarios", :force => true do |t|
    t.integer  "fb_id"
    t.string   "nome"
    t.date     "data_nascimento"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
