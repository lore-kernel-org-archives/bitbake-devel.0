Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <constantinx.musca@intel.com>) id 1TxaY3-00033M-Tv
	for bitbake-devel@lists.openembedded.org;
	Tue, 22 Jan 2013 10:53:44 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 22 Jan 2013 01:37:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,513,1355126400"; d="scan'208";a="276893434"
Received: from costin-desktop (HELO localhost.localdomain) ([10.237.105.152])
	by fmsmga001.fm.intel.com with ESMTP; 22 Jan 2013 01:37:08 -0800
From: Constantin Musca <constantinx.musca@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 22 Jan 2013 11:37:57 +0200
Message-Id: <1358847477-6786-1-git-send-email-constantinx.musca@intel.com>
X-Mailer: git-send-email 1.7.11.7
Cc: Constantin Musca <constantinx.musca@intel.com>
Subject: [PATCH 2/3] persist_data: add get_by_pattern method to API
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
X-List-Received-Date: Tue, 22 Jan 2013 09:53:45 -0000

- one can use get_by_pattern to get a list of values associated
with keys that match the specified pattern

Signed-off-by: Constantin Musca <constantinx.musca@intel.com>
---
 bitbake/lib/bb/persist_data.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/bitbake/lib/bb/persist_data.py b/bitbake/lib/bb/persist_data.py
index c69758d..994e61b 100644
--- a/bitbake/lib/bb/persist_data.py
+++ b/bitbake/lib/bb/persist_data.py
@@ -125,6 +125,11 @@ class SQLTable(collections.MutableMapping):
 
         return len(self) < len(other)
 
+    def get_by_pattern(self, pattern):
+        data = self._execute("SELECT * FROM %s WHERE key LIKE ?;" %
+                             self.table, [pattern])
+        return [row[1] for row in data]
+
     def values(self):
         return list(self.itervalues())
 
-- 
1.7.11.7



