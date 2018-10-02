Return-Path: <mark.hatle@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id BCCFE795DA
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  2 Oct 2018 01:37:20 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w921bL1f003148
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 1 Oct 2018 18:37:21 -0700 (PDT)
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.408.0;
	Mon, 1 Oct 2018 18:37:20 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 1 Oct 2018 21:37:19 -0400
Message-ID: <20181002013719.97783-1-mark.hatle@windriver.com>
X-Mailer: git-send-email 2.16.0.rc2
MIME-Version: 1.0
Subject: [PATCH] bitbake-worker: Add DryRun event
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
X-List-Received-Date: Tue, 02 Oct 2018 01:37:20 -0000
Content-Type: text/plain

There may be actions that a user wants to take, but the information is
only available during task execution.  Using the DryRun event you can prevent
the actual task execution, but get access to the associated data stores.

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 bin/bitbake-worker | 2 ++
 lib/bb/event.py    | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index e925054b..e27fe7ac 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -268,6 +268,8 @@ def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, append
                 os._exit(1)
             try:
                 if dry_run:
+                    localdata = bb.build._task_data(fn, taskname, the_data)
+                    bb.event.fire(bb.event.DryRun(), localdata)
                     return 0
                 return bb.build.exec_task(fn, taskname, the_data, cfg.profile)
             except:
diff --git a/lib/bb/event.py b/lib/bb/event.py
index 5b1b094a..c03541a1 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -832,3 +832,8 @@ class FindSigInfoResult(Event):
     def __init__(self, result):
         Event.__init__(self)
         self.result = result
+
+class DryRun(Event):
+    """
+    Event to fire during a dry run
+    """
-- 
2.16.0.rc2


