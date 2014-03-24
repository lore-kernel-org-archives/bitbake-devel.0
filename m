Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f178.google.com (mail-wi0-f178.google.com
	[209.85.212.178])
	by mail.openembedded.org (Postfix) with ESMTP id CF7A86FB6D
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Mar 2014 18:37:45 +0000 (UTC)
Received: by mail-wi0-f178.google.com with SMTP id bs8so2711895wib.17
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Mar 2014 11:37:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=t6QxDBM/A+U1v6kB2XPhd8iRRYxPvTR5JYQ8LBMTu2E=;
	b=QM/CKXoPV3iNoB2l1t9X90jFBEo/Y0JTdVAWSHuLu/VqmpsyEv+Qvr329eXlldDcq6
	tBUYUcXlDM2nLuv+m0/1tVOxTNARXmx/JZsexLnW83apyiAOtwszEipWBpbb5WjMNf7Q
	7OYJOcG1mGgBokHnZdLTT0JgBFBFGFPEaPwfVwNR6us9EIcDOygN4bAbEmbq5RQRiM8G
	VhYi7ag4YsVbPdYCqauYqQk0b2lc+JfxEO6UsFLkJcW4828YUU8MZoIGw8qW8WW58RzA
	t/tntWoVoQ3OPU+WWFfyX/mbGoOy8ntZat8xPA5gN69xabKx6pOyo+wdicOZAlNDJ8yM
	xh6A==
X-Gm-Message-State: ALoCoQnCXAYl0Zheggkss9GBNMGtpDGqm5KhICAsSv9vCZG1ef7zd7FMHlXUv2WtOD33kDC8co6c
X-Received: by 10.180.72.230 with SMTP id g6mr18148099wiv.1.1395686266328;
	Mon, 24 Mar 2014 11:37:46 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id fs8sm41451470wib.8.2014.03.24.11.37.44
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Mon, 24 Mar 2014 11:37:45 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id CE0F5562BD5; Mon, 24 Mar 2014 18:37:29 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 24 Mar 2014 18:37:28 +0000
Message-Id: <9dd53bd4355148916a89cf672b6c5db5f6b1ae35.1395686148.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <7e59b6b1cb44de00c512facece5ede96375a411f.1395686148.git.alexandru.damian@intel.com>
References: <7e59b6b1cb44de00c512facece5ede96375a411f.1395686148.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1395686148.git.alexandru.damian@intel.com>
References: <cover.1395686148.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 18/18] toaster: replace package dependency tag w/ view queries
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
X-List-Received-Date: Mon, 24 Mar 2014 18:37:46 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch moves the queries for package dependencies from the
project tags to the views. This is done to bring the code inline
with the Django philosophy of making all data queries in views.py

This change has no performance implication.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/templates/target.html       |  4 ++--
 lib/toaster/toastergui/templatetags/projecttags.py | 14 --------------
 lib/toaster/toastergui/views.py                    |  6 ++++++
 3 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/lib/toaster/toastergui/templates/target.html b/lib/toaster/toastergui/templates/target.html
index 4512898..5396b17 100644
--- a/lib/toaster/toastergui/templates/target.html
+++ b/lib/toaster/toastergui/templates/target.html
@@ -79,7 +79,7 @@
             {{package.license}}
         </td>
         <td class="depends">
-            {% with deps=package|runtime_dependencies:target.id %}
+            {% with deps=package.runtime_dependencies %}
             {% with deps_count=deps|length %}
             {% if deps_count > 0 %}
             <a class="btn"
@@ -96,7 +96,7 @@
             {% endwith %}
         </td>
         <td class="brought_in_by">
-            {% with rdeps=package|reverse_runtime_dependencies:target.id %}
+            {% with rdeps=package.reverse_runtime_dependencies %}
             {% with rdeps_count=rdeps|length %}
             {% if rdeps_count > 0 %}
             <a class="btn"
diff --git a/lib/toaster/toastergui/templatetags/projecttags.py b/lib/toaster/toastergui/templatetags/projecttags.py
index 39e92ce..12c2468 100644
--- a/lib/toaster/toastergui/templatetags/projecttags.py
+++ b/lib/toaster/toastergui/templatetags/projecttags.py
@@ -217,20 +217,6 @@ def filtered_packageversion(version, revision):
     """
     return "" if (not version or version == "") else version if (not revision or revision == "") else version + "-" + revision
         
-from django.db import models
-from orm.models import Package
-@register.filter
-def runtime_dependencies(package_object, targetid):
-    """ Return a queryset that lists the packages this package depends on
-    """
-    return package_object.package_dependencies_source.filter(target_id__exact=targetid, dep_type__in={'1'})
-
-@register.filter
-def reverse_runtime_dependencies(package_object, targetid):
-    """ Return a queryset that lists the packages depending on this package
-    """
-    return package_object.package_dependencies_target.filter(target_id__exact = targetid,dep_type__in={'1'})
-
 @register.filter
 def filter_sizeovertotal(package_object, total_size):
     """ Return the % size of the package over the total size argument
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 732be8f..e523c31 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -429,6 +429,12 @@ def target(request, build_id, target_id):
     packages_sum =  queryset.aggregate(Sum('installed_size'))
     queryset = _get_queryset(Package, queryset, filter_string, search_term, ordering_string)
     packages = _build_page_range(Paginator(queryset, request.GET.get('count', 25)),request.GET.get('page', 1))
+
+    # bring in package dependencies
+    for p in packages.object_list:
+        p.runtime_dependencies = p.package_dependencies_source.filter(target_id = target_id, dep_type=Package_Dependency.TYPE_TRDEPENDS)
+        p.reverse_runtime_dependencies = p.package_dependencies_target.filter(target_id = target_id, dep_type=Package_Dependency.TYPE_TRDEPENDS)
+
     context = { 'build': Build.objects.filter(pk=build_id)[0],
                 'target': Target.objects.filter(pk=target_id)[0],
                 'objects': packages,
-- 
1.8.3.2


