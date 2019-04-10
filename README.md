# BtWMonitor (Hjólað í Vinnuna Monitor)

BtWMonitor is a small Elixir/Phoenix application that monitors the first
place in the ["Hjólað í vinnuna" distance competition] [hiv-results].

The application uses [Hound][hound] and [Phantomjs][phantomjs] to
periodically scrape the current status. That result is compared to the 
previous result, and in case of an updated distance, a notification 
e-mail is sent using [Bamboo][bamboo] and [Mailgun][mailgun].

[hiv-results]: https://hjoladivinnuna.is/stadan/kilometrakeppni
[hound]: https://github.com/HashNuke/hound
[phantomjs]: http://phantomjs.org/
[bamboo]: https://github.com/thoughtbot/bamboo
[mailgun]: https://www.mailgun.com/
