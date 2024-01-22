import * as React from 'react';
import { BarChart } from '@mui/x-charts/BarChart';
import { axisClasses } from '@mui/x-charts';

const valueFormatter = (value) => `${value}mm`;

export default function SurveysStats({connectionAndSurveyStats}) {

  const chartSetting = {
    yAxis: [
      {
        label: 'count (per user)',
      },
    ],
    width: 585,
    height: 300,
    sx: {
      [`.${axisClasses.left} .${axisClasses.label}`]: {
        transform: 'translate(0px, 0)',
      },
    },
  };
    // Media query for medium screens
    // const mediumScreenQuery = '@media (min-width: 768px)';
    // chartSetting.width = 400; // Adjust width for medium screens
  
    // // Media query for large screens
    // const largeScreenQuery = '@media (min-width: 1024px)';
    // chartSetting.width = 500; // Adjust width for large screens

  const dataset = [
    {
      couple_survey_responses: connectionAndSurveyStats['couple_survey_responses'],
      personal_survey_responses: connectionAndSurveyStats['personal_survey_responses'],
      month: 'Completed Surveys',
    },
  ];

  return (
    <BarChart
      dataset={dataset}
      xAxis={[{ scaleType: 'band', dataKey: 'month' }]}
      series={[
        { dataKey: 'couple_survey_responses', label: "Couple's Surveys", valueFormatter },
        { dataKey: 'personal_survey_responses', label: 'Personal Surveys', valueFormatter },
      ]}
      {...chartSetting}
    />
  );
}
