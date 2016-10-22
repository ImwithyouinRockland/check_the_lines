class Games::ImportMasseyData < Less::Interaction
  expects :massey_url
  # expects :public_betting_url
  expects :sport
  #  http://www.masseyratings.com/pred.php?s=cf&sub=11604
  # Games::ImportMasseyData.run(massey_url: 'http://www.masseyratings.com/pred.php?s=cf&sub=11604', sport: 'ncaa_football' )
  # Games::ImportMasseyData.run(massey_url: 'http://www.masseyratings.com/pred.php?s=nfl', sport: 'nfl_football' )

  def run
    html = get_massey_html
    fetch_and_save_team_data(html)
    # public_betting = get_public_betting_info
  end

  private

  def save_game(game_hash)
      game = Game.find_or_create_by(
        home_team_name: @home_team_name,
        away_team_name: @away_team_name
      )
      Game.update(game, game_hash)
  end

  def get_massey_html
    browser = Watir::Browser.new :phantomjs
    browser.goto massey_url
    browser.button(id: 'showVegas').click
    doc = Nokogiri::HTML(browser.html)
    browser.close
    doc
  end

  def get_public_betting_info
    browser = Watir::Browser.new :phantomjs
    browser.goto public_betting_url
    doc = Nokogiri::HTML(browser.html)
    button = doc.css('.lnk')[1].children[1].attributes['id'].value
    doc = browser.button(id: button).click
    doc
  end

  def fetch_and_save_team_data(html)
    @week_id = html.css('#datepicker').first.attributes['value'].value
    rows = html.css('.bodyrow')
    rows.each do |row|
      create_instance_variables(row)
      save_game(game_hash) unless invalid_data?
    end
  end

  def invalid_data?
    @away_team_vegas_line == 0.0 || @home_team_vegas_line == 0.0 #|| @vegas_over_under == 0.0
  end

  # def invalid_data(row)
  #   if row.css('.fscore')[1].children.first.text == "---"
  #     true
  #   elsif row.css('.fscore')[1].children.last.text == "---"
  #     true
  #   elsif row.css('.fscore').last.children.first.text == "---"
  #     true
  #   elsif row.css('.fscore').last.children.last.children.first.text == "---"
  #     true
  #   else
  #     false
  #   end
  # end

  def game_hash
    {
      home_team_massey_line:  @home_team_massey_line,
      away_team_massey_line:  @away_team_massey_line,
      away_team_name:         @away_team_name,
      home_team_name:         @home_team_name,
      home_team_vegas_line:   @home_team_vegas_line,
      away_team_vegas_line:   @away_team_vegas_line,
      massey_over_under:      @massey_over_under,
      vegas_over_under:       @vegas_over_under,
      date:                   @date,
      sport:                  @sport,
      line_diff:              @line_diff,
      over_under_diff:        @over_under_diff,
      team_to_bet:            @team_to_bet,
      over_under_pick:        @over_under_pick,
      away_team_final_score:  @away_team_final_score,
      home_team_final_score:  @home_team_final_score,
      week_id:                @week_id
    }
  end

  def pick_over_under
    if @massey_over_under - @vegas_over_under > 0
      "Over"
    else
      "Under"
    end
  end

  def find_team_to_bet
    if @home_team_massey_line - @home_team_vegas_line > 0
      @away_team_name
    else
      @home_team_name
    end
  end

  def format_date(row)
    date = row.css('.fdate').first.children.first.children.first.text
    date = date[-2 .. -1]
    Date.parse(date)
  end

  def get_home_team_massey_line(row)
    game_array = row.css('.fscore')[1].children.to_a
    return -1 * game_array.first.text.to_f if game_array.first.attributes["class"].value == 'ltgreen'
    return game_array.last.text.to_f if game_array.last.attributes["class"].value == ' ltgreen'
  end

  def get_home_team_vegas_line(row)
    game_array = row.css('.fscore')[1].children.to_a
    return -1 * game_array.first.text.to_f if game_array.first.attributes["class"].value == 'ltred'
    return game_array.last.text.to_f if game_array.last.attributes["class"].value == 'ltred'
  end

  def create_instance_variables(row)
    @home_team_massey_line =  get_home_team_massey_line(row)
    @away_team_massey_line =  -get_home_team_massey_line(row)
    @away_team_name        =  row.css('.fteam').first.css('a').first.children.text
    @home_team_name        =  row.css('.fteam').first.css('a').last.children.text
    @home_team_vegas_line  =  get_home_team_vegas_line(row)
    @away_team_vegas_line  =  -get_home_team_vegas_line(row)
    @vegas_over_under      =  row.css('.fscore').last.children.last.text.to_f
    @massey_over_under     =  row.css('.fscore').last.children.first.text.to_f
    @date                  =  format_date(row)
    @sport                 =  sport
    @line_diff             =  (get_home_team_massey_line(row) - get_home_team_vegas_line(row)).abs
    @over_under_diff       =  (row.css('.fscore').last.children.first.text.to_f - row.css('.fscore').last.children.last.text.to_f).abs
    @team_to_bet           =  find_team_to_bet
    @over_under_pick       =  pick_over_under
    # @away_team_final_score =  row.css('.fscore').first.children.first.text.to_i
    # @home_team_final_score =  row.css('.fscore').first.children.last.children.text.to_i
  end
end