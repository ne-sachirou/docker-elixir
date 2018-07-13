"""Digdag tasks."""
import jinja2
import json


class Template(object):
    """Jinja2 template."""

    def render(self, **kwarg):
        """Render template."""
        src = kwarg['src']
        dest = kwarg['dest']
        template_vars = json.loads(kwarg['template_vars'])
        text = jinja2.Environment(loader=jinja2.FileSystemLoader('./', encoding='utf8')) \
                     .get_template(src) \
                     .render(template_vars)
        with open(dest, 'w', encoding='utf8') as f:
            f.write(text)
