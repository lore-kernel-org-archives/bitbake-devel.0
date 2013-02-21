Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1U8YFZ-0007c0-HG
	for bitbake-devel@lists.openembedded.org;
	Thu, 21 Feb 2013 16:39:57 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 21 Feb 2013 07:23:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,710,1355126400"; d="scan'208";a="290151603"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.120.83])
	by fmsmga001.fm.intel.com with ESMTP; 21 Feb 2013 07:23:41 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 21 Feb 2013 15:23:35 +0000
Message-Id: <1361460215-30292-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.10.4
Subject: [PATCH] build.py: avoid deleting taint files when writing stamps
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
X-List-Received-Date: Thu, 21 Feb 2013 15:39:59 -0000

The stamp cleaning process that occurs before writing out new stamps for
a task was deleting taint files as well. This resulted in tasks that
were forcibly re-executed using the -f or -C command line options to
have their previous output restored from shared state when called upon a
second time, because the taint value was no longer incorporated into the
task signature and thus it was reverting to its previous value. This
also affected the kernel menuconfig command in OE-Core.

Note that the taint file *is* still deleted when doing -c clean, which
is the desired behaviour.

Fixes [YOCTO #3919].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/build.py |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 5f5a007..d91ff53 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -519,10 +519,13 @@ def make_stamp(task, d, file_name = None):
     """
     cleanmask = stamp_cleanmask_internal(task, d, file_name)
     for mask in cleanmask:
-        # Preserve sigdata files in the stamps directory
         for name in glob.glob(mask):
+            # Preserve sigdata files in the stamps directory
             if "sigdata" in name:
                 continue
+            # Preserve taint files in the stamps directory
+            if name.endswith('.taint'):
+                continue
             os.unlink(name)
     
     stamp = stamp_internal(task, d, file_name)
-- 
1.7.10.4



