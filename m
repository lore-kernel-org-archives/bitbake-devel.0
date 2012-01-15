Received: from mail-ee0-f47.google.com ([74.125.83.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1RmXNl-0000j1-8e
	for bitbake-devel@lists.openembedded.org;
	Sun, 15 Jan 2012 22:12:54 +0100
Received: by eekd17 with SMTP id d17so1364784eek.6
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 15 Jan 2012 13:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
	bh=EJSTE/iboYiXbt1ekx72S6Le2aepiJVecfysK91Lago=;
	b=WT3E3icMAGiK62YbigeRg9Nclhf4AU+xWqbbru23NMKNjO/3eotkYB6++7evwKt4oX
	ABvwiozG3tWeogYVuC2gZEYW9jFDolA5U1I4/42q+Qhou8/H1GjFXZPfx4JlY5HM0UH3
	QrQbD0IT5UACILmMJ/sdKPgn15WVaNuIDtVEo=
Received: by 10.213.32.84 with SMTP id b20mr2849125ebd.139.1326661513239;
	Sun, 15 Jan 2012 13:05:13 -0800 (PST)
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id u53sm63337450eeu.6.2012.01.15.13.05.11
	(version=TLSv1/SSLv3 cipher=OTHER);
	Sun, 15 Jan 2012 13:05:12 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 15 Jan 2012 22:03:53 +0100
Message-Id: <1326661433-26379-2-git-send-email-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 1.7.8.3
In-Reply-To: <1326661433-26379-1-git-send-email-Martin.Jansa@gmail.com>
References: <1326661433-26379-1-git-send-email-Martin.Jansa@gmail.com>
Subject: [PATCH 2/2] prserv: fix import of sqlite3
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
X-List-Received-Date: Sun, 15 Jan 2012 21:12:55 -0000

* this is used in all other bitbake parts where sqlite3 is used, don't
  know why it wasn't used here, but it fails e.g. on Gentoo
  Traceback (most recent call last):
    File "bin/bitbake", line 39, in <module>
      from bb import cooker
    File "lib/bb/cooker.py", line 39, in <module>
      import prserv.serv
    File "lib/prserv/serv.py", line 4, in <module>
      import xmlrpclib,sqlite3
  ImportError: No module named sqlite3

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 lib/prserv/serv.py |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index a759fa7..fa437f9 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -1,7 +1,12 @@
 import os,sys,logging
 import signal, time, atexit, threading
 from SimpleXMLRPCServer import SimpleXMLRPCServer, SimpleXMLRPCRequestHandler
-import xmlrpclib,sqlite3
+import xmlrpclib
+
+try:
+    import sqlite3
+except ImportError:
+    from pysqlite2 import dbapi2 as sqlite3
 
 import bb.server.xmlrpc
 import prserv
-- 
1.7.8.3



