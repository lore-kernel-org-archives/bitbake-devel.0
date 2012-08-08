Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Peter.Seebach@windriver.com>) id 1SzFiv-0005Qu-7i
	for bitbake-devel@lists.openembedded.org;
	Thu, 09 Aug 2012 01:31:33 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q78NJiwf002972
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 8 Aug 2012 16:19:44 -0700 (PDT)
Received: from localhost.localdomain (172.25.34.64) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.309.2;
	Wed, 8 Aug 2012 16:19:44 -0700
From: Peter Seebach <peter.seebach@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 8 Aug 2012 18:19:42 -0500
Message-ID: <9005aeb8b41113f05121842055434fdeeda8c63c.1344467794.git.peter.seebach@windriver.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1344467794.git.peter.seebach@windriver.com>
References: <cover.1344467794.git.peter.seebach@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] cooker.py: Remove explicit build targets from the ignored list
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
X-List-Received-Date: Wed, 08 Aug 2012 23:31:33 -0000
Content-Type: text/plain

If something is in ASSUMED_PROVIDED, and a user tries to build it
explicitly, Nothing Happens. Bitbake just says it ran 0 out of 0
tasks. No diagnostics or explanations are offered.

In practice, the right thing is probably to assume that explicit
targets are intentional. So far as I can tell, cooker.buildTargets
is called only from the command line or from command.py, and both
cases seem to be explicit user actions.

Signed-off-by: Peter Seebach <peter.seebach@windriver.com>
---
 lib/bb/cooker.py |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 23fffc9..25d36d0 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1129,6 +1129,11 @@ class BBCooker:
         universe = ('universe' in targets)
         targets = self.checkPackages(targets)
 
+        # Explicitly disignore things that have been requested.
+        for target in targets:
+            if target in self.status.ignored_dependencies:
+                self.status.ignored_dependencies.remove(target)
+
         def buildTargetsIdle(server, rq, abort):
             if abort or self.state == state.stop:
                 rq.finish_runqueue(True)
-- 
1.7.0.4



