Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1QkJcs-0000xp-Mf
	for bitbake-devel@lists.openembedded.org;
	Fri, 22 Jul 2011 19:35:02 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 22 Jul 2011 10:30:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,248,1309762800"; d="scan'208";a="30862705"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.255.17.206])
	by orsmga001.jf.intel.com with ESMTP; 22 Jul 2011 10:30:43 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 22 Jul 2011 18:30:32 +0100
Message-Id: <c162ecab5c07724a7fabcde4cf2efeaea439201d.1311355686.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1311355686.git.paul.eggleton@linux.intel.com>
References: <cover.1311355686.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1311355686.git.paul.eggleton@linux.intel.com>
References: <cover.1311355686.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 3/6] bitbake: adjust comments/messages for default server change
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

Default server is process, adjust comments and messages accordingly.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/bin/bitbake |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/bitbake/bin/bitbake b/bitbake/bin/bitbake
index f198fd1..8d6fef7 100755
--- a/bitbake/bin/bitbake
+++ b/bitbake/bin/bitbake
@@ -172,8 +172,8 @@ Default BBFILES are the .bb files in the current directory.""")
 
     ui_main = get_ui(configuration)
 
-    # Server type could be xmlrpc or none currently, if nothing is specified,
-    # default server would be none
+    # Server type can be xmlrpc, process or none currently, if nothing is specified,
+    # the default server is process
     if configuration.servertype:
         server_type = configuration.servertype
     else:
@@ -184,7 +184,7 @@ Default BBFILES are the .bb files in the current directory.""")
         server = getattr(module, server_type)
     except AttributeError:
         sys.exit("FATAL: Invalid server type '%s' specified.\n"
-                 "Valid interfaces: xmlrpc, process, none [default]." % servertype)
+                 "Valid interfaces: xmlrpc, process [default], none." % servertype)
 
     # Save a logfile for cooker into the current working directory. When the
     # server is daemonized this logfile will be truncated.
-- 
1.7.4.1



