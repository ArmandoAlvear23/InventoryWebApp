RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
   warden.authenticate! scope: :user
 end
 config.current_user_method(&:current_user)

  ## == Cancan ==
  config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    #dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.main_app_name = ["Brownsville PUB", "Admin Dashboard"]

  if User.table_exists?
    RailsAdmin.config User do
      list do
        # simply adding fields by their names (order will be maintained)
          include_fields :id, :first_name, :last_name, :email, :last_sign_in_at, :admin
      end

        create do
          include_fields :id, :first_name, :last_name, :email, :password, :password_confirmation do
            required true
          end
          include_fields :admin
        end

        # edit do
        #   field :first_name, :string do
        #     required true
        #   end
        #   field :last_name, :string do
        #     required true
        #   end
        #   field :email, :string do
        #     required true
        #   end
        # end

    end
  end

end
