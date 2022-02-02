class Admin::UsersController < AdminController

  def initialize
    super

    @@attributes = [
        :first_name,:last_name,:email,:password,:user_role,:fb_id,:date_of_birth,
        :apple_id,:fb_token,:phone_number,:device_token,
        :profile_picture, :filter_radius, :filter_unit
    ]
    @@sortable_columns_priority = [:id, :first_name, :last_name, :email]
    @@sortable_order_priority = [:desc, :asc]
    @@section = 'User'
  end

  def index
    @list = User.order("first_name asc")

    respond_to do |format|
      format.html {
        @users = @list = @list.paginate(:per_page => 20, :page => params[:page])
        render 'index'
      }
      format.csv {send_data @list.to_csv}
    end
  end

  def bulk_actions
    User.where(id: params[:rows]).destroy_all
    render_notice(
        {
            success: "#{@@section.pluralize} has been deleted successfully",
        },
        {
            redirect: @locals[:index_path]
        }
    )
  end

  def create
    @object = User.new object_params
    @object.user_role = User.user_roles[:user]
    @object.password = SecureRandom.base64(5) if object_params[:password].blank?

    respond_to do |format|

      if @object.valid?
        @object.save
        format.html {
          flash[:success] = @locals[:labels][:created_success]
          redirect_to action: :index
        }
        format.json {
          render_notice({success: @locals[:labels][:created_success]})
        }
      else
        format.html {
          render :new
        }
        format.json {
          render json: {errors: format_errors(@object.errors)}, status: 409
        }
      end
    end
  end

  def video

  end

  def update
    @object.attributes = object_params

    respond_to do |format|
      if @object.valid?
        @object.save
        format.html {
          flash[:success] = @locals[:labels][:updated_success]
          redirect_to action: :index
        }
        format.json {
          render_notice({success: @locals[:labels][:updated_success]})
        }
      else
        format.html {
          render :edit
        }
        format.json {
          render json: {errors: format_errors(@object.errors)}, status: 409
        }
      end
    end
  end

  protected

  def view_params

    section = @@section

    @locals = {
        section: section.pluralize,
        subsection: section,
        labels: {
            new: "New #{section}",
            edit: "New #{section}",
            created_success: "#{section} created successfully",
            updated_success: "#{section} updated successfully",
            destroyed_success: "#{section} deleted successfully"
        },
        questions: {
            delete: "Are you sure that you want to delete this #{section.downcase}?"
        },
        new_path: new_admin_user_path,
        index_path: admin_users_path,
        csv_path: admin_users_path({format: :csv}),
        search_path: admin_users_path,
        batch_actions: [
            {
                name: 'Delete',
                url: bulk_actions_admin_users_path,
                message: "Are you sure to delete selected #{section.pluralize}?"
            }
        ]
    }

  end

  private

  def set_object
    @locals[:item] = @object = User.find(params[:id])
  end

  def object_params
    params.require(:user).permit(@@attributes)
  end
end
