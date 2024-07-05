Return-Path: <yang-mark.zhang@nokia-sbell.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F478C3271F
	for <webhook@archiver.kernel.org>; Fri,  5 Jul 2024 08:55:06 +0000 (UTC)
Received: from CNSHPPMGWESA01.NOKIA-SBELL.COM (CNSHPPMGWESA01.NOKIA-SBELL.COM [116.246.26.71])
 by mx.groups.io with SMTP id smtpd.web11.13319.1720169704191106383
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Jul 2024 01:55:04 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: nokia-sbell.com, ip: 116.246.26.71, mailfrom: yang-mark.zhang@nokia-sbell.com)
X-CSE-ConnectionGUID: R6zaPEqIShidGV2Colymqw==
X-CSE-MsgGUID: zB3CILrhQy+Hpl15Mg/Hcw==
X-IronPort-AV: E=Sophos;i="6.09,184,1716220800"; 
   d="scan'208";a="29190765"
Received: from unknown (HELO CNSHPPEXCH1609.nsn-intra.net) ([135.251.51.109])
  by CNSHPPMGWESA01.NOKIA-SBELL.COM with ESMTP; 05 Jul 2024 16:54:56 +0800
Received: from N-20W1PF3T7G3S.nsn-intra.net (135.251.51.115) by
 CNSHPPEXCH1609.nsn-intra.net (135.251.51.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 5 Jul 2024 16:54:56 +0800
From: y75zhang <yang-mark.zhang@nokia-sbell.com>
To: <bitbake-devel@lists.openembedded.org>
CC: y75zhang <yang-mark.zhang@nokia-sbell.com>
Subject: [PATCH] bitbake: checkstatus: drop shared connecton when catch Timeout error
Date: Fri, 5 Jul 2024 16:54:47 +0800
Message-ID: <20240705085448.1632-1-yang-mark.zhang@nokia-sbell.com>
X-Mailer: git-send-email 2.45.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [135.251.51.115]
X-ClientProxiedBy: CNSHPPEXCH1607.nsn-intra.net (135.251.51.107) To
 CNSHPPEXCH1609.nsn-intra.net (135.251.51.109)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Jul 2024 08:55:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16391

* to avoid wrong http response in checkstatus function:
   in wget checkstatus() we are using 'HTTPConnectionCache' to share connections
   1. state_file1(exists on http server) use shared connection <shared1> to send request
   2. http_server recieved request of state_file1, but delayed by some reason to sent respone
   3. state_file1 checkstatus() failed by timeout and drop shared connection <shared1>
   4. state_file2(not exists on http server) get shared connection <shared1> and send request
   5. http_server finally send 200 response for state_file1
   6. state_file2 recived 200 response and thought it was exists on http_server

* how to reproduce:
   modify /usr/lib64/python3.10/http/client.py like this to fake timeout event
   you will find that some sstate files with 200 response in fact do not exists in remote http server
— a/client.py
+++ b/client.py
@@ -68,6 +68,7 @@ Req-started-unread-response    _CS_REQ_STARTED    <response_class>
 Req-sent-unread-response       _CS_REQ_SENT       <response_class>
 """

+import random
 import email.parser
 import email.message
 import errno
@@ -1370,6 +1371,8 @@ class HTTPConnection:
         else:
             response = self.response_class(self.sock, method=self._method)

+        if random.choice([False, False, False, False, False, False, False, True]):
+            raise TimeoutError('timed out test')
         try:
             try:
                 response.begin()

Signed-off-by: y75zhang <yang-mark.zhang@nokia-sbell.com>
---
 bitbake/lib/bb/fetch2/wget.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index 2e92117..56caf92 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -244,7 +244,12 @@ class Wget(FetchMethod):
                         fetch.connection_cache.remove_connection(h.host, h.port)
                     raise urllib.error.URLError(err)
                 else:
-                    r = h.getresponse()
+                    try:
+                        r = h.getresponse()
+                    except TimeoutError as e:
+                        if fetch.connection_cache:
+                            fetch.connection_cache.remove_connection(h.host, h.port)
+                        raise TimeoutError(e)
 
                 # Pick apart the HTTPResponse object to get the addinfourl
                 # object initialized properly.
@@ -496,7 +501,7 @@ class Wget(FetchMethod):
                     valid = 1
                 elif self._vercmp(version, newver) < 0:
                     version = newver
-                
+
         pupver = re.sub('_', '.', version[1])
 
         bb.debug(3, "*** %s -> UpstreamVersion = %s (CurrentVersion = %s)" %
-- 
2.9.5


