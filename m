Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 7375C71C7B
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Jan 2017 16:13:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v0JGDC2O002522; Thu, 19 Jan 2017 16:13:30 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Bv5H68PH4Pdf; Thu, 19 Jan 2017 16:13:30 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v0JGDQ0c002780
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 19 Jan 2017 16:13:27 GMT
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1cUFL4-0000mr-D7; Thu, 19 Jan 2017 16:13:26 +0000
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 19 Jan 2017 16:13:23 +0000
Message-Id: <1484842404-2960-4-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1484842404-2960-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1484842404-2960-1-git-send-email-richard.purdie@linuxfoundation.org>
Subject: [PATCH 4/5] cooker: Add BB_LIMITEDDEPS support
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
X-List-Received-Date: Thu, 19 Jan 2017 16:13:31 -0000

When we're running with bitbake -b, BB_TASKDEPDATA is incorrect and limited.
We really need a way to know this from the metadata and this new variable
provides this in worker context. This means existing code can stop having
to guess.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-worker   | 2 ++
 lib/bb/cooker.py     | 1 +
 lib/bb/cookerdata.py | 1 +
 3 files changed, 4 insertions(+)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 5010bad..ee2d622 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -222,6 +222,8 @@ def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, append
                 the_data = databuilder.mcdata[mc]
                 the_data.setVar("BB_WORKERCONTEXT", "1")
                 the_data.setVar("BB_TASKDEPDATA", taskdepdata)
+                if cfg.limited_deps:
+                    the_data.setVar("BB_LIMITEDDEPS", "1")
                 the_data.setVar("BUILDNAME", workerdata["buildname"])
                 the_data.setVar("DATE", workerdata["date"])
                 the_data.setVar("TIME", workerdata["time"])
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index a7b9745..80007c5 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1409,6 +1409,7 @@ class BBCooker:
         item = info_array[0].pn
         self.recipecaches[mc].ignored_dependencies = set()
         self.recipecaches[mc].bbfile_priority[fn] = 1
+        self.configuration.limited_deps = True
 
         # Remove external dependencies
         self.recipecaches[mc].task_deps[fn]['depends'] = {}
diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index d9eab56..53f4587 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -147,6 +147,7 @@ class CookerConfiguration(object):
         self.interface = []
         self.writeeventlog = False
         self.server_only = False
+        self.limited_deps = False
 
         self.env = {}
 
-- 
2.7.4


