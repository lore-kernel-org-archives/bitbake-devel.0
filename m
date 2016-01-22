Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 150DD731FC
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Jan 2016 08:53:20 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id u0M8rHi2013578
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Jan 2016 00:53:18 -0800 (PST)
Received: from ala-blade47.wrs.com (147.11.105.67) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.248.2;
	Fri, 22 Jan 2016 00:53:17 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 22 Jan 2016 00:53:16 -0800
Message-ID: <97c47912af0bdb532c78e9eac10f412524f4af87.1453452762.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1453452762.git.liezhi.yang@windriver.com>
References: <cover.1453452762.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] taskdata.py: add RuntimeProviders to close matches
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
X-List-Received-Date: Fri, 22 Jan 2016 08:53:21 -0000
Content-Type: text/plain

This is useful for newbie, for example:
$ bitbake rpm-build
ERROR: Nothing PROVIDES 'rpm-build'. Close matches:
  pm-utils
  rpm RPROVIDES rpm-build

[YOCTO #8881]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/taskdata.py |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/taskdata.py b/bitbake/lib/bb/taskdata.py
index b083870..39c899e 100644
--- a/bitbake/lib/bb/taskdata.py
+++ b/bitbake/lib/bb/taskdata.py
@@ -429,7 +429,14 @@ class TaskData:
             return
 
         if not item in dataCache.providers:
-            bb.event.fire(bb.event.NoProvider(item, dependees=self.get_dependees_str(item), reasons=self.get_reasons(item), close_matches=self.get_close_matches(item, dataCache.providers.keys())), cfgData)
+            close_matches = self.get_close_matches(item, dataCache.providers.keys())
+            # Is it in RuntimeProviders ?
+            all_p = bb.providers.getRuntimeProviders(dataCache, item)
+            for fn in all_p:
+                new = dataCache.pkg_fn[fn] + " RPROVIDES " + item
+                if new not in close_matches:
+                    close_matches.append(new)
+            bb.event.fire(bb.event.NoProvider(item, dependees=self.get_dependees_str(item), reasons=self.get_reasons(item), close_matches=close_matches), cfgData)
             raise bb.providers.NoProvider(item)
 
         if self.have_build_target(item):
-- 
1.7.9.5


