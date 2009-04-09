class Admin::ExportController < RadiantController
  def yaml
    render :text => Radiant::Exporter.export, :content_type => "text/yaml"
  end
end
