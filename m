Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1ScN0i-0006eP-PJ
	for bitbake-devel@lists.openembedded.org;
	Wed, 06 Jun 2012 22:39:21 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q56KSq8L013177
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 6 Jun 2012 13:28:52 -0700 (PDT)
Received: from ord-jrw.wrs.com (172.25.32.41) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Wed, 6 Jun 2012 13:28:52 -0700
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 6 Jun 2012 15:28:38 -0500
Message-ID: <1339014519-9972-15-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1339014519-9972-1-git-send-email-jason.wessel@windriver.com>
References: <1339014519-9972-1-git-send-email-jason.wessel@windriver.com>
MIME-Version: 1.0
Subject: [PATCH v3 14/15] terminal.bbclass: Allow OE_TERMINAL_PREFERRED to override the fallback order for OE_TERMINAL
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
X-List-Received-Date: Wed, 06 Jun 2012 20:39:21 -0000
Content-Type: text/plain

With the addition of two different modes for the use of screen, an end
user may prefer to set specific fall back order for an X vs tty
environment.  This patch modifies the terminal.bbclass and terminal.py
to allow the variable OE_TERMINAL_PREFERRED to control the order of
trying the various supported OE_TERMINAL's.

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 meta/classes/terminal.bbclass |    3 ++-
 meta/lib/oe/terminal.py       |    8 +++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/meta/classes/terminal.bbclass b/meta/classes/terminal.bbclass
index 3cfc84b..2be6974 100644
--- a/meta/classes/terminal.bbclass
+++ b/meta/classes/terminal.bbclass
@@ -4,6 +4,7 @@ OE_TERMINAL[choices] = 'auto none \
                         ${@" ".join(o.name \
                                     for o in oe.terminal.prioritized())}'
 
+OE_TERMINAL_PREFERRED ?= "auto"
 OE_TERMINAL_EXPORTS = 'XAUTHORITY SHELL DBUS_SESSION_BUS_ADDRESS DISPLAY EXTRA_OEMAKE SCREENDIR'
 OE_TERMINAL_EXPORTS[type] = 'list'
 
@@ -34,7 +35,7 @@ def oe_terminal(command, title, d):
             bb.fatal('Unable to spawn terminal %s: %s' % (terminal, exc))
 
     try:
-        oe.terminal.spawn_preferred(command, title)
+        oe.terminal.spawn_preferred(d.getVar('OE_TERMINAL_PREFERRED', True), command, title)
     except oe.terminal.NoSupportedTerminals:
         bb.fatal('No valid terminal found, unable to open devshell')
     except oe.terminal.ExecutionError as exc:
diff --git a/meta/lib/oe/terminal.py b/meta/lib/oe/terminal.py
index ca94e73..943e5db 100644
--- a/meta/lib/oe/terminal.py
+++ b/meta/lib/oe/terminal.py
@@ -111,11 +111,13 @@ class Screen(Terminal):
 def prioritized():
     return Registry.prioritized()
 
-def spawn_preferred(command, title=None, env=None):
+def spawn_preferred(priorityList, command, title=None, env=None):
     """Spawn the first supported terminal, by priority"""
-    for terminal in prioritized():
+    if priorityList == "auto":
+        priorityList = ' '.join(o.name for o in prioritized())
+    for terminal in priorityList.split():
         try:
-            spawn(terminal.name, command, title, env)
+            spawn(terminal, command, title, env)
             break
         except UnsupportedTerminal:
             continue
-- 
1.7.10



