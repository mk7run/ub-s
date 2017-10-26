module DrugControllerHelper
  def find_severe_interactions(all_interactions)
    all_interactions.select {|interaction| interaction["severity"] != "N/A"}
  end

  def find_interaction_between(all_interactions, second_drug)
    all_interactions.select {|interaction| interaction["description"].include? second_drug }
  end

  def drug_comparison(drug, drug2)
    doc = Nokogiri::XML(open("https://rxnav.nlm.nih.gov/REST/rxcui?name=#{drug}"))
    doc2 = Nokogiri::XML(open("https://rxnav.nlm.nih.gov/REST/rxcui?name=#{drug2}"))
    drug_rxcui = doc.xpath("//rxnormId").children.text
    drug_rxcui2 = doc2.xpath("//rxnormId").children.text
    "/drugs?d1=#{drug_rxcui}&d2=#{drug2}"
  end

  def drug_all_interactions(drug)
    doc = Nokogiri::XML(open("https://rxnav.nlm.nih.gov/REST/rxcui?name=#{drug}"))
    drug_rxcui = doc.xpath("//rxnormId").children.text
    "/drugs?d1=#{drug_rxcui}"
  end

  def interaction_parser
    api_result = RestClient.get "https://rxnav.nlm.nih.gov/REST/interaction/interaction.json?rxcui=#{params[:d1]}"
    jhash = JSON.parse(api_result) #
    jhash["interactionTypeGroup"].first
  end
end

helpers DrugControllerHelper

