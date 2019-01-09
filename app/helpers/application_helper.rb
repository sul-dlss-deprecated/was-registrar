# frozen_string_literal: true

module ApplicationHelper
  def format_druid(druid)
    if druid.present?
      "#{Settings.argo_view_url}#{druid}"
    else
      druid
    end
  end

  def format_collection(collection_id, collections_list)
    return collection_id if collection_id.blank?

    collections_list.each do |collection_record|
      return link_to collection_record[0], format_druid(collection_id) if collection_id == collection_record[1]
    end
    collection_id
  end

  def format_apo(apo_id, apos_list)
    return apo_id if apo_id.blank?

    apos_list.each do |apo_record|
      return link_to apo_record[0], format_druid(apo_id) if apo_id == apo_record[1]
    end
    apo_id
  end
end
