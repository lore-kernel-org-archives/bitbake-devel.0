Return-Path: <ddalex@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id 666716D160
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  5 Nov 2013 12:26:44 +0000 (UTC)
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 05 Nov 2013 04:26:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,535,1378882800"; d="scan'208";a="317172629"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by AZSMGA002.ch.intel.com with ESMTP; 05 Nov 2013 04:26:44 -0800
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 491B7560AE4; Tue,  5 Nov 2013 12:26:47 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  5 Nov 2013 12:26:46 +0000
Message-Id: <1383654406-15206-1-git-send-email-alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 1/1] toaster: fix target package information
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
X-List-Received-Date: Tue, 05 Nov 2013 12:26:45 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Toaster needs to record information about packages
installed on a built target image, and dependencies
between these packages.

This patch fixes a bug where the variable from the
server wasn't read correctly leading which caused
the buildhistory to not be processed correctly.

Additionally, two display issues in the package table
were fixed, issues that lead to package information
being displayed incorrectly.

    [YOCTO #5197]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py                 |  2 +-
 bitbake/lib/toaster/bldviewer/templates/package.html | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index 2ca0bd3..fbf7546 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -548,7 +548,7 @@ class BuildInfoHelper(object):
 
             MACHINE_ARCH, error = self.server.runCommand(['getVariable', 'MACHINE_ARCH'])
             TCLIBC, error = self.server.runCommand(['getVariable', 'TCLIBC'])
-            BUILDHISTORY_DIR = self.server.runCommand(['getVariable', 'BUILDHISTORY_DIR'])
+            BUILDHISTORY_DIR, error = self.server.runCommand(['getVariable', 'BUILDHISTORY_DIR'])
             BUILDHISTORY_DIR_IMAGE = "%s/images/%s/%s/%s" % (BUILDHISTORY_DIR, MACHINE_ARCH, TCLIBC, target.target)
 
             self.internal_state['packages'] = {}
diff --git a/bitbake/lib/toaster/bldviewer/templates/package.html b/bitbake/lib/toaster/bldviewer/templates/package.html
index 642fcab..c22e988 100644
--- a/bitbake/lib/toaster/bldviewer/templates/package.html
+++ b/bitbake/lib/toaster/bldviewer/templates/package.html
@@ -19,12 +19,12 @@
                 <td><a name="#{{package.name}}">{{package.name}}</a></td>
                 <td>{{package.version}}</td>
                 <td>{{package.size}}</td>
-                <td><a name="{{package.recipe.name}}.{{package.package_name}}">
-                <a href="{% url layer_versions_recipes package.recipe.layer_version_id %}#{{package.recipe.name}}">{{package.recipe.name}}</a>{{package.package_name}}</a></td>
+                <td>{%if package.recipe %}<a name="{{package.recipe.name}}.{{package.package_name}}">
+                <a href="{% url layer_versions_recipes package.recipe.layer_version_id %}#{{package.recipe.name}}">{{package.recipe.name}}</a>{{package.package_name}}</a>{%endif%}</td>
                 <td>
-            <div style="height: 3em; overflow:auto">
-                    {% for d in package.depends_on %}
-                    <a href="#{{d.name}}">{{d.name}}</a><br/>
+            <div style="height: 4em; overflow:auto">
+                    {% for d in package.tpackage_dependencies_package.all %}
+                    <a href="#{{d.name}}">{{d.depends_on.name}}</a><br/>
                     {% endfor %}
             </div>
                 </td>
-- 
1.8.3.2


