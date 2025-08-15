require "csv"

namespace :pledges do
  desc "Export pledge data"

  namespace :export do
    EXPORT_PATH = Rails.root.join("tmp/pledges.csv")

    task all: :environment do
      if File.exist?(EXPORT_PATH)
        next puts "The file '#{EXPORT_PATH}' already exists! Please delete the file and try again."
      end

      CSV.open(EXPORT_PATH, "w") do |file|
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

      puts "New export file generated at '#{EXPORT_PATH}'"
    end

    task clear: :environment do
      if File.exist?(EXPORT_PATH)
        next File.delete(EXPORT_PATH)
      else
        puts "The file '#{EXPORT_PATH}' does not exist. Aborting task ..." unless File.exist?(EXPORT_PATH)
      end
    end
  end
end
