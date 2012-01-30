Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1RruB3-0000QF-7e
	for bitbake-devel@lists.openembedded.org;
	Mon, 30 Jan 2012 17:33:57 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 30 Jan 2012 08:26:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="104198221"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.192])
	by orsmga002.jf.intel.com with ESMTP; 30 Jan 2012 08:25:58 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 30 Jan 2012 16:25:50 +0000
Message-Id: <299c78edaeea942de068f7629676be023edbbc17.1327940413.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1327940413.git.paul.eggleton@linux.intel.com>
References: <cover.1327940413.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1327940413.git.paul.eggleton@linux.intel.com>
References: <cover.1327940413.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/6] bitbake-layers: use dashes in subcommands
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
X-List-Received-Date: Mon, 30 Jan 2012 16:33:57 -0000

Rather than the slightly awkward underscores, use dashes in subcommands
e.g. show-layers instead of show_layers. (The old underscored forms
continue to be accepted however.)

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/bin/bitbake-layers |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/bitbake/bin/bitbake-layers b/bitbake/bin/bitbake-layers
index 3007d51..041aa19 100755
--- a/bitbake/bin/bitbake-layers
+++ b/bitbake/bin/bitbake-layers
@@ -41,6 +41,8 @@ def main(args):
 
     cmds = Commands(initialenv)
     if args:
+        # Allow user to specify e.g. show-layers instead of show_layers
+        args = [args[0].replace('-', '_')] + args[1:]
         cmds.onecmd(' '.join(args))
     else:
         cmds.do_help('')
@@ -93,14 +95,14 @@ class Commands(cmd.Cmd):
         """display general help or help on a specified command"""
         if topic:
             sys.stdout.write('%s: ' % topic)
-            cmd.Cmd.do_help(self,topic)
+            cmd.Cmd.do_help(self, topic.replace('-', '_'))
         else:
             sys.stdout.write("usage: bitbake-layers <command> [arguments]\n\n")
             sys.stdout.write("Available commands:\n")
             procnames = self.get_names()
             for procname in procnames:
                 if procname[:3] == 'do_':
-                    sys.stdout.write("  %s\n" % procname[3:])
+                    sys.stdout.write("  %s\n" % procname[3:].replace('_', '-'))
                     doc = getattr(self, procname).__doc__
                     if doc:
                         sys.stdout.write("    %s\n" % doc.splitlines()[0])
@@ -126,7 +128,7 @@ class Commands(cmd.Cmd):
     def do_show_overlayed(self, args):
         """list overlayed recipes (where there is a recipe in another layer that has a higher layer priority)
 
-usage: show_overlayed
+usage: show-overlayed
 
 Highest priority recipes are listed with the recipes they overlay as subitems.
 """
@@ -197,7 +199,7 @@ build results (as the layer priority order has effectively changed).
 
             for layername in layernames:
                 if not layername in found_layernames:
-                    logger.error('Unable to find layer %s in current configuration, please run "%s show_layers" to list configured layers' % (layername, os.path.basename(sys.argv[0])))
+                    logger.error('Unable to find layer %s in current configuration, please run "%s show-layers" to list configured layers' % (layername, os.path.basename(sys.argv[0])))
                     return
             layers = found_layerdirs
         else:
@@ -316,7 +318,7 @@ build results (as the layer priority order has effectively changed).
     def do_show_appends(self, args):
         """list bbappend files and recipe files they apply to
 
-usage: show_appends
+usage: show-appends
 
 Recipes are listed with the bbappends that apply to them as subitems.
 """
-- 
1.7.5.4



