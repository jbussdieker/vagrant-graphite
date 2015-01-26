# Notes

Changing the composer refresh interval is very manual.

    ubuntu@benchmark:~$ grep "var interval" /opt/graphite/webapp/content/js/composer_widgets.js
    //var interval = Math.min.apply(null, [context['interval'] for each (context in MetricContexts)] || [0]) || 60;
    var interval = 60;
