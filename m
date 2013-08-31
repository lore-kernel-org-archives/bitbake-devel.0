Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 58D716BD80
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 31 Aug 2013 22:43:11 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r7VMtrD4008564 for <bitbake-devel@lists.openembedded.org>;
	Sat, 31 Aug 2013 23:55:53 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id YEX5B6OArnPV for <bitbake-devel@lists.openembedded.org>;
	Sat, 31 Aug 2013 23:55:53 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r7VMtlQJ008561
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Sat, 31 Aug 2013 23:55:48 +0100
Message-ID: <1377988977.1059.132.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sat, 31 Aug 2013 23:42:57 +0100
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: {PATCH] serv/db: Take an excluside lock on the database
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
X-List-Received-Date: Sat, 31 Aug 2013 22:43:11 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

We only support one server using the database at a time so take an exclusive
lock and avoid later lock overhead.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/prserv/db.py b/bitbake/lib/prserv/db.py
index dad445b..5599355 100644
--- a/bitbake/lib/prserv/db.py
+++ b/bitbake/lib/prserv/db.py
@@ -214,7 +214,7 @@ class PRData(object):
         except OSError as e:
             if e.errno != errno.EEXIST:
                 raise e
-        self.connection=sqlite3.connect(self.filename, isolation_level="DEFERRED", check_same_thread = False)
+        self.connection=sqlite3.connect(self.filename, isolation_level="EXCLUSIVE", check_same_thread = False)
         self.connection.row_factory=sqlite3.Row
         self._tables={}
 




