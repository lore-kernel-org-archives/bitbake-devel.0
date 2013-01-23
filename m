Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <constantinx.musca@intel.com>) id 1Ty1xd-0003kp-A0
	for bitbake-devel@lists.openembedded.org;
	Wed, 23 Jan 2013 16:09:58 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 23 Jan 2013 06:53:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,523,1355126400"; d="scan'208";a="275653527"
Received: from costin-desktop (HELO localhost.localdomain) ([10.237.105.152])
	by orsmga002.jf.intel.com with ESMTP; 23 Jan 2013 06:53:13 -0800
From: Constantin Musca <constantinx.musca@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 23 Jan 2013 16:54:03 +0200
Message-Id: <1358952843-14300-1-git-send-email-constantinx.musca@intel.com>
X-Mailer: git-send-email 1.7.11.7
Cc: Constantin Musca <constantinx.musca@intel.com>
Subject: [PATCH 1/3] prserv: use only PRSERV_HOST
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
X-List-Received-Date: Wed, 23 Jan 2013 15:09:59 -0000

- remove PRSERV_PORT variable
- use 'hostname:port' as PRSERV_HOST format
- use 'localhost:0' for enabling the local PRServer

[YOCTO #3744]

Signed-off-by: Constantin Musca <constantinx.musca@intel.com>
---
 bitbake/lib/prserv/serv.py | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/prserv/serv.py b/bitbake/lib/prserv/serv.py
index 5567c6f..d8bdf31 100644
--- a/bitbake/lib/prserv/serv.py
+++ b/bitbake/lib/prserv/serv.py
@@ -268,10 +268,17 @@ def is_local_special(host, port):
 
 def auto_start(d):
     global singleton
-    if (not d.getVar('PRSERV_HOST', True)) or (not d.getVar('PRSERV_PORT', True)):
+
+    host_params = filter(None, (d.getVar('PRSERV_HOST', True) or '').split(':'))
+    if not host_params:
+        return True
+
+    if len(host_params) != 2:
+        logger.critical('\n'.join(['PRSERV_HOST: incorrect format',
+                'Usage: PRSERV_HOST = "<hostname>:<port>"']))
         return True
 
-    if is_local_special(d.getVar('PRSERV_HOST', True), int(d.getVar('PRSERV_PORT', True))) and not singleton:
+    if is_local_special(host_params[0], int(host_params[1])) and not singleton:
         import bb.utils
         cachedir = (d.getVar("PERSISTENT_DIR", True) or d.getVar("CACHE", True))
         if not cachedir:
@@ -285,8 +292,8 @@ def auto_start(d):
     if singleton:
         host, port = singleton.getinfo()
     else:
-        host = d.getVar('PRSERV_HOST', True)
-        port = int(d.getVar('PRSERV_PORT', True))
+        host = host_params[0]
+        port = int(host_params[1])
 
     try:
         return PRServerConnection(host,port).ping()
-- 
1.7.11.7



