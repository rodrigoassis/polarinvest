module TransactionsHelper
  def format_date(date)
    # formatting date: Aug, 31 2007 - 9:55PM
    date.strftime("%b, %m %Y")
  end
end
