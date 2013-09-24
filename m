Return-Path: <ddalex@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id CFB886CB78
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:12 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 24 Sep 2013 09:53:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="382902502"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by orsmga001.jf.intel.com with ESMTP; 24 Sep 2013 09:53:13 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 63E64562D0A; Tue, 24 Sep 2013 17:53:05 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:56 +0100
Message-Id: <32fd9ea1ed40f33680693ccd88f3318f37c8b51d.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 87/94] bitbake: webhob: Clean up links in Simple UI
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:13 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch fixes 404s and 500 errors coming up on
a spidering of the UI simple interface.

Test used:  wget -r -l 6 http://localhost:8000/

For log, look up build/whbmain.log file.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/webhob/bldviewer/templates/build.html | 2 +-
 bitbake/lib/webhob/bldviewer/views.py             | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/bitbake/lib/webhob/bldviewer/templates/build.html b/bitbake/lib/webhob/bldviewer/templates/build.html
index dd0e5c0..bd7e0f3 100644
--- a/bitbake/lib/webhob/bldviewer/templates/build.html
+++ b/bitbake/lib/webhob/bldviewer/templates/build.html
@@ -27,7 +27,7 @@
             <td><a href="/simple/build/{{build.id}}/configuration/">{{build.get_outcome_display}}</a></td>
             <td>{{build.started_on}}</td>
             <td>{{build.completed_on}}</td>
-            <td>{% for t in build.target_set.all %}<a href="/simple/build/{{build.id}}/target/{{t.id}}">{{t.target}}</a><br/>{% endfor %}</td>
+            <td>{% for t in build.target_set.all %}<a href="/simple/build/{{build.id}}/target/{{t.id}}/packages/">{{t.target}}</a><br/>{% endfor %}</td>
             <td>{% if build.is_image %} <a href="/simple/build/{{build.id}}/package/">{{build.is_image}}</a>{% else %} {{build.is_image}} {% endif %}</td>
             <td>{{build.machine}}</td>
             <td>{% time_difference build.started_on build.completed_on %}</td>
diff --git a/bitbake/lib/webhob/bldviewer/views.py b/bitbake/lib/webhob/bldviewer/views.py
index 98099ee..b7bac73 100644
--- a/bitbake/lib/webhob/bldviewer/views.py
+++ b/bitbake/lib/webhob/bldviewer/views.py
@@ -52,7 +52,6 @@ def tpackage(request, build_id, target_id):
     template = 'package.html'
 
     packages = Target_Package.objects.filter(target=target_id)
-    package_depends = Target_Package_Dependency.objects.filter(package__in=packages)
 
     context = {'build' : Build.objects.filter(pk=build_id)[0],'packages': packages}
 
-- 
1.8.1.2


