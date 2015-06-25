module CsvExport
  def to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |item|
        csv << item.attributes.values_at(*column_names)
      end
    end
  end

  def to_user_csv
    CSV.generate do |csv|
      csv << ["id","name","birthday","email","encrypted_password"]
      all.each do |item|
        data = [item.id] + [item.name] + [item.birthday] + [item.email] + [item.encrypted_password]
        skills = item.skills.map(&:name)
        csv << data
        csv << ["skill"]
        csv << skills
      end
    end
  end
end
