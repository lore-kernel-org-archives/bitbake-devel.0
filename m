Return-Path: <haris.okanovic@ni.com>
Received: from ni.com (skprod3.natinst.com [130.164.80.24])
	by mail.openembedded.org (Postfix) with ESMTP id 5A91F77371
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 23 Feb 2016 17:36:43 +0000 (UTC)
Received: from us-aus-mgwout2.amer.corp.natinst.com (nb-snip2-1338.natinst.com
	[130.164.19.135])
	by us-aus-skprod3.natinst.com (8.15.0.59/8.15.0.59) with ESMTP id
	u1NHaia9023030 for <bitbake-devel@lists.openembedded.org>;
	Tue, 23 Feb 2016 11:36:44 -0600
Received: from harisdt.amer.corp.natinst.com ([130.164.14.198])
	by us-aus-mgwout2.amer.corp.natinst.com (Lotus Domino Release 8.5.3FP6
	HF1218) with ESMTP id 2016022311364447-70390 ;
	Tue, 23 Feb 2016 11:36:44 -0600 
From: Haris Okanovic <haris.okanovic@ni.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 23 Feb 2016 11:36:33 -0600
Message-Id: <1456248993-17387-1-git-send-email-haris.okanovic@ni.com>
X-Mailer: git-send-email 2.6.2
X-MIMETrack: Itemize by SMTP Server on US-AUS-MGWOut2/AUS/H/NIC(Release
	8.5.3FP6 HF1218|December 12, 2014) at 02/23/2016 11:36:44 AM,
	Serialize by Router on US-AUS-MGWOut2/AUS/H/NIC(Release 8.5.3FP6
	HF1218|December 12, 2014) at 02/23/2016 11:36:44 AM,
	Serialize complete at 02/23/2016 11:36:44 AM
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:, ,
	definitions=2016-02-23_10:, , signatures=0
X-Mailman-Approved-At: Wed, 24 Feb 2016 09:51:21 +0000
Cc: Haris Okanovic <haris.okanovic@ni.com>, ken.sharp@ni.com,
	bill.pittman@ni.com
Subject: [PATCH] prserv: Add dump_db()
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
X-List-Received-Date: Tue, 23 Feb 2016 17:36:45 -0000

Returns a script (string) that reconstructs the state of the
entire database at the time this function is called. The script
language is defined by the backing database engine, which is a
function of server configuration.
Returns None if the database engine does not support dumping to
script or if some other error is encountered in processing.

The SQLite3 implementation in db.py calls iterdump() [1] to generate
a script. iterdump() is the library equivalent of the `sqlite3 .dump`
shell command, and the scripts are compatible. Execute the script in
an empty SQLite3 database using the sqlite3 utility to restore a backup
of prserv.

Use case: Backup a live PR server database in a non-racy way, such
that one could snapshot the entire database after a set of bitbake
builds all using a shared server. I.e. All changes made prior to
the start of a dump_db() operation should be committed and captured
in the script. Subsequent changes made during the backup process are
not guaranteed to be captured.

Testing: ~7MB database backs up in ~1s while PR server is under load
from 32 thread bitbake builds on two separate machines.

[1] https://docs.python.org/2/library/sqlite3.html#sqlite3.Connection.iterdump

Signed-off-by: Haris Okanovic <haris.okanovic@ni.com>
Reviewed-by: Ken Sharp <ken.sharp@ni.com>
Reviewed-by: Bill Pittman <bill.pittman@ni.com>
---
 lib/prserv/db.py   |  8 ++++++++
 lib/prserv/serv.py | 25 +++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/lib/prserv/db.py b/lib/prserv/db.py
index 36c9f7b..2a86184 100644
--- a/lib/prserv/db.py
+++ b/lib/prserv/db.py
@@ -231,6 +231,14 @@ class PRTable(object):
                 datainfo.append(col)
         return (metainfo, datainfo)
 
+    def dump_db(self, fd):
+        writeCount = 0
+        for line in self.conn.iterdump():
+            writeCount = writeCount + len(line) + 1
+            fd.write(line)
+            fd.write('\n')
+        return writeCount
+
 class PRData(object):
     """Object representing the PR database"""
     def __init__(self, filename, nohist=True):
diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index f588f4d..affccd9 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -4,6 +4,7 @@ from SimpleXMLRPCServer import SimpleXMLRPCServer, SimpleXMLRPCRequestHandler
 import threading
 import Queue
 import socket
+import StringIO
 
 try:
     import sqlite3
@@ -59,6 +60,7 @@ class PRServer(SimpleXMLRPCServer):
         self.register_function(self.quit, "quit")
         self.register_function(self.ping, "ping")
         self.register_function(self.export, "export")
+        self.register_function(self.dump_db, "dump_db")
         self.register_function(self.importone, "importone")
         self.register_introspection_functions()
 
@@ -115,6 +117,26 @@ class PRServer(SimpleXMLRPCServer):
             logger.error(str(exc))
             return None
 
+    def dump_db(self):
+        """
+        Returns a script (string) that reconstructs the state of the
+        entire database at the time this function is called. The script
+        language is defined by the backing database engine, which is a
+        function of server configuration.
+        Returns None if the database engine does not support dumping to
+        script or if some other error is encountered in processing.
+        """
+        buff = StringIO.StringIO()
+        try:
+            self.table.sync()
+            self.table.dump_db(buff)
+            return buff.getvalue()
+        except Exception as exc:
+            logger.error(str(exc))
+            return None
+        finally:
+            buff.close()
+
     def importone(self, version, pkgarch, checksum, value):
         return self.table.importone(version, pkgarch, checksum, value)
 
@@ -288,6 +310,9 @@ class PRServerConnection(object):
     def export(self,version=None, pkgarch=None, checksum=None, colinfo=True):
         return self.connection.export(version, pkgarch, checksum, colinfo)
 
+    def dump_db(self):
+        return self.connection.dump_db()
+
     def importone(self, version, pkgarch, checksum, value):
         return self.connection.importone(version, pkgarch, checksum, value)
 
-- 
2.6.2


