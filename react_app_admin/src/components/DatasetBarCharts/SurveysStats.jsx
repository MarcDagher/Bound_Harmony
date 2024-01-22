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
    width: 600,
    height: 300,
    sx: {
      [`.${axisClasses.left} .${axisClasses.label}`]: {
        transform: 'translate(-20px, 0)',
      },
    },
  };

  const dataset = [
    {
      couple_survey_responses: connectionAndSurveyStats['couple_survey_responses'],
      personal_survey_responses: connectionAndSurveyStats['personal_survey_responses'],
      month: 'Completed Surveys',
    },
  ];

  // console.log("Inside function")
  // console.log(connectionAndSurveyStats)
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
