Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f169.google.com (mail-we0-f169.google.com
	[74.125.82.169])
	by mail.openembedded.org (Postfix) with ESMTP id C149D6F8DE
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Mar 2014 16:50:05 +0000 (UTC)
Received: by mail-we0-f169.google.com with SMTP id w62so1988466wes.28
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Mar 2014 09:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=AfHKRovgAG+02Vp0Y4CfDNbLSBoUQVyyT5IpF3CbC94=;
	b=nMVCdLGjXaj1cDkeO+pqeS/y+HCNEObMKCLt8ldSwloc5qWj55Z/lK+ng7LQw3lNxq
	LuCl/yog1Xy3aabHwgA+irM9x6UCALg6VgE5yzAhZVnJ/Q08rvtSSp4MQbp8iNStnoOR
	dF1Fqvkn7EXCGvcky8a3NxlT/97j5HWkeGDueInTwYuTtrgqQ1MWhFsTi0l/UQvKlqJL
	Imaa7EaB02n2bKH4TFtThp++cSBXX2camQcUso1VLDqw9Pc4KdNtCj+kG5dx31QpmAKJ
	UeUW4UsFN/LcgjjwUBV/TJgEcSKNhzsogDE1PG3noYsiFC4hGTQ6JZyPWs7mGkWcRRNQ
	puBw==
X-Gm-Message-State: ALoCoQnkc9covJdlXaxdB4Fm4PiV6Ktpe2QqE321Q9sqXjZM1wBuNr0V9E+8QVrtkk7XSGj2NbNs
X-Received: by 10.180.184.167 with SMTP id ev7mr14909852wic.55.1395939005859; 
	Thu, 27 Mar 2014 09:50:05 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id fs8sm13903593wib.8.2014.03.27.09.50.04
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Thu, 27 Mar 2014 09:50:04 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 877AE560079; Thu, 27 Mar 2014 16:50:02 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 27 Mar 2014 16:49:59 +0000
Message-Id: <8ba24af501d6b3a47a77bfa617e7405d2ab0e82c.1395938903.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <30647848c4c202df4537eb2c1810ec0999dab4bd.1395938903.git.alexandru.damian@intel.com>
References: <30647848c4c202df4537eb2c1810ec0999dab4bd.1395938903.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1395938903.git.alexandru.damian@intel.com>
References: <cover.1395938903.git.alexandru.damian@intel.com>
Cc: Farrell Wymore <farrell.wymore@windriver.com>,
	Alexandru DAMIAN <alexandru.damian@intel.com>,
	David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 7/9] toaster: added file types to the Outputs column in the build
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
X-List-Received-Date: Thu, 27 Mar 2014 16:50:06 -0000

From: David Reyna <David.Reyna@windriver.com>

The file types are displayed in the Outputs column in the build page. The file types
are derived from the target image filenames.

[YOCTO #5947]

Signed-off-by: Farrell Wymore <farrell.wymore@windriver.com>
Signed-off-by: David Reyna <David.Reyna@windriver.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/templates/build.html        |  6 +++++-
 lib/toaster/toastergui/templatetags/projecttags.py |  9 ++++++++
 lib/toaster/toastergui/views.py                    | 24 ++++++++++++++++++++--
 3 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/toastergui/templates/build.html b/lib/toaster/toastergui/templates/build.html
index 38ab2bf..7d13cc8 100644
--- a/lib/toaster/toastergui/templates/build.html
+++ b/lib/toaster/toastergui/templates/build.html
@@ -122,7 +122,11 @@
             <td class="warnings_no">{% if  build.warnings_no %}<a class="warnings_no warning" href="{% url "builddashboard" build.id %}#warnings">{{build.warnings_no}} warning{{build.warnings_no|pluralize}}</a>{%endif%}</td>
             <td class="time"><a href="{% url "buildtime" build.id %}">{{build.timespent|sectohms}}</a></td>
             <td class="log">{{build.cooker_log_path}}</td>
-            <td class="output">{% if build.outcome == 0 %}{% for t in build.target_set.all %}{% if t.is_image %}<a href="{%url "builddashboard" build.id%}#images">TODO: compute image output fstypes</a>{% endif %}{% endfor %}{% endif %}</td>
+            <td class="output">
+              {% if build.outcome == build.SUCCEEDED %}
+              <a href="{%url "builddashboard" build.id%}#images">{{fstypes|get_dict_value:build.id}}</a>
+              {% endif %}
+            </td>
         </tr>
 
         {% endfor %}
diff --git a/lib/toaster/toastergui/templatetags/projecttags.py b/lib/toaster/toastergui/templatetags/projecttags.py
index 76166ca..aa0ba39 100644
--- a/lib/toaster/toastergui/templatetags/projecttags.py
+++ b/lib/toaster/toastergui/templatetags/projecttags.py
@@ -240,3 +240,12 @@ def format_vpackage_namehelp(name):
     r += ' title="' + name + ' only has dependency information available.">'
     r += '</i>'
     return mark_safe(r)
+
+@register.filter
+def get_dict_value(dictionary, key):
+    """ return the value of a dictionary key
+    """
+    try:
+        return dictionary[key]
+    except KeyError:
+        return ''
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 0f92caf..d323b37 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -19,13 +19,13 @@
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
-import operator
+import operator,re
 
 from django.db.models import Q, Sum
 from django.shortcuts import render, redirect
 from orm.models import Build, Target, Task, Layer, Layer_Version, Recipe, LogMessage, Variable
 from orm.models import Task_Dependency, Recipe_Dependency, Package, Package_File, Package_Dependency
-from orm.models import Target_Installed_Package, Target_Image_File
+from orm.models import Target_Installed_Package, Target_File, Target_Image_File
 from django.views.decorators.cache import cache_control
 from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
 from django.http import HttpResponseBadRequest
@@ -231,6 +231,25 @@ def builds(request):
         else:
             b.eta = 0
 
+    # set up list of fstypes for each build
+    fstypes_map = {};
+    for build in build_info:
+        targets = Target.objects.filter( build_id = build.id )
+        comma = "";
+        extensions = "";
+        for t in targets:
+            if ( not t.is_image ):
+                continue
+            tif = Target_Image_File.objects.filter( target_id = t.id )
+            for i in tif:
+                s=re.sub('.*tar.bz2', 'tar.bz2', i.file_name)
+                if s == i.file_name:
+                    s=re.sub('.*\.', '', i.file_name)
+                if None == re.search(s,extensions):
+                    extensions += comma + s
+                    comma = ", "
+        fstypes_map[build.id]=extensions
+
     # send the data to the template
     context = {
             # specific info for
@@ -238,6 +257,7 @@ def builds(request):
             # TODO: common objects for all table views, adapt as needed
                 'objects' : build_info,
                 'objectname' : "builds",
+                'fstypes' : fstypes_map,
                 'search_term' : search_term,
                 'total_count' : queryset_with_search.count(),
             # Specifies the display of columns for the table, appearance in "Edit columns" box, toggling default show/hide, and specifying filters for columns
-- 
1.8.3.2


