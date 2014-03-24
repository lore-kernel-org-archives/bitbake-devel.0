Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f45.google.com (mail-wg0-f45.google.com [74.125.82.45])
	by mail.openembedded.org (Postfix) with ESMTP id D55406F77C
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Mar 2014 18:37:32 +0000 (UTC)
Received: by mail-wg0-f45.google.com with SMTP id l18so3798291wgh.16
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Mar 2014 11:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=ATwddbbSeRl4B98WTLcoYG3XsIfcBHwAKqBQHhC7D6g=;
	b=TQZW/X2l5STzdTVeFfzABYXC9e4Y8MwqjC4lJuBPHZPMTYaKzuBu2D8eUcsNc6zKAo
	kYpV2OSwOVmPVqxg7ncHJvTQhb5glRFuUqUhcHG8QajLd0slaa6JpiTGDegqnCuqTrEe
	Qy6Lr1G6MEKjNSjBu9SU6kUaDlYflzvkbqchFKJa7kitq+hF+YxoPFnbeuK7+BBSGRSp
	DtUMVxDU7x5tTrdg/PQtvFmb/4Yt/+M0xXPJH3Wq1UkbnAc8269pZPYl8MHZH76sb/Bz
	IhsNEKcPWwys0H3qrBySUVgkwZCGObypUC+inIa6VLT/mcjSBUfsAdDeqeCEL11kKRbJ
	RhQg==
X-Gm-Message-State: ALoCoQlBJWmEIizWcVNxtdemhvXLgSTZ7qn77LvAJS8rTUdrMGYDgq2CHxKhA4nbEuooaaGa77eZ
X-Received: by 10.180.24.134 with SMTP id u6mr17945435wif.41.1395686253165;
	Mon, 24 Mar 2014 11:37:33 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id t1sm38869413wia.1.2014.03.24.11.37.31
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Mon, 24 Mar 2014 11:37:31 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id AF395560D87; Mon, 24 Mar 2014 18:37:29 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 24 Mar 2014 18:37:11 +0000
Message-Id: <7e59b6b1cb44de00c512facece5ede96375a411f.1395686148.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <cover.1395686148.git.alexandru.damian@intel.com>
References: <cover.1395686148.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 01/18] toaster: Revert "added file types to the Outputs column in the build page"
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
X-List-Received-Date: Mon, 24 Mar 2014 18:37:33 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This reverts commit d40ac966b22e1fa1956d8f2fe37fd55fa670e88f.

Sloppy review on my part let the original patch in, when it should've
been rejected because the filter tags should have no knowledge of the
object system.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/templates/build.html        |  6 +----
 lib/toaster/toastergui/templatetags/projecttags.py | 27 ----------------------
 2 files changed, 1 insertion(+), 32 deletions(-)

diff --git a/lib/toaster/toastergui/templates/build.html b/lib/toaster/toastergui/templates/build.html
index 1c94e7c..8f557e9 100644
--- a/lib/toaster/toastergui/templates/build.html
+++ b/lib/toaster/toastergui/templates/build.html
@@ -92,11 +92,7 @@
             <td class="warnings_no">{% if  build.warnings_no %}<a class="warnings_no warning" href="{% url "builddashboard" build.id %}#warnings">{{build.warnings_no}} warning{{build.warnings_no|pluralize}}</a>{%endif%}</td>
             <td class="time"><a href="{% url "buildtime" build.id %}">{{build.timespent|sectohms}}</a></td>
             <td class="log">{{build.cooker_log_path}}</td>
-            <td class="output">
-              {% if build.outcome == 0 %}
-              {{build|get_image_extensions}}
-              {% endif %}
-            </td>
+            <td class="output">{% if build.outcome == 0 %}{% for t in build.target_set.all %}{% if t.is_image %}<a href="{%url "builddashboard" build.id%}#images">TODO: compute image output fstypes</a>{% endif %}{% endfor %}{% endif %}</td>
         </tr>
 
         {% endfor %}
diff --git a/lib/toaster/toastergui/templatetags/projecttags.py b/lib/toaster/toastergui/templatetags/projecttags.py
index e08258b..e7b23cb 100644
--- a/lib/toaster/toastergui/templatetags/projecttags.py
+++ b/lib/toaster/toastergui/templatetags/projecttags.py
@@ -24,8 +24,6 @@ import re
 from django import template
 from django.utils import timezone
 from django.template.defaultfilters import filesizeformat
-from orm.models import Target_Installed_Package, Target_Image_File
-from orm.models import Build, Target, Task, Layer, Layer_Version
 
 register = template.Library()
 
@@ -191,31 +189,6 @@ def string_slice(strvar,slicevar):
         return strvar[int(first):int(last)]
 
 @register.filter
-def get_image_extensions( build ):
-    """
-    This is a simple filter that returns a list (string)
-    of extensions of the build-targets-image files. Note
-    that each build can have multiple targets and each
-    target can yield more than one image file
-    """
-    targets = Target.objects.filter( build_id = build.id );
-    comma = "";
-    extensions = "";
-    for t in targets:
-        if ( not t.is_image ):
-            continue;
-        tif = Target_Image_File.objects.filter( target_id = t.id );
-        for i in tif:
-            try:
-                ndx = i.file_name.index( "." );
-            except ValueError:
-                ndx = 0;
-            s = i.file_name[ ndx + 1 : ];
-            extensions += comma + s;
-            comma = ", ";
-    return( extensions );
-
-@register.filter
 def filtered_installedsize(size, installed_size):
     """If package.installed_size not null and not empty return it,
        else return package.size
-- 
1.8.3.2


