Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id B30F3731FD
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 12:58:32 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga104.fm.intel.com with ESMTP; 15 Jan 2016 04:58:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,299,1449561600"; d="scan'208";a="29894755"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga004.fm.intel.com with ESMTP; 15 Jan 2016 04:58:33 -0800
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id AC65F6A4004
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 05:46:29 -0800 (PST)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 15 Jan 2016 13:01:03 +0200
Message-Id: <bb3192f818fba687c955e6add3813c0460deb999.1452855461.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1452855461.git.ed.bartosh@linux.intel.com>
References: <cover.1452855461.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1452855461.git.ed.bartosh@linux.intel.com>
References: <cover.1452855461.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 20/23] toaster: toastergui: fix error and warning counts for builds
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 15 Jan 2016 12:58:32 -0000

From: Elliot Smith <elliot.smith@intel.com>

The error and warning counts displayed for builds were counts of
the errors and warnings objects associated with a build. Because these
values were being derived on the fly, it was not possible to sort by
them.

Previously, the 3rd party django-aggregate-if library was used to
add aggregate fields to Build objects and should then have been
used to populate the "all builds" and "project builds" tables. However,
at some point the templates had changed so that the error and warning
counts were coming from the properties on the Build model and not from
these aggregates. This meant that it was not possible to sort by these
fields.

Django 1.8 supports conditional aggregates in annotation fields on
querysets. This means we can remove django-aggregate-if, use the new Django
1.8 feature to derive errors_no and warnings_no fields as annotations,
then use those annotation fields in the templates. This makes the "builds"
tables sortable again.

[YOCTO #8738]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 .../contrib/django-aggregate-if-master/.gitignore  |  10 --
 .../contrib/django-aggregate-if-master/.travis.yml |  50 ------
 .../contrib/django-aggregate-if-master/LICENSE     |  21 ---
 .../contrib/django-aggregate-if-master/README.rst  | 156 ----------------
 .../django-aggregate-if-master/aggregate_if.py     | 164 -----------------
 .../contrib/django-aggregate-if-master/runtests.py |  48 -----
 .../contrib/django-aggregate-if-master/setup.py    |  33 ----
 .../contrib/django-aggregate-if-master/tox.ini     | 198 ---------------------
 lib/toaster/toastergui/tables.py                   |  40 +++--
 lib/toaster/toastermain/settings.py                |   9 -
 10 files changed, 27 insertions(+), 702 deletions(-)
 delete mode 100644 bitbake/lib/toaster/contrib/django-aggregate-if-master/.gitignore
 delete mode 100644 bitbake/lib/toaster/contrib/django-aggregate-if-master/.travis.yml
 delete mode 100644 bitbake/lib/toaster/contrib/django-aggregate-if-master/LICENSE
 delete mode 100644 bitbake/lib/toaster/contrib/django-aggregate-if-master/README.rst
 delete mode 100644 bitbake/lib/toaster/contrib/django-aggregate-if-master/aggregate_if.py
 delete mode 100755 bitbake/lib/toaster/contrib/django-aggregate-if-master/runtests.py
 delete mode 100644 bitbake/lib/toaster/contrib/django-aggregate-if-master/setup.py
 delete mode 100644 bitbake/lib/toaster/contrib/django-aggregate-if-master/tox.ini

diff --git a/lib/toaster/contrib/django-aggregate-if-master/.gitignore b/lib/toaster/contrib/django-aggregate-if-master/.gitignore
deleted file mode 100644
index c45652d..0000000
--- a/lib/toaster/contrib/django-aggregate-if-master/.gitignore
+++ /dev/null
@@ -1,10 +0,0 @@
-*.pyc
-*.swp
-*.swo
-*.kpf
-*.egg-info/
-.idea
-.tox
-tmp/
-dist/
-.DS_Store
diff --git a/lib/toaster/contrib/django-aggregate-if-master/.travis.yml b/lib/toaster/contrib/django-aggregate-if-master/.travis.yml
deleted file mode 100644
index a920f39..0000000
--- a/lib/toaster/contrib/django-aggregate-if-master/.travis.yml
+++ /dev/null
@@ -1,50 +0,0 @@
-language: python
-python:
-  - "2.7"
-  - "3.4"
-services:
-  - mysql
-  - postgresql
-env:
-  - DJANGO=1.4 DB=sqlite
-  - DJANGO=1.4 DB=mysql
-  - DJANGO=1.4 DB=postgres
-  - DJANGO=1.5 DB=sqlite
-  - DJANGO=1.5 DB=mysql
-  - DJANGO=1.5 DB=postgres
-  - DJANGO=1.6 DB=sqlite
-  - DJANGO=1.6 DB=mysql
-  - DJANGO=1.6 DB=postgres
-  - DJANGO=1.7 DB=sqlite
-  - DJANGO=1.7 DB=mysql
-  - DJANGO=1.7 DB=postgres
-
-matrix:
-  exclude:
-    - python: "3.4"
-      env: DJANGO=1.4 DB=sqlite
-    - python: "3.4"
-      env: DJANGO=1.4 DB=mysql
-    - python: "3.4"
-      env: DJANGO=1.4 DB=postgres
-    - python: "3.4"
-      env: DJANGO=1.5 DB=sqlite
-    - python: "3.4"
-      env: DJANGO=1.5 DB=mysql
-    - python: "3.4"
-      env: DJANGO=1.5 DB=postgres
-    - python: "3.4"
-      env: DJANGO=1.6 DB=mysql
-    - python: "3.4"
-      env: DJANGO=1.7 DB=mysql
-
-before_script:
-  - mysql -e 'create database aggregation;'
-  - psql -c 'create database aggregation;' -U postgres
-install:
-  - pip install six
-  - if [ "$DB" == "mysql" ]; then pip install mysql-python; fi
-  - if [ "$DB" == "postgres" ]; then pip install psycopg2; fi
-  - pip install -q Django==$DJANGO --use-mirrors
-script:
-  - ./runtests.py --settings=tests.test_$DB
diff --git a/lib/toaster/contrib/django-aggregate-if-master/LICENSE b/lib/toaster/contrib/django-aggregate-if-master/LICENSE
deleted file mode 100644
index 6b7c3b1..0000000
--- a/lib/toaster/contrib/django-aggregate-if-master/LICENSE
+++ /dev/null
@@ -1,21 +0,0 @@
-The MIT License
-
-Copyright (c) 2012 Henrique Bastos
-
-Permission is hereby granted, free of charge, to any person obtaining a copy
-of this software and associated documentation files (the "Software"), to deal
-in the Software without restriction, including without limitation the rights
-to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-copies of the Software, and to permit persons to whom the Software is
-furnished to do so, subject to the following conditions:
-
-The above copyright notice and this permission notice shall be included in
-all copies or substantial portions of the Software.
-
-THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-THE SOFTWARE.
diff --git a/lib/toaster/contrib/django-aggregate-if-master/README.rst b/lib/toaster/contrib/django-aggregate-if-master/README.rst
deleted file mode 100644
index 739d4da..0000000
--- a/lib/toaster/contrib/django-aggregate-if-master/README.rst
+++ /dev/null
@@ -1,156 +0,0 @@
-Django Aggregate If: Condition aggregates for Django
-====================================================
-
-.. image:: https://travis-ci.org/henriquebastos/django-aggregate-if.png?branch=master
-    :target: https://travis-ci.org/henriquebastos/django-aggregate-if
-    :alt: Test Status
-
-.. image:: https://landscape.io/github/henriquebastos/django-aggregate-if/master/landscape.png
-    :target: https://landscape.io/github/henriquebastos/django-aggregate-if/master
-    :alt: Code Helth
-
-.. image:: https://pypip.in/v/django-aggregate-if/badge.png
-    :target: https://crate.io/packages/django-aggregate-if/
-    :alt: Latest PyPI version
-
-.. image:: https://pypip.in/d/django-aggregate-if/badge.png
-    :target: https://crate.io/packages/django-aggregate-if/
-    :alt: Number of PyPI downloads
-
-*Aggregate-if* adds conditional aggregates to Django.
-
-Conditional aggregates can help you reduce the ammount of queries to obtain
-aggregated information, like statistics for example.
-
-Imagine you have a model ``Offer`` like this one:
-
-.. code-block:: python
-
-    class Offer(models.Model):
-        sponsor = models.ForeignKey(User)
-        price = models.DecimalField(max_digits=9, decimal_places=2)
-        status = models.CharField(max_length=30)
-        expire_at = models.DateField(null=True, blank=True)
-        created_at = models.DateTimeField(auto_now_add=True)
-        updated_at = models.DateTimeField(auto_now=True)
-
-        OPEN = "OPEN"
-        REVOKED = "REVOKED"
-        PAID = "PAID"
-
-Let's say you want to know:
-
-#. How many offers exists in total;
-#. How many of them are OPEN, REVOKED or PAID;
-#. How much money was offered in total;
-#. How much money is in OPEN, REVOKED and PAID offers;
-
-To get these informations, you could query:
-
-.. code-block:: python
-
-    from django.db.models import Count, Sum
-
-    Offer.objects.count()
-    Offer.objects.filter(status=Offer.OPEN).aggregate(Count('pk'))
-    Offer.objects.filter(status=Offer.REVOKED).aggregate(Count('pk'))
-    Offer.objects.filter(status=Offer.PAID).aggregate(Count('pk'))
-    Offer.objects.aggregate(Sum('price'))
-    Offer.objects.filter(status=Offer.OPEN).aggregate(Sum('price'))
-    Offer.objects.filter(status=Offer.REVOKED).aggregate(Sum('price'))
-    Offer.objects.filter(status=Offer.PAID).aggregate(Sum('price'))
-
-In this case, **8 queries** were needed to retrieve the desired information.
-
-With conditional aggregates you can get it all with only **1 query**:
-
-.. code-block:: python
-
-    from django.db.models import Q
-    from aggregate_if import Count, Sum
-
-    Offer.objects.aggregate(
-        pk__count=Count('pk'),
-        pk__open__count=Count('pk', only=Q(status=Offer.OPEN)),
-        pk__revoked__count=Count('pk', only=Q(status=Offer.REVOKED)),
-        pk__paid__count=Count('pk', only=Q(status=Offer.PAID)),
-        pk__sum=Sum('price'),
-        pk__open__sum=Sum('price', only=Q(status=Offer.OPEN)),
-        pk__revoked__sum=Sum('price'), only=Q(status=Offer.REVOKED)),
-        pk__paid__sum=Sum('price'), only=Q(status=Offer.PAID))
-    )
-
-Installation
-------------
-
-*Aggregate-if* works with Django 1.4, 1.5, 1.6 and 1.7.
-
-To install it, simply:
-
-.. code-block:: bash
-
-    $ pip install django-aggregate-if
-
-Inspiration
------------
-
-There is a 5 years old `ticket 11305`_ that will (*hopefully*) implement this feature into
-Django 1.8.
-
-Using Django 1.6, I still wanted to avoid creating custom queries for very simple
-conditional aggregations. So I've cherry picked those ideas and others from the
-internet and built this library.
-
-This library uses the same API and tests proposed on `ticket 11305`_, so when the
-new feature is available you can easily replace ``django-aggregate-if``.
-
-Limitations
------------
-
-Conditions involving joins with aliases are not supported yet. If you want to
-help adding this feature, you're welcome to check the `first issue`_.
-
-Contributors
-------------
-
-* `Henrique Bastos <http://github.com/henriquebastos>`_
-* `Iuri de Silvio <https://github.com/iurisilvio>`_
-* `Hampus Stjernhav <https://github.com/champ>`_
-* `Bradley Martsberger <https://github.com/martsberger>`_
-* `Markus Bertheau <https://github.com/mbertheau>`_
-* `end0 <https://github.com/end0>`_
-* `Scott Sexton <https://github.com/scottsexton>`_
-* `Mauler <https://github.com/mauler>`_
-* `trbs <https://github.com/trbs>`_
-
-Changelog
----------
-
-0.5
-    - Support for Django 1.7
-
-0.4
-    - Use tox to run tests.
-    - Add support for Django 1.6.
-    - Add support for Python3.
-    - The ``only`` parameter now freely supports joins independent of the main query.
-    - Adds support for alias relabeling permitting excludes and updates with aggregates filtered on remote foreign key relations.
-
-0.3.1
-    - Fix quotation escaping.
-    - Fix boolean casts on Postgres.
-
-0.2
-    - Fix postgres issue with LIKE conditions.
-
-0.1
-    - Initial release.
-
-
-License
-=======
-
-The MIT License.
-
-.. _ticket 11305: https://code.djangoproject.com/ticket/11305
-.. _first issue: https://github.com/henriquebastos/django-aggregate-if/issues/1
diff --git a/lib/toaster/contrib/django-aggregate-if-master/aggregate_if.py b/lib/toaster/contrib/django-aggregate-if-master/aggregate_if.py
deleted file mode 100644
index d5f3427..0000000
--- a/lib/toaster/contrib/django-aggregate-if-master/aggregate_if.py
+++ /dev/null
@@ -1,164 +0,0 @@
-# coding: utf-8
-'''
-Implements conditional aggregates.
-
-This code was based on the work of others found on the internet:
-
-1. http://web.archive.org/web/20101115170804/http://www.voteruniverse.com/Members/jlantz/blog/conditional-aggregates-in-django
-2. https://code.djangoproject.com/ticket/11305
-3. https://groups.google.com/forum/?fromgroups=#!topic/django-users/cjzloTUwmS0
-4. https://groups.google.com/forum/?fromgroups=#!topic/django-users/vVprMpsAnPo
-'''
-from __future__ import unicode_literals
-from django.utils import six
-import django
-from django.db.models.aggregates import Aggregate as DjangoAggregate
-from django.db.models.sql.aggregates import Aggregate as DjangoSqlAggregate
-
-
-VERSION = django.VERSION[:2]
-
-
-class SqlAggregate(DjangoSqlAggregate):
-    conditional_template = '%(function)s(CASE WHEN %(condition)s THEN %(field)s ELSE null END)'
-
-    def __init__(self, col, source=None, is_summary=False, condition=None, **extra):
-        super(SqlAggregate, self).__init__(col, source, is_summary, **extra)
-        self.condition = condition
-
-    def relabel_aliases(self, change_map):
-        if VERSION < (1, 7):
-            super(SqlAggregate, self).relabel_aliases(change_map)
-        if self.has_condition:
-            condition_change_map = dict((k, v) for k, v in \
-                change_map.items() if k in self.condition.query.alias_map
-            )
-            self.condition.query.change_aliases(condition_change_map)
-
-    def relabeled_clone(self, change_map):
-        self.relabel_aliases(change_map)
-        return super(SqlAggregate, self).relabeled_clone(change_map)
-
-    def as_sql(self, qn, connection):
-        if self.has_condition:
-            self.sql_template = self.conditional_template
-            self.extra['condition'] = self._condition_as_sql(qn, connection)
-
-        return super(SqlAggregate, self).as_sql(qn, connection)
-
-    @property
-    def has_condition(self):
-        # Warning: bool(QuerySet) will hit the database
-        return self.condition is not None
-
-    def _condition_as_sql(self, qn, connection):
-        '''
-        Return sql for condition.
-        '''
-        def escape(value):
-            if isinstance(value, bool):
-                value = str(int(value))
-            if isinstance(value, six.string_types):
-                # Escape params used with LIKE
-                if '%' in value:
-                    value = value.replace('%', '%%')
-                # Escape single quotes
-                if "'" in value:
-                    value = value.replace("'", "''")
-                # Add single quote to text values
-                value = "'" + value + "'"
-            return value
-
-        sql, param = self.condition.query.where.as_sql(qn, connection)
-        param = map(escape, param)
-
-        return sql % tuple(param)
-
-
-class SqlSum(SqlAggregate):
-    sql_function = 'SUM'
-
-
-class SqlCount(SqlAggregate):
-    is_ordinal = True
-    sql_function = 'COUNT'
-    sql_template = '%(function)s(%(distinct)s%(field)s)'
-    conditional_template = '%(function)s(%(distinct)sCASE WHEN %(condition)s THEN %(field)s ELSE null END)'
-
-    def __init__(self, col, distinct=False, **extra):
-        super(SqlCount, self).__init__(col, distinct=distinct and 'DISTINCT ' or '', **extra)
-
-
-class SqlAvg(SqlAggregate):
-    is_computed = True
-    sql_function = 'AVG'
-
-
-class SqlMax(SqlAggregate):
-    sql_function = 'MAX'
-
-
-class SqlMin(SqlAggregate):
-    sql_function = 'MIN'
-
-
-class Aggregate(DjangoAggregate):
-    def __init__(self, lookup, only=None, **extra):
-        super(Aggregate, self).__init__(lookup, **extra)
-        self.only = only
-        self.condition = None
-
-    def _get_fields_from_Q(self, q):
-        fields = []
-        for child in q.children:
-            if hasattr(child, 'children'):
-                fields.extend(self._get_fields_from_Q(child))
-            else:
-                fields.append(child)
-        return fields
-
-    def add_to_query(self, query, alias, col, source, is_summary):
-        if self.only:
-            self.condition = query.model._default_manager.filter(self.only)
-            for child in self._get_fields_from_Q(self.only):
-                field_list = child[0].split('__')
-                # Pop off the last field if it's a query term ('gte', 'contains', 'isnull', etc.)
-                if field_list[-1] in query.query_terms:
-                    field_list.pop()
-                # setup_joins have different returns in Django 1.5 and 1.6, but the order of what we need remains.
-                result = query.setup_joins(field_list, query.model._meta, query.get_initial_alias(), None)
-                join_list = result[3]
-
-                fname = 'promote_alias_chain' if VERSION < (1, 5) else 'promote_joins'
-                args = (join_list, True) if VERSION < (1, 7) else (join_list,)
-
-                promote = getattr(query, fname)
-                promote(*args)
-
-        aggregate = self.sql_klass(col, source=source, is_summary=is_summary, condition=self.condition, **self.extra)
-        query.aggregates[alias] = aggregate
-
-
-class Sum(Aggregate):
-    name = 'Sum'
-    sql_klass = SqlSum
-
-
-class Count(Aggregate):
-    name = 'Count'
-    sql_klass = SqlCount
-
-
-class Avg(Aggregate):
-    name = 'Avg'
-    sql_klass = SqlAvg
-
-
-class Max(Aggregate):
-    name = 'Max'
-    sql_klass = SqlMax
-
-
-class Min(Aggregate):
-    name = 'Min'
-    sql_klass = SqlMin
diff --git a/lib/toaster/contrib/django-aggregate-if-master/runtests.py b/lib/toaster/contrib/django-aggregate-if-master/runtests.py
deleted file mode 100755
index 2e55864..0000000
--- a/lib/toaster/contrib/django-aggregate-if-master/runtests.py
+++ /dev/null
@@ -1,48 +0,0 @@
-#!/usr/bin/env python
-
-import os
-import sys
-from optparse import OptionParser
-
-
-def parse_args():
-    parser = OptionParser()
-    parser.add_option('-s', '--settings', help='Define settings.')
-    parser.add_option('-t', '--unittest', help='Define which test to run. Default all.')
-    options, args = parser.parse_args()
-
-    if not options.settings:
-        parser.print_help()
-        sys.exit(1)
-
-    if not options.unittest:
-        options.unittest = ['aggregation']
-
-    return options
-
-
-def get_runner(settings_module):
-    '''
-    Asks Django for the TestRunner defined in settings or the default one.
-    '''
-    os.environ['DJANGO_SETTINGS_MODULE'] = settings_module
-
-    import django
-    from django.test.utils import get_runner
-    from django.conf import settings
-
-    if hasattr(django, 'setup'):
-        django.setup()
-
-    return get_runner(settings)
-
-
-def runtests():
-    options = parse_args()
-    TestRunner = get_runner(options.settings)
-    runner = TestRunner(verbosity=1, interactive=True, failfast=False)
-    sys.exit(runner.run_tests([]))
-
-
-if __name__ == '__main__':
-    runtests()
diff --git a/lib/toaster/contrib/django-aggregate-if-master/setup.py b/lib/toaster/contrib/django-aggregate-if-master/setup.py
deleted file mode 100644
index aed3db1..0000000
--- a/lib/toaster/contrib/django-aggregate-if-master/setup.py
+++ /dev/null
@@ -1,33 +0,0 @@
-# coding: utf-8
-from setuptools import setup
-import os
-
-
-setup(name='django-aggregate-if',
-      version='0.5',
-      description='Conditional aggregates for Django, just like the famous SumIf in Excel.',
-      long_description=open(os.path.join(os.path.dirname(__file__), "README.rst")).read(),
-      author="Henrique Bastos", author_email="henrique@bastos.net",
-      license="MIT",
-      py_modules=['aggregate_if'],
-      install_requires=[
-          'six>=1.6.1',
-      ],
-      zip_safe=False,
-      platforms='any',
-      include_package_data=True,
-      classifiers=[
-          'Development Status :: 5 - Production/Stable',
-          'Framework :: Django',
-          'Intended Audience :: Developers',
-          'License :: OSI Approved :: MIT License',
-          'Natural Language :: English',
-          'Operating System :: OS Independent',
-          'Programming Language :: Python',
-          'Programming Language :: Python :: 2.7',
-          'Programming Language :: Python :: 3',
-          'Topic :: Database',
-          'Topic :: Software Development :: Libraries',
-      ],
-      url='http://github.com/henriquebastos/django-aggregate-if/',
-)
diff --git a/lib/toaster/contrib/django-aggregate-if-master/tox.ini b/lib/toaster/contrib/django-aggregate-if-master/tox.ini
deleted file mode 100644
index 78beb14..0000000
--- a/lib/toaster/contrib/django-aggregate-if-master/tox.ini
+++ /dev/null
@@ -1,198 +0,0 @@
-[tox]
-envlist =
-    py27-django1.4-sqlite,
-    py27-django1.4-postgres,
-    py27-django1.4-mysql,
-
-    py27-django1.5-sqlite,
-    py27-django1.5-postgres,
-    py27-django1.5-mysql,
-
-    py27-django1.6-sqlite,
-    py27-django1.6-postgres,
-    py27-django1.6-mysql,
-
-    py27-django1.7-sqlite,
-    py27-django1.7-postgres,
-    py27-django1.7-mysql,
-
-    py34-django1.6-sqlite,
-    py34-django1.6-postgres,
-    #py34-django1.6-mysql
-
-    py34-django1.7-sqlite,
-    py34-django1.7-postgres,
-    #py34-django1.7-mysql
-
-[testenv]
-whitelist_externals=
-    mysql
-    psql
-
-# Python 2.7
-# Django 1.4
-[testenv:py27-django1.4-sqlite]
-basepython = python2.7
-deps =
-    django==1.4
-commands = python runtests.py --settings tests.test_sqlite
-
-[testenv:py27-django1.4-postgres]
-basepython = python2.7
-deps =
-    django==1.4
-    psycopg2
-commands =
-    psql -c 'create database aggregation;' postgres
-    python runtests.py --settings tests.test_postgres
-    psql -c 'drop database aggregation;' postgres
-
-[testenv:py27-django1.4-mysql]
-basepython = python2.7
-deps =
-    django==1.4
-    mysql-python
-commands =
-    mysql -e 'create database aggregation;'
-    python runtests.py --settings tests.test_mysql
-    mysql -e 'drop database aggregation;'
-
-# Django 1.5
-[testenv:py27-django1.5-sqlite]
-basepython = python2.7
-deps =
-    django==1.5
-commands = python runtests.py --settings tests.test_sqlite
-
-[testenv:py27-django1.5-postgres]
-basepython = python2.7
-deps =
-    django==1.5
-    psycopg2
-commands =
-    psql -c 'create database aggregation;' postgres
-    python runtests.py --settings tests.test_postgres
-    psql -c 'drop database aggregation;' postgres
-
-[testenv:py27-django1.5-mysql]
-basepython = python2.7
-deps =
-    django==1.5
-    mysql-python
-commands =
-    mysql -e 'create database aggregation;'
-    python runtests.py --settings tests.test_mysql
-    mysql -e 'drop database aggregation;'
-
-# Django 1.6
-[testenv:py27-django1.6-sqlite]
-basepython = python2.7
-deps =
-    django==1.6
-commands = python runtests.py --settings tests.test_sqlite
-
-[testenv:py27-django1.6-postgres]
-basepython = python2.7
-deps =
-    django==1.6
-    psycopg2
-commands =
-    psql -c 'create database aggregation;' postgres
-    python runtests.py --settings tests.test_postgres
-    psql -c 'drop database aggregation;' postgres
-
-[testenv:py27-django1.6-mysql]
-basepython = python2.7
-deps =
-    django==1.6
-    mysql-python
-commands =
-    mysql -e 'create database aggregation;'
-    python runtests.py --settings tests.test_mysql
-    mysql -e 'drop database aggregation;'
-
-
-# Python 2.7 and Django 1.7
-[testenv:py27-django1.7-sqlite]
-basepython = python2.7
-deps =
-    django==1.7
-commands = python runtests.py --settings tests.test_sqlite
-
-[testenv:py27-django1.7-postgres]
-basepython = python2.7
-deps =
-    django==1.7
-    psycopg2
-commands =
-    psql -c 'create database aggregation;' postgres
-    python runtests.py --settings tests.test_postgres
-    psql -c 'drop database aggregation;' postgres
-
-[testenv:py27-django1.7-mysql]
-basepython = python2.7
-deps =
-    django==1.7
-    mysql-python
-commands =
-    mysql -e 'create database aggregation;'
-    python runtests.py --settings tests.test_mysql
-    mysql -e 'drop database aggregation;'
-
-
-# Python 3.4
-# Django 1.6
-[testenv:py34-django1.6-sqlite]
-basepython = python3.4
-deps =
-    django==1.6
-commands = python runtests.py --settings tests.test_sqlite
-
-[testenv:py34-django1.6-postgres]
-basepython = python3.4
-deps =
-    django==1.6
-    psycopg2
-commands =
-    psql -c 'create database aggregation;' postgres
-    python runtests.py --settings tests.test_postgres
-    psql -c 'drop database aggregation;' postgres
-
-[testenv:py34-django1.6-mysql]
-basepython = python3.4
-deps =
-    django==1.6
-    mysql-python3
-commands =
-    mysql -e 'create database aggregation;'
-    python runtests.py --settings tests.test_mysql
-    mysql -e 'drop database aggregation;'
-
-
-# Python 3.4
-# Django 1.7
-[testenv:py34-django1.7-sqlite]
-basepython = python3.4
-deps =
-    django==1.7
-commands = python runtests.py --settings tests.test_sqlite
-
-[testenv:py34-django1.7-postgres]
-basepython = python3.4
-deps =
-    django==1.7
-    psycopg2
-commands =
-    psql -c 'create database aggregation;' postgres
-    python runtests.py --settings tests.test_postgres
-    psql -c 'drop database aggregation;' postgres
-
-[testenv:py34-django1.7-mysql]
-basepython = python3.4
-deps =
-    django==1.7
-    mysql-python3
-commands =
-    mysql -e 'create database aggregation;'
-    python runtests.py --settings tests.test_mysql
-    mysql -e 'drop database aggregation;'
diff --git a/lib/toaster/toastergui/tables.py b/lib/toaster/toastergui/tables.py
index 14077e1..2279731 100644
--- a/lib/toaster/toastergui/tables.py
+++ b/lib/toaster/toastergui/tables.py
@@ -23,7 +23,7 @@ from toastergui.widgets import ToasterTable
 from orm.models import Recipe, ProjectLayer, Layer_Version, Machine, Project
 from orm.models import CustomImageRecipe, Package, Build, LogMessage, Task
 from orm.models import ProjectTarget
-from django.db.models import Q, Max, Count
+from django.db.models import Q, Max, Count, When, Case, Value, IntegerField
 from django.conf.urls import url
 from django.core.urlresolvers import reverse, resolve
 from django.http import HttpResponse
@@ -927,6 +927,13 @@ class BuildsTable(ToasterTable):
         return context
 
     def setup_queryset(self, *args, **kwargs):
+        """
+        The queryset is annotated so that it can be sorted by number of
+        errors and number of warnings; but note that the criteria for
+        finding the log messages to populate these fields should match those
+        used in the Build model (orm/models.py) to populate the errors and
+        warnings properties
+        """
         queryset = self.get_builds()
 
         # don't include in progress builds
@@ -935,20 +942,27 @@ class BuildsTable(ToasterTable):
         # sort
         queryset = queryset.order_by(self.default_orderby)
 
-        # annotate with number of ERROR and EXCEPTION log messages
+        # annotate with number of ERROR, EXCEPTION and CRITICAL log messages
+        criteria = (Q(logmessage__level=LogMessage.ERROR) |
+                    Q(logmessage__level=LogMessage.EXCEPTION) |
+                    Q(logmessage__level=LogMessage.CRITICAL))
+
         queryset = queryset.annotate(
-            errors_no = Count(
-                'logmessage',
-                only = Q(logmessage__level=LogMessage.ERROR) |
-                       Q(logmessage__level=LogMessage.EXCEPTION)
+            errors_no=Count(
+                Case(
+                    When(criteria, then=Value(1)),
+                    output_field=IntegerField()
+                )
             )
         )
 
         # annotate with number of WARNING log messages
         queryset = queryset.annotate(
-            warnings_no = Count(
-                'logmessage',
-                only = Q(logmessage__level=LogMessage.WARNING)
+            warnings_no=Count(
+                Case(
+                    When(logmessage__level=LogMessage.WARNING, then=Value(1)),
+                    output_field=IntegerField()
+                )
             )
         )
 
@@ -1020,17 +1034,17 @@ class BuildsTable(ToasterTable):
         '''
 
         errors_template = '''
-        {% if data.errors.count %}
+        {% if data.errors_no %}
             <a class="errors.count error" href="{% url "builddashboard" data.id %}#errors">
-                {{data.errors.count}} error{{data.errors.count|pluralize}}
+                {{data.errors_no}} error{{data.errors_no|pluralize}}
             </a>
         {% endif %}
         '''
 
         warnings_template = '''
-        {% if data.warnings.count %}
+        {% if data.warnings_no %}
             <a class="warnings.count warning" href="{% url "builddashboard" data.id %}#warnings">
-                {{data.warnings.count}} warning{{data.warnings.count|pluralize}}
+                {{data.warnings_no}} warning{{data.warnings_no|pluralize}}
             </a>
         {% endif %}
         '''
diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/settings.py
index 74103f3..c4f3d6b 100644
--- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -399,12 +399,3 @@ class InvalidString(str):
             "Undefined variable or unknown value for: \"%s\"" % other)
 
 TEMPLATE_STRING_IF_INVALID = InvalidString("%s")
-
-import sys
-sys.path.append(
-    os.path.join(
-    os.path.join(
-        os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
-            "contrib"),
-            "django-aggregate-if-master")
-    )
-- 
2.1.4


