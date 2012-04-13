Received: from moutng.kundenserver.de ([212.227.17.9])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <enrico.scholz@informatik.tu-chemnitz.de>)
	id 1SIhf9-0002ev-LW for bitbake-devel@lists.openembedded.org;
	Fri, 13 Apr 2012 16:39:47 +0200
Received: from mail.bigo.ensc.de (p54ADE1CF.dip.t-dialin.net [84.173.225.207])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0LlGmU-1RlHnV1yZa-00azYd; Fri, 13 Apr 2012 16:06:23 +0200
Received: from sheridan.bigo.ensc.de (sheridan.bigo.ensc.de [192.168.46.11])
	by mail.bigo.ensc.de (8.14.4/8.14.4) with ESMTP id q3DE6MiA007823;
	Fri, 13 Apr 2012 16:06:22 +0200
Received: from ensc by sheridan.bigo.ensc.de with local (Exim 4.76)
	(envelope-from <ensc@sheridan.bigo.ensc.de>)
	id 1SIh8n-000475-OR; Fri, 13 Apr 2012 16:06:21 +0200
From: Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 13 Apr 2012 16:06:12 +0200
Message-Id: <1334325973-15760-2-git-send-email-enrico.scholz@informatik.tu-chemnitz.de>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <1334325973-15760-1-git-send-email-enrico.scholz@informatik.tu-chemnitz.de>
References: <1334325973-15760-1-git-send-email-enrico.scholz@informatik.tu-chemnitz.de>
Sender: Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de>
X-Provags-ID: V02:K0:KU99SCIwlJvQy9pPqafoqweAgnvH3zfzl92gTulX2wD
	veMI31PS2vfQyuvQ4viLwoA8O/37jXqsvDt1P5APq1SmVDGln+
	8JNIgO6rUNsUOhXe+nHhcKa5RJPJEj9+5+IiyUUOBnFSKSKwQE
	ZgRBbDYgWlxxYEJOemQuSQ/dZ3uU0UxJBPSGeMVKGpTcJ1/QWi
	7LTWTUi2rm1Nur/sYUNAZ43IWHObJ+gQmBVNj9ktNGp1PfcM8Y
	yUcFKe2B4fxQFYfBH12JM8HYcr5UKC1oJtGn/cvWqkRpHrVoRf
	Ecq2GLY+lvmRYcgLjYJm159r5bSnRspaRWjUib8/XDeeWKjrks
	dXprpV6fUfdjnoqP8UFgOtCXTbScLsXRDbAN2+nH5mqfPY1ytX
	jH/hCpQC1lSAAN+k/hwrq2I2I3h1YKjOfqzqxKLcBTAluUkmUo tQ4fu
Cc: Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de>
Subject: [PATCH 2/3] runfetchcmd(): allow to use a sequence as cmd
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
X-List-Received-Date: Fri, 13 Apr 2012 14:39:47 -0000

Patch removes the explicit 'shell=True' from the bb.process.run() call
and modifies the environment directly.  This allows to use a sequence as
the cmd option which in turn, removes the need for quoting filenames
manually.

Unfortunately, modifying only runfetchmod() does not allow code like

  runfetchcmd([ud.basecmd, 'remote', 'add', ..., repourl])

because 'ud.basecmd' (expanded e.g. from ${FETCHCMD_git}) might contain
a command plus shell escaped options.

To cope with such situations, a runfetchcmd2() function was added
which quotes the arguments but takes the cmd as-is.

Having basecmd splitted off from cmdline string reduces information
printed out by check_network_access().  To retain the old behavior, an
optional argument was added which allows to specify the basecmd.

Signed-off-by: Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de>
---
 lib/bb/fetch2/__init__.py |   26 +++++++++++++++++++++-----
 1 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 9afbc4f..168efb5 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -407,10 +407,11 @@ def runfetchcmd(cmd, d, quiet = False, cleanup = []):
                   'SSH_AUTH_SOCK', 'SSH_AGENT_PID', 'HOME',
                   'GIT_PROXY_IGNORE', 'SOCKS5_USER', 'SOCKS5_PASSWD']
 
+    new_env = os.environ.copy()
     for var in exportvars:
         val = d.getVar(var, True)
         if val:
-            cmd = 'export ' + var + '=\"%s\"; %s' % (val, cmd)
+            new_env[var] = val
 
     logger.debug(1, "Running %s", cmd)
 
@@ -418,7 +419,7 @@ def runfetchcmd(cmd, d, quiet = False, cleanup = []):
     error_message = ""
 
     try:
-        (output, errors) = bb.process.run(cmd, shell=True, stderr=subprocess.PIPE)
+        (output, errors) = bb.process.run(cmd, stderr=subprocess.PIPE, env=new_env)
         success = True
     except bb.process.NotFoundError as e:
         error_message = "Fetch command %s" % (e.command)
@@ -438,14 +439,29 @@ def runfetchcmd(cmd, d, quiet = False, cleanup = []):
 
     return output
 
-def check_network_access(d, info = "", url = None):
+def runfetchcmd2(cmd, args, d, **opts):
+    cmd += ' '
+    cmd += ' '.join(map(lambda a: pipes.quote(a), args))
+    return runfetchcmd(cmd, d, **opts)
+
+def check_network_access(d, info = "", url = None, base_cmd = None):
     """
     log remote network access, and error if BB_NO_NETWORK is set
     """
+    if base_cmd:
+        info_str = base_cmd + ' '
+    else:
+        info_str = ''
+
+    if isinstance(info, list) or isinstance(info, tuple):
+        info_str += ' '.join(map(lambda a: pipes.quote(a), info))
+    else:
+        info_str += '%s' % info
+
     if d.getVar("BB_NO_NETWORK", True) == "1":
-        raise NetworkAccess(url, info)
+        raise NetworkAccess(url, info_str)
     else:
-        logger.debug(1, "Fetcher accessed the network with the command %s" % info)
+        logger.debug(1, "Fetcher accessed the network with the command %s" % info_str)
 
 def try_mirrors(d, origud, mirrors, check = False):
     """
-- 
1.7.7.6



