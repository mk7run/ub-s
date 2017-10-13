module DateFormat
  def long_form_date(timestamps)
    timestamps.strftime('%B %e, %Y')
  end
end
