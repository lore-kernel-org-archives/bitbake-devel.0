Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <lianhao.lu@intel.com>) id 1Rme0d-0007fE-7C
	for bitbake-devel@lists.openembedded.org;
	Mon, 16 Jan 2012 05:17:27 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 15 Jan 2012 20:09:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="98903688"
Received: from llu-piketon.sh.intel.com (HELO localhost) ([10.239.36.146])
	by orsmga002.jf.intel.com with ESMTP; 15 Jan 2012 20:09:49 -0800
From: Lianhao Lu <lianhao.lu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 16 Jan 2012 12:07:44 +0800
Message-Id: <554ae4c9ee0ac70254c6ca6a5ba44db844cf86b3.1326686612.git.lianhao.lu@intel.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1326686612.git.lianhao.lu@intel.com>
References: <cover.1326686612.git.lianhao.lu@intel.com>
Subject: [PATCH 1/1] bitbake/persist_data: Reconnect when DB is locked
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
X-List-Received-Date: Mon, 16 Jan 2012 04:17:27 -0000

[YOCTO #1761]
Reconnect to the backend Sqlite DB in 'database is locked' exception so
the timeout can be leveraged in each time retry.

Signed-off-by: Lianhao Lu <lianhao.lu@intel.com>
---
 bitbake/lib/bb/persist_data.py |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/persist_data.py b/bitbake/lib/bb/persist_data.py
index 17620ef..c4ea23b 100644
--- a/bitbake/lib/bb/persist_data.py
+++ b/bitbake/lib/bb/persist_data.py
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
-- 
1.7.0.4



