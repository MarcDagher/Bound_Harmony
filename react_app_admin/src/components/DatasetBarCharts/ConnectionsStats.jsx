import * as React from 'react';
import { BarChart } from '@mui/x-charts/BarChart';
import { axisClasses } from '@mui/x-charts';

const valueFormatter = (value) => `${value}mm`;

export default function ConnectionsStats({connectionAndSurveyStats}) {

  const chartSetting = {
    yAxis: [
      {
        label: 'count (per request)',
      },
    ],
    width: 500,
    height: 300,
    sx: {
      [`.${axisClasses.left} .${axisClasses.label}`]: {
        transform: 'translate(-20px, 0)',
      },
    },
  };

  const dataset = [
    {
      accepted_connections: connectionAndSurveyStats['accepted_connections'],
      disconnected_connections: connectionAndSurveyStats['disconnected_connections'],
      pending_connections: connectionAndSurveyStats['pending_connections'],
      rejected_connections: connectionAndSurveyStats['rejected_connections'],
      month: "Users' Connection Requests Status",
    },
  ];

  // console.log("Inside function")
  // console.log(connectionAndSurveyStats)
  return (
    <BarChart
      dataset={dataset}
      xAxis={[{ scaleType: 'band', dataKey: 'month' }]}
      series={[
        { dataKey: 'accepted_connections', label: 'Accepted', valueFormatter },
        { dataKey: 'disconnected_connections', label: 'Disconnected', valueFormatter },
        { dataKey: 'pending_connections', label: 'Pending', valueFormatter },
        { dataKey: 'rejected_connections', label: 'Rejected', valueFormatter },
      ]}
      {...chartSetting}
    />
  );
}
