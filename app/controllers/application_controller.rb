class ApplicationController < ActionController::Base
  protect_from_forgery

  def calculate_percentage( amount, total )
    return "0" if( total == 0)
    return "%.2f" % [(amount.to_f / total.to_f ) * 100]
  end

end
