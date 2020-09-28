# CSVファイルを扱うために必要
require 'csv'
# 名前空間 => import
namespace :import_csv do
  # タスクの説明
  desc "CSVデータをインポートするタスク"

  # タスク名　=> users
  task users: :environment do
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
      User.transaction do
        # 例外が発生する可能性のある処理 
        User.create!(list)
      end
      # 文字を青色で出力
      puts "インポート完了!!".blue
    rescue => e
      # 例外が発生した場合の処理
      # インポートができなかった場合の例外処理
      # 文字を黄色で出力
      puts "#{e.class}: #{e.message}".yellow
      puts "-------------------------"
      puts e.backtrace # 例外が発生した位置情報
      puts "-------------------------"
      puts "インポートに失敗".yellow
    end
  end
end