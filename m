Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RsbqC-000758-FR
	for bitbake-devel@lists.openembedded.org;
	Wed, 01 Feb 2012 16:11:20 +0100
Received: by opal (Postfix, from userid 111)
	id 1CE2910334; Wed,  1 Feb 2012 15:03:46 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120201150346.1CE2910334@opal>
Date: Wed,  1 Feb 2012 15:03:46 +0000 (UTC)
From: git@git.openembedded.org
Subject: Paul Eggleton : bitbake-layers: use dashes in subcommands
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
X-List-Received-Date: Wed, 01 Feb 2012 15:11:20 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 6d311ddc1be04ae5bd0a1ebee94b44968e8a3f27
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=6d311ddc1be04ae5bd0a1ebee94b44968e8a3f27

Author: Paul Eggleton <paul.eggleton@linux.intel.com>
Date:   Mon Jan 30 16:25:50 2012 +0000

bitbake-layers: use dashes in subcommands

Rather than the slightly awkward underscores, use dashes in subcommands
e.g. show-layers instead of show_layers. (The old underscored forms
continue to be accepted however.)

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 bin/bitbake-layers |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index 3007d51..041aa19 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
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



