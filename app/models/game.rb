class Game < ApplicationRecord
  has_many :player_games
  has_many :players, through: :player_games
  has_many :messages, through: :player_games
  has_many :images

  def num_players
    self.player_games.length
  end
  def currentImageURL
    self.images.last.data_url
  end

  def currentImageId
    self.images.last.id
  end

  def currentKeyword
    self.images.last.keyword
  end

  def recentMessages
    self.messages.last(10).map do |msg|
      { msg_id: msg.id, player_username: msg.player_username, content: msg.content, player_id: msg.player_id }
    end
  end

  def playerScores
    array = []
    self.player_games.each do |pg|
      array << {"#{pg.player.username}": "#{pg.score}"}
    end
    array
  end

  def currentDrawerId
    self.player_games.where(is_drawer: true).first.player_id
  end

  def currentDrawerUsername
    self.player_games.where(is_drawer: true).first.player.username
  end

  def currentDrawer
    self.player_games.where(is_drawer: true).first
  end
end
