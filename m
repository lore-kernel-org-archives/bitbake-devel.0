Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1ShXIH-0004rg-Cj
	for bitbake-devel@lists.openembedded.org;
	Thu, 21 Jun 2012 04:38:49 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q5L2S0U6025601
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jun 2012 19:28:00 -0700 (PDT)
Received: from usp-ub10.corp.ad.wrs.com (128.224.163.69) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.1.255.0; Wed, 20 Jun 2012 19:28:00 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 21 Jun 2012 10:28:54 +0800
Message-ID: <d4ec2885857ad121a3664a464a12d6de54a12f00.1340179047.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <cover.1340179047.git.liezhi.yang@windriver.com>
References: <cover.1340179047.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Cc: Zhenfeng.Zhao@windriver.com
Subject: [PATCH 1/1] print which pkgs would be built
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
X-List-Received-Date: Thu, 21 Jun 2012 02:38:49 -0000
Content-Type: text/plain

This is for giving the user a clear list to show which pkg would be
built, we have the "bitbake -g", but it is not easy to read for people,
it is for "dot". Improve the "bitbake -g" to also save a pn-buildlist:

$ bitbake -g core-image-sato
...
NOTE: PN build list saved to 'pn-buildlist'
[snip]

The contents of pn-buildlist:

busybox
shadow-native
pth
sysfsutils
qemu-helper-native
curl-native
ncurses-native
gdbm
xserver-xorg
linux-libc-headers
[snip]

[YOCTO #2404]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/bin/bitbake      |    2 +-
 bitbake/lib/bb/cooker.py |    4 ++++
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/bitbake/bin/bitbake b/bitbake/bin/bitbake
index 478ac06..5ddc28c 100755
--- a/bitbake/bin/bitbake
+++ b/bitbake/bin/bitbake
@@ -145,7 +145,7 @@ Default BBFILES are the .bb files in the current directory.""")
     parser.add_option("-e", "--environment", help = "show the global or per-package environment (this is what used to be bbread)",
                action = "store_true", dest = "show_environment", default = False)
 
-    parser.add_option("-g", "--graphviz", help = "emit the dependency trees of the specified packages in the dot syntax",
+    parser.add_option("-g", "--graphviz", help = "emit the dependency trees of the specified packages in the dot syntax, and the pn-buildlist to show the build list",
                 action = "store_true", dest = "dot_graph", default = False)
 
     parser.add_option("-I", "--ignore-deps", help = """Assume these dependencies don't exist and are already provided (equivalent to ASSUME_PROVIDED). Useful to make dependency graphs more appealing""",
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 928b600..a9aae5c 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -534,11 +534,15 @@ class BBCooker:
 
         # Prints a flattened form of package-depends below where subpackages of a package are merged into the main pn
         depends_file = file('pn-depends.dot', 'w' )
+        buildlist_file = file('pn-buildlist', 'w' )
         print("digraph depends {", file=depends_file)
         for pn in depgraph["pn"]:
             fn = depgraph["pn"][pn]["filename"]
             version = depgraph["pn"][pn]["version"]
             print('"%s" [label="%s %s\\n%s"]' % (pn, pn, version, fn), file=depends_file)
+            print("%s" % pn, file=buildlist_file)
+        buildlist_file.close()
+        logger.info("PN build list saved to 'pn-buildlist'")
         for pn in depgraph["depends"]:
             for depend in depgraph["depends"][pn]:
                 print('"%s" -> "%s"' % (pn, depend), file=depends_file)
-- 
1.7.1



