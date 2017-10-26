get '/' do
  erb :"/drugs/index"
end

post '/drugs' do
  drug = params[:drugname]
  drug2 = params[:drugname2]
  if drug2
    drug2 = drug2.chomp
    url = drug_comparison(drug, drug2)
  else
    url = drug_all_interactions(drug)
  end
  redirect url
end

get '/drugs' do
  drug = params[:d1]
  @drug2 = params[:d2]
  @disclaimer = interaction_parser["sourceDisclaimer"]
  @source_name = interaction_parser["sourceName"]
  interaction = interaction_parser["interactionType"].first
  @drug = interaction["minConceptItem"]
  interactions = interaction["interactionPair"]
  if @drug2
    @output = find_interaction_between(interactions, params[:d2])
  else
    @output = interactions
    # @output = find_severe_interactions(interactions)
  end
  erb :"/drugs/show"
end
