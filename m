Return-Path: <brian.avery@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id C1CA5731BC
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Jul 2016 22:53:55 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 12 Jul 2016 15:53:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,354,1464678000"; d="scan'208";a="1015672955"
Received: from bavery-ws-desk.jf.intel.com ([10.7.201.28])
	by orsmga002.jf.intel.com with ESMTP; 12 Jul 2016 15:53:44 -0700
From: bavery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 12 Jul 2016 15:54:47 -0700
Message-Id: <77a63c0acf0c0df17e603dbe1983b34845c1a1f9.1468363530.git.brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <4551b56f132497c055f39567946a5d3be347d770.1468363530.git.brian.avery@intel.com>
References: <4551b56f132497c055f39567946a5d3be347d770.1468363530.git.brian.avery@intel.com>
In-Reply-To: <cover.1468363530.git.brian.avery@intel.com>
References: <cover.1468363530.git.brian.avery@intel.com>
Cc: bavery <brian.avery@intel.com>
Subject: [PATCH 06/17] buildinfohelper: fix retrieval of targets
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
X-List-Received-Date: Tue, 12 Jul 2016 22:53:56 -0000

From: Elliot Smith <elliot.smith@intel.com>

When buildinfohelper records the targets for a build, it looks
up any existing targets for a build and creates them if they
are not present. This is because in the case of Toaster-triggered
builds, the Target objects have already been created (inside
triggerBuild()) and don't need to be recreated; but in the case
of cli builds, the Target objects have to be created by
buildinfohelper.

The issue is that the code for retrieving an existing target for
a build only looks for Targets with a matching target and build,
e.g. Targets for build X with target "core-image-minimal". But it
is perfectly legitimate to call bitbake with a command like
"bitbake core-image-minimal:do_populate_sdk
core-image-minimal:do_populate_sdk_ext". In such a case, the
code which looks for matching targets finds two objects, as it
doesn't filter by task.

Add the task into the filter for the Target so that only one
Target object is be returned. Note that a command
line like "bitbake recipe:task recipe:task" will still cause an
error as bitbake doesn't de-duplicate the command line arguments
and will run the recipe:task combination twice.

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: bavery <brian.avery@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index a5b2237..e1b59c3 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -201,6 +201,10 @@ class ORMWrapper(object):
 
     @staticmethod
     def get_or_create_targets(target_info):
+        """
+        NB get_or_create() is used here because for Toaster-triggered builds,
+        we already created the targets when the build was triggered.
+        """
         result = []
         for target in target_info['targets']:
             task = ''
@@ -210,13 +214,10 @@ class ORMWrapper(object):
                 task = task[3:]
             if task == 'build':
                 task = ''
-            obj, created = Target.objects.get_or_create(build=target_info['build'],
-                                                        target=target)
-            if created:
-                obj.is_image = False
-                if task:
-                    obj.task = task
-                obj.save()
+
+            obj, _ = Target.objects.get_or_create(build=target_info['build'],
+                                                  target=target,
+                                                  task=task)
             result.append(obj)
         return result
 
-- 
1.9.1


