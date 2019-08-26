Return-Path: <andrew@aj.id.au>
X-Greylist: delayed 597 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 26 Aug 2019 03:35:52 UTC
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
	[64.147.123.20])
	by mail.openembedded.org (Postfix) with ESMTP id E23A97F54D
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Aug 2019 03:35:52 +0000 (UTC)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 1C65E323;
	Sun, 25 Aug 2019 23:25:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
	by compute4.internal (MEProxy); Sun, 25 Aug 2019 23:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=fm3; bh=wXE6wogLBK/MLRkpBldLH58Xez
	K3Rn0sRLadtLOm4as=; b=ouO6kdjfjV+BZElGswUy1/hsp/o1R56ClK0F8ggfUX
	M20lCJacvgsdTylI+7Ry1BUrDqXQqwSktWB/LNXqqEMucgvo7gVkNJK/1FizVEhU
	SAsxBKwWLCH1mXy91wl2dxkFCPu7P4IAOtWDWy5k9boFF3bBdsk51fdGWVfgfx22
	MkVH+zTDwB7T4dmwR2kSD1F4zQdnMxGirzfPZ3r5mVIyqGeVHVZkzT0NGH27ff5a
	jSALY7VJnKVm/81GrZ3JOBW0ic5KxecGpcGo8/cOfo+0zFOxwLpJVpHNHUjKp36x
	JfcigtVlpOSP6s14lF5hmWotMFy9XrSMrw3LWwnWfatA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:date:from
	:message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=wXE6wogLBK/MLRkpB
	ldLH58XezK3Rn0sRLadtLOm4as=; b=yKvI8yZTNev6227uIuTNGxytu/dsTWSdN
	cjxhspfhHasfBROeZaq50fQRgS4hlCn8VAS8PEGJvP8e+FSvgYgMeE08klWcmnia
	TzHuocturG5IQIbWVwogaSjhIvW9OtEq3cUnaDXp8RsJkC7jYi+4XfiJdbc97l4p
	pxIylDVxTqgQSehVRO1ZiRTlFb8egY0Q3m/iBwm0W9wQpoIEBgvc1lkgWq6cM29Z
	DED1epjM8AH9rx9XW0agLGbnuNz/EwsqpsYdLZvF6IVg/8U0WUkJC0nysGBWZgA8
	Q4XpEtwCamt4Fa37NSCLe/3l5AObLh2Xh0bKRYrOUsMKPzDT92NKQ==
X-ME-Sender: <xms:QlFjXbGhPKLixhz0mXEcn5F4kC-GFSvVEPwYP3wL-RvfTzP_wXHUNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudehfedgjedvucetufdoteggodetrfdotf
	fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
	uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
	dttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegrjhdr
	ihgurdgruheqnecukfhppedvtdefrdehjedrvdduhedrudejkeenucfrrghrrghmpehmrg
	hilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushhtvghrufhiiigv
	pedt
X-ME-Proxy: <xmx:QlFjXWC-ncOwL1BcHDnRlAuZjIM7RqazuLU6JHBT6TBbXJaE8ZcA1w>
	<xmx:QlFjXVM2QzJLz2uc70JyFuChgDPbS6xNjDffBpUg4CN86oSLXYAwpg>
	<xmx:QlFjXReWYRO3Jr0bhqLyvJ2oEnrlPrGud3sw8jM4aYIyFboqN7aIUQ>
	<xmx:Q1FjXbrcH9LbV0D9lTX1IR7lLQtNyNrW9-mMasSweJ6ZUuTf9S_2EQ>
Received: from localhost.localdomain (203-57-215-178.dyn.iinet.net.au
	[203.57.215.178])
	by mail.messagingengine.com (Postfix) with ESMTPA id 3136880059;
	Sun, 25 Aug 2019 23:25:52 -0400 (EDT)
From: Andrew Jeffery <andrew@aj.id.au>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 26 Aug 2019 12:55:58 +0930
Message-Id: <20190826032558.15043-1-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 27 Aug 2019 13:03:22 +0000
Cc: bradleyb@fuzziesquirrel.com, ojayanth@in.ibm.com
Subject: [RFC PATCH] gitsm: Control submodule recursion
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
X-List-Received-Date: Mon, 26 Aug 2019 03:35:53 -0000
Content-Transfer-Encoding: 8bit

There exist some use-cases where repositories related by submodules do
not require submodules be recursively initialised despite needing the
first layer of submodules to be fetched. Enable this usecase in gitsm by
implementing a `recurse=X` SRC_URI parameter. The current implementation
of the recurse parameter defaults to enabling exhaustive recursion to
match the current behaviour of gitsm, with the one alternative being no
recursion. Enough rope is provided to allow specific recursion depths to
be implemented if necessary via the same interface. Values currently
unsupported for the recurse parameter raise a ValueError to ensure
forward compatibility.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 lib/bb/fetch2/gitsm.py | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index c622771d21aa..5a8426b486e3 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -6,7 +6,15 @@ after cloning.
 
 SRC_URI = "gitsm://<see Git fetcher for syntax>"
 
-See the Git fetcher, git://, for usage documentation.
+Supported SRC_URI options are:
+
+- recurse
+    Control recursive nature of submodule initialisation.
+
+    The default value is -1, which will recursively initialise all submodules.
+    Set to 0 to disable recursiion.
+
+See the Git fetcher, git://, for further usage documentation.
 
 NOTE: Switching a SRC_URI from "git://" to "gitsm://" requires a clean of your recipe.
 
@@ -26,6 +34,15 @@ from   bb.fetch2 import logger
 from   bb.fetch2 import Fetch
 from   bb.fetch2 import BBFetchException
 
+def should_recurse(ud):
+    recurse = ud.parm.get("recurse", "-1")
+
+    # Change this condition if we end up supporting specific maximum depths
+    if recurse in ( "-1", "0" ):
+        return recurse == "-1"
+
+    raise ValueError("Recursion control value not supported: %s" % (recurse))
+
 class GitSM(Git):
     def supports(self, ud, d):
         """
@@ -95,25 +112,28 @@ class GitSM(Git):
         for module in submodules:
             # Translate the module url into a SRC_URI
 
+            recurse = should_recurse(ud)
             if "://" in uris[module]:
                 # Properly formated URL already
                 proto = uris[module].split(':', 1)[0]
-                url = uris[module].replace('%s:' % proto, 'gitsm:', 1)
+                desired = "gitsm:" if recurse else "git:"
+                url = uris[module].replace('%s:' % proto, desired, 1)
             else:
+                scheme = "gitsm://" if recurse else "git://"
                 if ":" in uris[module]:
                     # Most likely an SSH style reference
                     proto = "ssh"
                     if ":/" in uris[module]:
                         # Absolute reference, easy to convert..
-                        url = "gitsm://" + uris[module].replace(':/', '/', 1)
+                        url = scheme + uris[module].replace(':/', '/', 1)
                     else:
                         # Relative reference, no way to know if this is right!
                         logger.warning("Submodule included by %s refers to relative ssh reference %s.  References may fail if not absolute." % (ud.url, uris[module]))
-                        url = "gitsm://" + uris[module].replace(':', '/', 1)
+                        url = scheme + uris[module].replace(':', '/', 1)
                 else:
                     # This has to be a file reference
                     proto = "file"
-                    url = "gitsm://" + uris[module]
+                    url = scheme + uris[module]
 
             url += ';protocol=%s' % proto
             url += ";name=%s" % module
@@ -209,7 +229,9 @@ class GitSM(Git):
         ret = self.process_submodules(ud, ud.destdir, unpack_submodules, d)
 
         if not ud.bareclone and ret:
+            recurse = should_recurse(ud)
             # All submodules should already be downloaded and configured in the tree.  This simply sets
             # up the configuration and checks out the files.  The main project config should remain
             # unmodified, and no download from the internet should occur.
-            runfetchcmd("%s submodule update --recursive --no-fetch" % (ud.basecmd), d, quiet=True, workdir=ud.destdir)
+            runfetchcmd("%s submodule update %s --no-fetch" % (ud.basecmd, "--recursive" if recurse else ""),
+                        d, quiet=True, workdir=ud.destdir)
-- 
2.20.1


