Return-Path: <Awais_Belal@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
	by mail.openembedded.org (Postfix) with ESMTP id 7790F6AC37
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Dec 2015 18:57:31 +0000 (UTC)
Received: from nat-ies.mentorg.com ([192.94.31.2]
	helo=SVR-IES-FEM-01.mgc.mentorg.com)
	by relay1.mentorg.com with esmtp 
	id 1a76PD-0003eO-JS from Awais_Belal@mentor.com 
	for bitbake-devel@lists.openembedded.org;
	Thu, 10 Dec 2015 10:57:31 -0800
Received: from awais-Precision-M4700.world.mentorg.com (137.202.0.76) by
	SVR-IES-FEM-01.mgc.mentorg.com (137.202.0.104) with Microsoft SMTP
	Server id 14.3.224.2; Thu, 10 Dec 2015 18:57:29 +0000
From: Awais Belal <awais_belal@mentor.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 10 Dec 2015 23:57:23 +0500
Message-ID: <1449773843-23411-1-git-send-email-awais_belal@mentor.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Subject: [PATCH] bitbake: fetch: use orig localpath when calling orig method
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
X-List-Received-Date: Thu, 10 Dec 2015 18:57:33 -0000
Content-Type: text/plain

From: Christopher Larson <chris_larson@mentor.com>

When a mirror tarball is fetched, the original fetch method is called, which
unpacks the mirror tarball. After the original method is called, it checks the
localpath of the mirror tarball rather than the clone path, which isn't ideal,
particularly if the mirror tarball was removed due to being out of date. We
know the original fetch method will do what it needs to do to get its content
in the form it needs from the mirror tarball, so we can use its localpath
instead.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
Signed-off-by: Awais Belal <awais_belal@mentor.com>
---
 lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index d66a212..68ebf8b 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -955,7 +955,7 @@ def try_mirror_url(fetch, origud, ud, ld, check = False):
                 origud.method.download(origud, ld)
                 if hasattr(origud.method,"build_mirror_data"):
                     origud.method.build_mirror_data(origud, ld)
-            return ud.localpath
+            return origud.localpath
         # Otherwise the result is a local file:// and we symlink to it
         if not os.path.exists(origud.localpath):
             if os.path.islink(origud.localpath):
-- 
1.9.1


