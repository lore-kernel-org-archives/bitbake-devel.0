Return-Path: <Konrad.Scherer@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 82A3B60167
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 24 Sep 2014 13:06:45 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.9/8.14.5) with ESMTP id s8OD6jtx001486
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 24 Sep 2014 06:06:46 -0700 (PDT)
Received: from yow-kscherer-d1.wrs.com (128.224.56.217) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.174.1; Wed, 24 Sep 2014 06:06:42 -0700
From: Konrad Scherer <konrad.scherer@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 24 Sep 2014 09:06:42 -0400
Message-ID: <1411564002-17672-1-git-send-email-konrad.scherer@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Subject: [PATCH] Improve error message when prserver cannot bind to supplied host address
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
X-List-Received-Date: Wed, 24 Sep 2014 13:06:47 -0000
Content-Type: text/plain

From: Konrad Scherer <Konrad.Scherer@windriver.com>

If localhost resolves to a remote address (due to a misconfigured network),
starting the pr server will fail without useful information.

To reproduce, add '<bogus ip> localhost' to /etc/hosts and run
'bitbake -p'. The error message will be:

ERROR: Timeout while attempting to communicate with bitbake server
ERROR: Could not connect to server False:

Running 'bitbake-prserv --host=localhost --port=0 --start' will fail with:

error: [Errno 99] Cannot assign requested address

Since these errors does not show the IP address of the attempted socket
binding, this results in a lot of wasted time looking at firewall rules, etc.

This patch results in the following error message if the socket binding fails:

PR Server unable to bind to <bogus ip>:0

Signed-off-by: Konrad Scherer <Konrad.Scherer@windriver.com>
---
 lib/prserv/serv.py | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 1e170ce..1b08d59 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -38,8 +38,17 @@ singleton = None
 class PRServer(SimpleXMLRPCServer):
     def __init__(self, dbfile, logfile, interface, daemon=True):
         ''' constructor '''
-        SimpleXMLRPCServer.__init__(self, interface,
-                                    logRequests=False, allow_none=True)
+        import socket
+        try:
+            SimpleXMLRPCServer.__init__(self, interface,
+                                        logRequests=False, allow_none=True)
+        except socket.error:
+            ip=socket.gethostbyname(interface[0])
+            port=interface[1]
+            msg="PR Server unable to bind to %s:%s\n" % (ip, port)
+            sys.stderr.write(msg)
+            raise PRServiceConfigError
+
         self.dbfile=dbfile
         self.daemon=daemon
         self.logfile=logfile
-- 
1.9.1


