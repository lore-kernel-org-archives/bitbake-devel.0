Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f43.google.com (mail-wg0-f43.google.com [74.125.82.43])
	by mail.openembedded.org (Postfix) with ESMTP id 388EA75692
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 May 2015 14:15:27 +0000 (UTC)
Received: by wgbgq6 with SMTP id gq6so37787297wgb.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 May 2015 07:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=FhwvJ+g0zlb4SbldVVgwV0+M59OLK8dOAM/BSFs+P6w=;
	b=EQdQ+AvEGHoDF+aZvbRH/jdTKMxT0H92RBwz2ArEisAR2kXo/A4F8PXmD8726RoqT+
	6uO3E4EOROMJLyBqQrOGLIO9VGRpnmfETBQJGrVoSkyYaR+eXz7UzeVzDvnYVsq38TWc
	IlEpwUoyESHU5vVjrBoU1+PviUKmpahNeVauzPar/9BLbD/Bc175VnmTq4PTQg1nYBiq
	+v6DjDjE2HwZY51vJZ5sQ7onGU/L6UZc/a1j4+KK68d2sQNHxWeUqbbykQnwE0u8VJz2
	tp4VCF+rv39N/ekWLsTP0Zj8fhP/ClzrT4SXU0WdVBrG6qgL/KxBHd45fYohsz16zw0c
	W8gQ==
X-Gm-Message-State: ALoCoQmV86ikC3cDMVVGNOG5UmSjm1Su/lNd/jczSfGemDCO9faQSF8zbTyenVKTO8L1tyn3gzVy
X-Received: by 10.180.90.73 with SMTP id bu9mr61574797wib.88.1432822528602;
	Thu, 28 May 2015 07:15:28 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id gy8sm4204616wib.13.2015.05.28.07.15.26
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 28 May 2015 07:15:27 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id BE84B561215; Thu, 28 May 2015 15:14:17 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 28 May 2015 15:14:00 +0100
Message-Id: <ec19973cb44c97ae0b724e383119f84f4ddc30ad.1432822343.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <f4c88fd9e39602ab841967166a14593f92576079.1432822343.git.alexandru.damian@intel.com>
References: <f4c88fd9e39602ab841967166a14593f92576079.1432822343.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1432822343.git.alexandru.damian@intel.com>
References: <cover.1432822343.git.alexandru.damian@intel.com>
Subject: [PATCH 06/22] toastergui: show relative paths in configvars view
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
X-List-Received-Date: Thu, 28 May 2015 14:15:28 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Reworked filtering of config paths.

Stripped clone paths, topdir and its parent directory from the paths
to config files in configvars view.

[YOCTO #7463]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/templates/configvars.html   | 10 +--
 lib/toaster/toastergui/templatetags/projecttags.py | 76 +++++++---------------
 lib/toaster/toastergui/views.py                    | 19 ++++--
 3 files changed, 42 insertions(+), 63 deletions(-)

diff --git a/lib/toaster/toastergui/templates/configvars.html b/lib/toaster/toastergui/templates/configvars.html
index 3e4c7e8..42c42a5 100644
--- a/lib/toaster/toastergui/templates/configvars.html
+++ b/lib/toaster/toastergui/templates/configvars.html
@@ -54,9 +54,11 @@
         <td class="variable_name"><a data-toggle="modal" href="#variable-{{variable.pk}}">{{variable.variable_name}}</a></td>
         <td class="variable_value"><a data-toggle="modal" href="#variable-{{variable.pk}}">{{variable.variable_value|truncatechars:153}}</a></td>
         <td class="file"><a data-toggle="modal" href="#variable-{{variable.pk}}">
-            {% if variable.vhistory.all %} {% autoescape off %}
-                {{variable.vhistory.all | filter_setin_files:file_filter | cut_layer_path_prefix:layer_names}}
-            {% endautoescape %} {% endif %}
+            {% if variable.vhistory.all %}
+                {% for path in variable.vhistory.all|filter_setin_files:file_filter %}
+                    {{path|cut_path_prefix:dirstostrip}}<p>
+                {% endfor %}
+            {% endif %}
         </a></td>
         <td class="description">
             {% if variable.description %}
@@ -115,7 +117,7 @@
                 <tbody>
                     {% for vh in variable.vhistory.all %}
                     <tr>
-                        <td>{{forloop.counter}}</td><td>{{vh.file_name|cut_layer_path_prefix:layer_names}}</td><td>{{vh.operation}}</td><td>{{vh.line_number}}</td>
+                        <td>{{forloop.counter}}</td><td>{{vh.file_name|cut_path_prefix:dirstostrip}}</td><td>{{vh.operation}}</td><td>{{vh.line_number}}</td>
                     </tr>
                     {%endfor%}
                 </tbody>
diff --git a/lib/toaster/toastergui/templatetags/projecttags.py b/lib/toaster/toastergui/templatetags/projecttags.py
index 54700e3..1bc3bc2 100644
--- a/lib/toaster/toastergui/templatetags/projecttags.py
+++ b/lib/toaster/toastergui/templatetags/projecttags.py
@@ -20,6 +20,7 @@
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 from datetime import datetime, timedelta
+from os.path import relpath
 import re
 from django import template
 from django.utils import timezone
@@ -182,47 +183,23 @@ def variable_parent_name(value):
     return re.sub('_[a-z].*', '', value)
 
 @register.filter
-def filter_setin_files(file_list,matchstr):
-    """ filter/search the 'set in' file lists. Note
-        that this output is not autoescaped to allow
-        the <p> marks, but this is safe as the data
-        is file paths
-    """
-
-    # no filters, show last file (if any)
-    if matchstr == ":":
-        if file_list:
-            return file_list[len(file_list)-1].file_name
-        else:
-            return ''
-
-    search, filter = matchstr.partition(':')[::2]
-    htmlstr=""
-    # match only filters
-    if search == '':
-        for i in range(len(file_list)):
-            if re.search(filter, file_list[i].file_name):
-                if htmlstr.find(file_list[i].file_name + "<p>") < 0:
-                    htmlstr += file_list[i].file_name + "<p>"
-        return htmlstr
-
-    # match only search string, plus always last file
-    if filter == "":
-        for i in range(len(file_list)-1):
-            if re.search(search,file_list[i].file_name):
-                if htmlstr.find(file_list[i].file_name + "<p>") < 0:
-                    htmlstr += file_list[i].file_name + "<p>"
-        if htmlstr.find(file_list[len(file_list)-1].file_name) < 0:
-            htmlstr += file_list[len(file_list)-1].file_name
-        return htmlstr
-
-    # match filter or search string
-    for i in range(len(file_list)):
-        if re.search(filter, file_list[i].file_name) or re.search(search,file_list[i].file_name):
-            if htmlstr.find(file_list[i].file_name + "<p>") < 0:
-                htmlstr += file_list[i].file_name + "<p>"
-    return htmlstr
-
+def filter_setin_files(file_list, matchstr):
+    """Filter/search the 'set in' file lists."""
+    result = []
+    search, filter = matchstr.split(':')
+    for pattern in (search, filter):
+        if pattern:
+            for fobj in file_list:
+                fname = fobj.file_name
+                if fname not in result and re.search(pattern, fname):
+                    result.append(fname)
+
+    # no filter, show last file (if any)
+    last = list(file_list)[-1].file_name
+    if not filter and last not in result:
+        result.append(last)
+
+    return result
 
 @register.filter
 def string_slice(strvar,slicevar):
@@ -313,16 +290,9 @@ def is_shaid(text):
         return False
 
 @register.filter
-def cut_layer_path_prefix(fullpath,layer_names):
-    ### if some part of the full local path to a layer matches
-    ### an entry in layer_names (sorted desc), return the layer
-    ### name relative path.
-    for lname in layer_names:
-        # import rpdb; rpdb.set_trace()
-        # only try layer names that are non-trivial to avoid false matches
-        if len(lname) >= 4:
-            # match layer name with as a subdir / or for remote layers /_
-            if re.search('/' + lname, fullpath) or re.search('/_' + lname, fullpath):
-                parts = re.split(lname, fullpath, 1)
-                return lname + parts[1]
+def cut_path_prefix(fullpath, prefixes):
+    """Cut path prefix from fullpath."""
+    for prefix in prefixes:
+        if fullpath.startswith(prefix):
+            return relpath(fullpath, prefix)
     return fullpath
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 761bf53..d451c3b 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -28,6 +28,8 @@ from django.shortcuts import render, redirect
 from orm.models import Build, Target, Task, Layer, Layer_Version, Recipe, LogMessage, Variable
 from orm.models import Task_Dependency, Recipe_Dependency, Package, Package_File, Package_Dependency
 from orm.models import Target_Installed_Package, Target_File, Target_Image_File, BuildArtifact
+from bldcontrol.models import BuildEnvironment, BuildRequest
+from bldcontrol import bbcontroller
 from django.views.decorators.cache import cache_control
 from django.core.urlresolvers import reverse
 from django.core.exceptions import MultipleObjectsReturned
@@ -39,6 +41,7 @@ from datetime import timedelta, datetime, date
 from django.utils import formats
 from toastergui.templatetags.projecttags import json as jsonfilter
 import json
+from os.path import dirname
 
 # all new sessions should come through the landing page;
 # determine in which mode we are running in, and redirect appropriately
@@ -1300,11 +1303,6 @@ def configvars(request, build_id):
 
     variables = _build_page_range(Paginator(queryset, pagesize), request.GET.get('page', 1))
 
-    layers = Layer.objects.filter(layer_version_layer__projectlayer__project__build=build_id).order_by("-name")
-    layer_names = map(lambda layer : layer.name, layers)
-    # special case for meta built-in layer
-    layer_names.append('meta')
-
     # show all matching files (not just the last one)
     file_filter= search_term + ":"
     if filter_string.find('/conf/') > 0:
@@ -1317,6 +1315,15 @@ def configvars(request, build_id):
         file_filter += '/bitbake.conf'
     build_dir=re.sub("/tmp/log/.*","",Build.objects.get(pk=build_id).cooker_log_path)
 
+    clones = []
+    for breq in BuildRequest.objects.filter(build_id=build_id):
+        bc = bbcontroller.getBuildEnvironmentController(pk = breq.environment.id)
+        for brl in breq.brlayer_set.all():
+            localdirname = bc.getGitCloneDirectory(brl.giturl, brl.commit)
+            if not localdirname.startswith("/"):
+                localdirname = os.path.join(bc.be.sourcedir, localdirname)
+            clones.append(localdirname)
+
     context = {
                 'objectname': 'configvars',
                 'object_search_display':'BitBake variables',
@@ -1327,7 +1334,7 @@ def configvars(request, build_id):
                 'total_count':queryset_with_search.count(),
                 'default_orderby' : 'variable_name:+',
                 'search_term':search_term,
-                'layer_names' : layer_names,
+                'dirstostrip': clones + [dirname(build_dir), dirname(dirname(build_dir))],
             # Specifies the display of columns for the table, appearance in "Edit columns" box, toggling default show/hide, and specifying filters for columns
                 'tablecols' : [
                 {'name': 'Variable',
-- 
1.9.1


