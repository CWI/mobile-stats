# encoding: utf-8
require 'spec_helper'

describe StatsController do

  describe 'index' do
    
    it 'has a 200 status code' do
      get :index
      expect(response.status).to eq(200)
    end
    
    it 'should redirect to vendor' do
      post :index, event_name: 'xxx'
      response.should redirect_to('/xxx/report/vendor')
    end

    it 'invalid params' do
      post :index, event_name: ''
      flash.should_not be_nil
      response.should render_template(:action=> "index")
    end
  end

  describe 'report_redirect' do

      it 'should redirect to vendor' do
        post :report_redirect, event_name: 'xxx'
        response.should redirect_to('/xxx/report/vendor')
       end
  end

   describe 'slug' do
     subject { controller.send(:slug, string) }

     context 'slug' do
       let (:string) {'xxx xxx'}
      it { should == 'xxx-xxx' }
    end
    
    context 'upper case' do
       let (:string) {'Xxx'}
      it { should == 'xxx' }
    end

    context '\w' do
       let (:string) {'xxç'}
      it { should == 'xx' }
    end
   end

end
