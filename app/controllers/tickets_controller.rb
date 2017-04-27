class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy,:generate_link_id, :complete]
  before_action :ticket_is_closed?, only: [:edit,:update]
  before_action :user_moderator?, only: [:index, :update, :edit, :complete]
  before_action :user_admin?, only: [:destroy]

  # GET /tickets
  # GET /tickets.json
  def index
      @tickets = Ticket.where(complete: false).order('status')
      @completed_tickets = Ticket.where(complete: true).order('updated_at')
      @tickets_inprogress = Ticket.where(moderator_id: current_user.id,status: Ticket::STATUSES['Inprogress'])
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
    @ticket = Ticket.find_by(link_id: params[:link_id])
    if user_signed_in?
        if current_user.moderator
            if @ticket.status == Ticket::STATUSES['Waiting']
                @ticket.status = Ticket::STATUSES['Inprogress']
                @ticket.moderator_id = current_user.id
                @ticket.save
            end
        end
    end
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
  end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets
  # POST /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)
    generate_link_id
    respond_to do |format|
      if @ticket.save
        #SecreturlMailer.secreturl_send(@ticket).deliver
        format.html { redirect_to root_path, notice: 'Ticket was successfully created. Thanks for the feedback!'+
                                                    ' We send your secret link on your email:'+@ticket.email }
        format.json { render :show, status: :created, location: root_path }
      else
        format.html { render :new }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to ticket_path, notice: 'Ticket was successfully updated.' }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to tickets_url, notice: 'Ticket was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def complete
    @ticket.complete = true
    @ticket.status = Ticket::STATUSES['Closed']
    @ticket.save
    redirect_to tickets_url, notice: "Ticket was successfully closed"
  end
private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find_by(link_id: params[:link_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      params.require(:ticket).permit(:title, :body, :email)
    end

    def generate_link_id
        @ticket.link_id = create_url
        @ticket.link_id = create_url while Ticket.find_by(link_id: @ticket.link_id)
    end

    def create_url
        alphabet = ('a'..'z').to_a
        alphabet += ('A'..'Z').to_a
        r = Random.new
        url = "ticket"
        2.times do
            url += "-"+3.times.map {alphabet.sample}.join
            url += "-"+r.rand(100..999).to_s
        end
        url
    end

    def ticket_is_closed?
        redirect_to root_path if @ticket.complete
    end

    def user_moderator?
        catch (:done)  do
            unless user_signed_in?
                redirect_to root_path
                throw :done
            end
        redirect_to root_path unless current_user.moderator
        end
    end

    def user_admin?
        catch (:done)  do
            unless user_signed_in?
                redirect_to root_path
                throw :done
            end
        redirect_to root_path unless current_user.admin
        end
    end
end
