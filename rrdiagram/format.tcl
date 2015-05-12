set all_graphs {
  marcacao {
    line 
      '{
      {optx targumentot} 
      {optx ! tconversaot}
      {optx : tformatot}
      '}
  }
  marcacao2 {
    line 
      '{
      {optx targumentot} 
      {optx ! {or /s /r }}
      {optx : tformatot}
      '}
  }
  argumento {
    line {or tposicaot tnomet}
    {optx
      {loop
        {or
          {line . natributon}
          {line [ nindicen ]}
        }
      }
    }
  }
  formato {
    line 
    {optx
      {optx tenchimentot}
      talinhamentot
    }
    {optx tsinalt}
    {optx #}
    {optx tlargurat}
    {optx ,}
    {optx {line . tprecisaot}}
    {optx ttipot}
  }
  formato2 {
      stack 
        {line
          {optx
            {optx tenchimentot}
            talinhamentot
          }
          {optx tsinalt}
          {optx #}
        }
        {line  
          {optx tlargurat}
          {optx ,}
          {optx {line . tprecisaot}}
          {optx ttipot}
        }
  }
}
