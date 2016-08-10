Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 6891377060
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Aug 2016 15:00:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u7AF0aE0011362 for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Aug 2016 16:00:36 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id rX8FFSEaixCJ for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Aug 2016 16:00:36 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u7AF0XYO011357
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Aug 2016 16:00:34 +0100
Message-ID: <1470841233.20391.3.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 10 Aug 2016 16:00:33 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] persist_data: Fix py3 update stack overflow
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
X-List-Received-Date: Wed, 10 Aug 2016 15:00:37 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Revision d0f904d407f57998419bd9c305ce53e5eaa36b24 accidentally broke
items() and values() and made them cause stack overflows. Undo that
breakage.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/persist_data.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/persist_data.py b/lib/bb/persist_data.py
index 403f3a5..bb6deca 100644
--- a/lib/bb/persist_data.py
+++ b/lib/bb/persist_data.py
@@ -131,14 +131,14 @@ class SQLTable(collections.MutableMapping):
         return [row[1] for row in data]
 
     def values(self):
-        return list(self.values())
+        return list(self.itervalues())
 
     def itervalues(self):
         data = self._execute("SELECT value FROM %s;" % self.table)
         return (row[0] for row in data)
 
     def items(self):
-        return list(self.items())
+        return list(self.iteritems())
 
     def iteritems(self):
         return self._execute("SELECT * FROM %s;" % self.table)


