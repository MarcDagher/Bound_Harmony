import * as React from 'react';
import { PieChart } from '@mui/x-charts/PieChart';

export default function AgeRangeStats({usersAgeRange}) {
  // console.log("inside pichart")
  // console.log(usersAgeRange)
  return (
    <PieChart
      series={[
        {
          data: [
            { id: 0, value: usersAgeRange['above_35'], label: '35yrs +' },
            { id: 1, value: usersAgeRange['below_18'], label: '-18yrs ' },
            { id: 2, value: usersAgeRange['between_18_and_24'], label: '18yrs - 35yrs' },
            { id: 3, value: usersAgeRange['between_24_and_35'], label: '24yrs - 35yrs' },
          ],
        },
      ]}
      width={400}
      height={200}
    />
  );
}
