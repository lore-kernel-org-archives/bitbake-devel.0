Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 7AE586CBD8
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Oct 2013 16:44:37 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 04 Oct 2013 09:44:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,1034,1371106800"; d="scan'208";a="414098038"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.120.164])
	by orsmga002.jf.intel.com with ESMTP; 04 Oct 2013 09:44:36 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  4 Oct 2013 17:44:26 +0100
Message-Id: <9dbfa318841331af7397e0c4c7de721c4eca3d8f.1380904913.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1380904913.git.paul.eggleton@linux.intel.com>
References: <cover.1380904913.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1380904913.git.paul.eggleton@linux.intel.com>
References: <cover.1380904913.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/4] bitbake-diffsigs: refactor argument parsing slightly
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
X-List-Received-Date: Fri, 04 Oct 2013 16:44:38 -0000

* Use OptionParser to parse the two options to -t rather than trying to
  pick them out ourselves.
* Add a description shown with --help output

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/bin/bitbake-diffsigs | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/bitbake/bin/bitbake-diffsigs b/bitbake/bin/bitbake-diffsigs
index 6e4c44a..6f24981 100755
--- a/bitbake/bin/bitbake-diffsigs
+++ b/bitbake/bin/bitbake-diffsigs
@@ -75,6 +75,7 @@ def find_compare_task(bbhandler, pn, taskname):
 
 
 parser = optparse.OptionParser(
+    description = "Compares siginfo/sigdata files written out by BitBake",
     usage = """
   %prog -t recipename taskname
   %prog sigdatafile1 sigdatafile2
@@ -82,25 +83,21 @@ parser = optparse.OptionParser(
 
 parser.add_option("-t", "--task",
         help = "find the signature data files for last two runs of the specified task and compare them",
-        action="store_true", dest="taskmode")
+        action="store", dest="taskargs", nargs=2, metavar='recipename taskname')
 
 options, args = parser.parse_args(sys.argv)
 
-if len(args) == 1:
-    parser.print_help()
+if options.taskargs:
+    tinfoil = bb.tinfoil.Tinfoil()
+    tinfoil.prepare(config_only = True)
+    find_compare_task(tinfoil, options.taskargs[0], options.taskargs[1])
 else:
-    if options.taskmode:
-        tinfoil = bb.tinfoil.Tinfoil()
-        if len(args) < 3:
-            logger.error("Please specify a recipe and task name")
-            sys.exit(1)
-        tinfoil.prepare(config_only = True)
-        find_compare_task(tinfoil, args[1], args[2])
+    if len(args) == 1:
+        parser.print_help()
+    elif len(args) == 2:
+        output = bb.siggen.dump_sigfile(sys.argv[1])
     else:
-        if len(args) == 2:
-            output = bb.siggen.dump_sigfile(sys.argv[1])
-        else:
-            output = bb.siggen.compare_sigfiles(sys.argv[1], sys.argv[2])
+        output = bb.siggen.compare_sigfiles(sys.argv[1], sys.argv[2])
 
-        if output:
-            print '\n'.join(output)
+    if output:
+        print '\n'.join(output)
-- 
1.8.1.2


