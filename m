Return-Path: <mark.hatle@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 9C7836A39B
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 29 May 2013 03:48:48 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id r4T3mpX0001254
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 May 2013 20:48:51 -0700 (PDT)
Received: from msp-mhatle-lx2.wrs.com (172.25.34.61) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server
	(TLS) id 14.2.342.3; Tue, 28 May 2013 20:48:49 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 28 May 2013 22:54:58 -0500
Message-ID: <1369799698-1417-1-git-send-email-mark.hatle@windriver.com>
X-Mailer: git-send-email 1.8.1.2.545.g2f19ada
MIME-Version: 1.0
X-Originating-IP: [172.25.34.61]
Subject: [PATCH] cooker.py: Remove explicit build targets from the ignored list
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 29 May 2013 03:48:48 -0000
Content-Type: text/plain

From: Peter Seebach <peter.seebach@windriver.com>

If something is in ASSUMED_PROVIDED, and a user tries to build it
explicitly, Nothing Happens. Bitbake just says it ran 0 out of 0
tasks. No diagnostics or explanations are offered.

In practice, the right thing is probably to assume that explicit
targets are intentional. So far as I can tell, cooker.buildTargets
is called only from the command line or from command.py, and both
cases seem to be explicit user actions.

Signed-off-by: Peter Seebach <peter.seebach@windriver.com>
Signed-off-by: Jeff Polk <jeff.polk@windriver.com>

Rename 'status' to 'recipecache' to match recent changes.

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 lib/bb/cooker.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 2ae3e9d..8f0e90c 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1067,6 +1067,11 @@ class BBCooker:
         universe = ('universe' in targets)
         targets = self.checkPackages(targets)
 
+        # Explicitly disignore things that have been requested.
+        for target in targets:
+            if target in self.recipecache.ignored_dependencies:
+                self.recipecache.ignored_dependencies.remove(target)
+
         def buildTargetsIdle(server, rq, abort):
             if abort or self.state == state.stop:
                 rq.finish_runqueue(True)
-- 
1.8.1.2.545.g2f19ada


