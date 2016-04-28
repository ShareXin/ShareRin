#!/usr/bin/env ruby

require 'gtk3'
require 'twitter'

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
    
        set_title "Tweet message"
        signal_connect "destroy" do 
            Gtk.main_quit 
        end

        set_default_size 350, 240
        set_window_position :center
        
        show_all        
    end
    def twitter(tweet)
        # Twitter configuration
        client = Twitter::REST::Client.new do |config|
          config.consumer_key        = ''
          config.consumer_secret     = ''
          config.access_token        = ''
         config.access_token_secret = ''
       end
        # Tweet
        client.update(tweet.buffer.text)
    end
end

Gtk
    window = RubyApp.new
Gtk.main