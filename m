Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1SW5WX-0005Br-5N
	for bitbake-devel@lists.openembedded.org;
	Sun, 20 May 2012 14:46:13 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q4KCa6L0012119
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 20 May 2012 05:36:06 -0700 (PDT)
Received: from usp-ub10.corp.ad.wrs.com (128.224.163.69) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.1.255.0; Sun, 20 May 2012 05:36:05 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sun, 20 May 2012 20:36:05 +0800
Message-ID: <54610c9a195864f2cebf7ca709f87b50245d5977.1337515887.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <cover.1337515887.git.liezhi.yang@windriver.com>
References: <cover.1337515887.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Cc: Zhenfeng.Zhao@windriver.com
Subject: [PATCH 1/2] replace os.system with subprocess.call
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
X-List-Received-Date: Sun, 20 May 2012 12:46:13 -0000
Content-Type: text/plain

Replace os.system with subprocess.call since the older function would
fail (more or less) silently if the executed program cannot be found

More info:
http://docs.python.org/library/subprocess.html#subprocess-replacements

[YOCTO #2075]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/fetch2/perforce.py            |    3 ++-
 bitbake/lib/bb/shell.py                      |    6 +++---
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py |    3 ++-
 bitbake/lib/bb/ui/ncurses.py                 |    4 ++--
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/perforce.py b/bitbake/lib/bb/fetch2/perforce.py
index cbdc848..6abf15d 100644
--- a/bitbake/lib/bb/fetch2/perforce.py
+++ b/bitbake/lib/bb/fetch2/perforce.py
@@ -27,6 +27,7 @@ BitBake build tools.
 
 from future_builtins import zip
 import os
+import subprocess
 import logging
 import bb
 from   bb import data
@@ -184,7 +185,7 @@ class Perforce(FetchMethod):
             dest = list[0][len(path)+1:]
             where = dest.find("#")
 
-            os.system("%s%s print -o %s/%s %s" % (p4cmd, p4opt, module, dest[:where], list[0]))
+            subprocess.call("%s%s print -o %s/%s %s" % (p4cmd, p4opt, module, dest[:where], list[0]), shell=True)
             count = count + 1
 
         if count == 0:
diff --git a/bitbake/lib/bb/shell.py b/bitbake/lib/bb/shell.py
index 1dd8d54..a83dedd 100644
--- a/bitbake/lib/bb/shell.py
+++ b/bitbake/lib/bb/shell.py
@@ -214,7 +214,7 @@ class BitBakeShellCommands:
         name = params[0]
         bbfile = self._findProvider( name )
         if bbfile is not None:
-            os.system( "%s %s" % ( os.environ.get( "EDITOR", "vi" ), bbfile ) )
+            subprocess.call( "%s %s" % ( os.environ.get( "EDITOR", "vi" ), bbfile ) , shell=True)
         else:
             print("ERROR: Nothing provides '%s'" % name)
     edit.usage = "<providee>"
@@ -259,7 +259,7 @@ class BitBakeShellCommands:
     def fileEdit( self, params ):
         """Call $EDITOR on a .bb file"""
         name = params[0]
-        os.system( "%s %s" % ( os.environ.get( "EDITOR", "vi" ), completeFilePath( name ) ) )
+        subprocess.call( "%s %s" % ( os.environ.get( "EDITOR", "vi" ), completeFilePath( name ) ) , shell=True)
     fileEdit.usage = "<bbfile>"
 
     def fileRebuild( self, params ):
@@ -370,7 +370,7 @@ SRC_URI = ""
 #}
 """, file=newpackage)
             newpackage.close()
-            os.system( "%s %s/%s" % ( os.environ.get( "EDITOR" ), fulldirname, filename ) )
+            subprocess.call( "%s %s/%s" % ( os.environ.get( "EDITOR" ), fulldirname, filename ) , shell=True)
     new.usage = "<directory> <filename>"
 
     def package( self, params ):
diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
index 1cfef80..2453dbc 100755
--- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
@@ -25,6 +25,7 @@ import gtk
 from bb.ui.crumbs.hobcolor import HobColors
 from bb.ui.crumbs.hobwidget import hic, HobViewTable, HobAltButton, HobButton
 from bb.ui.crumbs.hobpages import HobPage
+import subprocess
 
 #
 # ImageDetailsPage
@@ -299,7 +300,7 @@ class ImageDetailsPage (HobPage):
         self.show_all()
 
     def view_files_clicked_cb(self, button, image_addr):
-        os.system("xdg-open /%s" % image_addr)
+        subprocess.call("xdg-open /%s" % image_addr, shell=True)
 
     def refresh_package_detail_box(self, image_size):
         self.package_detail.update_line_widgets("Total image size: ", image_size)
diff --git a/bitbake/lib/bb/ui/ncurses.py b/bitbake/lib/bb/ui/ncurses.py
index 8524446..1425bbd 100644
--- a/bitbake/lib/bb/ui/ncurses.py
+++ b/bitbake/lib/bb/ui/ncurses.py
@@ -47,7 +47,7 @@
 
 from __future__ import division
 import logging
-import os, sys, curses, itertools, time
+import os, sys, curses, itertools, time, subprocess
 import bb
 import xmlrpclib
 from bb import ui
@@ -286,7 +286,7 @@ class NCursesUI:
 #                            bb.error("log data follows (%s)" % logfile)
 #                            number_of_lines = data.getVar("BBINCLUDELOGS_LINES", d)
 #                            if number_of_lines:
-#                                os.system('tail -n%s %s' % (number_of_lines, logfile))
+#                                subprocess.call('tail -n%s %s' % (number_of_lines, logfile), shell=True)
 #                            else:
 #                                f = open(logfile, "r")
 #                                while True:
-- 
1.7.1



