module ProjectsHelper
  def rupiah number
    number_to_currency(number, unit: 'Rp. ', separator: ',', delimiter: '.')
  end

  def indonesian_time time
    time.strftime('%d-%m-%Y')
  end
end
