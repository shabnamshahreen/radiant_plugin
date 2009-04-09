class Admin::ReferencesController < RadiantController
  def show
    respond_to do |format|
      format.any { render :action => params[:id] }
    end
  end
end
