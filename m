Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1SczdN-0004l4-Kj
	for bitbake-devel@lists.openembedded.org;
	Fri, 08 Jun 2012 15:53:50 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q58DhJEF023991
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 8 Jun 2012 06:43:19 -0700 (PDT)
Received: from ord-jrw.wrs.com (172.25.32.41) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Fri, 8 Jun 2012 06:43:19 -0700
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 8 Jun 2012 08:41:53 -0500
Message-ID: <1339162913-23759-19-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1339162913-23759-1-git-send-email-jason.wessel@windriver.com>
References: <1339162913-23759-1-git-send-email-jason.wessel@windriver.com>
MIME-Version: 1.0
Subject: [PATCH v4 18/18] terminal.py: Make screen_inline have a higher priority than screen
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
X-List-Received-Date: Fri, 08 Jun 2012 13:53:50 -0000
Content-Type: text/plain

The screen_inline is far easier to use and less confusing for
beginner users of oe-core.  Making this the default improves
the end user experience, and it is possible to change
the OE_TERMINAL variable as well as the default fall back list
with OE_TERMINAL_PREFERRED for anyone who desires the original
behavior.

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 meta/lib/oe/terminal.py |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/meta/lib/oe/terminal.py b/meta/lib/oe/terminal.py
index 943e5db..3122d56 100644
--- a/meta/lib/oe/terminal.py
+++ b/meta/lib/oe/terminal.py
@@ -55,11 +55,11 @@ class XTerminal(Terminal):
 
 class Gnome(XTerminal):
     command = 'gnome-terminal --disable-factory -t "{title}" -x {command}'
-    priority = 2
+    priority = 3
 
 class Xfce(XTerminal):
     command = 'Terminal -T "{title}" -e "{command}"'
-    priority = 2
+    priority = 3
 
     def __init__(self, command, title=None, env=None):
         # Upstream binary name is Terminal but Debian/Ubuntu use
@@ -73,7 +73,7 @@ class Xfce(XTerminal):
 
 class Konsole(XTerminal):
     command = 'konsole -T "{title}" -e {command}'
-    priority = 2
+    priority = 3
 
     def __init__(self, command, title=None, env=None):
         # Check version
@@ -86,14 +86,15 @@ class Konsole(XTerminal):
 
 class XTerm(XTerminal):
     command = 'xterm -T "{title}" -e {command}'
-    priority = 1
+    priority = 2
 
 class Rxvt(XTerminal):
     command = 'rxvt -T "{title}" -e {command}'
-    priority = 1
+    priority = 2
 
 class Screen_inline(Terminal):
     command = 'screen -D -m -t "{title}" -S devshell {command}'
+    priority = 1
 
     def __init__(self, command, title=None, env=None):
         Terminal.__init__(self, command, title, env)
-- 
1.7.10



