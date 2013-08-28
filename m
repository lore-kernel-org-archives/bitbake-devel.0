Return-Path: <pab@pabigot.com>
Received: from p3plsmtpa06-10.prod.phx3.secureserver.net
	(p3plsmtpa06-10.prod.phx3.secureserver.net [173.201.192.111])
	by mail.openembedded.org (Postfix) with ESMTP id 1DFC66BC26
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 28 Aug 2013 13:04:36 +0000 (UTC)
Received: from llc.pab ([66.41.60.82])
	by p3plsmtpa06-10.prod.phx3.secureserver.net with 
	id JD4Y1m00Q1mTNtu01D4Z1v; Wed, 28 Aug 2013 06:04:33 -0700
From: "Peter A. Bigot" <pab@pabigot.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 28 Aug 2013 08:04:22 -0500
Message-Id: <1377695062-16111-1-git-send-email-pab@pabigot.com>
X-Mailer: git-send-email 1.8.4
Subject: [PATCH] bitbake: server/xmlrpc/prserv: Increase timeout to default xmlrpc server
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
X-List-Received-Date: Wed, 28 Aug 2013 13:04:37 -0000

On a heavily-loaded host with local PR server the default 5 second timeout
produces too-frequent errors:

  ERROR: Can NOT get PRAUTO, exception timed out
  ERROR: Function failed: package_get_auto_pr

Since this error aborts the build a generous timeout seems appropriate.

Signed-off-by: Peter A. Bigot <pab@pabigot.com>
---
 lib/bb/server/xmlrpc.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/server/xmlrpc.py b/lib/bb/server/xmlrpc.py
index 4dee5d9..bb87fd7 100644
--- a/lib/bb/server/xmlrpc.py
+++ b/lib/bb/server/xmlrpc.py
@@ -78,7 +78,7 @@ class BBTransport(xmlrpclib.Transport):
             h.putheader("Bitbake-token", self.connection_token)
         xmlrpclib.Transport.send_content(self, h, body)
 
-def _create_server(host, port, timeout = 5):
+def _create_server(host, port, timeout = 20):
     t = BBTransport(timeout)
     s = xmlrpclib.Server("http://%s:%d/" % (host, port), transport=t, allow_none=True)
     return s, t
-- 
1.8.4


