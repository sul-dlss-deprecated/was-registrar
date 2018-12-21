# frozen_string_literal: true

module ApplicationHelper
  def format_druid druid
    if druid.present? then
      return "#{Settings.argo_view_url}#{druid}"
    else
      return druid
    end
  end

  def format_collection(collection_id, collections_list)
    if collection_id.blank? then
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
    if apo_id.blank? then
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
