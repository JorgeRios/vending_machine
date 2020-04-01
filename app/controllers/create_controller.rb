require 'csv'    


class CreateController < ActionController::Base
    skip_before_action :verify_authenticity_token

    def index
    end
    def create_app
        items = []
        CSV.parse(params['app'], row_sep: params['row_sep']) do |row|
           items << row
        end
        products = []
        key_names = items[0]
        items.each_with_index do |val,index|
            hash = {}
            if index != 0
                key_names.each_with_index do |key, index|
                hash[key] = val[index]
                end
                products << hash
            end
        end 
        begin
            @app = CaptureApp::create_app(products)
        end
        render :json =>{:stat => 'ok', :app_id=>@app.id}
    end


end
