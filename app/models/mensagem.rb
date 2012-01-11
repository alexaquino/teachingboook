class Mensagem < ActiveRecord::Base
  
  belongs_to :recebedor, :polymorphic => true
  belongs_to :autor, :class_name => "Usuario", :foreign_key => "autor_id"
  
end
