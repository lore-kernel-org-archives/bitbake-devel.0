Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1UaOH4-0008CF-3y
	for bitbake-devel@lists.openembedded.org;
	Thu, 09 May 2013 12:40:35 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 09 May 2013 03:20:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,639,1363158000"; d="scan'208";a="334227527"
Received: from unknown (HELO helios.amr.corp.intel.com) ([10.255.12.169])
	by orsmga002.jf.intel.com with ESMTP; 09 May 2013 03:22:28 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  9 May 2013 11:22:26 +0100
Message-Id: <1368094946-14686-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
Subject: [PATCH] bin/bitbake: add a check for /dev/shm existing
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
X-List-Received-Date: Thu, 09 May 2013 10:40:37 -0000

Python multiprocessing needs /dev/shm, and if it doesn't exist (e.g. in
a chroot environment) or is not writable, you'll get
"OSError: [Errno 38] Function not implemented" or
"OSError: [Errno 13] Permission denied" with a traceback, which doesn't
really help to explain what is wrong.

Implements [YOCTO #4407].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bin/bitbake | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/bin/bitbake b/bin/bitbake
index 0e69207..ae6c2cb 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -43,6 +43,10 @@ from bb import server
 __version__ = "1.19.0"
 logger = logging.getLogger("BitBake")
 
+# Python multiprocessing requires /dev/shm
+if not os.access('/dev/shm', os.W_OK | os.X_OK):
+    sys.exit("FATAL: /dev/shm does not exist or is not writable")
+
 # Unbuffer stdout to avoid log truncation in the event
 # of an unorderly exit as well as to provide timely
 # updates to log files for use with tail
-- 
1.8.1.2



