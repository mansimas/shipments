base_dir = File.expand_path(File.join(File.dirname(__FILE__), '..'))
app_dir  = File.join(base_dir, 'app')
tests_dir = File.join(base_dir, 'tests')

$LOAD_PATH.unshift(app_dir)

require 'test/unit'

exit Test::Unit::AutoRunner.run(true, tests_dir)
