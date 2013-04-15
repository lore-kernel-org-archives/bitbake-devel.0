Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei.adrianx.dinu@intel.com>) id 1URh42-0004BX-JI
	for bitbake-devel@lists.openembedded.org;
	Mon, 15 Apr 2013 12:55:12 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 15 Apr 2013 03:37:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,474,1363158000"; d="scan'208";a="286240196"
Received: from adinu-vostro-460.rb.intel.com ([10.237.105.147])
	by azsmga001.ch.intel.com with ESMTP; 15 Apr 2013 03:37:39 -0700
From: Andrei Dinu <andrei.adrianx.dinu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 15 Apr 2013 13:38:14 +0300
Message-Id: <1366022295-4744-3-git-send-email-andrei.adrianx.dinu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1366022295-4744-1-git-send-email-andrei.adrianx.dinu@intel.com>
References: <1366022295-4744-1-git-send-email-andrei.adrianx.dinu@intel.com>
Subject: [PATCH 2/3] hob.py : implemented handle_sys_exit() for hob
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
X-List-Received-Date: Mon, 15 Apr 2013 10:55:18 -0000

In order to display the error shown by bitbake in a
dialog rather than in the console, handle_sys_exit()
was implemented in hob ui.

Signed-off-by: Andrei Dinu <andrei.adrianx.dinu@intel.com>
---
 bitbake/lib/bb/ui/hob.py |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/hob.py b/bitbake/lib/bb/ui/hob.py
index 55bd84c..3053eb0 100755
--- a/bitbake/lib/bb/ui/hob.py
+++ b/bitbake/lib/bb/ui/hob.py
@@ -11,8 +11,6 @@
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
 #
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
@@ -22,6 +20,7 @@
 
 import sys
 import os
+from bb.ui.crumbs.hig import hoberror
 requirements = "FATAL: Hob requires Gtk+ 2.20.0 or higher, PyGtk 2.21.0 or higher"
 try:
     import gobject
@@ -83,6 +82,11 @@ def main (server = None, eventHandler = None):
     finally:
         hobHandler.cancel_build(force = True)
 
+def handle_sys_exit():
+    dialog = hoberror.HobError(bb.event.ui_queue[len(bb.event.ui_queue)-1].getMessage())
+    bb.event.ui_queue = []
+    dialog.run()
+
 if __name__ == "__main__":
     try:
         ret = main()
-- 
1.7.9.5



