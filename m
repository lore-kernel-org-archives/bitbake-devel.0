Return-Path: <ddalex@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id F37546CB83
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:15 +0000 (UTC)
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 24 Sep 2013 09:53:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="298814639"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by AZSMGA002.ch.intel.com with ESMTP; 24 Sep 2013 09:53:13 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 5E685562CEC; Tue, 24 Sep 2013 17:53:05 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:54 +0100
Message-Id: <69c44f609772fe76c084ebcd0c1b64858a8c8445.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 85/94] bitbake: webhob: record task hash information
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:17 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We record the task hash for all queue tasks.

Displaying the task hash in the Simple interface.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py             | 5 +++++
 bitbake/lib/webhob/bldviewer/templates/task.html | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index b5c2dc0..4ffa0d9 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -324,6 +324,11 @@ class BuildInfoHelper(object):
         task_information['outcome'] = Task.OUTCOME_NA
         task_information['recipe'] = recipe
         task_information['task_name'] = event.taskname
+        try:
+            # some tasks don't come with a hash. and that's ok
+            task_information['sstate_checksum'] = event.taskhash
+        except AttributeError:
+            pass
         return task_information
 
     def _get_layer_version_for_path(self, path):
diff --git a/bitbake/lib/webhob/bldviewer/templates/task.html b/bitbake/lib/webhob/bldviewer/templates/task.html
index 65d75cb..25715fe 100644
--- a/bitbake/lib/webhob/bldviewer/templates/task.html
+++ b/bitbake/lib/webhob/bldviewer/templates/task.html
@@ -11,6 +11,7 @@
             <th>Task</th>
             <th>Recipe Version</th>
             <th>Task Type</th>
+            <th>Checksum</th>
             <th>Outcome</th>
             <th>Message</th>
             <th>Logfile</th>
@@ -36,6 +37,7 @@
                 <td>Prebuilt</td>
                 {% endif %}
 
+                <td>{{task.sstate_checksum}}</td>
                 <td>{{task.get_outcome_display}}</td>
                 <td><p>{{task.message}}</td>
                 <td><a target="_fileview" href="file:///{{task.logfile}}">{{task.logfile}}</a></td>
-- 
1.8.1.2


