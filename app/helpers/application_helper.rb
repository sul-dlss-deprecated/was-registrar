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
    return collection_id
  end

  def format_apo(apo_id, apos_list)
    unless apo_id.present? then
      return apo_id
    end

    apos_list.each do |apo_record|
      if apo_id == apo_record[1]
        return link_to apo_record[0], format_druid(apo_id)
      end
    end
    return apo_id
  end
end
