Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 8A367706D9
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  5 Nov 2014 16:58:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	sA5Gvidc021633
	for <bitbake-devel@lists.openembedded.org>; Wed, 5 Nov 2014 16:57:44 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id N2bCpjLkag0n for <bitbake-devel@lists.openembedded.org>;
	Wed,  5 Nov 2014 16:57:44 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	sA5GvcE4021630
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 5 Nov 2014 16:57:40 GMT
Message-ID: <1415206693.23396.56.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 05 Nov 2014 16:58:13 +0000
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Subject: [PATCH] prserv: Use WAL mode
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
X-List-Received-Date: Wed, 05 Nov 2014 16:58:23 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Ideally, we want the PR service to have minimal influence from 
queued disk IO. sqlite tends to be paranoid about data loss and 
locks/fsync calls. There is a "WAL mode" which changes the journalling
mechanism and would appear much better suited to our use case.

This patch therefore switches the database to what WAL mode. With this
change, write overhead appears significantly reduced.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/prserv/db.py b/bitbake/lib/prserv/db.py
index 3bdc046..9d6d115 100644
--- a/bitbake/lib/prserv/db.py
+++ b/bitbake/lib/prserv/db.py
@@ -235,6 +235,7 @@ class PRData(object):
         self.connection=sqlite3.connect(self.filename, isolation_level="EXCLUSIVE", check_same_thread = False)
         self.connection.row_factory=sqlite3.Row
         self.connection.execute("pragma synchronous = off;")
+        self.connection.execute("PRAGMA journal_mode = WAL;")
         self._tables={}
 
     def __del__(self):



