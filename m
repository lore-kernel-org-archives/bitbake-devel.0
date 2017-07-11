Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id CB17F77FFE
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Jul 2017 10:27:49 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id v6BARntr010989
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Jul 2017 03:27:50 -0700 (PDT)
Received: from ala-blade48.wrs.com (147.11.105.68) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.294.0;
	Tue, 11 Jul 2017 03:27:49 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 11 Jul 2017 03:27:46 -0700
Message-ID: <868892a60e4f6888b29455b40de5b16d6cc7ec9c.1499768495.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1499768495.git.liezhi.yang@windriver.com>
References: <cover.1499768495.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [RFC PATCH 1/3] bitbake: knotty.py: add MonitorDiskEvent and RecipeTaskPreProcess
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
X-List-Received-Date: Tue, 11 Jul 2017 10:27:49 -0000
Content-Type: text/plain

Sometimes, we may see the errors:
$ bitbake --observe-only
ERROR: Unknown event: <bb.event.MonitorDiskEvent object at 0x7fbd2e0a8438>
ERROR: Unknown event: <bb.event.RecipeTaskPreProcess object at 0x7fdc6b7e7b00>

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/ui/knotty.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 11afb3e7441..71ec168fa6c 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -667,11 +667,13 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                                   bb.event.MultiConfigParsed,
                                   bb.event.RecipeParsed,
                                   bb.event.RecipePreFinalise,
+                                  bb.event.RecipeTaskPreProcess,
                                   bb.runqueue.runQueueEvent,
                                   bb.event.OperationStarted,
                                   bb.event.OperationCompleted,
                                   bb.event.OperationProgress,
                                   bb.event.DiskFull,
+                                  bb.event.MonitorDiskEvent,
                                   bb.event.HeartbeatEvent,
                                   bb.build.TaskProgress)):
                 continue
-- 
2.11.0


