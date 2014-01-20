Return-Path: <olof.johansson@axis.com>
Received: from anubis.se.axis.com (anubis.se.axis.com [195.60.68.12])
	by mail.openembedded.org (Postfix) with ESMTP id BAE5C6CBD7
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 11:03:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by anubis.se.axis.com (Postfix) with ESMTP id 83BD519DC8
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 12:03:51 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at anubis.se.axis.com
Received: from anubis.se.axis.com ([127.0.0.1])
	by localhost (anubis.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 4UXQBH8cCcix for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 12:03:48 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by anubis.se.axis.com (Postfix) with ESMTP id 70BA419DDE
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 12:03:27 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 71D6AC70
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 12:03:25 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id 61E5670A
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 12:03:25 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by seth.se.axis.com (Postfix) with ESMTP id 604DF3E06F
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 12:03:25 +0100 (CET)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.2.255.0; Mon, 20 Jan 2014
	12:03:25 +0100
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id 38CA99C075; 
	Mon, 20 Jan 2014 12:03:25 +0100 (CET)
From: Olof Johansson <olof.johansson@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 20 Jan 2014 12:03:24 +0100
Message-ID: <1390215804-20578-6-git-send-email-olof.johansson@axis.com>
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1390215804-20578-1-git-send-email-olof.johansson@axis.com>
References: <1390215804-20578-1-git-send-email-olof.johansson@axis.com>
MIME-Version: 1.0
Subject: [PATCH 5/5] fetch2.URI: Set username/password should not change the other
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
X-List-Received-Date: Mon, 20 Jan 2014 11:03:51 -0000
Content-Type: text/plain

When setting the username after already having set the password, the password
was unexpectedly reset. This change fixes this issue and introduces unit tests
to make sure it doesn't happen again.

Signed-off-by: Olof Johansson <olof.johansson@axis.com>
---
 lib/bb/fetch2/__init__.py |  5 +++--
 lib/bb/tests/fetch.py     | 14 ++++++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index abff9e2..18cd821 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -321,9 +321,10 @@ class URI(object):
 
     @username.setter
     def username(self, username):
+        password = self.password
         self.userinfo = username
-        if self.password:
-            self.userinfo += ":%s" % self.password
+        if password:
+            self.userinfo += ":%s" % password
 
     @property
     def password(self):
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 6ffe296..707062e 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -274,6 +274,20 @@ class URITest(unittest.TestCase):
             self.assertEqual(uri.username, test['username'])
             self.assertEqual(uri.password, test['password'])
 
+            # make sure changing the values doesn't do anything unexpected
+            uri.username = 'changeme'
+            self.assertEqual(uri.username, 'changeme')
+            self.assertEqual(uri.password, test['password'])
+            uri.password = 'insecure'
+            self.assertEqual(uri.username, 'changeme')
+            self.assertEqual(uri.password, 'insecure')
+
+            # reset back after our trickery
+            uri.userinfo = test['userinfo']
+            self.assertEqual(uri.userinfo, test['userinfo'])
+            self.assertEqual(uri.username, test['username'])
+            self.assertEqual(uri.password, test['password'])
+
             uri.hostname = test['hostname']
             self.assertEqual(uri.hostname, test['hostname'])
             self.assertEqual(uri.hostport, test['hostname'])
-- 
1.8.5.2


