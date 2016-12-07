function species_dilution_array = Dilution(t,x,data_dictionary)

  % volume is the last species -
  volume = x(end);

  % How many species do we have?
  number_of_species = length(x);

  % Get flow rate array et al from the data_dictionary -
  flowrate_array = data_dictionary.volumetric_flowrate_array;
  feed_composition_array = data_dictionary.material_feed_concentration_array;
  number_of_reactor_feed_streams = data_dictionary.number_of_reactor_feed_streams;

  % Formulate the dilution rate array -
  dilution_rate_array = zeros(number_of_reactor_feed_streams,1);
  dilution_rate_array(1,1) = flowrate_array(1,1)/(volume);
  dilution_rate_array(2,1) = flowrate_array(2,1)/(volume);
  dilution_rate_array(3,1) = flowrate_array(3,1)/(volume);

  % Calculate the species feed array -
  species_feed_array = feed_composition_array*dilution_rate_array;
  species_dilution_array = species_feed_array - sum(dilution_rate_array)*x;

  % Correct for volume -
  species_dilution_array(end,1) = sum(dilution_rate_array);
return
