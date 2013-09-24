Return-Path: <ddalex@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id EFD8C6CB7B
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:12 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 24 Sep 2013 09:53:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="406511895"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by fmsmga002.fm.intel.com with ESMTP; 24 Sep 2013 09:53:11 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 1AB745627C6; Tue, 24 Sep 2013 17:53:05 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:29 +0100
Message-Id: <3872a5f90777ad18fcc22ffdebd821d5d4eea456.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 60/94] bitbake: dsi: small bugfixes in data collection
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:14 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

A couple of bugfixes in the data collection:
- cache the TMPDIR since it's not gonna change during the build
- CommandCompleted can be issues outside of a build,  so
update the build only if we're running one

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index 232eea8..6f4789c 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -161,6 +161,7 @@ class BuildInfoHelper(object):
         self.server = server
         self.orm_wrapper = ORMWrapper()
         self.has_build_history = has_build_history
+        self.tmp_dir = self.server.runCommand(["getVariable", "TMPDIR"])[0]
 
     def _configure_django(self):
         # Add webhob to sys path for importing modules
@@ -298,13 +299,12 @@ class BuildInfoHelper(object):
     def _get_path_information(self, task_object):
         build_stats_format = "{tmpdir}/buildstats/{target}-{machine}/{buildname}/{package}/"
 
-        tmp_dir = self.server.runCommand(["getVariable", "TMPDIR"])[0]
         target = self.internal_state['target']
         machine = self.internal_state['build'].machine.name
         buildname = self.internal_state['build'].build_name
         package = task_object.recipe.name + "-" + task_object.recipe.version.strip(":")
 
-        build_stats_path = build_stats_format.format(tmpdir=tmp_dir, target=target,
+        build_stats_path = build_stats_format.format(tmpdir=self.tmp_dir, target=target,
                                                      machine=machine, buildname=buildname,
                                                      package=package)
 
@@ -373,7 +373,8 @@ class BuildInfoHelper(object):
 
 
     def update_build_information(self, event, errors, warnings, taskfailures):
-        self.orm_wrapper.update_build_object(self.internal_state['build'], errors, warnings, taskfailures)
+        if 'build' in self.internal_state:
+            self.orm_wrapper.update_build_object(self.internal_state['build'], errors, warnings, taskfailures)
 
     def store_started_task(self, event):
         identifier = re.split(':', event.taskfile)[-1] + event.taskname
-- 
1.8.1.2


