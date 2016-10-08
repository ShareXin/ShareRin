#!/usr/bin/env ruby

require 'gtk3'
require 'twitter'
require 'inifile'

class RubyApp < Gtk::Window

    def initialize
        super
        
        init_ui
    end
    
    def init_ui
    
        set_border_width 10
                
        grid = Gtk::Grid.new 
        grid.set_column_spacing 5
        grid.set_row_spacing 5
                    
        tweet = Gtk::TextView.new
        tweet.set_hexpand true
        tweet.set_vexpand true
        grid.attach tweet, 0, 1, 3, 3

        vbox = Gtk::Box.new :vertical, 4

        cancel_btn = Gtk::Button.new :label => "Cancel"
        cancel_btn.set_size_request 50, 30
        cancel_btn.signal_connect "clicked" do
		Gtk.main_quit
        end

        vbox.add cancel_btn
        grid.attach vbox, 1, 4, 1, 1
        
        tweet_btn = Gtk::Button.new :label => "Tweet" 
        tweet_btn.set_size_request 50, 30
        grid.attach tweet_btn, 2, 4, 1, 1
        tweet_btn.signal_connect "clicked" do
                 Gtk.main_quit
                 twitter(tweet)
        end

        add grid
    
        set_title "Tweet image w/ message"
        signal_connect "destroy" do 
            Gtk.main_quit 
        end

        set_default_size 350, 240
        set_window_position :center
        
        show_all        
    end
    def twitter(tweet)
        # Twitter configuration
        configFile = IniFile.load(Dir.home + '/.config/ShareXin/config.ini')
        twitterConfig = configFile["Twitter"]
        config = {
          consumer_key: twitterConfig["api"],
          consumer_secret: twitterConfig["api_secret"],
          access_token: twitterConfig["access"],
          access_token_secret: twitterConfig["access_secret"],
        }
        client = Twitter::REST::Client.new(config)
        # Tweet
        client.update_with_media(tweet.buffer.text, File.new('/tmp/ShareRin_img.png'))
    end
end

Gtk
    window = RubyApp.new
Gtk.main
