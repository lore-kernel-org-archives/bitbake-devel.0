Return-Path: <stefanx.stanacar@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by mail.openembedded.org (Postfix) with ESMTP id 9CC5D6F0FE
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Feb 2014 15:42:05 +0000 (UTC)
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 27 Feb 2014 07:42:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,555,1389772800"; d="scan'208";a="344182940"
Received: from linux.jf.intel.com (HELO linux.intel.com) ([10.23.219.25])
	by AZSMGA002.ch.intel.com with ESMTP; 27 Feb 2014 07:42:05 -0800
Received: from firebird.rb.intel.com (firebird.rb.intel.com [10.237.105.156])
	by linux.intel.com (Postfix) with ESMTP id C865E6A4007;
	Thu, 27 Feb 2014 07:41:54 -0800 (PST)
From: Stefan Stanacar <stefanx.stanacar@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 27 Feb 2014 17:42:07 +0200
Message-Id: <1393515727-421-1-git-send-email-stefanx.stanacar@intel.com>
X-Mailer: git-send-email 1.8.5.3
Subject: [PATCH] build: filter out expanded empty strings for lockfiles flag
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
X-List-Received-Date: Thu, 27 Feb 2014 15:42:07 -0000

If we have something similar to:

    LOCKFILES = "${TMPDIR}/my.lock"
    LOCKFILES_qemuall = ""

    do_task[lockfiles] += "${LOCKFILES}"

when expanded, lockfiles will be empty for qemu, resulting in

     File "/home/stefans/yocto/poky/bitbake/lib/bb/utils.py", line 630, in mkdirhier
	raise e
    OSError: [Errno 2] No such file or directory: ''

This should filter out the empty expansions.

Signed-off-by: Stefan Stanacar <stefanx.stanacar@intel.com>
---
 bitbake/lib/bb/build.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index 50a28dc..52e4149 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -173,7 +173,7 @@ def exec_func(func, d, dirs = None):
 
     lockflag = flags.get('lockfiles')
     if lockflag:
-        lockfiles = [d.expand(f) for f in lockflag.split()]
+        lockfiles = [f for f in d.expand(lockflag).split()]
     else:
         lockfiles = None
 
-- 
1.8.5.3


