Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f48.google.com (mail-wm0-f48.google.com [74.125.82.48])
	by mail.openembedded.org (Postfix) with ESMTP id AEEC36FF6B
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Mar 2016 11:32:21 +0000 (UTC)
Received: by mail-wm0-f48.google.com with SMTP id l68so126949157wml.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 08 Mar 2016 03:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=ZHrqxSik5v5P43oPWpAuJZuXEthr/iAqNi5P9YkteaI=;
	b=Fdtxywvr3lWyp9eo224Ul5RfWt0AgNyAOv6IlTwjTdbhI+lQFLfukkWVbEwawLogUv
	Fr/BIm56n0VJDH88R5zcHHYtPoXF7BhtiwHy5waR1ccuolMHKcZ4n3ljKnDb6EjI93ne
	rAG2HpfVbcw2M8liFz9qMQtJy63v0+6AdxyO9oWku3BClmQZ6oYTh6OoQ1PtMHGl6755
	WPJ3t4C4EpOHz+jFHicio6IFErPxv6CbWDpS4dnGsQNR5mjY6nAimB5t3JzScHF9hYgh
	a6TeBfXYfduJrpgPxt+Of3Ln58dKXu/ODacfzYX1C9G9IDaZ+3o2KrE5onSJ3xaD1z0s
	KldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=ZHrqxSik5v5P43oPWpAuJZuXEthr/iAqNi5P9YkteaI=;
	b=bWJ5LMmeH3S/MiEGQgHQ2rUVmtKpl3NcJkOzm4S910hc3KZQ5cX7XpigS6yMHqhLr4
	y7TEPS67lf3YF881RIXJn3JK3UwRD/YqxG5THblbB1n05OC7j1udUxj5kA0c9uge5CqZ
	mvRkzeX0NcoALQHrBi4laOdiNacABeiPeQ9gOClUYjJTSohnHbsd8aLYICyaC2QbcoBK
	QDh0/c9EQn2uUHWbPQyCiACNUHgTkWmoYhOABfl8s/OiuIiFSEKxwuOdzpl2dpe/BpMg
	YCyOOUQg3l0Cl88nhb7bcGy30Qo02lZYdY8S6BtAslMrEpGGWXY3ctTZ7AB2LHhniNTz
	C+4g==
X-Gm-Message-State: AD7BkJK6JjIf+fplb76BXM+AssPlrtQHs2ORv4SfiShRZXcGDoW5K9C3rvLMeMw3jb4582LQ
X-Received: by 10.194.90.100 with SMTP id bv4mr17353141wjb.4.1457436741832;
	Tue, 08 Mar 2016 03:32:21 -0800 (PST)
Received: from dorado.home (host86-147-84-80.range86-147.btcentralplus.com.
	[86.147.84.80]) by smtp.gmail.com with ESMTPSA id
	y62sm2955138wmg.12.2016.03.08.03.32.20
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 08 Mar 2016 03:32:20 -0800 (PST)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  8 Mar 2016 11:32:12 +0000
Message-Id: <1457436732-7609-2-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1457436732-7609-1-git-send-email-michael.g.wood@intel.com>
References: <1457436732-7609-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH] toaster: rework task buildstats storage and display
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
X-List-Received-Date: Tue, 08 Mar 2016 11:32:22 -0000

From: Elliot Smith <elliot.smith@intel.com>

The data available from buildstats is now more fine grained than
previously, so take advantage of that to enrich the data we save
against tasks:

* Store the CPU usage for user and system separately, and display
them separately.
* Disk IO is now measured in bytes, not ms. Also store the
read/write bytes separately.
* Store started and ended times, as well as elapsed_time. This
will enable future features such as showing which tasks were
running at a particular point in the build.

There was also a problem with how we were looking up the Task
object, which meant that the buildstats were being added to
new tasks which weren't correctly associated with the build. Fix
how we look up the Task (only looking for tasks which match the
build, and the task and recipe names in the build stats data) so
the build stats are associated with the correct task.

[YOCTO #8842]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/bb/ui/buildinfohelper.py                       | 72 ++++++++++------------
 .../orm/migrations/0005_task_field_separation.py   | 48 +++++++++++++++
 lib/toaster/orm/models.py                          | 18 +++++-
 .../toastergui/templates/basebuildpage.html        |  4 +-
 lib/toaster/toastergui/templates/task.html         | 23 ++++---
 lib/toaster/toastergui/templates/tasks.html        | 20 +++---
 lib/toaster/toastergui/urls.py                     |  2 +-
 lib/toaster/toastergui/views.py                    | 55 +++++++++++------
 8 files changed, 163 insertions(+), 79 deletions(-)
 create mode 100644 lib/toaster/orm/migrations/0005_task_field_separation.py

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 81abede..7fedb76 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -50,6 +50,7 @@ from bb.msg import BBLogFormatter as formatter
 from django.db import models
 from pprint import pformat
 import logging
+from datetime import datetime, timedelta
 
 from django.db import transaction, connection
 
@@ -120,6 +121,12 @@ class ORMWrapper(object):
 
         return vars(self)[dictname][key]
 
+    def _timestamp_to_datetime(self, secs):
+        """
+        Convert timestamp in seconds to Python datetime
+        """
+        return datetime(1970, 1, 1) + timedelta(seconds=secs)
+
     # pylint: disable=no-self-use
     # we disable detection of no self use in functions because the methods actually work on the object
     # even if they don't touch self anywhere
@@ -223,6 +230,28 @@ class ORMWrapper(object):
         target.license_manifest_path = license_manifest_path
         target.save()
 
+    def update_task_object(self, build, task_name, recipe_name, task_stats):
+        """
+        Find the task for build which matches the recipe and task name
+        to be stored
+        """
+        task_to_update = Task.objects.get(
+            build = build,
+            task_name = task_name,
+            recipe__name = recipe_name
+        )
+
+        task_to_update.started = self._timestamp_to_datetime(task_stats['started'])
+        task_to_update.ended = self._timestamp_to_datetime(task_stats['ended'])
+        task_to_update.elapsed_time = (task_stats['ended'] - task_stats['started'])
+        task_to_update.cpu_time_user = task_stats['cpu_time_user']
+        task_to_update.cpu_time_system = task_stats['cpu_time_system']
+        task_to_update.disk_io_read = task_stats['disk_io_read']
+        task_to_update.disk_io_write = task_stats['disk_io_write']
+        task_to_update.disk_io = task_stats['disk_io_read'] + task_stats['disk_io_write']
+
+        task_to_update.save()
+
     def get_update_task_object(self, task_information, must_exist = False):
         assert 'build' in task_information
         assert 'recipe' in task_information
@@ -259,14 +288,6 @@ class ORMWrapper(object):
                 task_object.sstate_result = Task.SSTATE_FAILED
                 object_changed = True
 
-        # mark down duration if we have a start time and a current time
-        if 'start_time' in task_information.keys() and 'end_time' in task_information.keys():
-            duration = task_information['end_time'] - task_information['start_time']
-            task_object.elapsed_time = duration
-            object_changed = True
-            del task_information['start_time']
-            del task_information['end_time']
-
         if object_changed:
             task_object.save()
         return task_object
@@ -1091,31 +1112,11 @@ class BuildInfoHelper(object):
 
 
     def store_tasks_stats(self, event):
-        for (taskfile, taskname, taskstats, recipename) in BuildInfoHelper._get_data_from_event(event):
-            localfilepath = taskfile.split(":")[-1]
-            assert localfilepath.startswith("/")
+        task_data = BuildInfoHelper._get_data_from_event(event)
 
-            recipe_information = self._get_recipe_information_from_taskfile(taskfile)
-            try:
-                if recipe_information['file_path'].startswith(recipe_information['layer_version'].local_path):
-                    recipe_information['file_path'] = recipe_information['file_path'][len(recipe_information['layer_version'].local_path):].lstrip("/")
-
-                recipe_object = Recipe.objects.get(layer_version = recipe_information['layer_version'],
-                            file_path__endswith = recipe_information['file_path'],
-                            name = recipename)
-            except Recipe.DoesNotExist:
-                logger.error("Could not find recipe for recipe_information %s name %s" , pformat(recipe_information), recipename)
-                raise
-
-            task_information = {}
-            task_information['build'] = self.internal_state['build']
-            task_information['recipe'] = recipe_object
-            task_information['task_name'] = taskname
-            task_information['cpu_usage'] = taskstats['cpu_usage']
-            task_information['disk_io'] = taskstats['disk_io']
-            if 'elapsed_time' in taskstats:
-                task_information['elapsed_time'] = taskstats['elapsed_time']
-            self.orm_wrapper.get_update_task_object(task_information)
+        for (task_file, task_name, task_stats, recipe_name) in task_data:
+            build = self.internal_state['build']
+            self.orm_wrapper.update_task_object(build, task_name, recipe_name, task_stats)
 
     def update_and_store_task(self, event):
         assert 'taskfile' in vars(event)
@@ -1137,13 +1138,6 @@ class BuildInfoHelper(object):
         recipe = self.orm_wrapper.get_update_recipe_object(recipe_information, True)
         task_information = self._get_task_information(event,recipe)
 
-        if 'time' in vars(event):
-            if not 'start_time' in self.internal_state['taskdata'][identifier]:
-                self.internal_state['taskdata'][identifier]['start_time'] = event.time
-            else:
-                task_information['end_time'] = event.time
-                task_information['start_time'] = self.internal_state['taskdata'][identifier]['start_time']
-
         task_information['outcome'] = self.internal_state['taskdata'][identifier]['outcome']
 
         if 'logfile' in vars(event):
diff --git a/lib/toaster/orm/migrations/0005_task_field_separation.py b/lib/toaster/orm/migrations/0005_task_field_separation.py
new file mode 100644
index 0000000..fb1196b
--- /dev/null
+++ b/lib/toaster/orm/migrations/0005_task_field_separation.py
@@ -0,0 +1,48 @@
+# -*- coding: utf-8 -*-
+from __future__ import unicode_literals
+
+from django.db import migrations, models
+
+
+class Migration(migrations.Migration):
+
+    dependencies = [
+        ('orm', '0004_provides'),
+    ]
+
+    operations = [
+        migrations.RemoveField(
+            model_name='task',
+            name='cpu_usage',
+        ),
+        migrations.AddField(
+            model_name='task',
+            name='cpu_time_system',
+            field=models.DecimalField(null=True, max_digits=8, decimal_places=2),
+        ),
+        migrations.AddField(
+            model_name='task',
+            name='cpu_time_user',
+            field=models.DecimalField(null=True, max_digits=8, decimal_places=2),
+        ),
+        migrations.AddField(
+            model_name='task',
+            name='disk_io_read',
+            field=models.IntegerField(null=True),
+        ),
+        migrations.AddField(
+            model_name='task',
+            name='disk_io_write',
+            field=models.IntegerField(null=True),
+        ),
+        migrations.AddField(
+            model_name='task',
+            name='ended',
+            field=models.DateTimeField(null=True),
+        ),
+        migrations.AddField(
+            model_name='task',
+            name='started',
+            field=models.DateTimeField(null=True),
+        ),
+    ]
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 93b5df3..182d355 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -720,9 +720,23 @@ class Task(models.Model):
     work_directory = models.FilePathField(max_length=255, blank=True)
     script_type = models.IntegerField(choices=TASK_CODING, default=CODING_NA)
     line_number = models.IntegerField(default=0)
-    disk_io = models.IntegerField(null=True)
-    cpu_usage = models.DecimalField(max_digits=8, decimal_places=2, null=True)
+
+    # start/end times
+    started = models.DateTimeField(null=True)
+    ended = models.DateTimeField(null=True)
+
+    # in seconds; this is stored to enable sorting
     elapsed_time = models.DecimalField(max_digits=8, decimal_places=2, null=True)
+
+    # in bytes; note that disk_io is stored to enable sorting
+    disk_io = models.IntegerField(null=True)
+    disk_io_read = models.IntegerField(null=True)
+    disk_io_write = models.IntegerField(null=True)
+
+    # in seconds
+    cpu_time_user = models.DecimalField(max_digits=8, decimal_places=2, null=True)
+    cpu_time_system = models.DecimalField(max_digits=8, decimal_places=2, null=True)
+
     sstate_result = models.IntegerField(choices=SSTATE_RESULT, default=SSTATE_NA)
     message = models.CharField(max_length=240)
     logfile = models.FilePathField(max_length=255, blank=True)
diff --git a/lib/toaster/toastergui/templates/basebuildpage.html b/lib/toaster/toastergui/templates/basebuildpage.html
index 0dc71f5..ff9433e 100644
--- a/lib/toaster/toastergui/templates/basebuildpage.html
+++ b/lib/toaster/toastergui/templates/basebuildpage.html
@@ -67,8 +67,8 @@
               {% block nav-buildtime %}
                   <li><a href="{% url 'buildtime' build.pk %}">Time</a></li>
               {% endblock %}
-              {% block nav-cpuusage %}
-                  <li><a href="{% url 'cpuusage' build.pk %}">CPU usage</a></li>
+              {% block nav-cputime %}
+                  <li><a href="{% url 'cputime' build.pk %}">CPU time</a></li>
               {% endblock %}
               {% block nav-diskio %}
                   <li><a href="{% url 'diskio' build.pk %}">Disk I/O</a></li>
diff --git a/lib/toaster/toastergui/templates/task.html b/lib/toaster/toastergui/templates/task.html
index ef628d9..5768262 100644
--- a/lib/toaster/toastergui/templates/task.html
+++ b/lib/toaster/toastergui/templates/task.html
@@ -238,7 +238,7 @@
 </dl>
 
 {# Performance section - shown only for executed tasks #}
-{%if task.elapsed_time or task.cpu_usage or task.disk_io %}
+{%if task.elapsed_time or task.cpu_time_user or task.cpu_time_system or task.disk_io %}
     <h2 class="details">Performance</h2>
 {% endif %}
     <dl class="dl-horizontal">
@@ -249,19 +249,26 @@
         </dt>
         <dd>{{task.elapsed_time|format_none_and_zero|floatformat:2}}</dd>
         {% endif %}
-        {% if task.cpu_usage > 0 %}
+        {% if task.cpu_time_user > 0 %}
         <dt>
-            <i class="icon-question-sign get-help" title="The percentage of task CPU utilization"></i>
-            CPU usage
+            <i class="icon-question-sign get-help" title="Total amount of time spent executing in user mode, in seconds. Note that this time can be greater than the task time due to parallel execution."></i>
+            User CPU time (secs)
         </dt>
-        <dd>{{task.cpu_usage|format_none_and_zero|floatformat:2}}%</dd>
+        <dd>{{task.cpu_time_user|format_none_and_zero|floatformat:2}}</dd>
+        {% endif %}
+        {% if task.cpu_time_system > 0 %}
+        <dt>
+            <i class="icon-question-sign get-help" title="Total amount of time spent executing in kernel mode, in seconds. Note that this time can be greater than the task time due to parallel execution."></i>
+            System CPU time (secs)
+        </dt>
+        <dd>{{task.cpu_time_system|format_none_and_zero|floatformat:2}}</dd>
         {% endif %}
         {% if task.disk_io > 0 %}
         <dt>
-            <i class="icon-question-sign get-help" title="Number of miliseconds the task spent doing disk input and output"></i>
-            Disk I/O (ms)
+            <i class="icon-question-sign get-help" title="Number of bytes written to and read from the disk during the task"></i>
+            Disk I/O (bytes)
         </dt>
-        <dd>{{task.disk_io|format_none_and_zero}}</dd>
+        <dd>{{task.disk_io|format_none_and_zero|intcomma}}</dd>
         {% endif %}
     </dl>
 
diff --git a/lib/toaster/toastergui/templates/tasks.html b/lib/toaster/toastergui/templates/tasks.html
index 353410f..23eb957 100644
--- a/lib/toaster/toastergui/templates/tasks.html
+++ b/lib/toaster/toastergui/templates/tasks.html
@@ -1,4 +1,5 @@
 {% extends "basebuildpage.html" %}
+{% load humanize %}
 {% load projecttags %}
 
 {% block title %} {{mainheading}} - {{build.target_set.all|dictsort:"target"|join:", "}} {{build.machine}} - {{build.project.name}} - Toaster{% endblock %}
@@ -20,13 +21,15 @@
     <li><a href="{% url 'buildtime' build.pk %}">Time</a></li>
   {% endif %}
 {% endblock %}
-{% block nav-cpuusage %}
-  {% if 'CPU usage' == mainheading %}
-    <li class="active"><a href="{% url 'cpuusage' build.pk %}">CPU usage</a></li>
+
+{% block nav-cputime %}
+  {% if 'CPU time' == mainheading %}
+    <li class="active"><a href="{% url 'cputime' build.pk %}">CPU time</a></li>
   {% else %}
-    <li><a href="{% url 'cpuusage' build.pk %}">CPU usage</a></li>
+    <li><a href="{% url 'cputime' build.pk %}">CPU time</a></li>
   {% endif %}
 {% endblock %}
+
 {% block nav-diskio %}
   {% if 'Disk I/O' == mainheading %}
     <li class="active"><a href="{% url 'diskio' build.pk %}">Disk I/O</a></li>
@@ -107,11 +110,14 @@
             <td class="time_taken">
                 {{task.elapsed_time|format_none_and_zero|floatformat:2}}
             </td>
-            <td class="cpu_used">
-                {{task.cpu_usage|format_none_and_zero|floatformat:2}}{% if task.cpu_usage %}%{% endif %}
+            <td class="cpu_time_system">
+                {{task.cpu_time_system|format_none_and_zero|floatformat:2}}
+            </td>
+            <td class="cpu_time_user">
+                {{task.cpu_time_user|format_none_and_zero|floatformat:2}}
             </td>
             <td class="disk_io">
-                {{task.disk_io|format_none_and_zero}}
+                {{task.disk_io|format_none_and_zero|intcomma}}
             </td>
 
         </tr>
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index 4aa6488..400580a 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -64,7 +64,7 @@ urlpatterns = patterns('toastergui.views',
         url(r'^build/(?P<build_id>\d+)/configuration$', 'configuration', name='configuration'),
         url(r'^build/(?P<build_id>\d+)/configvars$', 'configvars', name='configvars'),
         url(r'^build/(?P<build_id>\d+)/buildtime$', 'buildtime', name='buildtime'),
-        url(r'^build/(?P<build_id>\d+)/cpuusage$', 'cpuusage', name='cpuusage'),
+        url(r'^build/(?P<build_id>\d+)/cputime$', 'cputime', name='cputime'),
         url(r'^build/(?P<build_id>\d+)/diskio$', 'diskio', name='diskio'),
 
         # image information dir
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index bd11892..85ca9be 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1005,11 +1005,11 @@ def tasks_common(request, build_id, variant, task_anchor):
         object_search_display="disk I/O data"
         filter_search_display="tasks"
         (pagesize, orderby) = _get_parameters_values(request, 25, 'disk_io:-')
-    elif 'cpuusage'  == variant:
-        title_variant='CPU usage'
-        object_search_display="CPU usage data"
+    elif 'cputime'  == variant:
+        title_variant='CPU time'
+        object_search_display="CPU time data"
         filter_search_display="tasks"
-        (pagesize, orderby) = _get_parameters_values(request, 25, 'cpu_usage:-')
+        (pagesize, orderby) = _get_parameters_values(request, 25, 'cpu_time_system:-')
     else :
         title_variant='Tasks'
         object_search_display="tasks"
@@ -1161,23 +1161,38 @@ def tasks_common(request, build_id, variant, task_anchor):
         del tc_time['clclass']
         tc_cache['hidden']='1'
 
-    tc_cpu={
-        'name':'CPU usage',
-        'qhelp':'The percentage of task CPU utilization',
-        'orderfield': _get_toggle_order(request, "cpu_usage", True),
-        'ordericon':_get_toggle_order_icon(request, "cpu_usage"),
-        'orderkey' : 'cpu_usage',
-        'clclass': 'cpu_used', 'hidden' : 1,
+    tc_cpu_time_system={
+        'name':'System CPU time (secs)',
+        'qhelp':'Total amount of time spent executing in kernel mode, in ' +
+                'seconds. Note that this time can be greater than the task ' +
+                'time due to parallel execution.',
+        'orderfield': _get_toggle_order(request, "cpu_time_system", True),
+        'ordericon':_get_toggle_order_icon(request, "cpu_time_system"),
+        'orderkey' : 'cpu_time_system',
+        'clclass': 'cpu_time_system', 'hidden' : 1,
     }
 
-    if  'cpuusage' == variant:
-        tc_cpu['hidden']='0'
-        del tc_cpu['clclass']
+    tc_cpu_time_user={
+        'name':'User CPU time (secs)',
+        'qhelp':'Total amount of time spent executing in user mode, in seconds. ' +
+                'Note that this time can be greater than the task time due to ' +
+                'parallel execution.',
+        'orderfield': _get_toggle_order(request, "cpu_time_user", True),
+        'ordericon':_get_toggle_order_icon(request, "cpu_time_user"),
+        'orderkey' : 'cpu_time_user',
+        'clclass': 'cpu_time_user', 'hidden' : 1,
+    }
+
+    if 'cputime' == variant:
+        tc_cpu_time_system['hidden']='0'
+        tc_cpu_time_user['hidden']='0'
+        del tc_cpu_time_system['clclass']
+        del tc_cpu_time_user['clclass']
         tc_cache['hidden']='1'
 
     tc_diskio={
-        'name':'Disk I/O (ms)',
-        'qhelp':'Number of miliseconds the task spent doing disk input and output',
+        'name':'Disk I/O (bytes)',
+        'qhelp':'Number of bytes written to and read from the disk during the task',
         'orderfield': _get_toggle_order(request, "disk_io", True),
         'ordericon':_get_toggle_order_icon(request, "disk_io"),
         'orderkey' : 'disk_io',
@@ -1208,7 +1223,8 @@ def tasks_common(request, build_id, variant, task_anchor):
                     tc_outcome,
                     tc_cache,
                     tc_time,
-                    tc_cpu,
+                    tc_cpu_time_system,
+                    tc_cpu_time_user,
                     tc_diskio,
                 ]}
 
@@ -1229,9 +1245,8 @@ def buildtime(request, build_id):
 def diskio(request, build_id):
     return tasks_common(request, build_id, 'diskio', '')
 
-def cpuusage(request, build_id):
-    return tasks_common(request, build_id, 'cpuusage', '')
-
+def cputime(request, build_id):
+    return tasks_common(request, build_id, 'cputime', '')
 
 def recipes(request, build_id):
     template = 'recipes.html'
-- 
2.5.0


