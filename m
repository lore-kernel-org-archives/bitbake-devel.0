Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mx.groups.io with SMTP id smtpd.web11.16690.1600352704309961636
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Sep 2020 07:25:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linux.microsoft.com header.s=default header.b=jGk2ar12;
 spf=pass (domain: linux.microsoft.com, ip: 13.77.154.182, mailfrom: anbelski@linux.microsoft.com)
Received: from anbelski-lsg-linux-yocto-1.irsgb21fvobu5fvmalxug44hib.xx.internal.cloudapp.net (unknown [52.247.218.173])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9B86C20B7179
	for <bitbake-devel@lists.openembedded.org>; Thu, 17 Sep 2020 07:25:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9B86C20B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1600352703;
	bh=csCZSaQuQJwjvhXVwUhQVrog88MXmiQK8Oz6F5f7Kco=;
	h=From:To:Subject:Date:Reply-To:From;
	b=jGk2ar12q0a9M9P2/QiUGrjnp8Bm2HtgoFL0adWZRzAFDLGbDxoJQWw4umvVFn5jw
	 F5nCD9O6g+1CTWahBJ5JD69W2JwAQEcPgAF3i0dWFeukNvTLhYcrwlzOe3trFMnUvA
	 MDxw+lS4/HtGqexMJYzF6nOlmJGs82vwmhgzIzyA=
From: anbelski@linux.microsoft.com
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] bitbake: hashserv: Fix localhost sometimes resolved to a wrong IP
Date: Thu, 17 Sep 2020 14:24:48 +0000
Message-Id: <20200917142448.31407-1-anbelski@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Reply-To: anatol.belski@microsoft.com

From: Anatol Belski <anatol.belski@microsoft.com>

From: Anatol Belski <anbelski@linux.microsoft.com>

Using localhost for direct builds on host is fine. A case with a
misbehavior has been sighted on a Docker build. Even when the host
supports IPv6, but Docker is not configured correspondingly - some
versions of the asyncio Python module seem to misbehave and try to
use IPv6 where it's not supported in the container. This happens at
least on some Ubuntu 18.04 based containers, resolving the IP
explicitly appears to be the fix.

Signed-off-by: Anatol Belski <anbelski@linux.microsoft.com>
---
 bitbake/lib/hashserv/tests.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/hashserv/tests.py b/bitbake/lib/hashserv/tests.py
index b34c436876..4566f24738 100644
--- a/bitbake/lib/hashserv/tests.py
+++ b/bitbake/lib/hashserv/tests.py
@@ -14,6 +14,7 @@ import sys
 import tempfile
 import threading
 import unittest
+import socket
 
 
 class TestHashEquivalenceServer(object):
@@ -163,4 +164,8 @@ class TestHashEquivalenceUnixServer(TestHashEquivalenceServer, unittest.TestCase
 
 class TestHashEquivalenceTCPServer(TestHashEquivalenceServer, unittest.TestCase):
     def get_server_addr(self):
-        return "localhost:0"
+        # Some hosts cause asyncio module to misbehave, when IPv6 is not enabled.
+        # If IPv6 is enabled, it should be safe to use localhost directly, in general
+        # case it is more reliable to resolve the IP address explicitly.
+        return socket.gethostbyname("localhost") + ":0"
+            
-- 
2.17.1

