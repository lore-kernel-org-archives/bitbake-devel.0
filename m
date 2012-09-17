Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1TDk8s-0003Uc-8s
	for bitbake-devel@lists.openembedded.org;
	Tue, 18 Sep 2012 00:50:14 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q8HMbYIg002036
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Sep 2012 15:37:34 -0700 (PDT)
Received: from ord-lpggp2.wrs.com (128.224.65.244) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.309.2;
	Mon, 17 Sep 2012 15:37:34 -0700
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 17 Sep 2012 17:43:50 -0500
Message-ID: <1347921831-60604-4-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1347921831-60604-1-git-send-email-jason.wessel@windriver.com>
References: <1347921831-60604-1-git-send-email-jason.wessel@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 3/4] terminal: pass data store all the way through to terminal class
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
X-List-Received-Date: Mon, 17 Sep 2012 22:50:14 -0000
Content-Type: text/plain

Passing the data store will be needed for firing a custom event
for the screen class.

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 meta/classes/terminal.bbclass |    4 ++--
 meta/lib/oe/terminal.py       |   22 +++++++++++-----------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/meta/classes/terminal.bbclass b/meta/classes/terminal.bbclass
index 3cfc84b..2cd6f4c 100644
--- a/meta/classes/terminal.bbclass
+++ b/meta/classes/terminal.bbclass
@@ -25,7 +25,7 @@ def oe_terminal(command, title, d):
         bb.fatal('Devshell usage disabled with OE_TERMINAL')
     elif terminal != 'auto':
         try:
-            oe.terminal.spawn(terminal, command, title)
+            oe.terminal.spawn(terminal, command, title, None, d)
             return
         except oe.terminal.UnsupportedTerminal:
             bb.warn('Unsupported terminal "%s", defaulting to "auto"' %
@@ -34,7 +34,7 @@ def oe_terminal(command, title, d):
             bb.fatal('Unable to spawn terminal %s: %s' % (terminal, exc))
 
     try:
-        oe.terminal.spawn_preferred(command, title)
+        oe.terminal.spawn_preferred(command, title, None, d)
     except oe.terminal.NoSupportedTerminals:
         bb.fatal('No valid terminal found, unable to open devshell')
     except oe.terminal.ExecutionError as exc:
diff --git a/meta/lib/oe/terminal.py b/meta/lib/oe/terminal.py
index d66309f..c71d6ad 100644
--- a/meta/lib/oe/terminal.py
+++ b/meta/lib/oe/terminal.py
@@ -28,7 +28,7 @@ class Registry(oe.classutils.ClassRegistry):
 class Terminal(Popen):
     __metaclass__ = Registry
 
-    def __init__(self, sh_cmd, title=None, env=None):
+    def __init__(self, sh_cmd, title=None, env=None, d=None):
         fmt_sh_cmd = self.format_command(sh_cmd, title)
         try:
             Popen.__init__(self, fmt_sh_cmd, env=env)
@@ -47,7 +47,7 @@ class Terminal(Popen):
             return [element.format(**fmt) for element in self.command]
 
 class XTerminal(Terminal):
-    def __init__(self, sh_cmd, title=None, env=None):
+    def __init__(self, sh_cmd, title=None, env=None, d=None):
         Terminal.__init__(self, sh_cmd, title, env)
         if not os.environ.get('DISPLAY'):
             raise UnsupportedTerminal(self.name)
@@ -60,7 +60,7 @@ class Xfce(XTerminal):
     command = 'Terminal -T "{title}" -e "{command}"'
     priority = 2
 
-    def __init__(self, command, title=None, env=None):
+    def __init__(self, command, title=None, env=None, d=None):
         # Upstream binary name is Terminal but Debian/Ubuntu use
         # xfce4-terminal to avoid possible(?) conflicts
         distro = distro_name()
@@ -68,20 +68,20 @@ class Xfce(XTerminal):
             cmd = 'xfce4-terminal -T "{title}" -e "{command}"'
         else:
             cmd = command
-        XTerminal.__init__(self, cmd, title, env)
+        XTerminal.__init__(self, cmd, title, env, d)
 
 class Konsole(XTerminal):
     command = 'konsole -T "{title}" -e {command}'
     priority = 2
 
-    def __init__(self, sh_cmd, title=None, env=None):
+    def __init__(self, sh_cmd, title=None, env=None, d=None):
         # Check version
         vernum = check_konsole_version("konsole")
         if vernum:
             if vernum.split('.')[0] == "2":
                 logger.debug(1, 'Konsole from KDE 4.x will not work as devshell, skipping')
                 raise UnsupportedTerminal(self.name)
-        XTerminal.__init__(self, sh_cmd, title, env)
+        XTerminal.__init__(self, sh_cmd, title, env, d)
 
 class XTerm(XTerminal):
     command = 'xterm -T "{title}" -e {command}'
@@ -94,7 +94,7 @@ class Rxvt(XTerminal):
 class Screen(Terminal):
     command = 'screen -D -m -t "{title}" -S devshell {command}'
 
-    def __init__(self, sh_cmd, title=None, env=None):
+    def __init__(self, sh_cmd, title=None, env=None, d=None):
         s_id = "devshell_%i" % os.getpid()
         self.command = "screen -D -m -t \"{title}\" -S %s {command}" % s_id
         Terminal.__init__(self, sh_cmd, title, env)
@@ -105,18 +105,18 @@ class Screen(Terminal):
 def prioritized():
     return Registry.prioritized()
 
-def spawn_preferred(sh_cmd, title=None, env=None):
+def spawn_preferred(sh_cmd, title=None, env=None, d=None):
     """Spawn the first supported terminal, by priority"""
     for terminal in prioritized():
         try:
-            spawn(terminal.name, sh_cmd, title, env)
+            spawn(terminal.name, sh_cmd, title, env, d)
             break
         except UnsupportedTerminal:
             continue
     else:
         raise NoSupportedTerminals()
 
-def spawn(name, sh_cmd, title=None, env=None):
+def spawn(name, sh_cmd, title=None, env=None, d=None):
     """Spawn the specified terminal, by name"""
     logger.debug(1, 'Attempting to spawn terminal "%s"', name)
     try:
@@ -124,7 +124,7 @@ def spawn(name, sh_cmd, title=None, env=None):
     except KeyError:
         raise UnsupportedTerminal(name)
 
-    pipe = terminal(sh_cmd, title, env)
+    pipe = terminal(sh_cmd, title, env, d)
     output = pipe.communicate()[0]
     if pipe.returncode != 0:
         raise ExecutionError(sh_cmd, pipe.returncode, output)
-- 
1.7.1



