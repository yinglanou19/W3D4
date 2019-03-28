def what_was_that_one_with(those_actors)
  # Find the movies starring all `those_actors` (an array of actor names).
  # Show each movie's title and id.
  Movie.joins(:actors).group(:id).where("actors.name IN (?)", those_actors).having('COUNT(*) = ?',those_actors.length).select(:title,:id)
end

def golden_age
  # Find the decade with the highest average movie score.
  Movie.group('(yr/10)*10').order('avg(score) DESC').limit(1).pluck('(yr/10)*10')[0]
end

def costars(name)
  # List the names of the actors that the named actor has ever
  # appeared with.
  # Hint: use a subquery
  Actor.find_by(name:name).movies.joins(:actors).distinct.where("actors.name != ?", name).pluck("actors.name")

end

def actor_out_of_work
  # Find the number of actors in the database who have not appeared in a movie
  Actor.left_outer_joins(:castings).where(castings:{id:nil}).count
end

def starring(str)
  # Find the movies with an actor who had a name like `whazzername`.
  # A name is like whazzername if the actor's name contains all of the
  # letters in whazzername, ignoring case, in order.

  # ex. "Sylvester Stallone" is like "sylvester" and "lester stone" but
  # not like "stallone sylvester" or "zylvester ztallone"
  new_str = "%"
  str.each_char do |char|
    new_str += char+"%"
  end 
  new_str 

  Movie.joins(:actors).where('UPPER(actors.name) LIKE UPPER(?)', new_str)

end

def longest_career
  # Find the 3 actors who had the longest careers
  # (the greatest time between first and last movie).
  # Order by actor names. Show each actor's id, name, and the length of
  # their career.
  Actor.joins(:movies).group(:id).order('(MAX(yr)-MIN(yr)) DESC').limit(3).select('actors.id, actors.name, (MAX(yr)-MIN(yr)) AS career').order(:name)
end
