Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 017C27C33D
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Jan 2019 06:51:01 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x0P6p3RF011362
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Jan 2019 22:51:03 -0800 (PST)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.408.0; Thu, 24 Jan 2019 22:51:02 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 25 Jan 2019 15:09:29 +0800
Message-ID: <070002fb5989fd3c629d06ce77d9b33d11982a18.1548400142.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1548400142.git.liezhi.yang@windriver.com>
References: <cover.1548400142.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] bitbake: cookerdata: Check duplicated BBFILE_COLLECTIONS
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
X-List-Received-Date: Fri, 25 Jan 2019 06:51:02 -0000
Content-Type: text/plain

It shouldn't work when there are duplicated BBFILE_COLLECTIONS.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/cookerdata.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
index 5df66e6..09412e2 100644
--- a/bitbake/lib/bb/cookerdata.py
+++ b/bitbake/lib/bb/cookerdata.py
@@ -391,7 +391,11 @@ class CookerDataBuilder(object):
                 bb.fatal("BBFILES_DYNAMIC entries must be of the form <collection name>:<filename pattern>, not:\n    %s" % "\n    ".join(invalid))
 
             layerseries = set((data.getVar("LAYERSERIES_CORENAMES") or "").split())
+            collections_tmp = collections[:]
             for c in collections:
+                collections_tmp.remove(c)
+                if c in collections_tmp:
+                    bb.fatal("Found duplicated BBFILE_COLLECTIONS '%s', check bblayers.conf or layer.conf to fix it." % c)
                 compat = set((data.getVar("LAYERSERIES_COMPAT_%s" % c) or "").split())
                 if compat and not (compat & layerseries):
                     bb.fatal("Layer %s is not compatible with the core layer which only supports these series: %s (layer is compatible with %s)"
-- 
2.7.4


