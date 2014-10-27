Return-Path: <ben.shelton@ni.com>
Received: from ni.com (skprod3.natinst.com [130.164.80.24])
	by mail.openembedded.org (Postfix) with ESMTP id 662E460097
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 27 Oct 2014 17:27:57 +0000 (UTC)
Received: from us-aus-mgwout2.amer.corp.natinst.com (nb-snip2-1338.natinst.com
	[130.164.19.135])
	by us-aus-skprod3.natinst.com (8.14.5/8.14.5) with ESMTP id
	s9RHRvrb027749 for <bitbake-devel@lists.openembedded.org>;
	Mon, 27 Oct 2014 12:27:57 -0500
Received: from bshelton-desktop.natinst.com ([130.164.14.198])
	by us-aus-mgwout2.amer.corp.natinst.com (Lotus Domino Release 8.5.3FP6)
	with ESMTP id 2014102712275682-310275 ;
	Mon, 27 Oct 2014 12:27:56 -0500 
From: Ben Shelton <ben.shelton@ni.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 27 Oct 2014 12:27:23 -0500
Message-Id: <1414430843-27307-1-git-send-email-ben.shelton@ni.com>
X-Mailer: git-send-email 2.1.1
X-MIMETrack: Itemize by SMTP Server on US-AUS-MGWOut2/AUS/H/NIC(Release
	8.5.3FP6|November 21, 2013) at 10/27/2014 12:27:56 PM,
	Serialize by Router on US-AUS-MGWOut2/AUS/H/NIC(Release
	8.5.3FP6|November 21, 2013) at 10/27/2014 12:27:56 PM,
	Serialize complete at 10/27/2014 12:27:56 PM
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.12.52, 1.0.28,
	0.0.0000
	definitions=2014-10-27_04:2014-10-27, 2014-10-27,
	1970-01-01 signatures=0
Subject: [PATCH] prserv: don't wait until exit to sync
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
X-List-Received-Date: Mon, 27 Oct 2014 17:28:07 -0000

In the commit 'prserv: Ensure data is committed', the PR server moved to
only committing transactions to the database when the PR server is
stopped.  This improves performance, but it means that if the machine
running the PR server loses power unexpectedly or if the PR server
process gets SIGKILL, the uncommitted package revision data is lost.

To fix this issue, sync the database periodically, once per 30 seconds
by default, if it has been marked as dirty.  To be safe, continue to
sync the database at exit regardless of its status.

Signed-off-by: Ben Shelton <ben.shelton@ni.com>
---
 lib/prserv/db.py   | 14 ++++++++++++++
 lib/prserv/serv.py |  7 +++++++
 2 files changed, 21 insertions(+)

diff --git a/lib/prserv/db.py b/lib/prserv/db.py
index 49f36da..3bdc046 100644
--- a/lib/prserv/db.py
+++ b/lib/prserv/db.py
@@ -19,6 +19,7 @@ class PRTable(object):
     def __init__(self, conn, table, nohist):
         self.conn = conn
         self.nohist = nohist
+        self.dirty = False
         if nohist:
             self.table = "%s_nohist" % table 
         else:
@@ -47,6 +48,11 @@ class PRTable(object):
         self.conn.commit()
         self._execute("BEGIN EXCLUSIVE TRANSACTION")
 
+    def sync_if_dirty(self):
+        if self.dirty:
+            self.sync()
+            self.dirty = False
+
     def _getValueHist(self, version, pkgarch, checksum):
         data=self._execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=?;" % self.table,
                            (version, pkgarch, checksum))
@@ -62,6 +68,8 @@ class PRTable(object):
             except sqlite3.IntegrityError as exc:
                 logger.error(str(exc))
 
+            self.dirty = True
+
             data=self._execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=?;" % self.table,
                                (version, pkgarch, checksum))
             row=data.fetchone()
@@ -89,6 +97,8 @@ class PRTable(object):
                 logger.error(str(exc))
                 self.conn.rollback()
 
+            self.dirty = True
+
             data=self._execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=?;" % self.table,
                                (version, pkgarch, checksum))
             row=data.fetchone()
@@ -118,6 +128,8 @@ class PRTable(object):
             except sqlite3.IntegrityError as exc:
                 logger.error(str(exc))
 
+            self.dirty = True
+
             data = self._execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=?;" % self.table,
                            (version, pkgarch, checksum))
             row = data.fetchone()
@@ -139,6 +151,8 @@ class PRTable(object):
             except sqlite3.IntegrityError as exc:
                 logger.error(str(exc))
 
+        self.dirty = True
+
         data = self._execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=? AND value>=?;" % self.table,
                             (version,pkgarch,checksum,value))
         row=data.fetchone()
diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 1b08d59..6ab1097 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -122,6 +122,10 @@ class PRServer(SimpleXMLRPCServer):
     def work_forever(self,):
         self.quit = False
         self.timeout = 0.5
+        iter_count = 1
+        # With 60 iterations between syncs and a 0.5 second timeout between
+        # iterations, this will sync if dirty every ~30 seconds.
+        iterations_between_sync = 60
 
         logger.info("Started PRServer with DBfile: %s, IP: %s, PORT: %s, PID: %s" %
                      (self.dbfile, self.host, self.port, str(os.getpid())))
@@ -129,6 +133,9 @@ class PRServer(SimpleXMLRPCServer):
         self.handlerthread.start()
         while not self.quit:
             self.handle_request()
+            iter_count = (iter_count + 1) % iterations_between_sync
+            if iter_count == 0:
+                self.table.sync_if_dirty()
 
         self.table.sync()
         logger.info("PRServer: stopping...")
-- 
2.1.1


