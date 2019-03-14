Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 14D3C7C3EA
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Mar 2019 09:09:38 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x2E99ebn016278
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Mar 2019 02:09:40 -0700 (PDT)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.439.0; Thu, 14 Mar 2019 02:09:39 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 14 Mar 2019 17:28:21 +0800
Message-ID: <d73ce5c9d372d09ff28654f55640611fe0b36e3c.1552555629.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1552555629.git.liezhi.yang@windriver.com>
References: <cover.1552555629.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 5/5] fetch2: Add gitsm's function process_submodules()
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
X-List-Received-Date: Thu, 14 Mar 2019 09:09:39 -0000
Content-Type: text/plain

So that bbclass can call it as fetcher.process_submodules(), otherwise, the
bbclass has to handle submodules itself.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 64d7526..78bea1f 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -1807,6 +1807,31 @@ class Fetch(object):
             if ud.lockfile:
                 bb.utils.unlockfile(lf)
 
+    def process_submodules(self, ud, workdir, function, urls=None):
+        if not urls:
+            urls = self.urls
+
+        for url in urls:
+            if url not in self.ud:
+                self.ud[url] = FetchData(url, d)
+            ud = self.ud[url]
+            ud.setup_localpath(self.d)
+
+            if not ud.localfile and ud.localpath is None:
+                continue
+
+
+            if ud.lockfile:
+                lf = bb.utils.lockfile(ud.lockfile)
+
+            ud.method.process_submodules(ud, workdir, function, self.d)
+            if ud.donestamp:
+                bb.utils.remove(ud.donestamp)
+
+            if ud.lockfile:
+                bb.utils.unlockfile(lf)
+
+
 class FetchConnectionCache(object):
     """
         A class which represents an container for socket connections.
-- 
2.7.4


