Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 23E846BD80
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 31 Aug 2013 22:41:49 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r7VMsVFN008530 for <bitbake-devel@lists.openembedded.org>;
	Sat, 31 Aug 2013 23:54:31 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id cDe4XD3hTEYh for <bitbake-devel@lists.openembedded.org>;
	Sat, 31 Aug 2013 23:54:31 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r7VMsQIW008527
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Sat, 31 Aug 2013 23:54:27 +0100
Message-ID: <1377988895.1059.130.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sat, 31 Aug 2013 23:41:35 +0100
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: serv/db: Fix looping upon database locked issues
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
X-List-Received-Date: Sat, 31 Aug 2013 22:41:50 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If the database is locked we will get an immediate error indicating so,
there is no retry timeout. The looping code is therefore useless, the loop
count is near instantly exceeded.

Using a time based retry means we can wait a sensible time, then gracefully
exit.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/prserv/db.py b/bitbake/lib/prserv/db.py
index 7bc1980..b7190ba 100644
--- a/bitbake/lib/prserv/db.py
+++ b/bitbake/lib/prserv/db.py
@@ -2,6 +2,7 @@ import logging
 import os.path
 import errno
 import prserv
+import time
 
 try:
     import sqlite3
@@ -32,13 +33,13 @@ class PRTable(object):
 
     def _execute(self, *query):
         """Execute a query, waiting to acquire a lock if necessary"""
-        count = 0
+        start = time.time()
+        end = start + 20
         while True:
             try:
                 return self.conn.execute(*query)
             except sqlite3.OperationalError as exc:
-                if 'is locked' in str(exc) and count < 500:
-                    count = count + 1
+                if 'is locked' in str(exc) and end > time.time():
                     continue
                 raise exc
 



