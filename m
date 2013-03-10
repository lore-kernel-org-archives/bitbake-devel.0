Received: from anubis.se.axis.com ([195.60.68.12])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <olof.johansson@axis.com>) id 1UEjGw-0006r0-Nk
	for bitbake-devel@lists.openembedded.org;
	Sun, 10 Mar 2013 17:39:03 +0100
Received: from localhost (localhost [127.0.0.1])
	by anubis.se.axis.com (Postfix) with ESMTP id 33E6419E05
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 10 Mar 2013 17:22:18 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at anubis.se.axis.com
Received: from anubis.se.axis.com ([127.0.0.1])
	by localhost (anubis.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id lL-mRa7daSXg for <bitbake-devel@lists.openembedded.org>;
	Sun, 10 Mar 2013 17:22:16 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by anubis.se.axis.com (Postfix) with ESMTP id 4ACA119DE8
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 10 Mar 2013 17:22:15 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by seth.se.axis.com (Postfix) with ESMTP id 4918F3E2AA
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 10 Mar 2013 17:22:15 +0100 (CET)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.2.176.0; Sun, 10 Mar 2013
	17:22:15 +0100
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id 6BF099C078; 
	Sun, 10 Mar 2013 17:22:23 +0100 (CET)
From: Olof Johansson <olof.johansson@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sun, 10 Mar 2013 17:22:22 +0100
Message-ID: <1362932543-3737-6-git-send-email-olof.johansson@axis.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1362932543-3737-1-git-send-email-olof.johansson@axis.com>
References: <1362932543-3737-1-git-send-email-olof.johansson@axis.com>
MIME-Version: 1.0
Subject: [PATCH 5/5] fetch2.URI: Set username/password should not change the other
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
X-List-Received-Date: Sun, 10 Mar 2013 16:40:06 -0000
Content-Type: text/plain

When setting the username after already having set the password, the password
was unexpectedly reset. This change fixes this issue and introduces unit tests
to make sure it doesn't happen again.

Signed-off-by: Olof Johansson <olof.johansson@axis.com>
---
 lib/bb/fetch2/__init__.py |    5 +++--
 lib/bb/tests/fetch.py     |   14 ++++++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index f890181..39190c6 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -314,9 +314,10 @@ class URI(object):
 
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
index be21623..ee3e572 100644
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
1.7.10.4



