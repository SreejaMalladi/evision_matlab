function [case_data, dates] = covid_data(app,dates)
%COVID_DATA Summary of this function goes here
%   Detailed explanation goes here
    if strcmp(app.DiseaseDropDown.Value, 'COVID-19')
%         py.case_scraper.get_covid_data()
        if strcmp(app.PredictionLevel.Value, 'National')
            try
                data = readtable('covid-19-data/us.csv');
            catch
                data = readtable('covid-19-data\us.csv');
            end
            case_data_total = data.cases;
        elseif strcmp(app.PredictionLevel.Value, 'State')
            try
                total_data = readtable('covid-19-data/us.csv');
            catch
                total_data = readtable('covid-19-data\us.csv');
            end
            data = total_data(strcmp(total_data.state, app.SublevelDropDown.Value), :);
            case_data_total = data.cases;
        end
        app.ProgressBar.Title = 'Formatting Data';
        str_dates = string(dates);
        i = 1;
        while(1)
            if str_dates(1) == data.date(i)
                break
            else
                i = i + 1;
                continue
            end
        end
        case_data_total = case_data_total(i:length(case_data_total), :);  
        case_data = total_to_weekly(case_data_total);
    end
    case_data(isnan(case_data)) = 0;
end

