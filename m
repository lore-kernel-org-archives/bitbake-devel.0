Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SALFK-0003SV-NI
	for bitbake-devel@lists.openembedded.org;
	Wed, 21 Mar 2012 14:06:34 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 21 Mar 2012 05:57:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="119980043"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by orsmga001.jf.intel.com with ESMTP; 21 Mar 2012 05:57:37 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Mar 2012 20:55:11 +0800
Message-Id: <db4f8096f54b0b07dee581ffbdd7d2ede5c1c5b9.1332334068.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1332334068.git.dongxiao.xu@intel.com>
References: <cover.1332334068.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1332334068.git.dongxiao.xu@intel.com>
References: <cover.1332334068.git.dongxiao.xu@intel.com>
Subject: [PATCH 07/17] process.py: Increase the timeout value for polling commands
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
X-List-Received-Date: Wed, 21 Mar 2012 13:06:35 -0000

The parseConfigurationFiles commands needs more time for piping,
thus change the polling timeout value from 0.5s to 1s.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/server/process.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index ba91336..946af05 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -45,7 +45,7 @@ class ServerCommunicator():
         while True:
             # don't let the user ctrl-c while we're waiting for a response
             try:
-                if self.connection.poll(.5):
+                if self.connection.poll(1):
                     return self.connection.recv()
                 else:
                     return None
-- 
1.7.4.1



