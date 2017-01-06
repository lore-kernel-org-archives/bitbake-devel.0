Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id AAF036E668
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  6 Jan 2017 12:37:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v06CbDs0010201; Fri, 6 Jan 2017 12:37:13 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 3bTJ8qixHEil; Fri,  6 Jan 2017 12:37:13 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v06Cb971010196
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 6 Jan 2017 12:37:10 GMT
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1cPTld-0005Ut-7y; Fri, 06 Jan 2017 12:37:09 +0000
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  6 Jan 2017 12:37:03 +0000
Message-Id: <1483706223-21092-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH] prserv/persist_data/utils: Drop obsolete python2 imports
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
X-List-Received-Date: Fri, 06 Jan 2017 12:37:15 -0000

These imports were from python 2.6 and earlier, 2.4 in some cases.
Drop them since we're all python3 now.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/persist_data.py |  6 +-----
 lib/bb/utils.py        | 22 +++++-----------------
 lib/prserv/serv.py     |  7 +------
 3 files changed, 7 insertions(+), 28 deletions(-)

diff --git a/lib/bb/persist_data.py b/lib/bb/persist_data.py
index e6bbff8..bef7018 100644
--- a/lib/bb/persist_data.py
+++ b/lib/bb/persist_data.py
@@ -28,11 +28,7 @@ import sys
 import warnings
 from bb.compat import total_ordering
 from collections import Mapping
-
-try:
-    import sqlite3
-except ImportError:
-    from pysqlite2 import dbapi2 as sqlite3
+import sqlite3
 
 sqlversion = sqlite3.sqlite_version_info
 if sqlversion[0] < 3 or (sqlversion[0] == 3 and sqlversion[1] < 3):
diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index a22a05e..2845126 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -523,12 +523,8 @@ def md5_file(filename):
     """
     Return the hex string representation of the MD5 checksum of filename.
     """
-    try:
-        import hashlib
-        m = hashlib.md5()
-    except ImportError:
-        import md5
-        m = md5.new()
+    import hashlib
+    m = hashlib.md5()
 
     with open(filename, "rb") as f:
         for line in f:
@@ -538,14 +534,9 @@ def md5_file(filename):
 def sha256_file(filename):
     """
     Return the hex string representation of the 256-bit SHA checksum of
-    filename.  On Python 2.4 this will return None, so callers will need to
-    handle that by either skipping SHA checks, or running a standalone sha256sum
-    binary.
+    filename.
     """
-    try:
-        import hashlib
-    except ImportError:
-        return None
+    import hashlib
 
     s = hashlib.sha256()
     with open(filename, "rb") as f:
@@ -557,10 +548,7 @@ def sha1_file(filename):
     """
     Return the hex string representation of the SHA1 checksum of the filename
     """
-    try:
-        import hashlib
-    except ImportError:
-        return None
+    import hashlib
 
     s = hashlib.sha1()
     with open(filename, "rb") as f:
diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index d9b602f..a7efa58 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -5,12 +5,7 @@ import threading
 import queue
 import socket
 import io
-
-try:
-    import sqlite3
-except ImportError:
-    from pysqlite2 import dbapi2 as sqlite3
-
+import sqlite3
 import bb.server.xmlrpc
 import prserv
 import prserv.db
-- 
2.7.4


