Return-Path: <ddalex@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 2DBD26CAFC
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:10 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 24 Sep 2013 09:50:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="408442581"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by orsmga002.jf.intel.com with ESMTP; 24 Sep 2013 09:53:11 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 10728562587; Tue, 24 Sep 2013 17:53:05 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:25 +0100
Message-Id: <f42ec76b022a796ad68dfbd32face301d2e12908.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 56/94] bitbake: webhob: add simple visualisation for build errors
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:10 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Adding Simple web error viewing in the builds page.
Now the error/warning column will contain the actual
content of the error.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/webhob/bldviewer/templates/build.html | 4 ++--
 bitbake/lib/webhob/bldviewer/views.py             | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/webhob/bldviewer/templates/build.html b/bitbake/lib/webhob/bldviewer/templates/build.html
index 15d88a0..bef84a9 100644
--- a/bitbake/lib/webhob/bldviewer/templates/build.html
+++ b/bitbake/lib/webhob/bldviewer/templates/build.html
@@ -33,8 +33,8 @@
             <td>{% if build.is_image %} <a href="/simple/build/{{build.id}}/package/">{{build.is_image}}</a>{% else %} {{build.is_image}} {% endif %}</td>
             <td>{{build.machine.name}}</td>
             <td>{% time_difference build.started_on build.completed_on %}</td>
-            <td>{{build.errors_no}}</td>
-            <td>{{build.warnings_no}}</td>
+            <td>{% if  build.errors_no %}{% for error in logs %}{% if error.build == build %}{% if error.level == 2 %}<p>{{error.message}}</p>{% endif %}{% endif %}{% endfor %}{% else %}None{% endif %}</td>
+            <td>{% if  build.warnings_no %}{% for warning in logs %}{% if warning.build == build %}{% if warning.level == 1 %}<p>{{warning.message}}</p>{% endif %}{% endif %}{% endfor %}{% else %}None{% endif %}</td>
             <td>{{build.image_fstypes}}</td>
             <td>{{build.cooker_log_path}}</td>
             <td>{{build.bitbake_version}}</td>
diff --git a/bitbake/lib/webhob/bldviewer/views.py b/bitbake/lib/webhob/bldviewer/views.py
index 99e4b99..8535963 100644
--- a/bitbake/lib/webhob/bldviewer/views.py
+++ b/bitbake/lib/webhob/bldviewer/views.py
@@ -2,14 +2,16 @@ import operator
 
 from django.db.models import Q
 from django.shortcuts import render
-from orm.models import Build, Task, Layer, Layer_Version, Task_Dependency, Recipe, Package, Package_Dependency
+from orm.models import Build, Task, Layer, Layer_Version, Recipe, Package, LogMessage
+from orm.models import Task_Dependency, Package_Dependency
 
 
 def build(request):
     template = 'build.html'
     build_info = Build.objects.all()
+    logs = LogMessage.objects.all()
 
-    context = {'builds': build_info}
+    context = {'builds': build_info, 'logs': logs }
 
     return render(request, template, context)
 
-- 
1.8.1.2


