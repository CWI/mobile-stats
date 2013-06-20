# -*- encoding : utf-8 -*-
Before('@javascrip') do
  @headless_start ||= Headless.new.start
end

After do
  DatabaseCleaner.clean
end
