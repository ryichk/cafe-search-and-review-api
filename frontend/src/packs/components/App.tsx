import React from 'react';

export interface Props {
  title: string
}

const App: React.FC<Props> = ({title}) => {
    return (
      <div>
        <h1>{title}</h1>
      </div>
    );
}

export default App;