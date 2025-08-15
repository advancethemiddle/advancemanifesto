require "csv"

namespace :pledges do
  desc "Export pledge data"

  namespace :export do
    task all: :environment do
      export_path = Rails.root.join("tmp/pledges.csv")

      CSV.open(export_path, "w") do |file|
        file << [ "id", "first_name", "last_name", "email", "created_at", "updated_at" ]
        Pledge.find_each do |pledge|
          file << [
            pledge.id,
            pledge.first_name,
            pledge.last_name,
            pledge.email,
            pledge.created_at,
            pledge.updated_at
          ]
        end
      end

      puts "New export file generated at #{export_path}"
    end
  end
end
