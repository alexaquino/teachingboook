class QuestoesController < ApplicationController
  helper :send_doc
  include SendDocHelper
  
  # GET /questoes
  # GET /questoes.xml
  def index
    @questoes = Questao.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @questoes }
    end
  end

  # GET /questoes/1
  # GET /questoes/1.xml
  def show
    @questao = Questao.find(params[:id])
    
    load_respostas

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @questao }
    end
  end

  # GET /questoes/new
  # GET /questoes/new.xml
  def new
    @questao = Questao.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @questao }
    end
  end

  # GET /questoes/1/edit
  def edit
    @questao = Questao.find(params[:id])
  end

  # POST /questoes
  # POST /questoes.xml
  def create
    @questao = Questao.new(params[:questao])

    respond_to do |format|
      if @questao.save
        format.html { redirect_to(@questao, :notice => 'Questao was successfully created.') }
        format.xml  { render :xml => @questao, :status => :created, :location => @questao }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @questao.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /questoes/1
  # PUT /questoes/1.xml
  def update
    @questao = Questao.find(params[:id])

    respond_to do |format|
      if @questao.update_attributes(params[:questao])
        format.html { redirect_to(@questao, :notice => 'Questao was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @questao.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /questoes/1
  # DELETE /questoes/1.xml
  def destroy
    @questao = Questao.find(params[:id])
    @questao.destroy

    respond_to do |format|
      format.html { redirect_to(questoes_url) }
      format.xml  { head :ok }
    end
  end
  
  def questao_to_report
    @questao = Questao.find(params[:id])
    @mensagens = @questao.respostas
  end
  
  def questao_report
    @questao = Questao.find(params[:id])
    @mensagens = @questao.respostas
    
    @params = Hash.new
    
    @params["QUESTAO_ID"] = @questao.id
    
    send_doc(
      render_to_string(:template => "questoes/questao_to_report/", :layout => false),
      'report1',
      @params,
      "boletim_questao_#{@questao.id}", 
      'pdf')
  end
  
  private
  
  def load_respostas
    cmts = api_client.get_connections(@questao.post_id, "comments")
    cmts.each do |c|
      if !Mensagem.find_by_post_id(c['id'])
        data = c['created_time'].slice(0, 10)
        hora = c['created_time'].slice(11, 8)
        data_hora = data.to_s + ' ' + hora.to_s
        puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + data_hora
        resposta = Mensagem.new({:conteudo => c['message'], :post_id => c['id'], :recebedor_id => @questao.id, :recebedor_type => @questao.class.to_s, :autor_id => load_autor(c['from']['id']), :created_at => DateTime.strptime(data_hora, "%Y-%m-%d %H:%M:%S").to_time, :updated_at => DateTime.strptime(data_hora, "%Y-%m-%d %H:%M:%S").to_time})
        resposta.save
      end
    end
  end
  
  def load_autor(fb_id)
    user = Usuario.find_by_fb_id(fb_id)
    if !user
      usuario = api_client.get_object(fb_id)
      user = Usuario.new({:fb_id => usuario['id'].to_i, :nome => usuario['name'], :data_nascimento => Date.strptime(usuario['birthday'], '%m/%d/%Y')})
      user.save
    end
    user.id
  end
end