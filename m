Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SDXbg-0007bX-OS
	for bitbake-devel@lists.openembedded.org;
	Fri, 30 Mar 2012 10:54:52 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 30 Mar 2012 01:45:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="126893349"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga002.jf.intel.com with ESMTP; 30 Mar 2012 01:45:44 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 30 Mar 2012 17:12:41 +0800
Message-Id: <7bb76a68926bc36bc6f8a27180916e13c5c304a3.1333098599.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1333098599.git.shane.wang@intel.com>
References: <cover.1333098599.git.shane.wang@intel.com>
Subject: [PATCH 1/2] runqueue: wait and deal with those <defunct> sub-processes as soon as they are os.killed() when "Force stop"
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
X-List-Received-Date: Fri, 30 Mar 2012 08:54:53 -0000

When "Force stop" is performed during the build stage, after os.kill() kills the build sub-processes, there are many <defunct> python processes in the system. In Hob, when the user initiates a new build, os.waitpid() in runqueue_process_waitpid() will be called, and the pids of those <defunct> processes will be returned as result[0], then self.build_pids[result[0]] will throw KeyError exception because now for the new build self.build_pids is empty.

This patch is to address the above issue to collect the results and handle the sub-processes as soon as they are killed.

[Yocto #2186]

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/runqueue.py |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 6970548..b870caf 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1068,6 +1068,7 @@ class RunQueueExecute:
             for k, v in self.build_pids.iteritems():
                 try:
                     os.kill(-k, signal.SIGTERM)
+                    os.waitpid(-1, 0)
                 except:
                     pass
         for pipe in self.build_pipes:
-- 
1.7.6



