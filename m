Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
	[209.85.212.169])
	by mail.openembedded.org (Postfix) with ESMTP id 86B736F877
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Mar 2014 17:59:09 +0000 (UTC)
Received: by mail-wi0-f169.google.com with SMTP id hm4so32408wib.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Mar 2014 10:59:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=tPIzBdCeSiTOH8YcgdKvrzdGYVyv2pecoLpjROlJqVw=;
	b=KH86lxAjLVVb/9m46wpRxVvUfKW5XHOIyUHHdkecqJ6ZyaQxw4Z4dRFGrBaBoY0BQm
	Xjm+FH1oJ6nM7oRZowv28ydjIfrE4SAujmUIiZQlJu5YVjoqrPvyPmVvj5tzUwSvIhHI
	o+I1ZvN5DrfhWeIFPV3SZIr/A1hW4muk6ccIMJufMqF6IE0/ItQ6KwltRUKUfe0jAqUF
	juQ/TqA2iX45W7dE070OFyjeiaqARADj1e0GpUEd0LczAphOrqD87OQjk0mLCS0wGDgN
	ZqAYgZOO26W5rXREDl5t1jNRDhwSxU5f7Rnvj+UIRQ9ufOH8+ZguZkcQgDrv8hOuWbeK
	eTgA==
X-Gm-Message-State: ALoCoQkfRLrctmN1q+3LDT5BfTmMa8fk3AO/5H8IOsWqcmpL6za2m8HTNYHdo9mX3E93ShKuTst4
X-Received: by 10.180.79.7 with SMTP id f7mr7344790wix.20.1394819950831;
	Fri, 14 Mar 2014 10:59:10 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id j8sm15553388wjn.13.2014.03.14.10.59.06
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Fri, 14 Mar 2014 10:59:08 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 2A5DF56133A; Fri, 14 Mar 2014 17:59:01 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 14 Mar 2014 17:59:00 +0000
Message-Id: <5984a3c7b8cc113794eb863caba7c7353165fdc1.1394819783.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <9f34a1c5e94d73cdba1def7059c60211514e054c.1394819783.git.alexandru.damian@intel.com>
References: <9f34a1c5e94d73cdba1def7059c60211514e054c.1394819783.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1394819783.git.alexandru.damian@intel.com>
References: <cover.1394819783.git.alexandru.damian@intel.com>
Cc: Farrell Wymore <farrell.wymore@windriver.com>
Subject: [PATCH 19/19] toaster: added file types to the Outputs column in the build page
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
X-List-Received-Date: Fri, 14 Mar 2014 17:59:10 -0000

From: Farrell Wymore <farrell.wymore@windriver.com>

The file types are displayed in the Outputs column in the build page.
The file types are derived from the target image filenames.

[YOCTO #5947]

Signed-off-by: Farrell Wymore <farrell.wymore@windriver.com>
---
 lib/toaster/toastergui/templates/build.html        |  6 ++++-
 lib/toaster/toastergui/templatetags/projecttags.py | 27 ++++++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/templates/build.html b/lib/toaster/toastergui/templates/build.html
index 3c9256c..f1fa70d 100644
--- a/lib/toaster/toastergui/templates/build.html
+++ b/lib/toaster/toastergui/templates/build.html
@@ -92,7 +92,11 @@
             <td class="warnings_no">{% if  build.warnings_no %}<a class="warnings_no warning" href="{% url "builddashboard" build.id %}#warnings">{{build.warnings_no}} warning{{build.warnings_no|pluralize}}</a>{%endif%}</td>
             <td class="time"><a href="{% url "buildtime" build.id %}">{{build.timespent|sectohms}}</a></td>
             <td class="log">{{build.cooker_log_path}}</td>
-            <td class="output">{% if build.outcome == 0 %}{% for t in build.target_set.all %}{% if t.is_image %}<a href="{%url "builddashboard" build.id%}#images">TODO: compute image output fstypes</a>{% endif %}{% endfor %}{% endif %}</td>
+            <td class="output">
+              {% if build.outcome == 0 %}
+              {{build|get_image_extensions}}
+              {% endif %}
+            </td>
         </tr>
 
         {% endfor %}
diff --git a/lib/toaster/toastergui/templatetags/projecttags.py b/lib/toaster/toastergui/templatetags/projecttags.py
index 857680b..60d5dd0 100644
--- a/lib/toaster/toastergui/templatetags/projecttags.py
+++ b/lib/toaster/toastergui/templatetags/projecttags.py
@@ -24,6 +24,8 @@ import re
 from django import template
 from django.utils import timezone
 from django.template.defaultfilters import filesizeformat
+from orm.models import Target_Installed_Package, Target_Image_File
+from orm.models import Build, Target, Task, Layer, Layer_Version
 
 register = template.Library()
 
@@ -188,3 +190,28 @@ def string_slice(strvar,slicevar):
     else:
         return strvar[int(first):int(last)]
 
+@register.filter
+def get_image_extensions( build ):
+    """
+    This is a simple filter that returns a list (string)
+    of extensions of the build-targets-image files. Note
+    that each build can have multiple targets and each
+    target can yield more than one image file
+    """
+    targets = Target.objects.filter( build_id = build.id );
+    comma = "";
+    extensions = "";
+    for t in targets:
+        if ( not t.is_image ):
+            continue;
+        tif = Target_Image_File.objects.filter( target_id = t.id );
+        for i in tif:
+            try:
+                ndx = i.file_name.index( "." );
+            except ValueError:
+                ndx = 0;
+            s = i.file_name[ ndx + 1 : ];
+            extensions += comma + s;
+            comma = ", ";
+    return( extensions );
+
-- 
1.8.3.2


