class ImportCsv < ApplicationRecord
  # CSVデータのパスを引数として受け取り、インポート処理を実行
  def self.users_data
    # インポートするファイルのパスを取得
    path = File.join Rails.root, "db/csv_data/csv_data.csv"
    # インポートするデータを格納するための配列
    list = []
    # CSVファイルからインポートするデータを取得し配列に格納
    CSV.foreach(path, headers: true) do |row|
      list << {
        name: row["name"],
        age: row["age"],
        address: row["address"],
        gender: row["gender"],
        hobby: row["hobby"]
      }
    end
    puts "インポート処理を開始"
    # インポートができなかった場合の例外処理
    begin
      User.create!(list)
      puts "インポート完了!!"
    rescue => e
      # 例外が発生した場合の処理
      # インポートができなかった場合の例外処理
      puts "#{e.class}: #{e.message}"
      puts "-------------------------"
      puts e.backtrace # 例外が発生した位置情報
      puts "-------------------------"
      puts "インポートに失敗"
    end
  end
end