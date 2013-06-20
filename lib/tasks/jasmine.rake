unless Rails.env.production? || Rails.env.cucumber?
  namespace :jasmine do
    desc 'run jasmine with headless gem'
    task :headless do
      Bundler.require :development
      Bundler.require :test

      headless = Headless.new
      headless.start
      Rake::Task['jasmine:headless'].invoke
    end
  end
end
