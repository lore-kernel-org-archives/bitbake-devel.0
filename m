Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 340416C0ED
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Mar 2019 07:51:51 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x2P7pqnD026289
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Mar 2019 00:51:52 -0700 (PDT)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.439.0; Mon, 25 Mar 2019 00:51:51 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 25 Mar 2019 16:10:58 +0800
Message-ID: <1a8af9bf38bd4401ca71c076d14e5f74e589f888.1553501143.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1553501143.git.liezhi.yang@windriver.com>
References: <cover.1553501143.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 2/2 v2] fetch2: Use bb.utils.to_boolean() for BB_NO_NETWORK
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
X-List-Received-Date: Mon, 25 Mar 2019 07:51:51 -0000
Content-Type: text/plain

Make it consistent with BB_FETCH_PREMIRRORONLY.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 6445184..8fecc80 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -898,7 +898,7 @@ def check_network_access(d, info, url):
     log remote network access, and error if BB_NO_NETWORK is set or the given
     URI is untrusted
     """
-    if d.getVar("BB_NO_NETWORK") == "1":
+    if bb.utils.to_boolean(d.getVar("BB_NO_NETWORK")):
         raise NetworkAccess(url, info)
     elif not trusted_network(d, url):
         raise UntrustedUrl(url, info)
@@ -1098,7 +1098,7 @@ def trusted_network(d, url):
     BB_ALLOWED_NETWORKS is set globally or for a specific recipe.
     Note: modifies SRC_URI & mirrors.
     """
-    if d.getVar('BB_NO_NETWORK') == "1":
+    if bb.utils.to_boolean(d.getVar("BB_NO_NETWORK")):
         return True
 
     pkgname = d.expand(d.getVar('PN', False))
-- 
2.7.4


