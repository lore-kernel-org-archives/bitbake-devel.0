Return-Path: <ddalex@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id D255960EB6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Sep 2013 12:09:52 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga102.jf.intel.com with ESMTP; 26 Sep 2013 05:06:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,985,1371106800"; d="scan'208";a="401349914"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by fmsmga001.fm.intel.com with ESMTP; 26 Sep 2013 05:09:50 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id B8142560586; Thu, 26 Sep 2013 13:09:49 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 26 Sep 2013 13:09:46 +0100
Message-Id: <1380197387-15773-1-git-send-email-alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 1/3] bitbake: add webhob code to bitbake
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
X-List-Received-Date: Thu, 26 Sep 2013 12:09:53 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch contains all the files of Webhob,
with the history squashed together.

Features added:
* webhob start script
* data object model
* Django framework and boilerplate code
* web API
* Simple UI code

Code contains fixes for bugs discovered during
testing phase:
    [YOCTO #5186]
    [YOCTO #5196]
    [YOCTO #5194]
    [YOCTO #5218]
    [YOCTO #5218]
    [YOCTO #5010]
    [YOCTO #4967]
    [YOCTO #4873]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/bin/webhob                                 | 145 ++++++++++++
 bitbake/lib/webhob/__init__.py                     |   0
 bitbake/lib/webhob/bldviewer/__init__.py           |   0
 bitbake/lib/webhob/bldviewer/api.py                |  37 +++
 bitbake/lib/webhob/bldviewer/templates/base.html   |  30 +++
 .../webhob/bldviewer/templates/basebuildpage.html  |  17 ++
 .../lib/webhob/bldviewer/templates/basetable.html  |  46 ++++
 bitbake/lib/webhob/bldviewer/templates/bfile.html  |  24 ++
 .../lib/webhob/bldviewer/templates/bpackage.html   |  44 ++++
 bitbake/lib/webhob/bldviewer/templates/build.html  |  45 ++++
 .../webhob/bldviewer/templates/configuration.html  |  20 ++
 bitbake/lib/webhob/bldviewer/templates/layer.html  |  34 +++
 .../lib/webhob/bldviewer/templates/package.html    |  36 +++
 bitbake/lib/webhob/bldviewer/templates/recipe.html |  54 +++++
 bitbake/lib/webhob/bldviewer/templates/task.html   |  63 +++++
 .../lib/webhob/bldviewer/templatetags/__init__.py  |   0
 .../webhob/bldviewer/templatetags/projecttags.py   |  26 +++
 bitbake/lib/webhob/bldviewer/urls.py               |  32 +++
 bitbake/lib/webhob/bldviewer/views.py              | 238 +++++++++++++++++++
 bitbake/lib/webhob/manage.py                       |  10 +
 bitbake/lib/webhob/orm/__init__.py                 |   0
 bitbake/lib/webhob/orm/models.py                   | 260 +++++++++++++++++++++
 bitbake/lib/webhob/orm/tests.py                    |  16 ++
 bitbake/lib/webhob/orm/views.py                    |   1 +
 bitbake/lib/webhob/whbgui/__init__.py              |   0
 bitbake/lib/webhob/whbgui/static/images/yocto.jpg  | Bin 0 -> 6582 bytes
 bitbake/lib/webhob/whbgui/templates/index.html     |  13 ++
 bitbake/lib/webhob/whbgui/tests.py                 |  34 +++
 bitbake/lib/webhob/whbgui/urls.py                  |  27 +++
 bitbake/lib/webhob/whbgui/views.py                 |  26 +++
 bitbake/lib/webhob/whbmain/__init__.py             |   0
 bitbake/lib/webhob/whbmain/settings.py             | 191 +++++++++++++++
 bitbake/lib/webhob/whbmain/urls.py                 |  40 ++++
 bitbake/lib/webhob/whbmain/wsgi.py                 |  32 +++
 34 files changed, 1541 insertions(+)
 create mode 100755 bitbake/bin/webhob
 create mode 100644 bitbake/lib/webhob/__init__.py
 create mode 100644 bitbake/lib/webhob/bldviewer/__init__.py
 create mode 100644 bitbake/lib/webhob/bldviewer/api.py
 create mode 100644 bitbake/lib/webhob/bldviewer/templates/base.html
 create mode 100644 bitbake/lib/webhob/bldviewer/templates/basebuildpage.html
 create mode 100644 bitbake/lib/webhob/bldviewer/templates/basetable.html
 create mode 100644 bitbake/lib/webhob/bldviewer/templates/bfile.html
 create mode 100644 bitbake/lib/webhob/bldviewer/templates/bpackage.html
 create mode 100644 bitbake/lib/webhob/bldviewer/templates/build.html
 create mode 100644 bitbake/lib/webhob/bldviewer/templates/configuration.html
 create mode 100644 bitbake/lib/webhob/bldviewer/templates/layer.html
 create mode 100644 bitbake/lib/webhob/bldviewer/templates/package.html
 create mode 100644 bitbake/lib/webhob/bldviewer/templates/recipe.html
 create mode 100644 bitbake/lib/webhob/bldviewer/templates/task.html
 create mode 100644 bitbake/lib/webhob/bldviewer/templatetags/__init__.py
 create mode 100644 bitbake/lib/webhob/bldviewer/templatetags/projecttags.py
 create mode 100644 bitbake/lib/webhob/bldviewer/urls.py
 create mode 100644 bitbake/lib/webhob/bldviewer/views.py
 create mode 100755 bitbake/lib/webhob/manage.py
 create mode 100644 bitbake/lib/webhob/orm/__init__.py
 create mode 100644 bitbake/lib/webhob/orm/models.py
 create mode 100644 bitbake/lib/webhob/orm/tests.py
 create mode 100644 bitbake/lib/webhob/orm/views.py
 create mode 100644 bitbake/lib/webhob/whbgui/__init__.py
 create mode 100644 bitbake/lib/webhob/whbgui/static/images/yocto.jpg
 create mode 100644 bitbake/lib/webhob/whbgui/templates/index.html
 create mode 100644 bitbake/lib/webhob/whbgui/tests.py
 create mode 100644 bitbake/lib/webhob/whbgui/urls.py
 create mode 100644 bitbake/lib/webhob/whbgui/views.py
 create mode 100644 bitbake/lib/webhob/whbmain/__init__.py
 create mode 100644 bitbake/lib/webhob/whbmain/settings.py
 create mode 100644 bitbake/lib/webhob/whbmain/urls.py
 create mode 100644 bitbake/lib/webhob/whbmain/wsgi.py

diff --git a/bitbake/bin/webhob b/bitbake/bin/webhob
new file mode 100755
index 0000000..7bc9759
--- /dev/null
+++ b/bitbake/bin/webhob
@@ -0,0 +1,145 @@
+#!/bin/bash
+# (c) 2013 Intel Corp.
+
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+
+
+# This script enables webhob event logging and
+# starts bitbake resident server
+# use as:  source webhob [start|stop]
+
+# Helper function to kill a background webhob development server
+
+function webserverKillAll()
+{
+	local pidfile
+	for pidfile in ${BUILDDIR}/whbmain.pid; do
+		if [ -f ${pidfile} ]; then
+		while kill -0 $(< ${pidfile}) 2>/dev/null; do
+			kill -SIGTERM -$(< ${pidfile}) 2>/dev/null
+			sleep 1;
+		done;
+		rm  ${pidfile}
+		fi
+	done
+}
+
+
+function webserverStartAll()
+{
+        retval=0
+        python $BBBASEDIR/lib/webhob/manage.py syncdb || retval=1
+        if [ $retval -eq 1 ]; then
+                echo "Failed db sync, stopping system start" 1>&2
+        else
+            python $BBBASEDIR/lib/webhob/manage.py runserver </dev/null >${BUILDDIR}/whbmain.log 2>&1 & echo $! >${BUILDDIR}/whbmain.pid
+        fi
+        return $retval
+}
+
+
+# We make sure we're running in the current shell and in a good environment
+
+if [ -z "$ZSH_NAME" ] && [ `basename "$0"` = `basename $BASH_SOURCE` ]; then
+    echo "Error: This script needs to be sourced. Please run as 'source webhob [start|stop]'" 1>&2;
+    exit 1
+fi
+
+if [ -z "$BUILDDIR" ] || [ -z `which bitbake` ]; then
+    echo "Error: Build environment is not setup or bitbake is not in path." 1>&2;
+    return 2
+fi
+
+BBBASEDIR=`dirname ${BASH_SOURCE}`/..
+
+
+# Verify prerequisites
+
+if ! echo "import django; print (1,4,5) == django.VERSION[0:3]" | python 2>/dev/null | grep True >/dev/null; then
+    echo -e "This program needs Django 1.4.5. Please install with\n\nsudo pip install django==1.4.5"
+    return 2
+fi
+
+
+
+# Determine the action. If specified by arguments, fine, if not, toggle it
+if [ "x$1" == "xstart" ] || [ "x$1" == "xstop" ]; then
+    CMD="$1"
+else
+    if [ -z "$BBSERVER" ]; then
+        CMD="start"
+    else
+        CMD="stop"
+    fi;
+fi
+
+NODSI=0
+if [ "x$2" == "xnodsi" ]; then
+    NODSI=1
+fi
+
+echo "The system will $CMD."
+
+# Make sure it's safe to run by checking bitbake lock
+
+lock=1
+if [ -e $BUILDDIR/bitbake.lock ]; then
+    (flock -n 200 ) 200<$BUILDDIR/bitbake.lock || lock=0
+fi
+
+if [ ${CMD} == "start" ] && ( [ $lock -eq 0 ] || [ -e $BUILDDIR/whbmain.pid ] ); then
+    echo "Error: bitbake lock state error. System is already on." 2>&1
+    return 3
+elif [ ${CMD} == "stop" ] && ( [ $lock -eq 1 ] || ! [ -e $BUILDDIR/whbmain.pid ] ) ; then
+    echo "Error: bitbake lock state error. Trying to stop a stopped system ?
+If you think the system is hanged up, you can try to manually stop system with the commands
+
+# BBSERVER=localhost:8200 bitbake -m
+
+and
+
+# webserverKillAll
+" 2>&1
+    return 3
+fi
+
+
+# Execute the commands
+
+case $CMD in
+    start )
+        webserverStartAll || return 4
+        unset BBSERVER
+        bitbake --server-only -t xmlrpc -B localhost:8200
+        export BBSERVER=localhost:8200
+        if [ $NODSI == 0 ]; then        # we start the DSI only if not inhibited
+            bitbake --observe-only -u dsi >/dev/null 2>&1 & echo $! >${BUILDDIR}/dsi.pid
+        fi
+    ;;
+    stop )
+        if [ -f ${BUILDDIR}/dsi.pid ]; then
+            kill $(< ${BUILDDIR}/dsi.pid )
+            rm ${BUILDDIR}/dsi.pid
+        fi
+        bitbake -m
+        unset BBSERVER
+        webserverKillAll
+        # force stop any misbehaving bitbake server
+        lsof bitbake.lock | awk '{print $2}' | grep "[0-9]\+" | xargs -n1 -r kill
+    ;;
+esac
+
+echo "Successful ${CMD}."
+
diff --git a/bitbake/lib/webhob/__init__.py b/bitbake/lib/webhob/__init__.py
new file mode 100644
index 0000000..e69de29
diff --git a/bitbake/lib/webhob/bldviewer/__init__.py b/bitbake/lib/webhob/bldviewer/__init__.py
new file mode 100644
index 0000000..e69de29
diff --git a/bitbake/lib/webhob/bldviewer/api.py b/bitbake/lib/webhob/bldviewer/api.py
new file mode 100644
index 0000000..175749d
--- /dev/null
+++ b/bitbake/lib/webhob/bldviewer/api.py
@@ -0,0 +1,37 @@
+#
+# BitBake Webhob Implementation
+#
+# Copyright (C) 2013        Intel Corporation
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+from django.conf.urls import patterns, include, url
+
+
+urlpatterns = patterns('bldviewer.views',
+        url(r'^builds$', 'model_explorer',  {'model_name':'build'}, name='builds'),
+        url(r'^targets$', 'model_explorer',  {'model_name':'target'}, name='targets'),
+        url(r'^tasks$', 'model_explorer', {'model_name':'task'}, name='task'),
+        url(r'^task_dependencies$', 'model_explorer',  {'model_name':'task_dependency'}, name='task_dependencies'),
+        url(r'^packages$', 'model_explorer',  {'model_name':'build_package'}, name='build_packages'),
+        url(r'^package_dependencies$', 'model_explorer',  {'model_name':'build_package_dependency'}, name='build_package_dependencies'),
+        url(r'^target_packages$', 'model_explorer',  {'model_name':'target_package'}, name='target_packages'),
+        url(r'^package_files$', 'model_explorer',  {'model_name':'build_file'}, name='build_files'),
+        url(r'^layers$', 'model_explorer', {'model_name':'layer'}, name='layer'),
+        url(r'^layerversions$', 'model_explorer', {'model_name':'layerversion'}, name='layerversion'),
+        url(r'^recipes$', 'model_explorer', {'model_name':'recipe'}, name='recipe'),
+        url(r'^recipe_dependencies$', 'model_explorer',  {'model_name':'recipe_dependency'}, name='recipe_dependencies'),
+        url(r'^variables$', 'model_explorer',  {'model_name':'variable'}, name='variables'),
+        url(r'^logmessages$', 'model_explorer',  {'model_name':'logmessage'}, name='logmessages'),
+)
diff --git a/bitbake/lib/webhob/bldviewer/templates/base.html b/bitbake/lib/webhob/bldviewer/templates/base.html
new file mode 100644
index 0000000..1a2278a
--- /dev/null
+++ b/bitbake/lib/webhob/bldviewer/templates/base.html
@@ -0,0 +1,30 @@
+<!DOCTYPE html>
+
+<html>
+	<head>
+		<title>Toaster Simple Explorer</title>
+<script src="/static/js/jquery-2.0.3.js">
+</script>
+<script src="/static/js/bootstrap.js">
+</script>
+<link href="/static/css/bootstrap.css" rel="stylesheet" type="text/css">
+	</head>
+
+<body style="height: 100%">
+<div style="width:100%; height: 100%; position:absolute">
+<div style="width: 100%; height: 3em" class="nav">
+    <ul class="nav nav-tabs">
+        <li><a href="/simple/builds/">All Builds</a></li>
+        <li><a href="/simple/layers/">All Layers</a></li>
+    </ul>
+</div>
+
+<div style="overflow-y:scroll; width: 100%; position: absolute; top: 3em; bottom:70px ">
+{% block pagecontent %}
+{% endblock %}
+</div>
+<div class="navbar" style="position: absolute; bottom: 0; width:100%"><br/>About Toaster | Yocto Project </div>
+</div>
+</body>
+</html>
+
diff --git a/bitbake/lib/webhob/bldviewer/templates/basebuildpage.html b/bitbake/lib/webhob/bldviewer/templates/basebuildpage.html
new file mode 100644
index 0000000..478019b
--- /dev/null
+++ b/bitbake/lib/webhob/bldviewer/templates/basebuildpage.html
@@ -0,0 +1,17 @@
+{% extends "basetable.html" %}
+
+{% block pagename %}
+<ul class="nav nav-tabs" style="display: inline-block">
+  <li><a>Build {{build.target_set.all|join:"&nbsp;"}} at {{build.started_on}} : </a></li>
+  <li><a href="/simple/build/{{build.id}}/task/"> Tasks </a></li>
+  <li><a href="/simple/build/{{build.id}}/packages/"> Build Packages </a></li>
+    {% for t in build.target_set.all %}
+        {% if t.is_image %}
+  <li><a href="/simple/build/{{build.id}}/target/{{t.pk}}/packages/"> Packages for {{t.target}} </a> </li>
+        {% endif %}
+    {% endfor %}
+  <li><a href="/simple/build/{{build.id}}/configuration/"> Configuration </a> </li>
+</ul>
+     <h1>Toaster - Build {% block pagetitle %} {% endblock %}</h1>
+{% endblock %}
+
diff --git a/bitbake/lib/webhob/bldviewer/templates/basetable.html b/bitbake/lib/webhob/bldviewer/templates/basetable.html
new file mode 100644
index 0000000..083bcb8
--- /dev/null
+++ b/bitbake/lib/webhob/bldviewer/templates/basetable.html
@@ -0,0 +1,46 @@
+{% extends "base.html" %}
+
+{% block pagecontent %}
+<script>
+function showhideTableColumn(i, sh) {
+    if (sh)
+        $('td:nth-child('+i+'),th:nth-child('+i+')').show();
+    else
+        $('td:nth-child('+i+'),th:nth-child('+i+')').hide();
+}
+
+
+function filterTableRows(test) {
+    if (test.length > 0) {
+        var r = test.split(/[ ,]+/).map(function (e) { return new RegExp(e, 'i') });
+        $('tr.data').map( function (i, el) {
+            (! r.map(function (j) { return j.test($(el).html())}).reduce(function (c, p) { return c && p;} )) ? $(el).hide() : $(el).show();
+        });
+    } else
+    {
+        $('tr.data').show();
+    }
+}
+</script>
+<div style="margin-bottom: 0.5em">
+
+    {% block pagename %}
+    {% endblock %}
+    <div align="left" style="display:inline-block; width: 40%; margin-left: 2em"> Search: <input type="search" id="filterstring" style="width: 80%" onkeyup="filterTableRows($('#filterstring').val())" autocomplete="off">
+    </div>
+    {% if hideshowcols %}
+    <div align="right" style="display: inline-block; width: 40%">Show/Hide columns:
+    {% for i in hideshowcols %}
+        <span>{{i.name}} <input type="checkbox" id="ct{{i.name}}" onchange="showhideTableColumn({{i.order}}, $('#ct{{i.name}}').is(':checked'))" checked autocomplete="off"></span> |
+    {% endfor %}
+    </div>
+    {% endif %}
+</div>
+<div>
+    <table class="table table-striped table-condensed" style="width:95%">
+{% block pagetable %}
+{% endblock %}
+    </table>
+</div>
+
+{% endblock %}
diff --git a/bitbake/lib/webhob/bldviewer/templates/bfile.html b/bitbake/lib/webhob/bldviewer/templates/bfile.html
new file mode 100644
index 0000000..d4943c0
--- /dev/null
+++ b/bitbake/lib/webhob/bldviewer/templates/bfile.html
@@ -0,0 +1,24 @@
+{% extends "basebuildpage.html" %}
+
+{% block pagetitle %}Files for package {{files.0.bpackage.name}} {% endblock %}
+{% block pagetable %}
+    {% if not files %}
+        <p>No files were recorded for this package!</p>
+    {% else %}
+
+            <tr>
+            <th>Name</th>
+            <th>Size</th>
+            </tr>
+
+            {% for file in files %}
+
+            <tr class="data">
+            <td>{{file.path}}</td>
+            <td>{{file.size}}</td>
+
+            {% endfor %}
+
+    {% endif %}
+
+{% endblock %}
diff --git a/bitbake/lib/webhob/bldviewer/templates/bpackage.html b/bitbake/lib/webhob/bldviewer/templates/bpackage.html
new file mode 100644
index 0000000..39190d8
--- /dev/null
+++ b/bitbake/lib/webhob/bldviewer/templates/bpackage.html
@@ -0,0 +1,44 @@
+{% extends "basebuildpage.html" %}
+
+{% block pagetitle %}Packages{% endblock %}
+{% block pagetable %}
+    {% if not packages %}
+        <p>No packages were recorded for this target!</p>
+    {% else %}
+
+            <tr>
+            <th>Name</th>
+            <th>Version</th>
+            <th>Recipe</th>
+            <th>Summary</th>
+            <th>Section</th>
+            <th>Description</th>
+            <th>Size</th>
+            <th>License</th>
+            <th>Dependencies List (all)</th>
+            </tr>
+
+            {% for package in packages %}
+
+            <tr class="data">
+                <td><a name="#{{package.name}}" href="/simple/build/{{build.pk}}/package/{{package.pk}}/files/">{{package.name}} ({{package.filelist_bpackage.count}} files)</a></td>
+                <td>{{package.version}}-{{package.revision}}</td>
+                <td><a href="/simple/layerversions/{{package.recipe.layer_version_id}}/recipes/#{{package.recipe.name}}">{{package.recipe.name}}</a>{{package.package_name}}</a></td>
+
+            <td>{{package.summary}}</td>
+            <td>{{package.section}}</td>
+            <td>{{package.description}}</td>
+            <td>{{package.size}}</td>
+            <td>{{package.license}}</td>
+            <td>
+        <div style="height: 3em; overflow:auto">
+            {% for bpd in package.bpackage_dependencies_package.all %}
+                {{bpd.dep_type}}: {{bpd.depends_on}} <br/>
+            {% endfor %}
+        </div>
+            </td>
+            {% endfor %}
+
+    {% endif %}
+
+{% endblock %}
diff --git a/bitbake/lib/webhob/bldviewer/templates/build.html b/bitbake/lib/webhob/bldviewer/templates/build.html
new file mode 100644
index 0000000..bd7e0f3
--- /dev/null
+++ b/bitbake/lib/webhob/bldviewer/templates/build.html
@@ -0,0 +1,45 @@
+{% extends "basetable.html" %}
+
+{% block pagename %}
+    <h1>Toaster - Builds</h1>
+{% endblock %}
+
+{% block pagetable %}
+
+    {% load projecttags %}
+        <tr>
+            <th>Outcome</th>
+            <th>Started On</th>
+            <th>Completed On</th>
+            <th>Target</th>
+            <th>Image ?</th>
+            <th>Machine</th>
+            <th>Time</th>
+            <th>Errors</th>
+            <th>Warnings</th>
+            <th>Output</th>
+            <th>Log</th>
+            <th>Bitbake Version</th>
+            <th>Build Name</th>
+        </tr>
+        {% for build in builds %}
+        <tr class="data">
+            <td><a href="/simple/build/{{build.id}}/configuration/">{{build.get_outcome_display}}</a></td>
+            <td>{{build.started_on}}</td>
+            <td>{{build.completed_on}}</td>
+            <td>{% for t in build.target_set.all %}<a href="/simple/build/{{build.id}}/target/{{t.id}}/packages/">{{t.target}}</a><br/>{% endfor %}</td>
+            <td>{% if build.is_image %} <a href="/simple/build/{{build.id}}/package/">{{build.is_image}}</a>{% else %} {{build.is_image}} {% endif %}</td>
+            <td>{{build.machine}}</td>
+            <td>{% time_difference build.started_on build.completed_on %}</td>
+            <td>{{build.errors_no}}:{% if  build.errors_no %}{% for error in logs %}{% if error.build == build %}{% if error.level == 2 %}<p>{{error.message}}</p>{% endif %}{% endif %}{% endfor %}{% else %}None{% endif %}</td>
+            <td>{{build.warnings_no}}:{% if  build.warnings_no %}{% for warning in logs %}{% if warning.build == build %}{% if warning.level == 1 %}<p>{{warning.message}}</p>{% endif %}{% endif %}{% endfor %}{% else %}None{% endif %}</td>
+            <td>{{build.image_fstypes}}</td>
+            <td>{{build.cooker_log_path}}</td>
+            <td>{{build.bitbake_version}}</td>
+            <td>{{build.build_name}}</td>
+        </tr>
+
+        {% endfor %}
+{% endblock %}
+
+
diff --git a/bitbake/lib/webhob/bldviewer/templates/configuration.html b/bitbake/lib/webhob/bldviewer/templates/configuration.html
new file mode 100644
index 0000000..052c37c
--- /dev/null
+++ b/bitbake/lib/webhob/bldviewer/templates/configuration.html
@@ -0,0 +1,20 @@
+{% extends "basebuildpage.html" %}
+
+{% block pagetitle %}Configuration{% endblock %}
+{% block pagetable %}
+
+            <tr>
+            <th>Name</th>
+            <th>Value</th>
+            <th>Description</th>
+            </tr>
+
+            {% for variable in configuration %}
+
+            <tr class="data">
+                <td>{{variable.variable_name}}</td>
+                <td>{{variable.variable_value}}</td>
+                <td>{% if variable.description %}{{variable.description}}{% endif %}</td>
+            {% endfor %}
+
+{% endblock %}
diff --git a/bitbake/lib/webhob/bldviewer/templates/layer.html b/bitbake/lib/webhob/bldviewer/templates/layer.html
new file mode 100644
index 0000000..374a0f9
--- /dev/null
+++ b/bitbake/lib/webhob/bldviewer/templates/layer.html
@@ -0,0 +1,34 @@
+{% extends "basetable.html" %}
+
+{% block pagename %}
+    <h1>Toaster - Layers</h1>
+{% endblock %}
+
+{% block pagetable %}
+    {% load projecttags %}
+
+        <tr>
+            <th>Name</th>
+            <th>Local Path</th>
+            <th>Layer Index URL</th>
+            <th>Known Versions</th>
+        </tr>
+
+        {% for layer in layers %}
+
+        <tr class="data">
+            <td>{{layer.name}}</td>
+            <td>{{layer.local_path}}</td>
+            <td><a href='{{layer.layer_index_url}}'>{{layer.layer_index_url}}</a></td>
+            <td><table>
+            {% for lv in layer.versions %}
+                <tr><td>
+        <a href="/simple/layerversions/{{lv.id}}/recipes">({{lv.priority}}){{lv.branch}}:{{lv.commit}} ({{lv.count}} recipes)</a>
+                </td></tr>
+            {% endfor %}
+            </table></td>
+        </tr>
+
+        {% endfor %}
+
+{% endblock %}
diff --git a/bitbake/lib/webhob/bldviewer/templates/package.html b/bitbake/lib/webhob/bldviewer/templates/package.html
new file mode 100644
index 0000000..4ce25ae
--- /dev/null
+++ b/bitbake/lib/webhob/bldviewer/templates/package.html
@@ -0,0 +1,36 @@
+{% extends "basebuildpage.html" %}
+
+{% block pagetable %}
+    {% if not packages %}
+        <p>No packages were recorded for this target!</p>
+    {% else %}
+
+            <tr>
+            <th>Name</th>
+            <th>Version</th>
+            <th>Size (in KiB)</th>
+            <th>Recipe</th>
+            <th>Depends on</th>
+            </tr>
+
+            {% for package in packages %}
+
+            <tr class="data">
+                <td><a name="#{{package.name}}">{{package.name}}</a></td>
+                <td>{{package.version}}</td>
+                <td>{{package.size}}</td>
+                <td><a name="{{package.recipe.name}}.{{package.package_name}}">
+                <a href="/simple/layerversions/{{package.recipe.layer_version_id}}/recipes/#{{package.recipe.name}}">{{package.recipe.name}}</a>{{package.package_name}}</a></td>
+                <td>
+            <div style="height: 3em; overflow:auto">
+                    {% for d in package.depends_on %}
+                    <a href="#{{d.name}}">{{d.name}}</a><br/>
+                    {% endfor %}
+            </div>
+                </td>
+
+            {% endfor %}
+
+    {% endif %}
+
+{% endblock %}
diff --git a/bitbake/lib/webhob/bldviewer/templates/recipe.html b/bitbake/lib/webhob/bldviewer/templates/recipe.html
new file mode 100644
index 0000000..a624370
--- /dev/null
+++ b/bitbake/lib/webhob/bldviewer/templates/recipe.html
@@ -0,0 +1,54 @@
+{% extends "basetable.html" %}
+
+{% block pagename %}
+<ul class="nav nav-tabs" style="display: inline-block">
+  <li><a>Layer  {{layer_version.layer.name}}&nbsp;:&nbsp;{{layer_version.branch}}&nbsp;:&nbsp;{{layer_version.commit}}&nbsp;:&nbsp;{{layer_version.priority}}</a></li>
+</ul>
+    <h1>Toaster - Recipes for a Layer</h1>
+{% endblock %}
+
+{% block pagetable %}
+    {% load projecttags %}
+
+        <tr>
+        </tr>
+            <th>Name</th>
+            <th>Version</th>
+            <th>Summary</th>
+            <th>Description</th>
+            <th>Section</th>
+            <th>License</th>
+            <th>License file</th>
+            <th>Homepage</th>
+            <th>Bugtracker</th>
+            <th>Author</th>
+            <th>File_path</th>
+            <th style="width: 30em">Recipe Dependency</th>
+
+
+        {% for recipe in recipes %}
+
+        <tr class="data">
+            <td><a name="{{recipe.name}}">{{recipe.name}}</a></td>
+            <td>{{recipe.version}}</td>
+            <td>{{recipe.summary}}</td>
+            <td>{{recipe.description}}</td>
+            <td>{{recipe.section}}</td>
+            <td>{{recipe.license}}</td>
+            <td>{{recipe.licensing_info}}</td>
+            <td>{{recipe.homepage}}</td>
+            <td>{{recipe.bugtracker}}</td>
+            <td>{{recipe.author}}</td>
+            <td>{{recipe.file_path}}</td>
+            <td>
+        <div style="height: 5em; overflow:auto">
+            {% for rr in recipe.r_dependencies_recipe.all %}
+                <a href="#{{rr.depends_on.name}}">{{rr.depends_on.name}}</a><br/>
+            {% endfor %}
+        </div>
+            </td>
+        </tr>
+
+        {% endfor %}
+
+{% endblock %}
diff --git a/bitbake/lib/webhob/bldviewer/templates/task.html b/bitbake/lib/webhob/bldviewer/templates/task.html
new file mode 100644
index 0000000..25715fe
--- /dev/null
+++ b/bitbake/lib/webhob/bldviewer/templates/task.html
@@ -0,0 +1,63 @@
+{% extends "basebuildpage.html" %}
+
+{% block pagetitle %}Tasks{% endblock %}
+{% block pagetable %}
+    {% if not tasks %}
+        <p>No tasks were executed in this build!</p>
+    {% else %}
+
+            <tr>
+            <th>Order</th>
+            <th>Task</th>
+            <th>Recipe Version</th>
+            <th>Task Type</th>
+            <th>Checksum</th>
+            <th>Outcome</th>
+            <th>Message</th>
+            <th>Logfile</th>
+            <th>Time</th>
+            <th>CPU usage</th>
+            <th>Disk I/O</th>
+            <th>Script type</th>
+            <th>File path</th>
+            <th>Depends</th>
+            </tr>
+
+            {% for task in tasks %}
+
+            <tr class="data">
+                <td>{{task.order}}</td>
+                <td><a name="{{task.recipe.name}}.{{task.task_name}}">
+                <a href="/simple/layerversions/{{task.recipe.layer_version_id}}/recipes/#{{task.recipe.name}}">{{task.recipe.name}}</a>.{{task.task_name}}</a></td>
+                <td>{{task.recipe.version}}</td>
+
+                {% if task.task_executed %}
+                <td>Executed</td>
+                {% else %}
+                <td>Prebuilt</td>
+                {% endif %}
+
+                <td>{{task.sstate_checksum}}</td>
+                <td>{{task.get_outcome_display}}</td>
+                <td><p>{{task.message}}</td>
+                <td><a target="_fileview" href="file:///{{task.logfile}}">{{task.logfile}}</a></td>
+                <td>{{task.elapsed_time}}</td>
+                <td>{{task.cpu_usage}}</td>
+                <td>{{task.disk_io}}</td>
+                <td>{{task.get_script_type_display}}</td>
+                <td><a target="_fileview" href="file:///{{task.recipe.file_path}}">{{task.recipe.file_path}}</a></td>
+                <td>
+            <div style="height: 3em; overflow:auto">
+                {% for tt in task.task_dependencies_task.all %}
+                    <a href="#{{tt.depends_on.recipe.name}}.{{tt.depends_on.task_name}}">
+                    {{tt.depends_on.recipe.name}}.{{tt.depends_on.task_name}}</a><br/>
+                {% endfor %}
+            </div>
+                </td>
+                </tr>
+
+            {% endfor %}
+
+    {% endif %}
+
+{% endblock %}
diff --git a/bitbake/lib/webhob/bldviewer/templatetags/__init__.py b/bitbake/lib/webhob/bldviewer/templatetags/__init__.py
new file mode 100644
index 0000000..e69de29
diff --git a/bitbake/lib/webhob/bldviewer/templatetags/projecttags.py b/bitbake/lib/webhob/bldviewer/templatetags/projecttags.py
new file mode 100644
index 0000000..5ea5407
--- /dev/null
+++ b/bitbake/lib/webhob/bldviewer/templatetags/projecttags.py
@@ -0,0 +1,26 @@
+#
+# BitBake Webhob Implementation
+#
+# Copyright (C) 2013        Intel Corporation
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+from datetime import datetime
+from django import template
+
+register = template.Library()
+
+@register.simple_tag
+def time_difference(start_time, end_time):
+    return end_time - start_time
diff --git a/bitbake/lib/webhob/bldviewer/urls.py b/bitbake/lib/webhob/bldviewer/urls.py
new file mode 100644
index 0000000..f63cdbc
--- /dev/null
+++ b/bitbake/lib/webhob/bldviewer/urls.py
@@ -0,0 +1,32 @@
+#
+# BitBake Webhob Implementation
+#
+# Copyright (C) 2013        Intel Corporation
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+from django.conf.urls import patterns, include, url
+from django.views.generic.simple import redirect_to
+
+urlpatterns = patterns('bldviewer.views',
+        url(r'^builds/$', 'build', name='build'),
+        url(r'^build/(?P<build_id>\d+)/task/$', 'task', name='task'),
+        url(r'^build/(?P<build_id>\d+)/packages/$', 'bpackage', name='bpackage'),
+        url(r'^build/(?P<build_id>\d+)/package/(?P<package_id>\d+)/files/$', 'bfile', name='bfile'),
+        url(r'^build/(?P<build_id>\d+)/target/(?P<target_id>\d+)/packages/$', 'tpackage', name='tpackage'),
+        url(r'^build/(?P<build_id>\d+)/configuration/$', 'configuration', name='configuration'),
+        url(r'^layers/$', 'layer', name='layer'),
+        url(r'^layerversions/(?P<layerversion_id>\d+)/recipes/.*$', 'layer_versions_recipes', name='layer_versions_recipes'),
+        url(r'^$', redirect_to, {'url': 'builds/'}),
+)
diff --git a/bitbake/lib/webhob/bldviewer/views.py b/bitbake/lib/webhob/bldviewer/views.py
new file mode 100644
index 0000000..c678b52
--- /dev/null
+++ b/bitbake/lib/webhob/bldviewer/views.py
@@ -0,0 +1,238 @@
+#
+# BitBake Webhob Implementation
+#
+# Copyright (C) 2013        Intel Corporation
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+import operator
+
+from django.db.models import Q
+from django.shortcuts import render
+from orm.models import Build, Target, Task, Layer, Layer_Version, Recipe, Target_Package, LogMessage, Variable
+from orm.models import Task_Dependency, Recipe_Dependency, Build_Package, Build_File, Build_Package_Dependency
+from django.views.decorators.cache import cache_control
+
+@cache_control(no_store=True)
+def build(request):
+    template = 'build.html'
+    build_info = Build.objects.all()
+
+    logs = LogMessage.objects.all()
+
+    context = {'builds': build_info, 'logs': logs ,
+        'hideshowcols' : [
+                {'name': 'Output', 'order':10},
+                {'name': 'Log', 'order':11},
+            ]}
+
+    return render(request, template, context)
+
+def task(request, build_id):
+    template = 'task.html'
+
+    tasks = Task.objects.filter(build=build_id)
+
+    context = {'build': Build.objects.filter(pk=build_id)[0], 'tasks': tasks}
+
+    return render(request, template, context)
+
+def configuration(request, build_id):
+    template = 'configuration.html'
+    variables = Variable.objects.filter(build=build_id)
+    context = {'build': Build.objects.filter(pk=build_id)[0], 'configuration' : variables}
+    return render(request, template, context)
+
+def bpackage(request, build_id):
+    template = 'bpackage.html'
+    packages = Build_Package.objects.filter(build = build_id)
+    context = {'build': Build.objects.filter(pk=build_id)[0], 'packages' : packages}
+    return render(request, template, context)
+
+def bfile(request, build_id, package_id):
+    template = 'bfile.html'
+    files = Build_File.objects.filter(bpackage = package_id)
+    context = {'build': Build.objects.filter(pk=build_id)[0], 'files' : files}
+    return render(request, template, context)
+
+def tpackage(request, build_id, target_id):
+    template = 'package.html'
+
+    packages = Target_Package.objects.filter(target=target_id)
+
+    context = {'build' : Build.objects.filter(pk=build_id)[0],'packages': packages}
+
+    return render(request, template, context)
+
+def layer(request):
+    template = 'layer.html'
+    layer_info = Layer.objects.all()
+
+    for li in layer_info:
+        li.versions = Layer_Version.objects.filter(layer = li)
+        for liv in li.versions:
+            liv.count = Recipe.objects.filter(layer_version__id = liv.id).count()
+
+    context = {'layers': layer_info}
+
+    return render(request, template, context)
+
+
+def layer_versions_recipes(request, layerversion_id):
+    template = 'recipe.html'
+    recipes = Recipe.objects.filter(layer_version__id = layerversion_id)
+
+    context = {'recipes': recipes,
+            'layer_version' : Layer_Version.objects.filter( id = layerversion_id )[0]
+    }
+
+    return render(request, template, context)
+
+#### API
+
+import json
+from django.core import serializers
+from django.http import HttpResponse, HttpResponseBadRequest
+
+
+def model_explorer(request, model_name):
+
+    DESCENDING = 'desc'
+    response_data = {}
+    model_mapping = {
+        'build': Build,
+        'target': Target,
+        'target_package': Target_Package,
+        'task': Task,
+        'task_dependency': Task_Dependency,
+        'package': Build_Package,
+        'layer': Layer,
+        'layerversion': Layer_Version,
+        'recipe': Recipe,
+        'recipe_dependency': Recipe_Dependency,
+        'build_package': Build_Package,
+        'build_package_dependency': Build_Package_Dependency,
+        'build_file': Build_File,
+        'variable': Variable,
+        'logmessage': LogMessage,
+        }
+
+    if model_name not in model_mapping.keys():
+        return HttpResponseBadRequest()
+
+    model = model_mapping[model_name]
+
+    try:
+        limit = int(request.GET.get('limit', 0))
+    except ValueError:
+        limit = 0
+
+    try:
+        offset = int(request.GET.get('offset', 0))
+    except ValueError:
+        offset = 0
+
+    ordering_string, invalid = _validate_input(request.GET.get('orderby', ''),
+                                               model)
+    if invalid:
+        return HttpResponseBadRequest()
+
+    filter_string, invalid = _validate_input(request.GET.get('filter', ''),
+                                             model)
+    if invalid:
+        return HttpResponseBadRequest()
+
+    search_term = request.GET.get('search', '')
+
+    if filter_string:
+        filter_terms = _get_filtering_terms(filter_string)
+        try:
+            queryset = model.objects.filter(**filter_terms)
+        except ValueError:
+            queryset = []
+    else:
+        queryset = model.objects.all()
+
+    if search_term:
+        queryset = _get_search_results(search_term, queryset, model)
+
+    if ordering_string and queryset:
+        column, order = ordering_string.split(':')
+        if order.lower() == DESCENDING:
+            queryset = queryset.order_by('-' + column)
+        else:
+            queryset = queryset.order_by(column)
+
+    if offset and limit:
+        queryset = queryset[offset:(offset+limit)]
+    elif offset:
+        queryset = queryset[offset:]
+    elif limit:
+        queryset = queryset[:limit]
+
+    if queryset:
+        response_data['count'] = queryset.count()
+    else:
+        response_data['count'] = 0
+
+    response_data['list'] = serializers.serialize('json', queryset)
+
+    return HttpResponse(json.dumps(response_data),
+                        content_type='application/json')
+
+def _get_filtering_terms(filter_string):
+
+    search_terms = filter_string.split(":")
+    keys = search_terms[0].split(',')
+    values = search_terms[1].split(',')
+
+    return dict(zip(keys, values))
+
+def _validate_input(input, model):
+
+    invalid = 0
+
+    if input:
+        input_list = input.split(":")
+
+        # Check we have only one colon
+        if len(input_list) != 2:
+            invalid = 1
+            return None, invalid
+
+        # Check we have an equal number of terms both sides of the colon
+        if len(input_list[0].split(',')) != len(input_list[1].split(',')):
+            invalid = 1
+            return None, invalid
+
+        # Check we are looking for a valid field
+        valid_fields = model._meta.get_all_field_names()
+        for field in input_list[0].split(','):
+            if field not in valid_fields:
+                invalid = 1
+                return None, invalid
+
+    return input, invalid
+
+def _get_search_results(search_term, queryset, model):
+    search_objects = []
+    for st in search_term.split(" "):
+        q_map = map(lambda x: Q(**{x+'__icontains': st}),
+                model.search_allowed_fields)
+
+        search_objects.append(reduce(operator.or_, q_map))
+    search_object = reduce(operator.and_, search_objects)
+    queryset = queryset.filter(search_object)
+
+    return queryset
diff --git a/bitbake/lib/webhob/manage.py b/bitbake/lib/webhob/manage.py
new file mode 100755
index 0000000..1b2c1a7
--- /dev/null
+++ b/bitbake/lib/webhob/manage.py
@@ -0,0 +1,10 @@
+#!/usr/bin/env python
+import os
+import sys
+
+if __name__ == "__main__":
+    os.environ.setdefault("DJANGO_SETTINGS_MODULE", "whbmain.settings")
+
+    from django.core.management import execute_from_command_line
+
+    execute_from_command_line(sys.argv)
diff --git a/bitbake/lib/webhob/orm/__init__.py b/bitbake/lib/webhob/orm/__init__.py
new file mode 100644
index 0000000..e69de29
diff --git a/bitbake/lib/webhob/orm/models.py b/bitbake/lib/webhob/orm/models.py
new file mode 100644
index 0000000..2ce226c
--- /dev/null
+++ b/bitbake/lib/webhob/orm/models.py
@@ -0,0 +1,260 @@
+#
+# BitBake Webhob Implementation
+#
+# Copyright (C) 2013        Intel Corporation
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+from django.db import models
+from django.utils.encoding import python_2_unicode_compatible
+
+
+class Build(models.Model):
+    SUCCEEDED = 0
+    FAILED = 1
+    IN_PROGRESS = 2
+
+    BUILD_OUTCOME = (
+        (SUCCEEDED, 'Succeeded'),
+        (FAILED, 'Failed'),
+        (IN_PROGRESS, 'In Progress'),
+    )
+
+    search_allowed_fields = ['machine',
+                             'cooker_log_path']
+
+    machine = models.CharField(max_length=100)
+    distro = models.CharField(max_length=100)
+    distro_version = models.CharField(max_length=100)
+    started_on = models.DateTimeField()
+    completed_on = models.DateTimeField()
+    outcome = models.IntegerField(choices=BUILD_OUTCOME, default=IN_PROGRESS)
+    errors_no = models.IntegerField(default=0)
+    warnings_no = models.IntegerField(default=0)
+    cooker_log_path = models.CharField(max_length=500)
+    build_name = models.CharField(max_length=100)
+    bitbake_version = models.CharField(max_length=50)
+
+@python_2_unicode_compatible
+class Target(models.Model):
+    search_allowed_fields = ['target', 'image_fstypes', 'file_name']
+    build = models.ForeignKey(Build)
+    target = models.CharField(max_length=100)
+    is_image = models.BooleanField(default = False)
+    image_fstypes = models.CharField(max_length=100)
+    file_name = models.CharField(max_length=100)
+    file_size = models.IntegerField()
+
+    def __str__(self):
+        return self.target
+
+
+class Task(models.Model):
+
+    SSTATE_NA = 0
+    SSTATE_MISS = 1
+    SSTATE_FAILED = 2
+    SSTATE_RESTORED = 3
+
+    SSTATE_RESULT = (
+        (SSTATE_NA, 'Not Applicable'), # For rest of tasks, but they still need checking.
+        (SSTATE_MISS, 'Missing'), # it is a miss
+        (SSTATE_FAILED, 'Failed'), # there was a pkg, but the script failed
+        (SSTATE_RESTORED, 'Restored'), # succesfully restored
+    )
+
+    CODING_PYTHON = 0
+    CODING_SHELL = 1
+
+    TASK_CODING = (
+        (CODING_PYTHON, 'Python'),
+        (CODING_SHELL, 'Shell'),
+    )
+
+    OUTCOME_SUCCESS = 0
+    OUTCOME_COVERED = 1
+    OUTCOME_SSTATE = 2
+    OUTCOME_EXISTING = 3
+    OUTCOME_FAILED = 4
+    OUTCOME_NA = 5
+
+    TASK_OUTCOME = (
+        (OUTCOME_SUCCESS, 'Succeeded'),
+        (OUTCOME_COVERED, 'Covered'),
+        (OUTCOME_SSTATE, 'Sstate'),
+        (OUTCOME_EXISTING, 'Existing'),
+        (OUTCOME_FAILED, 'Failed'),
+        (OUTCOME_NA, 'Not Available'),
+    )
+
+    build = models.ForeignKey(Build, related_name='task_build')
+    order = models.IntegerField(null=True)
+    task_executed = models.BooleanField(default=False) # True means Executed, False means Prebuilt
+    outcome = models.IntegerField(choices=TASK_OUTCOME, default=OUTCOME_NA)
+    sstate_checksum = models.CharField(max_length=100, null=True)
+    path_to_sstate_obj = models.FilePathField(max_length=500, blank=True)
+    recipe = models.ForeignKey('Recipe', related_name='build_recipe')
+    task_name = models.CharField(max_length=100)
+    source_url = models.FilePathField(max_length=255, null=True)
+    log_file = models.FilePathField(max_length=255, blank=True)
+    work_directory = models.FilePathField(max_length=255, null=True)
+    script_type = models.IntegerField(choices=TASK_CODING, default=CODING_PYTHON)
+    line_number = models.IntegerField(default=0)
+    py_stack_trace = models.TextField(null=True)
+    disk_io = models.IntegerField(null=True)
+    cpu_usage = models.DecimalField(max_digits=6, decimal_places=2, null=True)
+    elapsed_time = models.CharField(max_length=50, default=0)
+    sstate_result = models.IntegerField(choices=SSTATE_RESULT, default=SSTATE_NA)
+    message = models.CharField(max_length=240)
+    logfile = models.FilePathField(max_length=255, null=True)
+
+    class Meta:
+        ordering = ('order', 'recipe' ,)
+
+
+class Task_Dependency(models.Model):
+    task = models.ForeignKey(Task, related_name='task_dependencies_task')
+    depends_on = models.ForeignKey(Task, related_name='task_dependencies_depends')
+
+
+class Build_Package(models.Model):
+    build = models.ForeignKey('Build')
+    recipe = models.ForeignKey('Recipe', null=True)
+    name = models.CharField(max_length=100)
+    version = models.CharField(max_length=100, default="")
+    revision = models.CharField(max_length=32, default="")
+    summary = models.CharField(max_length=200, default="")
+    description = models.CharField(max_length=200, default="")
+    size = models.IntegerField(default=0)
+    section = models.CharField(max_length=80, null=True)
+    license = models.CharField(max_length=80, null=True)
+
+class Build_Package_Dependency(models.Model):
+    TYPE_RDEPENDS = 0
+    TYPE_RPROVIDES = 1
+    TYPE_RRECOMMENDS = 2
+    TYPE_RSUGGESTS = 3
+    TYPE_RREPLACES = 4
+    TYPE_RCONFLICTS = 5
+    DEPENDS_TYPE = (
+        (TYPE_RDEPENDS, "rdepends"),
+        (TYPE_RPROVIDES, "rprovides"),
+        (TYPE_RRECOMMENDS, "rrecommends"),
+        (TYPE_RSUGGESTS, "rsuggests"),
+        (TYPE_RREPLACES, "rreplaces"),
+        (TYPE_RCONFLICTS, "rconflicts"),
+    )
+    package = models.ForeignKey(Build_Package, related_name='bpackage_dependencies_package')
+    depends_on = models.CharField(max_length=100)   # soft dependency
+    dep_type = models.IntegerField(choices=DEPENDS_TYPE)
+
+
+class Target_Package(models.Model):
+    target = models.ForeignKey('Target')
+    recipe = models.ForeignKey('Recipe', null=True)
+    name = models.CharField(max_length=100)
+    version = models.CharField(max_length=100, default="")
+    size = models.IntegerField()
+
+
+class Target_Package_Dependency(models.Model):
+    TYPE_DEPENDS = 0
+    TYPE_RDEPENDS = 1
+    TYPE_RECOMMENDS = 2
+
+    DEPENDS_TYPE = (
+        (TYPE_DEPENDS, "depends"),
+        (TYPE_RDEPENDS, "rdepends"),
+        (TYPE_RECOMMENDS, "recommends"),
+    )
+    package = models.ForeignKey(Target_Package, related_name='tpackage_dependencies_package')
+    depends_on = models.ForeignKey(Target_Package, related_name='tpackage_dependencies_depends')
+    dep_type = models.IntegerField(choices=DEPENDS_TYPE)
+
+
+class Build_File(models.Model):
+    bpackage = models.ForeignKey(Build_Package, related_name='filelist_bpackage')
+    path = models.FilePathField(max_length=255, blank=True)
+    size = models.IntegerField()
+
+class Target_File(models.Model):
+    tpackage = models.ForeignKey(Target_Package, related_name='filelist_tpackage')
+    path = models.FilePathField(max_length=255, blank=True)
+    size = models.IntegerField()
+
+
+class Recipe(models.Model):
+    name = models.CharField(max_length=100, null=True)
+    version = models.CharField(max_length=100, null=True)
+    layer_version = models.ForeignKey('Layer_Version', related_name='recipe_layer_version')
+    summary = models.CharField(max_length=100, null=True)
+    description = models.CharField(max_length=100, null=True)
+    section = models.CharField(max_length=100, null=True)
+    license = models.CharField(max_length=200, null=True)
+    licensing_info = models.TextField(null=True)
+    homepage = models.URLField(null=True)
+    bugtracker = models.URLField(null=True)
+    author = models.CharField(max_length=100, null=True)
+    file_path = models.FilePathField(max_length=255)
+
+
+class Recipe_Dependency(models.Model):
+    TYPE_DEPENDS = 0
+    TYPE_RDEPENDS = 1
+
+    DEPENDS_TYPE = (
+        (TYPE_DEPENDS, "depends"),
+        (TYPE_RDEPENDS, "rdepends"),
+    )
+    recipe = models.ForeignKey(Recipe, related_name='r_dependencies_recipe')
+    depends_on = models.ForeignKey(Recipe, related_name='r_dependencies_depends')
+    dep_type = models.IntegerField(choices=DEPENDS_TYPE)
+
+class Layer(models.Model):
+    name = models.CharField(max_length=100)
+    local_path = models.FilePathField(max_length=255)
+    layer_index_url = models.URLField()
+
+
+class Layer_Version(models.Model):
+    layer = models.ForeignKey(Layer, related_name='layer_version_layer')
+    branch = models.CharField(max_length=50)
+    commit = models.CharField(max_length=100)
+    priority = models.IntegerField()
+
+
+class Variable(models.Model):
+    build = models.ForeignKey(Build, related_name='variable_build')
+    variable_name = models.CharField(max_length=100)
+    variable_value = models.TextField(null=True)
+    file = models.FilePathField(max_length=255)
+    changed = models.BooleanField(default=False)
+    human_readable_name = models.CharField(max_length=200)
+    description = models.TextField(null=True)
+
+
+class LogMessage(models.Model):
+    INFO = 0
+    WARNING = 1
+    ERROR = 2
+
+    LOG_LEVEL = ( (INFO, "info"),
+            (WARNING, "warn"),
+            (ERROR, "error") )
+
+    build = models.ForeignKey(Build)
+    level = models.IntegerField(choices=LOG_LEVEL, default=INFO)
+    message=models.CharField(max_length=240)
+    pathname = models.FilePathField(max_length=255, null=True)
+    lineno = models.IntegerField(null=True)
diff --git a/bitbake/lib/webhob/orm/tests.py b/bitbake/lib/webhob/orm/tests.py
new file mode 100644
index 0000000..501deb7
--- /dev/null
+++ b/bitbake/lib/webhob/orm/tests.py
@@ -0,0 +1,16 @@
+"""
+This file demonstrates writing tests using the unittest module. These will pass
+when you run "manage.py test".
+
+Replace this with more appropriate tests for your application.
+"""
+
+from django.test import TestCase
+
+
+class SimpleTest(TestCase):
+    def test_basic_addition(self):
+        """
+        Tests that 1 + 1 always equals 2.
+        """
+        self.assertEqual(1 + 1, 2)
diff --git a/bitbake/lib/webhob/orm/views.py b/bitbake/lib/webhob/orm/views.py
new file mode 100644
index 0000000..60f00ef
--- /dev/null
+++ b/bitbake/lib/webhob/orm/views.py
@@ -0,0 +1 @@
+# Create your views here.
diff --git a/bitbake/lib/webhob/whbgui/__init__.py b/bitbake/lib/webhob/whbgui/__init__.py
new file mode 100644
index 0000000..e69de29
diff --git a/bitbake/lib/webhob/whbgui/static/images/yocto.jpg b/bitbake/lib/webhob/whbgui/static/images/yocto.jpg
new file mode 100644
index 0000000000000000000000000000000000000000..5de4b7693aa330bb8220baa81567bf82c307a8ab
GIT binary patch
literal 6582
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
aOU31^K>#@}(ZTG-?Z2-R|4z5g$NmTTvPqNx

literal 0
HcmV?d00001

diff --git a/bitbake/lib/webhob/whbgui/templates/index.html b/bitbake/lib/webhob/whbgui/templates/index.html
new file mode 100644
index 0000000..80b02d9
--- /dev/null
+++ b/bitbake/lib/webhob/whbgui/templates/index.html
@@ -0,0 +1,13 @@
+<html>
+<head>
+	<title>GUI Page</title>
+</head>
+<body>
+{% load staticfiles %}
+
+<img src="{% static "/static/images/yocto.jpg" %}" alt="Yocto"/>
+
+This is your basic index page!
+</body>
+
+</html>
\ No newline at end of file
diff --git a/bitbake/lib/webhob/whbgui/tests.py b/bitbake/lib/webhob/whbgui/tests.py
new file mode 100644
index 0000000..a450412
--- /dev/null
+++ b/bitbake/lib/webhob/whbgui/tests.py
@@ -0,0 +1,34 @@
+#
+# BitBake Webhob Implementation
+#
+# Copyright (C) 2013        Intel Corporation
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+"""
+This file demonstrates writing tests using the unittest module. These will pass
+when you run "manage.py test".
+
+Replace this with more appropriate tests for your application.
+"""
+
+from django.test import TestCase
+
+
+class SimpleTest(TestCase):
+    def test_basic_addition(self):
+        """
+        Tests that 1 + 1 always equals 2.
+        """
+        self.assertEqual(1 + 1, 2)
diff --git a/bitbake/lib/webhob/whbgui/urls.py b/bitbake/lib/webhob/whbgui/urls.py
new file mode 100644
index 0000000..fb32896
--- /dev/null
+++ b/bitbake/lib/webhob/whbgui/urls.py
@@ -0,0 +1,27 @@
+#
+# BitBake Webhob Implementation
+#
+# Copyright (C) 2013        Intel Corporation
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+import os
+
+from django.conf import settings
+from django.conf.urls import patterns, include, url
+
+
+urlpatterns = patterns('whbgui.views',
+        url(r'^$', 'guihome', name='guihome'),
+)
diff --git a/bitbake/lib/webhob/whbgui/views.py b/bitbake/lib/webhob/whbgui/views.py
new file mode 100644
index 0000000..16f5347
--- /dev/null
+++ b/bitbake/lib/webhob/whbgui/views.py
@@ -0,0 +1,26 @@
+#
+# BitBake Webhob Implementation
+#
+# Copyright (C) 2013        Intel Corporation
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+from django.shortcuts import render
+from orm.models import Build, Task
+
+
+def guihome(request):
+    template = 'index.html'
+
+    return render(request, template)
diff --git a/bitbake/lib/webhob/whbmain/__init__.py b/bitbake/lib/webhob/whbmain/__init__.py
new file mode 100644
index 0000000..e69de29
diff --git a/bitbake/lib/webhob/whbmain/settings.py b/bitbake/lib/webhob/whbmain/settings.py
new file mode 100644
index 0000000..f361c38
--- /dev/null
+++ b/bitbake/lib/webhob/whbmain/settings.py
@@ -0,0 +1,191 @@
+#
+# BitBake Webhob Implementation
+#
+# Copyright (C) 2013        Intel Corporation
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+# Django settings for webhob project.
+
+DEBUG = True
+TEMPLATE_DEBUG = DEBUG
+
+ADMINS = (
+    # ('Your Name', 'your_email@example.com'),
+)
+
+MANAGERS = ADMINS
+
+DATABASES = {
+    'default': {
+        'ENGINE': 'django.db.backends.sqlite3', # Add 'postgresql_psycopg2', 'mysql', 'sqlite3' or 'oracle'.
+        'NAME': 'webhob.sqlite',                      # Or path to database file if using sqlite3.
+        'USER': '',
+        'PASSWORD': '',
+        'HOST': '127.0.0.1',                      # Empty for localhost through domain sockets or '127.0.0.1' for localhost through TCP.
+        'PORT': '3306',                      # Set to empty string for default.
+    }
+}
+
+# Hosts/domain names that are valid for this site; required if DEBUG is False
+# See https://docs.djangoproject.com/en/1.5/ref/settings/#allowed-hosts
+ALLOWED_HOSTS = []
+
+# Local time zone for this installation. Choices can be found here:
+# http://en.wikipedia.org/wiki/List_of_tz_zones_by_name
+# although not all choices may be available on all operating systems.
+# In a Windows environment this must be set to your system time zone.
+
+# Always use local computer's time zone
+TIME_ZONE = ''
+
+# Language code for this installation. All choices can be found here:
+# http://www.i18nguy.com/unicode/language-identifiers.html
+LANGUAGE_CODE = 'en-us'
+
+SITE_ID = 1
+
+# If you set this to False, Django will make some optimizations so as not
+# to load the internationalization machinery.
+USE_I18N = True
+
+# If you set this to False, Django will not format dates, numbers and
+# calendars according to the current locale.
+USE_L10N = True
+
+
+# If you set this to False, Django will not use timezone-aware datetimes.
+USE_TZ = True
+
+# Absolute filesystem path to the directory that will hold user-uploaded files.
+# Example: "/var/www/example.com/media/"
+MEDIA_ROOT = ''
+
+# URL that handles the media served from MEDIA_ROOT. Make sure to use a
+# trailing slash.
+# Examples: "http://example.com/media/", "http://media.example.com/"
+MEDIA_URL = ''
+
+# Absolute path to the directory static files should be collected to.
+# Don't put anything in this directory yourself; store your static files
+# in apps' "static/" subdirectories and in STATICFILES_DIRS.
+# Example: "/var/www/example.com/static/"
+STATIC_ROOT = ''
+
+# URL prefix for static files.
+# Example: "http://example.com/static/", "http://static.example.com/"
+STATIC_URL = '/static/'
+
+# Additional locations of static files
+STATICFILES_DIRS = (
+    # Put strings here, like "/home/html/static" or "C:/www/django/static".
+    # Always use forward slashes, even on Windows.
+    # Don't forget to use absolute paths, not relative paths.
+)
+
+# List of finder classes that know how to find static files in
+# various locations.
+STATICFILES_FINDERS = (
+    'django.contrib.staticfiles.finders.FileSystemFinder',
+    'django.contrib.staticfiles.finders.AppDirectoriesFinder',
+#    'django.contrib.staticfiles.finders.DefaultStorageFinder',
+)
+
+# Make this unique, and don't share it with anybody.
+SECRET_KEY = 'fy@5+5w9zn5wa0vsegn1c8p_6w&pa_ms-4t0cna1vle79nzlkn'
+
+# List of callables that know how to import templates from various sources.
+TEMPLATE_LOADERS = (
+    'django.template.loaders.filesystem.Loader',
+    'django.template.loaders.app_directories.Loader',
+#     'django.template.loaders.eggs.Loader',
+)
+
+MIDDLEWARE_CLASSES = (
+    'django.middleware.common.CommonMiddleware',
+    'django.contrib.sessions.middleware.SessionMiddleware',
+    'django.middleware.csrf.CsrfViewMiddleware',
+    'django.contrib.auth.middleware.AuthenticationMiddleware',
+    'django.contrib.messages.middleware.MessageMiddleware',
+    # Uncomment the next line for simple clickjacking protection:
+    # 'django.middleware.clickjacking.XFrameOptionsMiddleware',
+)
+
+ROOT_URLCONF = 'whbmain.urls'
+
+# Python dotted path to the WSGI application used by Django's runserver.
+WSGI_APPLICATION = 'whbmain.wsgi.application'
+
+TEMPLATE_DIRS = (
+    # Put strings here, like "/home/html/django_templates" or "C:/www/django/templates".
+    # Always use forward slashes, even on Windows.
+    # Don't forget to use absolute paths, not relative paths.
+)
+
+INSTALLED_APPS = (
+    #'django.contrib.auth',
+    #'django.contrib.contenttypes',
+    #'django.contrib.sessions',
+    #'django.contrib.sites',
+    #'django.contrib.messages',
+    'django.contrib.staticfiles',
+    # Uncomment the next line to enable the admin:
+    # 'django.contrib.admin',
+    # Uncomment the next line to enable admin documentation:
+    # 'django.contrib.admindocs',
+    'orm',
+    'whbmain',
+    'bldviewer',
+    'whbgui',
+)
+
+# A sample logging configuration. The only tangible logging
+# performed by this configuration is to send an email to
+# the site admins on every HTTP 500 error when DEBUG=False.
+# See http://docs.djangoproject.com/en/dev/topics/logging for
+# more details on how to customize your logging configuration.
+LOGGING = {
+    'version': 1,
+    'disable_existing_loggers': False,
+    'filters': {
+        'require_debug_false': {
+            '()': 'django.utils.log.RequireDebugFalse'
+        }
+    },
+    'handlers': {
+        'mail_admins': {
+            'level': 'ERROR',
+            'filters': ['require_debug_false'],
+            'class': 'django.utils.log.AdminEmailHandler'
+        }
+    },
+    'loggers': {
+        'django.request': {
+            'handlers': ['mail_admins'],
+            'level': 'ERROR',
+            'propagate': True,
+        },
+    }
+}
+
+# If we're using sqlite, we need to tweak the performance a bit
+from django.db.backends.signals import connection_created
+def activate_synchronous_off(sender, connection, **kwargs):
+    if connection.vendor == 'sqlite':
+        cursor = connection.cursor()
+        cursor.execute('PRAGMA synchronous = 0;')
+connection_created.connect(activate_synchronous_off)
+#
+
+
diff --git a/bitbake/lib/webhob/whbmain/urls.py b/bitbake/lib/webhob/whbmain/urls.py
new file mode 100644
index 0000000..60f86e4
--- /dev/null
+++ b/bitbake/lib/webhob/whbmain/urls.py
@@ -0,0 +1,40 @@
+#
+# BitBake Webhob Implementation
+#
+# Copyright (C) 2013        Intel Corporation
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+from django.conf.urls import patterns, include, url
+from django.views.generic.simple import redirect_to
+
+
+# Uncomment the next two lines to enable the admin:
+# from django.contrib import admin
+# admin.autodiscover()
+
+urlpatterns = patterns('',
+    url(r'^simple/', include('bldviewer.urls')),
+    url(r'^api/1.0/', include('bldviewer.api')),
+    url(r'^gui/', include('whbgui.urls')),
+    url(r'^$', redirect_to, {'url': '/simple/'}),
+    # Examples:
+    # url(r'^webhob/', include('webhob.foo.urls')),
+
+    # Uncomment the admin/doc line below to enable admin documentation:
+    # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),
+
+    # Uncomment the next line to enable the admin:
+    # url(r'^admin/', include(admin.site.urls)),
+)
diff --git a/bitbake/lib/webhob/whbmain/wsgi.py b/bitbake/lib/webhob/whbmain/wsgi.py
new file mode 100644
index 0000000..9595eda
--- /dev/null
+++ b/bitbake/lib/webhob/whbmain/wsgi.py
@@ -0,0 +1,32 @@
+"""
+WSGI config for webhob project.
+
+This module contains the WSGI application used by Django's development server
+and any production WSGI deployments. It should expose a module-level variable
+named ``application``. Django's ``runserver`` and ``runfcgi`` commands discover
+this application via the ``WSGI_APPLICATION`` setting.
+
+Usually you will have the standard Django WSGI application here, but it also
+might make sense to replace the whole Django WSGI application with a custom one
+that later delegates to the Django one. For example, you could introduce WSGI
+middleware here, or combine a Django application with an application of another
+framework.
+
+"""
+import os
+
+# We defer to a DJANGO_SETTINGS_MODULE already in the environment. This breaks
+# if running multiple sites in the same mod_wsgi process. To fix this, use
+# mod_wsgi daemon mode with each site in its own daemon process, or use
+# os.environ["DJANGO_SETTINGS_MODULE"] = "webhob.settings"
+os.environ.setdefault("DJANGO_SETTINGS_MODULE", "wbhmain.settings")
+
+# This application object is used by any WSGI server configured to use this
+# file. This includes Django's development server, if the WSGI_APPLICATION
+# setting points here.
+from django.core.wsgi import get_wsgi_application
+application = get_wsgi_application()
+
+# Apply WSGI middleware here.
+# from helloworld.wsgi import HelloWorldApplication
+# application = HelloWorldApplication(application)
-- 
1.8.1.2


