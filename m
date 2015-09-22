Return-Path: <elliot.smith@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 8B44173CF2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Sep 2015 09:35:04 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 22 Sep 2015 02:35:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,572,1437462000"; d="scan'208";a="810261458"
Received: from martinbu-mobl.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.21.229])
	by fmsmga002.fm.intel.com with ESMTP; 22 Sep 2015 02:35:05 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 22 Sep 2015 10:34:52 +0100
Message-Id: <adee73e311b4f4c21718045b2720affb5de61342.1442914166.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1442914166.git.elliot.smith@intel.com>
References: <cover.1442914166.git.elliot.smith@intel.com>
Subject: [PATCH 1/4] toaster: store task name in Target objects
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
X-List-Received-Date: Tue, 22 Sep 2015 09:35:06 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Information about a task is not stored in Target objects.
This makes it impossible to correctly operate with the builds
where task is specified.

Storing taks name is an enabler for other fixes in UI and backend
related to restarting builds.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/toaster/bldcontrol/management/commands/runbuilds.py | 2 +-
 lib/toaster/orm/models.py                               | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/bldcontrol/management/commands/runbuilds.py b/lib/toaster/bldcontrol/management/commands/runbuilds.py
index 718e144..5243a50 100644
--- a/lib/toaster/bldcontrol/management/commands/runbuilds.py
+++ b/lib/toaster/bldcontrol/management/commands/runbuilds.py
@@ -118,7 +118,7 @@ class Command(NoArgsCommand):
             br.save()
             # transpose target information
             for brtarget in br.brtarget_set.all():
-                Target.objects.create(build = br.build, target= brtarget.target)
+                Target.objects.create(build=br.build, target=brtarget.target, task=brtarget.task)
             # transpose the launch errors in ToasterExceptions
             for brerror in br.brerror_set.all():
                 LogMessage.objects.create(build = br.build, level = LogMessage.EXCEPTION, message = brerror.errmsg)
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index e4d2e87..883ecf4 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -270,7 +270,7 @@ class Project(models.Model):
                                 )
             for t in self.projecttarget_set.all():
                 BRTarget.objects.create(req = br, target = t.target, task = t.task)
-                Target.objects.create(build = br.build, target = t.target)
+                Target.objects.create(build = br.build, target = t.target, task = t.task)
 
             for v in self.projectvariable_set.all():
                 BRVariable.objects.create(req = br, name = v.name, value = v.value)
-- 
1.9.3

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


