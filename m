Return-Path: <david.reyna@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 659EB78382
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  3 Sep 2017 05:32:28 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id v835WTYs012128
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 2 Sep 2017 22:32:30 -0700
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.78) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.361.1; Sat, 2 Sep 2017 22:32:28 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sat, 2 Sep 2017 22:24:06 -0700
Message-ID: <5dae30682532de125c447ff7b28ec8cd49e35da0.1504416112.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1504416112.git.David.Reyna@windriver.com>
References: <cover.1504416112.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.78]
Subject: [PATCH 3/4] toaster: debug message for lists layers missing separators
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
X-List-Received-Date: Sun, 03 Sep 2017 05:32:28 -0000
Content-Type: text/plain

From: Olaf Mandel <o.mandel@menlosystems.com>

One of the debug messages during build contains a list of all layers
but without spaces or other separators between them. Use pformat
instead.

[YOCTO #12014]

Signed-off-by: Olaf Mandel <o.mandel@menlosystems.com>
Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/bldcontrol/localhostbecontroller.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 6142f7e..a93cf40 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -230,7 +230,7 @@ class LocalhostBEController(BuildEnvironmentController):
                 continue  # not a custom recipe, skip
 
         layerlist.extend(nongitlayerlist)
-        logger.debug("\n\nset layers gives this list \n %s" % ''.join(layerlist))
+        logger.debug("\n\nset layers gives this list %s" % pformat(layerlist))
         self.islayerset = True
         return layerlist
 
-- 
1.9.1


