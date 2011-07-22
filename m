Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1QkJct-0000xQ-3T
	for bitbake-devel@lists.openembedded.org;
	Fri, 22 Jul 2011 19:35:03 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 22 Jul 2011 10:30:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,248,1309762800"; d="scan'208";a="30862709"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.255.17.206])
	by orsmga001.jf.intel.com with ESMTP; 22 Jul 2011 10:30:44 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 22 Jul 2011 18:30:33 +0100
Message-Id: <15996e3a04fdebd5bbe152ed2c549fdaebe044b1.1311355686.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1311355686.git.paul.eggleton@linux.intel.com>
References: <cover.1311355686.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1311355686.git.paul.eggleton@linux.intel.com>
References: <cover.1311355686.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 4/6] bitbake-layers: check for errors before parsing
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
X-List-Received-Date: Fri, 22 Jul 2011 17:35:03 -0000

Don't always parse on initialisation - instead check for errors and then
parse when we know we need to. Avoids keeping the user waiting.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/bin/bitbake-layers |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/bitbake/bin/bitbake-layers b/bitbake/bin/bitbake-layers
index 1c48c8c..56253f5 100755
--- a/bitbake/bin/bitbake-layers
+++ b/bitbake/bin/bitbake-layers
@@ -48,7 +48,7 @@ class Commands(cmd.Cmd):
                                          self.register_idle_function)
         self.config_data = self.cooker.configuration.data
         bb.providers.logger.setLevel(logging.ERROR)
-        self.prepare_cooker()
+        self.cooker_data = None
 
     def register_idle_function(self, function, data):
         pass
@@ -71,10 +71,16 @@ class Commands(cmd.Cmd):
         self.cooker_data = self.cooker.status
         self.cooker_data.appends = self.cooker.appendlist
 
+    def check_prepare_cooker(self):
+        if not self.cooker_data:
+            self.prepare_cooker()
+
     def do_show_layers(self, args):
+        self.check_prepare_cooker()
         logger.info(str(self.config_data.getVar('BBLAYERS', True)))
 
     def do_show_overlayed(self, args):
+        self.check_prepare_cooker()
         if self.cooker.overlayed:
             logger.info('Overlayed recipes:')
             for f in self.cooker.overlayed.iterkeys():
@@ -94,6 +100,7 @@ class Commands(cmd.Cmd):
             logger.error('Directory %s exists and is non-empty, please clear it out first' % arglist[0])
             return
 
+        self.check_prepare_cooker()
         layers = (self.config_data.getVar('BBLAYERS', True) or "").split()
         for layer in layers:
             overlayed = []
@@ -143,6 +150,7 @@ class Commands(cmd.Cmd):
         recipefile.writelines(appendfile.readlines())
 
     def do_show_appends(self, args):
+        self.check_prepare_cooker()
         if not self.cooker_data.appends:
             logger.info('No append files found')
             return
-- 
1.7.4.1



