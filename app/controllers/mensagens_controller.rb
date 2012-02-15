class MensagensController < ApplicationController
  # GET /mensagens
  # GET /mensagens.xml
  def index
    @mensagens = Mensagem.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mensagens }
    end
  end

  # GET /mensagens/1
  # GET /mensagens/1.xml
  def show
    @mensagem = Mensagem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @mensagem }
    end
  end

  # GET /mensagens/new
  # GET /mensagens/new.xml
  def new
    @mensagem = Mensagem.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mensagem }
    end
  end

  # GET /mensagens/1/edit
  def edit
    @mensagem = Mensagem.find(params[:id])
  end

  # POST /mensagens
  # POST /mensagens.xml
  def create
    @mensagem = Mensagem.new(params[:mensagem])
    @mensagem.autor = session[:current_user]
    id_to_post = String.new
    
    case @mensagem.recebedor_type
    when "Turma"
      aux = Turma.find(@mensagem.recebedor_id)
      id_to_post = aux.group_id
    end
    
    @mensagem.post_id = api_client.put_wall_post(@mensagem.conteudo, {}, id_to_post)['id']

    respond_to do |format|
      if @mensagem.save
        #format.html { redirect_to(@mensagem, :notice => 'Mensagem was successfully created.') }
        format.xml  { render :xml => @mensagem, :status => :created, :location => @mensagem }
        format.js   {}
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @mensagem.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /mensagens/1
  # PUT /mensagens/1.xml
  def update
    @mensagem = Mensagem.find(params[:id])

    respond_to do |format|
      if @mensagem.update_attributes(params[:mensagem])
        #format.html { redirect_to(@mensagem, :notice => 'Nota atualizada com sucesso!') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @mensagem.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /mensagens/1
  # DELETE /mensagens/1.xml
  def destroy
    @mensagem = Mensagem.find(params[:id])
    api_client.delete_object(@mensagem.post_id)
    @mensagem.destroy

    respond_to do |format|
      format.xml  { head :ok }
      format.js   { head :ok }
    end
  end
end
