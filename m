Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 456C175D1B
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Jul 2015 13:13:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t6ADDvGs010945 for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Jul 2015 14:13:57 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id KE3tBUFjKwXy for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Jul 2015 14:13:56 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t6ADDhSq010937
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Jul 2015 14:13:54 +0100
Message-ID: <1436534023.3310.10.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 10 Jul 2015 14:13:43 +0100
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Subject: [PATCH] prserv/db: Document history modes
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
X-List-Received-Date: Fri, 10 Jul 2015 13:13:57 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

I keep having to dig into the archives to remember this information.
Add it as a comment to the file instead.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/prserv/db.py b/bitbake/lib/prserv/db.py
index 9d6d115..43795801 100644
--- a/bitbake/lib/prserv/db.py
+++ b/bitbake/lib/prserv/db.py
@@ -15,6 +15,16 @@ sqlversion = sqlite3.sqlite_version_info
 if sqlversion[0] < 3 or (sqlversion[0] == 3 and sqlversion[1] < 3):
     raise Exception("sqlite3 version 3.3.0 or later is required.")
 
+#
+# "No History" mode - for a given query tuple (version, pkgarch, checksum),
+# the returned value will be the largest among all the values of the same
+# (version, pkgarch). This means the PR value returned can NOT be decremented.
+#
+# "History" mode - Return a new higher value for previously unseen query
+# tuple (version, pkgarch, checksum), otherwise return historical value.
+# Value can decrement if returning to a previous build.
+#
+
 class PRTable(object):
     def __init__(self, conn, table, nohist):
         self.conn = conn



