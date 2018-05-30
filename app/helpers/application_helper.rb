module ApplicationHelper

	def simple_time(time)
		# 条件分岐で時間の表記の仕方を変える
    # 例：　「1時間前」、「10分前」、「5分前」、「数分前」
    time_method = (Time.now - time) / 60
    one_day = 60 * 24
    hour_time = time_method.to_i / 60
    day_time = time_method.to_i / one_day
    if time_method.to_i == 0
      p "数秒前"
    elsif time_method.to_i > 0 && time_method.to_i < 60
      p "#{time_method.to_i}分前"
    elsif time_method.to_i > 60 && hour_time < 24
      p "#{hour_time}時間前"
    elsif hour_time > 23 && day_time < 6
      p "#{day_time}日前"
    else
      time.strftime("%Y-%m-%d　%H:%M")
    end
	end

	def get_twitter_card_info(page)
      twitter_card = {}
      if page
        twitter_card[:url] = "https://www.locqer.com/users/#{page.nickname}"
        twitter_card[:title] = "問題を作ったよ！"
        twitter_card[:description] = "#{page.username}の問題に答えて思いを聞いてみよう！"
        twitter_card[:image] = "#{asset_url("IMG_8323.JPG")}"
      else
        twitter_card[:url] = 'https://www.locqer.com'
        twitter_card[:title] = '秘密を打ち明けるSNS「LOCQER」'
        twitter_card[:description] = 'あなたの思いを大切な人にだけ伝えてみよう！'
        twitter_card[:image] = "#{asset_url("IMG_8323.JPG")}"
      end
      twitter_card[:card] = 'summary_large_image'
      twitter_card[:site] = '@Yapy_service'
      twitter_card
  	end
  	
end
