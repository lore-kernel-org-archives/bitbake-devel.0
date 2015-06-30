Return-Path: <anibal.limon@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 3D64575C7D
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 30 Jun 2015 14:37:15 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga103.fm.intel.com with ESMTP; 30 Jun 2015 07:37:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,378,1432623600"; d="scan'208";a="753307224"
Received: from alimon-thinkpad-w540.zpn.intel.com ([10.219.4.55])
	by fmsmga002.fm.intel.com with ESMTP; 30 Jun 2015 07:37:15 -0700
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 30 Jun 2015 09:39:10 -0500
Message-Id: <1435675155-3431-2-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1435675155-3431-1-git-send-email-anibal.limon@linux.intel.com>
References: <1435675155-3431-1-git-send-email-anibal.limon@linux.intel.com>
MIME-Version: 1.0
Subject: [PATCHv3 1/6] fetch2/__init__.py: Add FetchConnectionCache class
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
X-List-Received-Date: Tue, 30 Jun 2015 14:37:20 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

FetchConnectionCache class acts as a container for socket connections
useful when implement connection cache into fetcher modules.

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 lib/bb/fetch2/__init__.py | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index cc772df..7fd9ec7 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1711,6 +1711,42 @@ class Fetch(object):
             if ud.lockfile:
                 bb.utils.unlockfile(lf)
 
+class FetchConnectionCache(object):
+    """
+        A class which represents an container for socket connections.
+    """
+    def __init__(self):
+        self.cache = {}
+
+    def get_connection_name(self, host, port):
+        return host + ':' + str(port)
+
+    def add_connection(self, host, port, connection):
+        cn = self.get_connection_name(host, port)
+
+        if cn not in self.cache:
+            self.cache[cn] = connection
+
+    def get_connection(self, host, port):
+        connection = None
+
+        cn = self.get_connection_name(host, port)
+        if cn in self.cache:
+            connection = self.cache[cn]
+
+        return connection
+
+    def remove_connection(self, host, port):
+        cn = self.get_connection_name(host, port)
+        if cn in self.cache:
+            self.cache[cn].close()
+            del self.cache[cn]
+
+    def close_connections(self):
+        for cn in self.cache.keys():
+            self.cache[cn].close()
+            del self.cache[cn]
+
 from . import cvs
 from . import git
 from . import gitsm
-- 
1.9.1


