defmodule Tow.Parse do
  import SweetXml

  def parse do
    doc = "data/test.xml"
    result = doc |> xpath(~x"//matchup/name/text()")
     #assert result == 'Match One'
  end






end
