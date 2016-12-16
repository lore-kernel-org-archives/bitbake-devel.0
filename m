Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 41B9C77293
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Dec 2016 10:05:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	uBGA5YPv010122; Fri, 16 Dec 2016 10:05:34 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id h8BzD0EPVJM8; Fri, 16 Dec 2016 10:05:34 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	uBGA5U8l010117
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 16 Dec 2016 10:05:32 GMT
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1cHpOM-0004do-TY; Fri, 16 Dec 2016 10:05:30 +0000
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Dec 2016 10:05:22 +0000
Message-Id: <1481882722-17796-2-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1481882722-17796-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1481882722-17796-1-git-send-email-richard.purdie@linuxfoundation.org>
Subject: [PATCH 2/2] BBHandler: use with instead of open/close
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
X-List-Received-Date: Fri, 16 Dec 2016 10:05:39 -0000

From: Ross Burton <ross.burton@intel.com>

This is more pythonic and can handle unclosed file warnings better
than the previous code structure.

Signed-off-by: Ross Burton <ross.burton@intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/parse/parse_py/BBHandler.py | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/lib/bb/parse/parse_py/BBHandler.py b/lib/bb/parse/parse_py/BBHandler.py
index f2a2151..fe918a4 100644
--- a/lib/bb/parse/parse_py/BBHandler.py
+++ b/lib/bb/parse/parse_py/BBHandler.py
@@ -87,17 +87,17 @@ def get_statements(filename, absolute_filename, base_name):
     try:
         return cached_statements[absolute_filename]
     except KeyError:
-        file = open(absolute_filename, 'r')
-        statements = ast.StatementGroup()
-
-        lineno = 0
-        while True:
-            lineno = lineno + 1
-            s = file.readline()
-            if not s: break
-            s = s.rstrip()
-            feeder(lineno, s, filename, base_name, statements)
-        file.close()
+        with open(absolute_filename, 'r') as f:
+            statements = ast.StatementGroup()
+
+            lineno = 0
+            while True:
+                lineno = lineno + 1
+                s = f.readline()
+                if not s: break
+                s = s.rstrip()
+                feeder(lineno, s, filename, base_name, statements)
+
         if __inpython__:
             # add a blank line to close out any python definition
             feeder(lineno, "", filename, base_name, statements, eof=True)
-- 
2.7.4


