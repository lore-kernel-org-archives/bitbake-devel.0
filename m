Return-Path: <rpjday@crashcourse.ca>
Received: from smtp486.redcondor.net (smtp486.redcondor.net [208.80.204.86])
	by mail.openembedded.org (Postfix) with ESMTP id B412F6FE27
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Jul 2014 21:54:53 +0000 (UTC)
Received: from astoria.ccjclearline.com ([64.235.106.9])
	by smtp486.redcondor.net ({6695537a-536a-45f9-a249-877c85428649})
	via TCP (outbound) with ESMTPS id 20140722215453230
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Jul 2014 21:54:53 +0000
X-RC-FROM: <rpjday@crashcourse.ca>
X-RC-RCPT: <bitbake-devel@lists.openembedded.org>
Received: from [64.134.185.139] (port=55971 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1X9i1H-00030S-2K for bitbake-devel@lists.openembedded.org;
	Tue, 22 Jul 2014 17:54:47 -0400
Date: Tue, 22 Jul 2014 17:54:42 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.LFD.2.11.1407221753510.15822@localhost>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
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
X-MAG-OUTBOUND: ccj.redcondor.net@64.235.106.9/32
Subject: [PATCH] "per-package" should say "per-recipe"
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
X-List-Received-Date: Tue, 22 Jul 2014 21:54:57 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII


Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/bin/bitbake b/bin/bitbake
index e31a636..39aa3ec 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -148,7 +148,7 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
         parser.add_option("-s", "--show-versions", help = "Show current and preferred versions of all recipes.",
                    action = "store_true", dest = "show_versions", default = False)

-        parser.add_option("-e", "--environment", help = "Show the global or per-package environment complete with information about where variables were set/changed.",
+        parser.add_option("-e", "--environment", help = "Show the global or per-recipe environment complete with information about where variables were set/changed.",
                    action = "store_true", dest = "show_environment", default = False)

         parser.add_option("-g", "--graphviz", help = "Save dependency tree information for the specified targets in the dot syntax.",
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.xml b/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
index ade91e9..d348bc9 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
@@ -515,7 +515,7 @@
                              handler is required.
        -p, --parse-only      Quit after parsing the BB recipes.
        -s, --show-versions   Show current and preferred versions of all recipes.
-       -e, --environment     Show the global or per-package environment complete
+       -e, --environment     Show the global or per-recipe environment complete
                              with information about where variables were
                              set/changed.
        -g, --graphviz        Save dependency tree information for the specified
diff --git a/doc/bitbake.1 b/doc/bitbake.1
index 15a7f20..a6c8d97 100644
--- a/doc/bitbake.1
+++ b/doc/bitbake.1
@@ -89,7 +89,7 @@ quit after parsing the BB files (developers only)
 show current and preferred versions of all packages
 .TP
 .B \-e, \-\-environment
-show the global or per-package environment (this is what used to be bbread)
+show the global or per-recipe environment (this is what used to be bbread)
 .TP
 .B \-g, \-\-graphviz
 emit the dependency trees of the specified packages in the dot syntax
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index f44a088..ecb3f9b 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -402,7 +402,7 @@ class BBCooker:

     def showEnvironment(self, buildfile = None, pkgs_to_build = []):
         """
-        Show the outer or per-package environment
+        Show the outer or per-recipe environment
         """
         fn = None
         envdata = None

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================


