module DateFormatting
  def long_form_date(timestamps)
    timestamps.strftime('%B %e, %Y')
  end
end

helpers DateFormatting
