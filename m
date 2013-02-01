Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1U1CcM-0007KY-0K
	for bitbake-devel@lists.openembedded.org;
	Fri, 01 Feb 2013 10:09:07 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id r118rL3u015060
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 1 Feb 2013 00:53:21 -0800 (PST)
Received: from pek-usp-3.wrs.com (128.224.163.124) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.318.4;
	Fri, 1 Feb 2013 00:53:21 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 1 Feb 2013 16:56:45 +0800
Message-ID: <e0003fc8f4d0046be8813fd3b80cdc06f0933d49.1359697886.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <cover.1359697886.git.liezhi.yang@windriver.com>
References: <cover.1359697886.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Cc: Zhenfeng.Zhao@windriver.com
Subject: [PATCH 1/1] knotty.py: fix unknown event bb.event.DiskFull
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
X-List-Received-Date: Fri, 01 Feb 2013 09:09:14 -0000
Content-Type: text/plain

There is an error:

ERROR: No new tasks can be excuted since the disk space monitor action
is "STOPTASKS"!
ERROR: Unknown event: <bb.event.DiskFull object at 0x2ab6310>

This is because we don't handle the event bb.event.DiskFull in
knotty.py, we don't want the knotty to do anything here since we have
done everything in monitordisk.py, so just ignore this event would fix
the problem.

[YOCTO #3523]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/ui/knotty.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index a2983ca..6834b83 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -453,7 +453,8 @@ def main(server, eventHandler, tf = TerminalFilter):
                                   bb.runqueue.runQueueExitWait,
                                   bb.event.OperationStarted,
                                   bb.event.OperationCompleted,
-                                  bb.event.OperationProgress)):
+                                  bb.event.OperationProgress,
+                                  bb.event.DiskFull)):
                 continue
 
             logger.error("Unknown event: %s", event)
-- 
1.7.11.2



