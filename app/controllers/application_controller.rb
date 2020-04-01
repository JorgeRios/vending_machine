require 'csv'    


class ApplicationController < ActionController::Base
    skip_before_action :verify_authenticity_token
    before_action :load_app

    

    def show_machine
        render :json => {:stat => 'ok', :machine => @app}.to_json
      end
    
    def charge_amount(amount, type)
        puts "amount #{amount}"
        if type == 'dollar'
            @app.current_balance = @app.current_balance.to_f + amount.to_f
        else
            @app.current_balance = @app.current_balance.to_f + amount.to_f/100
        end
        render :json => {:stat => 'ok', :app => @app}.to_json
    end
    
    def add_money
        amount = params[:amount]
        type = params[:type]
        if type == 'dollar'
            if [1,2].include? amount.to_i
                charge_amount(amount, type)
            else
                render :json => {:stat => 'bad', :message => "only accepts 1 or 2 dollars you have added #{amount}"}.to_json
            return
            end

        elsif type == 'cent'
            if [1,5,10,25,50].include? amount.to_i
                charge_amount(amount, type)
            else
                render :json => {:stat => 'bad', :message => "only accepts 1, 5, 10, 25, 50 cents you have added #{amount}"}.to_json
                return
            end
        else
            render :json => {:stat => 'bad', :message => "is not possible add this amount"}.to_json
            return
        end
    end

    def buy_item
        code = params[:code_item]
        puts "viendo products #{@app.products} #{code}"
        item = @app.products.select { |item| item['code'] == code }
        item = item[0]
        if item['cost'].to_f > @app.current_balance.to_f
            render :json => {:stat => 'bad', :message => "you need to add more money"}.to_json
        else
            @app.current_balance = @app.current_balance.to_f - item['cost'].to_f
            render :json => {:stat => 'ok', :message => 'thanks for you buy', :app => @app}.to_json
        end
    end

    def load_app
        begin
            app_id = params[:app_id]
            @app = CaptureApp::find_by(app_id)
            rescue AppNotFoundError => e
                render :json => {:stat => 'bad', :message => 'app not found'}.to_json
                return
            rescue AppsNotFoundError => e
                msg = "No application configured with #{api_args.keys[1]} #{api_args.values[1]}"
                Rails.logger.warn msg
                render_exception e, error_description: msg, code: 224
                return
        end
    end


end
