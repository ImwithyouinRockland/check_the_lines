class Games::GameOver < Less::Interaction

  def run
    urls.each do |url|
      html = Games::FetchHtml.run(url: url.values.first, sport: url.keys.first )
      fetch_and_save_team_data(html)
    end
  end

  private

  def urls
    Games::FetchUrls.run
  end

  def fetch_and_save_team_data(html)
    @week_id = html.css('#datepicker').first.attributes['value'].value
    rows = html.css('.bodyrow')
    rows.each do |row|
        create_instance_variables(row)
        update_game if game_over(row)
    end
  end

  def update_game
    game = Game.where(away_team_name: @away_team_name, home_team_name: @home_team_name).first
    game.update(
      game_over: true
    ) unless game.nil?
  end

  def game_over(row)
    return true if row.css('.fdate .detail').text == "FINAL"
    false
  end

  def create_instance_variables(row)
    @away_team_name        =  NameFormatter.new(row.css('.fteam').first.css('a').first.children.text).format_name
    @home_team_name        =  NameFormatter.new(row.css('.fteam').first.css('a').last.children.text).format_name
  end


end
