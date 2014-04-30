#!/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/bin/ruby

require "osx/cocoa"
include OSX

class Timer
  def init
    tick
  end
  def tick(a)
    count = `notmuch count -- tag:inbox AND tag:unread`
    foreground = count.to_i > 0 ? NSColor.whiteColor : NSColor.blackColor
    background = count.to_i > 0 ? NSColor.colorWithSRGBRed_green_blue_alpha(0.8, 0.1, 0.1, 0.6) : NSColor.clearColor
    dict = NSDictionary.dictionaryWithObjects_forKeys([background, foreground, NSFont.systemFontOfSize(16)], [NSBackgroundColorAttributeName, NSForegroundColorAttributeName, NSFontAttributeName])
    str = NSAttributedString.alloc().initWithString_attributes("\n ✉ " + count, dict)
    $statusitem.setAttributedTitle(str)
  end
  def click(a)
    NSLog("hiiii")
  end
end

app = NSApplication.sharedApplication
$statusitem = NSStatusBar.systemStatusBar().statusItemWithLength(NSVariableStatusItemLength)
NSTimer.scheduledTimerWithTimeInterval_target_selector_userInfo_repeats(10.0, Timer.new, 'tick:', nil, true)

app.run
