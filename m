Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RnfmP-00052j-69
	for bitbake-devel@lists.openembedded.org;
	Thu, 19 Jan 2012 01:23:01 +0100
Received: by opal (Postfix, from userid 111)
	id 6517210332; Thu, 19 Jan 2012 00:24:43 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120119002443.6517210332@opal>
Date: Thu, 19 Jan 2012 00:24:43 +0000 (UTC)
From: git@git.openembedded.org
Subject: Lianhao Lu : bitbake/persist_data: Reconnect when DB is locked
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
X-List-Received-Date: Thu, 19 Jan 2012 00:23:01 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: b310382764367b573c84f33d847c6eb821266f9e
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=b310382764367b573c84f33d847c6eb821266f9e

Author: Lianhao Lu <lianhao.lu@intel.com>
Date:   Mon Jan 16 12:07:44 2012 +0800

bitbake/persist_data: Reconnect when DB is locked

[YOCTO #1761]
Reconnect to the backend Sqlite DB in 'database is locked' exception so
the timeout can be leveraged in each time retry.

Signed-off-by: Lianhao Lu <lianhao.lu@intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/persist_data.py |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/lib/bb/persist_data.py b/lib/bb/persist_data.py
index 17620ef..c4ea23b 100644
--- a/lib/bb/persist_data.py
+++ b/lib/bb/persist_data.py
@@ -47,9 +47,10 @@ if hasattr(sqlite3, 'enable_shared_cache'):
 @total_ordering
 class SQLTable(collections.MutableMapping):
     """Object representing a table/domain in the database"""
-    def __init__(self, cursor, table):
-        self.cursor = cursor
+    def __init__(self, cachefile, table):
+        self.cachefile = cachefile
         self.table = table
+        self.cursor = connect(self.cachefile)
 
         self._execute("CREATE TABLE IF NOT EXISTS %s(key TEXT, value TEXT);"
                       % table)
@@ -63,6 +64,8 @@ class SQLTable(collections.MutableMapping):
             except sqlite3.OperationalError as exc:
                 if 'database is locked' in str(exc) and count < 500:
                     count = count + 1
+                    self.cursor.close()
+                    self.cursor = connect(self.cachefile)
                     continue
                 raise
 
@@ -188,7 +191,7 @@ class PersistData(object):
         del self.data[domain][key]
 
 def connect(database):
-    return sqlite3.connect(database, timeout=30, isolation_level=None)
+    return sqlite3.connect(database, timeout=5, isolation_level=None)
 
 def persist(domain, d):
     """Convenience factory for SQLTable objects based upon metadata"""
@@ -201,5 +204,4 @@ def persist(domain, d):
 
     bb.utils.mkdirhier(cachedir)
     cachefile = os.path.join(cachedir, "bb_persist_data.sqlite3")
-    connection = connect(cachefile)
-    return SQLTable(connection, domain)
+    return SQLTable(cachefile, domain)



