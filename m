Return-Path: <Maxin.John@enea.com>
Received: from mx-3.enea.com (sestofw01.enea.se [192.36.1.252])
	by mail.openembedded.org (Postfix) with SMTP id 8C96172DD1
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Feb 2015 13:41:20 +0000 (UTC)
Received: from maxin-HP-EliteBook-Folio-9470m.enea.se (172.16.141.163) by
	smtp.enea.com (172.21.1.208) with Microsoft SMTP Server id 14.3.224.2;
	Mon, 9 Feb 2015 14:41:19 +0100
From: "Maxin B. John" <maxin.john@enea.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 9 Feb 2015 14:41:17 +0100
Message-ID: <1423489277-7774-1-git-send-email-maxin.john@enea.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Received-SPF: None (SESTOEX08.enea.se: maxin.john@enea.com does not
	designate permitted sender hosts)
Subject: [PATCH v2] depexp.py: Fix segfault if DISPLAY is not set
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 09 Feb 2015 13:41:24 -0000
Content-Type: text/plain

bitbake -g -u depexp <package> segfaults when DISPLAY is not set
properly. Fix it with a proper check.

[YOCTO #7299]

Signed-off-by: Maxin B. John <maxin.john@enea.com>
---
 bitbake/lib/bb/ui/depexp.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/bitbake/lib/bb/ui/depexp.py b/bitbake/lib/bb/ui/depexp.py
index 0c71a3e..1b8f0b2 100644
--- a/bitbake/lib/bb/ui/depexp.py
+++ b/bitbake/lib/bb/ui/depexp.py
@@ -17,6 +17,7 @@
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
+import sys
 import gobject
 import gtk
 import Queue
@@ -215,6 +216,12 @@ def main(server, eventHandler, params):
         print("XMLRPC Fault getting commandline:\n %s" % x)
         return
 
+    try:
+        gtk.init_check()
+    except:
+        sys.stderr.write("Please set DISPLAY variable before running this command \n")
+        return
+
     shutdown = 0
 
     gtkgui = gtkthread(shutdown)
-- 
1.9.1


