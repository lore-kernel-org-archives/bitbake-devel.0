Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1S1ZuQ-0000Jk-0d
	for bitbake-devel@lists.openembedded.org;
	Sun, 26 Feb 2012 09:56:46 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q1Q8mJIj019941
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 26 Feb 2012 00:48:19 -0800 (PST)
Received: from build-PowerEdge-T100.corp.ad.wrs.com (128.224.163.66) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.1.255.0; Sun, 26 Feb 2012 00:48:19 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sun, 26 Feb 2012 16:48:14 +0800
Message-ID: <e614d45f3058a2eb2c49077b4d8d5a3d27a9a32a.1330245845.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1330245845.git.liezhi.yang@windriver.com>
References: <cover.1330245845.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/3] V5 Fix finish_now when no running task
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Sun, 26 Feb 2012 08:56:46 -0000
Content-Type: text/plain

This patch comes from Richard, the finish_now did nothing when no
running tasks in the past, it should always stop the runqueue, fix it
now.

[YOCTO #1589]
Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/runqueue.py |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 1959007..1c3187d 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1060,6 +1060,13 @@ class RunQueueExecute:
         for pipe in self.build_pipes:
             self.build_pipes[pipe].read()
 
+        if len(self.failed_fnids) != 0:
+            self.rq.state = runQueueFailed
+            return
+
+        self.rq.state = runQueueComplete
+        return
+
     def finish(self):
         self.rq.state = runQueueCleanUp
 
-- 
1.7.4.1



