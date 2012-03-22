Received: from astoria.ccjclearline.com ([64.235.106.9])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <rpjday@crashcourse.ca>) id 1SAoET-00065y-KI
	for bitbake-devel@lists.openembedded.org;
	Thu, 22 Mar 2012 21:03:37 +0100
Received: from cpec03f0ed08c7f-cm001ac318e826.cpe.net.cable.rogers.com
	([99.241.91.63] helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69) (envelope-from <rpjday@crashcourse.ca>)
	id 1SAo5r-0005OA-ON for bitbake-devel@lists.openembedded.org;
	Thu, 22 Mar 2012 15:54:43 -0400
Date: Thu, 22 Mar 2012 15:54:37 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@oneiric
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.DEB.2.02.1203221552180.21491@oneiric>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
X-AntiAbuse: This header was added to track abuse,
	please include it with any abuse report
X-AntiAbuse: Primary Hostname - astoria.ccjclearline.com
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Subject: [PATCH] Fix typo: BB_NUMBER_THREAD -> BB_NUMBER_THREADS
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 22 Mar 2012 20:03:37 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII


Correct some apparent misspellings of BB_NUMBER_THREADS.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
index 5a292e7..619f1d4 100755
--- a/lib/bb/ui/crumbs/builder.py
+++ b/lib/bb/ui/crumbs/builder.py
@@ -75,7 +75,7 @@ class Configuration:
         self.sstatedir = template.getVar("SSTATE_DIR")
         self.sstatemirror = template.getVar("SSTATE_MIRROR")
         self.pmake = int(template.getVar("PARALLEL_MAKE").split()[1])
-        self.bbthread = int(template.getVar("BB_NUMBER_THREAD"))
+        self.bbthread = int(template.getVar("BB_NUMBER_THREADS"))
         self.image_rootfs_size = int(template.getVar("IMAGE_ROOTFS_SIZE"))
         self.image_extra_size = int(template.getVar("IMAGE_EXTRA_SPACE"))
         # image_overhead_factor is read-only.
@@ -103,7 +103,7 @@ class Configuration:
         template.setVar("SSTATE_DIR", self.sstatedir)
         template.setVar("SSTATE_MIRROR", self.sstatemirror)
         template.setVar("PARALLEL_MAKE", "-j %s" % self.pmake)
-        template.setVar("BB_NUMBER_THREAD", self.bbthread)
+        template.setVar("BB_NUMBER_THREADS", self.bbthread)
         template.setVar("PACKAGE_CLASSES", " ".join(["package_" + i for i in self.curr_package_format.split()]))
         template.setVar("IMAGE_ROOTFS_SIZE", self.image_rootfs_size)
         template.setVar("IMAGE_EXTRA_SPACE", self.image_extra_size)
diff --git a/lib/bb/ui/crumbs/template.py b/lib/bb/ui/crumbs/template.py
index a03063c..5679c18 100644
--- a/lib/bb/ui/crumbs/template.py
+++ b/lib/bb/ui/crumbs/template.py
@@ -125,7 +125,7 @@ class RecipeFile(ConfigFile):

 class TemplateMgr(gobject.GObject):

-    __gLocalVars__ = ["MACHINE", "PACKAGE_CLASSES", "DISTRO", "DL_DIR", "SSTATE_DIR", "SSTATE_MIRROR", "PARALLEL_MAKE", "BB_NUMBER_THREAD", "CONF_VERSION"]
+    __gLocalVars__ = ["MACHINE", "PACKAGE_CLASSES", "DISTRO", "DL_DIR", "SSTATE_DIR", "SSTATE_MIRROR", "PARALLEL_MAKE", "BB_NUMBER_THREADS", "CONF_VERSION"]
     __gBBLayersVars__ = ["BBLAYERS", "LCONF_VERSION"]
     __gRecipeVars__ = ["DEPENDS", "IMAGE_INSTALL"]


-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================


