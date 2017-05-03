class TicketsController < ApplicationController
  before_action :set_ticket, only: [ :show, :edit, :update, :destroy, :complete]
  before_action :ticket_is_closed?, only: [:edit,:update]
  before_action :user_log_in?, only: [:user_moderator?, :user_admin?]
  before_action :user_moderator?, only: [:index, :update, :edit, :complete]
  before_action :user_admin?, only: [:destroy]
  before_action :init_service_for_create, only: [:create]
  # GET /tickets
  def index
      @uncompleted_tickets = Ticket.uncompleted.all
      @completed_tickets = Ticket.completed.all
      @tickets_inprogress = Ticket.inprogress(current_user).all
  end

  # GET /tickets/1
  def show
    if user_signed_in?
        if current_user.moderator
            @service.change_status
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
  def create
    @ticket = @service_create.create
    redirect_to root_path, notice: 'Ticket was successfully created. Thanks for the feedback!'+
                                    ' We send your secret link on your email:'+@ticket.email.to_s
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    @ticket.update(ticket_params)
    redirect_to ticket_path, notice: 'Ticket was successfully updated.'
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket.destroy
    redirect_to tickets_url, notice: 'Ticket was successfully destroyed.'
  end

  def complete
      @service.complete
      redirect_to tickets_url, notice: "Ticket was successfully closed"
  end

private

    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find_by(link_id: params[:link_id])
      @service = TicketsService.new(@ticket, current_user,nil)
    end

    def init_service_for_create
        @service_create = TicketsService.new(nil,nil,ticket_params)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      params.require(:ticket).permit(:title, :body, :email)
    end

    def ticket_is_closed?
        redirect_to root_path if @ticket.complete
    end

    def user_log_in?
        redirect_to root_path unless user_signed_in?
    end

    def user_moderator?
        redirect_to root_path unless current_user.moderator
    end

    def user_admin?
        redirect_to root_path unless current_user.admin
    end

end
