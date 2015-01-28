# Usage

    bundle install
    bundle exec librarian-puppet install
    vagrant up graphite

## Machines

### Graphite

This is a general purpose graphite server with a single carbon cache running on the standard ports (2003, 2004, 7002).

### Graphite-Sharding

This is a basic example of sharding metrics to multiple carbon caches using the carbon relay.

### Benchmark

This is a simple graphite server tuned for higher resolution data (useful for benchmarking or load testing).

# Notes

Changing the composer refresh interval is very manual.

    ubuntu@benchmark:~$ grep "var interval" /opt/graphite/webapp/content/js/composer_widgets.js
    //var interval = Math.min.apply(null, [context['interval'] for each (context in MetricContexts)] || [0]) || 60;
    var interval = 60;
