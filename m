Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 9F8627E819
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  4 Jul 2019 03:48:48 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x643mT2I019892
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 3 Jul 2019 20:48:39 -0700
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.439.0; Wed, 3 Jul 2019 20:48:18 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 4 Jul 2019 12:12:37 +0800
Message-ID: <94e192f582faa200b0384945c1986b13bb9c3cfd.1562213458.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1562213458.git.liezhi.yang@windriver.com>
References: <cover.1562213458.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] cache: Create a symlink for current cachefile
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
X-List-Received-Date: Thu, 04 Jul 2019 03:48:48 -0000
Content-Type: text/plain

So that people or other tools can easily know which one is being used, just
like what we did for run.do_task and log.do_task, otherwise, we have no way
to know it. I usually use "ls -t", but it isn't reliable since the one which
is being used may not the latest one.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/cache.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index 5fb2f17..c813d6a 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -399,6 +399,14 @@ class Cache(NoCache):
         else:
             logger.debug(1, "Cache file %s not found, building..." % self.cachefile)
 
+        symlink = os.path.join(self.cachedir, "bb_cache.dat")
+        if os.path.exists(symlink):
+            bb.utils.remove(symlink)
+        try:
+            os.symlink(os.path.basename(self.cachefile), symlink)
+        except OSError:
+            pass
+
     def load_cachefile(self):
         cachesize = 0
         previous_progress = 0
-- 
2.7.4


