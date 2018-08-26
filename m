Return-Path: <david.reyna@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 68D9F79367
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 26 Aug 2018 22:36:53 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w7QMasF6029553
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 26 Aug 2018 15:36:54 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.217) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Sun, 26 Aug 2018 15:36:54 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sun, 26 Aug 2018 15:33:25 -0700
Message-ID: <cee2ffc3db30e73572fd3178debb1f59ec71e597.1535322629.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1535322629.git.David.Reyna@windriver.com>
References: <cover.1535322629.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.217]
Subject: [PATCH 2/9] toaster: use a more flexible way to find bitbake
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
X-List-Received-Date: Sun, 26 Aug 2018 22:36:53 -0000
Content-Type: text/plain

From: Awais Belal <awais_belal@mentor.com>

The current mechanism for finding the bitbake binary
assumes a directory structure which is identical to
poky, where oe-core's meta and bitbake directories are
at the same level. There can be a case where bitbake
is used from elsewhere and in such cases the above
mentioned assumption fails to hold, whereas this is
totally allowed by the oe-init-build-env script which
can take bitbakedir as an argument.
The better approach is to allow bitbake to be derived
from PATH, while keeping the older mechanism in place so
it can be removed after tests are done in various
environments. This makes more sense as toaster has
also been launched from the same bitbake instance
that is the one in PATH.

[YOCTO #12891]

Signed-off-by: Awais Belal <awais_belal@mentor.com>
Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/bldcontrol/localhostbecontroller.py | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 5df2290..aba09e0 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -444,8 +444,19 @@ class LocalhostBEController(BuildEnvironmentController):
         # clean the Toaster to build environment
         env_clean = 'unset BBPATH;' # clean BBPATH for <= YP-2.4.0
 
-        # run bitbake server from the clone
+        # run bitbake server from the clone if available
+        # otherwise pick it from the PATH
         bitbake = os.path.join(self.pokydirname, 'bitbake', 'bin', 'bitbake')
+        if not os.path.exists(bitbake):
+            logger.info("Bitbake not available under %s, will try to use it from PATH" %
+                        self.pokydirname)
+            for path in os.environ["PATH"].split(os.pathsep):
+                if os.path.exists(os.path.join(path, 'bitbake')):
+                    bitbake = os.path.join(path, 'bitbake')
+                    break
+            else:
+                logger.error("Looks like Bitbake is not available, please fix your environment")
+
         toasterlayers = os.path.join(builddir,"conf/toaster-bblayers.conf")
         if not is_merged_attr:
             self._shellcmd('%s bash -c \"source %s %s; BITBAKE_UI="knotty" %s --read %s --read %s '
-- 
1.9.1


