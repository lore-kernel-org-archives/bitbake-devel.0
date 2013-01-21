Received: from ra.se.axis.com ([195.60.68.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <olof.johansson@axis.com>) id 1TxDu6-0005yL-M8
	for bitbake-devel@lists.openembedded.org;
	Mon, 21 Jan 2013 10:43:01 +0100
Received: from localhost (localhost [127.0.0.1])
	by ra.se.axis.com (Postfix) with ESMTP id 1185111F7E
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Jan 2013 10:18:06 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at ra.se.axis.com
Received: from ra.se.axis.com ([127.0.0.1])
	by localhost (ra.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id BIcOHKfXiPvq for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Jan 2013 10:18:04 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by ra.se.axis.com (Postfix) with ESMTP id 8268511FA7
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Jan 2013 10:18:04 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by seth.se.axis.com (Postfix) with ESMTP id 2BA423E29E
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Jan 2013 10:18:04 +0100 (CET)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.2.176.0; Mon, 21 Jan 2013
	10:18:04 +0100
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id 0D7BA9C078; 
	Mon, 21 Jan 2013 10:18:04 +0100 (CET)
From: Olof Johansson <olof.johansson@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 21 Jan 2013 10:18:03 +0100
Message-ID: <1358759883-7566-7-git-send-email-olof.johansson@axis.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1358759883-7566-1-git-send-email-olof.johansson@axis.com>
References: <1358759883-7566-1-git-send-email-olof.johansson@axis.com>
MIME-Version: 1.0
Subject: [PATCH 6/6] fetch2: Add SFTP fetcher
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
X-List-Received-Date: Mon, 21 Jan 2013 09:43:01 -0000
Content-Type: text/plain

This fetcher differs from the SSH fetcher in that it adheres more
strictly to the SECSH URI internet draft --- it uses the sftp://
instead of the ssh:// scheme, and it uses sftp instead of scp.

Signed-off-by: Olof Johansson <olof.johansson@axis.com>
---
 lib/bb/fetch2/__init__.py |    2 +
 lib/bb/fetch2/sftp.py     |  104 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)
 create mode 100644 lib/bb/fetch2/sftp.py

diff --git lib/bb/fetch2/__init__.py lib/bb/fetch2/__init__.py
index 549e261..86302f7 100644
--- lib/bb/fetch2/__init__.py
+++ lib/bb/fetch2/__init__.py
@@ -1448,6 +1448,7 @@ from . import svn
 from . import wget
 from . import svk
 from . import ssh
+from . import sftp
 from . import perforce
 from . import bzr
 from . import hg
@@ -1461,6 +1462,7 @@ methods.append(git.Git())
 methods.append(cvs.Cvs())
 methods.append(svk.Svk())
 methods.append(ssh.SSH())
+methods.append(sftp.SFTP())
 methods.append(perforce.Perforce())
 methods.append(bzr.Bzr())
 methods.append(hg.Hg())
diff --git lib/bb/fetch2/sftp.py lib/bb/fetch2/sftp.py
new file mode 100644
index 0000000..0902ce7
--- /dev/null
+++ lib/bb/fetch2/sftp.py
@@ -0,0 +1,104 @@
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
+"""
+BitBake SFTP Fetch implementation
+
+Class for fetching files via SFTP. It tries to adhere to the (now
+expired) IETF Internet Draft for "Uniform Resource Identifier (URI)
+Scheme for Secure File Transfer Protocol (SFTP) and Secure Shell
+(SSH)" (SECSH URI).
+
+It uses SFTP (as to adhere to the SECSH URI specification). It only
+supports key based authentication, not password. This class, unlike
+the SSH fetcher, does not support fetching a directory tree from the
+remote.
+
+  http://tools.ietf.org/html/draft-ietf-secsh-scp-sftp-ssh-uri-04
+  https://www.iana.org/assignments/uri-schemes/prov/sftp
+  https://tools.ietf.org/html/draft-ietf-secsh-filexfer-13
+
+"""
+
+# Copyright (C) 2013, Olof Johansson <olof.johansson@axis.com>
+#
+# Based in part on bb.fetch2.wget:
+#    Copyright (C) 2003, 2004  Chris Larson
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+# Based on functions from the base bb module, Copyright 2003 Holger Schurig
+
+import os
+import bb
+import urllib
+import commands
+from bb import data
+from bb.fetch2 import URI
+from bb.fetch2 import FetchMethod
+from bb.fetch2 import runfetchcmd
+
+
+class SFTP(FetchMethod):
+    """Class to fetch urls via 'sftp'"""
+    def supports(self, url, ud, d):
+        """
+        Check to see if a given url can be fetched with sftp.
+        """
+        return ud.type in ['sftp']
+
+    def recommends_checksum(self, urldata):
+        return True
+
+    def urldata_init(self, ud, d):
+        if 'protocol' in ud.parm and ud.parm['protocol'] == 'git':
+            raise bb.fetch2.ParameterError(
+                "Invalid protocol - if you wish to fetch from a git " +
+                "repository using ssh, you need to instead use the " +
+                "git:// prefix with protocol=ssh", ud.url)
+
+        if 'downloadfilename' in ud.parm:
+            ud.basename = ud.parm['downloadfilename']
+        else:
+            ud.basename = os.path.basename(ud.path)
+
+        ud.localfile = data.expand(urllib.unquote(ud.basename), d)
+
+    def download(self, uri, ud, d):
+        """Fetch urls"""
+
+        urlo = URI(uri)
+        basecmd = 'sftp -oPasswordAuthentication=no'
+        port = ''
+        if urlo.port:
+            port = '-P %d' % urlo.port
+            urlo.port = None
+
+        dldir = data.getVar('DL_DIR', d, True)
+        lpath = os.path.join(dldir, ud.localfile)
+
+        user = ''
+        if urlo.userinfo:
+            user = urlo.userinfo + '@'
+
+        remote = '%s%s:%s' % (user, urlo.hostname, urlo.path)
+
+        cmd = '%s %s %s %s' % (basecmd, port, commands.mkarg(remote),
+                               commands.mkarg(lpath))
+
+        bb.fetch2.check_network_access(d, cmd, uri)
+        runfetchcmd(cmd, d)
+        return True
+
+    def checkstatus(self, uri, ud, d):
+        return self.download(uri, ud, d, True)
-- 
1.7.10.4



