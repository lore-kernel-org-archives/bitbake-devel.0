Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RoHko-00049Y-H3
	for bitbake-devel@lists.openembedded.org;
	Fri, 20 Jan 2012 17:55:54 +0100
Received: by opal (Postfix, from userid 111)
	id A6D951033A; Fri, 20 Jan 2012 16:57:48 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120120165748.A6D951033A@opal>
Date: Fri, 20 Jan 2012 16:57:48 +0000 (UTC)
From: git@git.openembedded.org
Subject: Martin Jansa : prserv: fix import of sqlite3
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
X-List-Received-Date: Fri, 20 Jan 2012 16:55:54 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 9a57ec705cf5c932d8c2a35852db7a4627c57937
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=9a57ec705cf5c932d8c2a35852db7a4627c57937

Author: Martin Jansa <martin.jansa@gmail.com>
Date:   Sun Jan 15 22:03:53 2012 +0100

prserv: fix import of sqlite3

* this is used in all other bitbake parts where sqlite3 is used, don't
  know why it wasn't used here, but it fails e.g. on Gentoo
  Traceback (most recent call last):
    File "bin/bitbake", line 39, in <module>
      from bb import cooker
    File "lib/bb/cooker.py", line 39, in <module>
      import prserv.serv
    File "lib/prserv/serv.py", line 4, in <module>
      import xmlrpclib,sqlite3
  ImportError: No module named sqlite3

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/prserv/serv.py |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index a759fa7..fa437f9 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -1,7 +1,12 @@
 import os,sys,logging
 import signal, time, atexit, threading
 from SimpleXMLRPCServer import SimpleXMLRPCServer, SimpleXMLRPCRequestHandler
-import xmlrpclib,sqlite3
+import xmlrpclib
+
+try:
+    import sqlite3
+except ImportError:
+    from pysqlite2 import dbapi2 as sqlite3
 
 import bb.server.xmlrpc
 import prserv



