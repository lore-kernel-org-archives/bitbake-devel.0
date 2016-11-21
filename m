Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id B32E56FF73
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Nov 2016 14:30:31 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id uALEUVO7025563
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Nov 2016 06:30:32 -0800 (PST)
Received: from ala-blade47.wrs.com (147.11.105.67) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.294.0;
	Mon, 21 Nov 2016 06:30:30 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 21 Nov 2016 06:30:29 -0800
Message-ID: <fc76e8587c53ee68f9ddcb716064b020adea56ee.1479738455.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <cover.1479738455.git.liezhi.yang@windriver.com>
References: <cover.1479738455.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] cooker.py: runqueue: fix for "bitbake -g world"
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
X-List-Received-Date: Mon, 21 Nov 2016 14:30:31 -0000
Content-Type: text/plain

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Fixed:
$ bitbake -g world

The pn-buildlist and *.dot are null, it was null, this was because
generateTaskDepTreeData() didn't add the prefix "do_" to default task
"build".

[YOCTO #10651]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/cooker.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index c08af45..4f034c1 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -715,6 +715,9 @@ class BBCooker:
         Create a dependency graph of pkgs_to_build including reverse dependency
         information.
         """
+        if not task.startswith("do_"):
+            task = "do_%s" % task
+
         runlist, taskdata = self.prepareTreeData(pkgs_to_build, task)
         rq = bb.runqueue.RunQueue(self, self.data, self.recipecaches, taskdata, runlist)
         rq.rqdata.prepare()
-- 
2.10.2


