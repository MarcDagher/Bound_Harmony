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
    width: 570,
    height: 300,
    sx: {
      [`.${axisClasses.left} .${axisClasses.label}`]: {
        transform: 'translate(-0px, 0)',
      },
    },
  };

  const dataset = [
    {
      accepted_connections: connectionAndSurveyStats['accepted_connections'],
      disconnected_connections: connectionAndSurveyStats['disconnected_connections'],
      pending_connections: connectionAndSurveyStats['pending_connections'],
      rejected_connections: connectionAndSurveyStats['rejected_connections'],
      month: "Status of Users' Connection Requests",
    },
  ];


  const seriesColors = [ '#FF7F80', '#B52022', '#F03E3F', '#F45A5C'];
  return (
    <BarChart
      dataset={dataset}
      xAxis={[{ scaleType: 'band', dataKey: 'month' }]}
      series={[
        { dataKey: 'accepted_connections', label: 'Accepted', valueFormatter, color: seriesColors[0],},
        { dataKey: 'disconnected_connections', label: 'Disconnected', valueFormatter, color: seriesColors[1]},
        { dataKey: 'pending_connections', label: 'Pending', valueFormatter, color: seriesColors[2]},
        { dataKey: 'rejected_connections', label: 'Rejected', valueFormatter, color: seriesColors[3]},
      ]}
      {...chartSetting}
    />
  );
}
