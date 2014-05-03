Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 4CEEC609BF
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  3 May 2014 10:26:22 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s43AIiK2006227 for <bitbake-devel@lists.openembedded.org>;
	Sat, 3 May 2014 11:18:45 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 0oiqxMt3tA2j for <bitbake-devel@lists.openembedded.org>;
	Sat,  3 May 2014 11:18:44 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s43AIdP8006220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 3 May 2014 11:18:41 +0100
Message-ID: <1399112313.12731.99.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sat, 03 May 2014 11:18:33 +0100
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] persist_data: Avoid fsync() calls
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
X-List-Received-Date: Sat, 03 May 2014 10:26:23 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If the power were to fail, it doesn't matter to us much if the data
makes it to disk or not, we'd have other problems. However an fsync()
call on a multi build autobuilder is painful so lets avoid them.

This is particularly true in this case if a timeout causes a reconnect
during a build.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/persist_data.py b/bitbake/lib/bb/persist_data.py
index 994e61b..5795bc8 100644
--- a/bitbake/lib/bb/persist_data.py
+++ b/bitbake/lib/bb/persist_data.py
@@ -199,7 +199,9 @@ class PersistData(object):
         del self.data[domain][key]
 
 def connect(database):
-    return sqlite3.connect(database, timeout=5, isolation_level=None)
+    connection = sqlite3.connect(database, timeout=5, isolation_level=None)
+    connection.execute("pragma synchronous = off;")
+    return connection
 
 def persist(domain, d):
     """Convenience factory for SQLTable objects based upon metadata"""



