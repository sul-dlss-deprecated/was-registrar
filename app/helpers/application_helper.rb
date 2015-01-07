module ApplicationHelper
  def format_druid druid
    if druid.present? then
      return "#{Rails.configuration.argo_catalog}#{druid}"
    else
      return druid
    end 
  end
  
  def format_collection(collection_id, collections_list)
    
    unless collection_id.present? then
      return collection_id
    end
    
    collections_list.each do |collection_record|
      if collection_id == collection_record[1]
        return  link_to collection_record[0], format_druid(collection_id)
      end 
    end
  end
end
