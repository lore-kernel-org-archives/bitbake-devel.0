Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QkUIa-0005rY-0H
	for bitbake-devel@lists.openembedded.org;
	Sat, 23 Jul 2011 06:58:48 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 22 Jul 2011 21:54:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,251,1309762800"; d="scan'208";a="31029054"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.127])
	by orsmga001.jf.intel.com with ESMTP; 22 Jul 2011 21:54:36 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 22 Jul 2011 21:54:25 -0700
Message-Id: <08d73d4ea9e538e7acd44ed52702c5092211e6ee.1311396521.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1311396520.git.josh@linux.intel.com>
References: <cover.1311396520.git.josh@linux.intel.com>
In-Reply-To: <cover.1311396520.git.josh@linux.intel.com>
References: <cover.1311396520.git.josh@linux.intel.com>
Subject: [PATCH 6/8] ui/crumbs/hobprefs: set higher arbitrary limit on threads & parallelism
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
X-List-Received-Date: Sat, 23 Jul 2011 04:58:48 -0000

We don't have a good handle on a sane cap value so just set it to an
arbitrary, but reasonably high, number. Once we have some more numbers on
values for number of threads and make parallelism we can integrate the
algorithm into the GUI.

Addresses [YOCTO #1266]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hobprefs.py |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobprefs.py b/lib/bb/ui/crumbs/hobprefs.py
index 779c14a..e01a266 100644
--- a/lib/bb/ui/crumbs/hobprefs.py
+++ b/lib/bb/ui/crumbs/hobprefs.py
@@ -243,7 +243,12 @@ class HobPrefs(gtk.Dialog):
         pbox.pack_start(hbox, expand=False, fill=False, padding=6)
         label = gtk.Label("BitBake threads:")
         label.show()
-        spin_max = 9 #self.cpu_cnt * 3
+        # NOTE: may be a good idea in future to intelligently cap the maximum
+        # values but we need more data to make an educated decision, for now
+        # set a high maximum as a value for upper bounds is required by the
+        # gtk.Adjustment
+        spin_max = 30 # seems like a high enough arbitrary number
+        #spin_max = self.cpu_cnt * 3
         hbox.pack_start(label, expand=False, fill=False, padding=6)
         bbadj = gtk.Adjustment(value=self.bbthread, lower=1, upper=spin_max, step_incr=1)
         bbspinner = gtk.SpinButton(adjustment=bbadj, climb_rate=1, digits=0)
-- 
1.7.6



