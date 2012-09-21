Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1TF4iF-0004KT-PA
	for bitbake-devel@lists.openembedded.org;
	Fri, 21 Sep 2012 17:00:15 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 21 Sep 2012 07:47:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,463,1344236400"; d="scan'208";a="209599856"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.241])
	by orsmga002.jf.intel.com with ESMTP; 21 Sep 2012 07:47:30 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 21 Sep 2012 15:47:24 +0100
Message-Id: <a7d6473cb9c15ff50274a6ca663f730aa196c69a.1348238757.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1348238757.git.paul.eggleton@linux.intel.com>
References: <cover.1348238757.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1348238757.git.paul.eggleton@linux.intel.com>
References: <cover.1348238757.git.paul.eggleton@linux.intel.com>
Subject: [PATCH v2 2/4] hob: allow configuring default machine using HOB_MACHINE
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
X-List-Received-Date: Fri, 21 Sep 2012 15:00:16 -0000

Allow specifying HOB_MACHINE in local.conf to set the initially
selected machine. With this set, Hob will select the specified machine
and then jump straight into parsing recipes. If you do wish to change
the selected machine with HOB_MACHINE set you still can - you just need
to stop the parsing process first.

Fixes [YOCTO #3148].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 9e9d040..3e96a3b 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -754,6 +754,8 @@ class Builder(gtk.Window):
 
     def handler_command_succeeded_cb(self, handler, initcmd):
         if initcmd == self.handler.GENERATE_CONFIGURATION:
+            if not self.configuration.curr_mach:
+                self.configuration.curr_mach = self.handler.runCommand(["getVariable", "HOB_MACHINE"]) or ""
             self.update_configuration_parameters(self.get_parameters_sync())
             self.sanity_check()
         elif initcmd == self.handler.SANITY_CHECK:
-- 
1.7.9.5



