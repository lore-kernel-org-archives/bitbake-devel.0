Return-Path: <andrew@aj.id.au>
X-Greylist: delayed 451 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 27 Aug 2019 00:11:07 UTC
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25])
	by mail.openembedded.org (Postfix) with ESMTP id D0CBA7E648
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Aug 2019 00:11:07 +0000 (UTC)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 702CA222F1;
	Mon, 26 Aug 2019 20:03:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
	by compute4.internal (MEProxy); Mon, 26 Aug 2019 20:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=fm3; bh=wXE6wogLBK/MLRkpBldLH58Xez
	K3Rn0sRLadtLOm4as=; b=A2NcyzAxQHaBwoj8t8BLZyEwyWXfrXW6DHvoZYjaRS
	ld5cglpbKgbfYI7f2g0wDIii6l3IfjOvGGtEprNyJFy1D/n1031rl6+IfdvQASiG
	lp49hFGTz3d2uS9u9X2T23ELYy8WdrU71jsfCwK1wT/RzVTi3uZaprwqGgMsAEaS
	lflHX10dWu6XTjQuvjrNUV25D/y0HTbJpqIOPUujwlcnp+H7iAOH8CD9NwQ8fdu1
	qRZMz/TQUh4246OJyvodp0y+MEDWrzTy9rgGiUlfwpR6kiwVZWAiXddRWY0lqzBR
	qU4ETp1ENrkVcSf1ax75lrjnBJhCFlwcJtdHUyyTZqtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:date:from
	:message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=wXE6wogLBK/MLRkpB
	ldLH58XezK3Rn0sRLadtLOm4as=; b=nbIwfjXtDA7f0BXV291Jx9rfUai4eYntv
	ZGAwysh2fzogMzC+3hAXfBWAuS4h3Xa36lddEzUk4PWGEMHcYhYfxREuszpbkYGX
	uwBBNFGMzRFX6P/1i2xnd1cf4jdAlxJDslhzLYlBpDGXDx7P3aXZN62UkuUHXPc/
	7nNLWR3jblyNgvXd34hiMkFbJrDTUqQBZ2GijH+98JWYlwNi++sAIEorAVwt9Fu0
	3OmMlxQCB/UnU9I0Eubl7kDT/8WjNxMlXXe5U0h39jry+qHMxXH1lKjN0tcER/ie
	kDeE+UpHW5tMYhRl2d7DUxn+Dvq8HwFM0Psqrt63ip1bCw9H+5zMA==
X-ME-Sender: <xms:V3NkXWzz3dTazFdV36QmTMzlQbOFGQMl-0LjzWicypjg4uDUuXurxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudehhedgfedvucetufdoteggodetrfdotf
	fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
	uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
	dttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegrjhdr
	ihgurdgruheqnecukfhppedvtdefrdehjedrvdduhedrudejkeenucfrrghrrghmpehmrg
	hilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushhtvghrufhiiigv
	pedt
X-ME-Proxy: <xmx:V3NkXZccgFHwN5jzEkpSAOy08H8HGwmezmsX_0bdZ0v1GtHXrbbebQ>
	<xmx:V3NkXXg2vPz-Q0hqWlSTbTeLM4XJtqgJxlo1-bJCG98bOPR8q8Zmtg>
	<xmx:V3NkXd8hf-VJAt3alUUVuQr7wi5lCevVEdJa2mZ5s5MZV81B7y-V2w>
	<xmx:WHNkXdjBXrpIEp5FI_JxzbgURL17eYLij4M8UphXI5mG2ny4KgVVlQ>
Received: from mistburn.lan (203-57-215-178.dyn.iinet.net.au [203.57.215.178])
	by mail.messagingengine.com (Postfix) with ESMTPA id 6B9458006A;
	Mon, 26 Aug 2019 20:03:33 -0400 (EDT)
From: Andrew Jeffery <andrew@aj.id.au>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 27 Aug 2019 09:33:58 +0930
Message-Id: <20190827000358.25777-1-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: bradleyb@fuzziesquirrel.com, ojayanth@in.ibm.com
Subject: [RESEND RFC PATCH] gitsm: Control submodule recursion
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
X-List-Received-Date: Tue, 27 Aug 2019 00:11:08 -0000
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


