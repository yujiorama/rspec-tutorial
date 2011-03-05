# Run me with:
#   $ watchr specs.watchr

# --------------------------------------------------
# Rules
# --------------------------------------------------
watch( '^.*spec\.rb'                 )  { |m| rspec  m[0] }

# --------------------------------------------------
# Signal Handling
# --------------------------------------------------
Signal.trap('INT' ) { abort("\n") } # Ctrl-C

# --------------------------------------------------
# Helpers
# --------------------------------------------------
def rspec(*paths)
  run "rspec #{gem_opt} -I. -fs #{paths.flatten.join(' ')}"
end

def tests
  Dir['test/**/test_*.rb'] - ['test/test_helper.rb']
end

def run( cmd )
  puts   cmd
  system cmd
end

def gem_opt
  defined?(Gem) ? "-rubygems" : ""
end

