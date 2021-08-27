FROM gitpod/workspace-postgres
USER gitpod

# Install the Ruby version specified in '.ruby-version'
COPY --chown=gitpod:gitpod .ruby-version /tmp
RUN echo "rvm_gems_path=/home/gitpod/.rvm" > ~/.rvmrc
RUN bash -lc "rvm reinstall ruby-$(cat /tmp/.ruby-version) && rvm use ruby-$(cat /tmp/.ruby-version) --default && gem install rails"
RUN echo "rvm_gems_path=/workspace/.rvm" > ~/.rvmrc

# Install dependencies
RUN sudo apt-get -q update \
 && sudo apt-get install -y openjdk-8-jre-headless xvfb libxi6 libgconf-2-4 libnss3-dev \
 && sudo rm -rf /var/lib/apt/lists/*

# Install Chrome
RUN sudo wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - \
 && echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list \
 && sudo apt-get -y update \
 && sudo apt-get -y install google-chrome-stable

# Install ChromeDriver
RUN CHROME_DRIVER_VERSION=`curl -sS https://chromedriver.storage.googleapis.com/LATEST_RELEASE` \
 && sudo wget -N https://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip -P ~/ \
 && unzip ~/chromedriver_linux64.zip -d ~/ \
 && sudo mv -f ~/chromedriver /usr/local/bin/chromedriver \
 && sudo chown root:root /usr/local/bin/chromedriver \
 && sudo chmod 0755 /usr/local/bin/chromedriver

# Install Selenium
RUN SELENIUM_STANDALONE_VERSION=3.9.1 \
 && SELENIUM_SUBDIR=$(echo "$SELENIUM_STANDALONE_VERSION" | cut -d"." -f-2) \
 && wget -N https://selenium-release.storage.googleapis.com/$SELENIUM_SUBDIR/selenium-server-standalone-$SELENIUM_STANDALONE_VERSION.jar -P ~/ \
 && sudo mv -f ~/selenium-server-standalone-$SELENIUM_STANDALONE_VERSION.jar /usr/local/bin/selenium-server-standalone.jar \
 && sudo chown root:root /usr/local/bin/selenium-server-standalone.jar \
 && sudo chmod 0755 /usr/local/bin/selenium-server-standalone.jar