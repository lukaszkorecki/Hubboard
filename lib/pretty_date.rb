# Taken from: http://my.safaribooksonline.com/0596523696?portal=oreilly
require 'date'
class Date
  def to_gm_time
    to_time(new_offset, :gm)
  end

  def to_local_time
    to_time(new_offset(DateTime.now.offset-offset), :local)
  end

  private
  def to_time(dest, method)
    #Convert a fraction of a day to a number of microseconds
    usec = (dest.sec_fraction * 60 * 60 * 24 * (10**6)).to_i
    Time.send(method, dest.year, dest.month, dest.day, dest.hour, dest.min,
              dest.sec, usec)
  end
end
# this is adjusted example from:
# http://stackoverflow.com/questions/195740/how-do-you-do-relative-time-in-rails/195894#195894
module PrettyDate
  def to_pretty
    a = (Time.now.to_i-self.to_gm_time.to_i).to_i

    case a
      when 0 then return 'just now'
      when 1 then return 'a second ago'
      when 2..59 then return a.to_s+' seconds ago'
      when 60..119 then return 'a minute ago' #120 = 2 minutes
      when 120..3540 then return (a/60).to_i.to_s+' minutes ago'
      when 3541..7100 then return 'an hour ago' # 3600 = 1 hour
      when 7101..82800 then return ((a+99)/3600).to_i.to_s+' hours ago'
      when 82801..172000 then return 'a day ago' # 86400 = 1 day
      when 172001..518400 then return ((a+800)/(60*60*24)).to_i.to_s+' days ago'
      when 518400..1036800 then return 'a week ago'
    end
    weeks = ((a+180000)/(60*60*24*7)).to_i #.to_s+' weeks ago'
    puts weeks
    case weeks
    when 2..52
      "#{weeks} weeks ago"
    when 52
      "1 year ago"
    else
      "#{"%.1f" % (weeks.to_f / 52)} years ago"
    end
  end
end

class Time
  # HAXX
  def to_gm_time
    self.to_i
  end
end


DateTime.send :include,  PrettyDate
Time.send :include,  PrettyDate
