module ApplicationHelper
  def format_druid druid
    if druid.nil? or druid.blank? then
      return druid
    else
      return "#{Rails.configuration.argo_catalog}#{druid}"
    end 
  end
  
  def format_collection(collection_id, collections_list)
    
    if collection_id.nil? or collection_id.blank? then
      return collection_id
    end
    
    collections_list.each do |collection_record|
      if collection_id == collection_record[1] then
        return "<a href='"+format_druid(collection_id)+"' >"+collection_record[0]+"</a>"
      end 
    end
  end
end
