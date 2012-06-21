Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1ShlM2-0004g1-5n
	for bitbake-devel@lists.openembedded.org;
	Thu, 21 Jun 2012 19:39:38 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 21 Jun 2012 10:28:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="114744299"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.120.141])
	by AZSMGA002.ch.intel.com with ESMTP; 21 Jun 2012 10:28:50 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 21 Jun 2012 18:28:46 +0100
Message-Id: <1340299727-8480-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH 1/2] bitbake: tweak help text for -C slightly
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
X-List-Received-Date: Thu, 21 Jun 2012 17:39:38 -0000

What is specified is a command (or "cmd" as in the help text for -f)
rather than a task - i.e. you specify compile, not do_compile, so change
the sentence to reflect that and reorder it slightly so it makes sense.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bin/bitbake |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/bitbake b/bin/bitbake
index f23673f..e55a538 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -118,7 +118,7 @@ Default BBFILES are the .bb files in the current directory.""")
     parser.add_option("-c", "--cmd", help = "Specify task to execute. Note that this only executes the specified task for the providee and the packages it depends on, i.e. 'compile' does not implicitly call stage for the dependencies (IOW: use only if you know what you are doing). Depending on the base.bbclass a listtasks tasks is defined and will show available tasks",
                action = "store", dest = "cmd")
 
-    parser.add_option("-C", "--clear-stamp", help = "Invalidate the specified stamp for a task such as 'compile' and run the default task for the specified target(s)",
+    parser.add_option("-C", "--clear-stamp", help = "Invalidate the stamp for the specified cmd such as 'compile' and run the default task for the specified target(s)",
                 action = "store", dest = "invalidate_stamp")
 
     parser.add_option("-r", "--read", help = "read the specified file before bitbake.conf",
-- 
1.7.9.5



