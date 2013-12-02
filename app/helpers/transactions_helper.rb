module TransactionsHelper
  def format_date(date)
    # formatting date: Aug, 02 2013
    date.strftime("%b, %d %Y")
  end
end
