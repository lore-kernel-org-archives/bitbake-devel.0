Return-Path: <pavel@zhukoff.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED09BECAAA3
	for <webhook@archiver.kernel.org>; Fri, 26 Aug 2022 08:41:14 +0000 (UTC)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 by mx.groups.io with SMTP id smtpd.web08.35011.1661503267417239478
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 26 Aug 2022 01:41:08 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@zhukoff.net header.s=fm1
 header.b=VmC1Pp12;
 spf=pass (domain: zhukoff.net, ip: 66.111.4.25, mailfrom: pavel@zhukoff.net)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 9C4515C004D;
	Fri, 26 Aug 2022 04:41:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 26 Aug 2022 04:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zhukoff.net; h=
	cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1661503266; x=1661589666; bh=uK
	FuBt5pj0faFRF07vm7DDfy4Iinw4RQjHbVbB+Lb2U=; b=VmC1Pp12+I5fC/ZOuw
	O9PMxfJoiam5loDhXYZyrBMN2T8lRQSnvqpsPugiXmfQtzZpFkZpw2Oj3nmjYZDf
	JU0WmVUKynsQ6q6DkI+NXeNcsv/WRN6Ff3YwVFP9IjNDNKGHyMAv9DXP3lz7X6XG
	UZljU8itsz/HNaiesNmfcLvymYb3I0pD73KMNAmTD9I4rGhjIUJf5L5WLYwaPnuJ
	54/YnUkbe817/hBr1iXOOVdlWMzmBmb2mMQkefo+yrLrAmIQyaiIHHAB3gb6E/PY
	qlFO9ZHUeVFNR/fiDS3uCFppHteqJQ+Z0Bj8pD1gHgsjc2VxJrL+vE44g2Bxpw3E
	qQDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1661503266; x=1661589666; bh=uKFuBt5pj0faF
	RF07vm7DDfy4Iinw4RQjHbVbB+Lb2U=; b=mQ1q1JCjATfm2kn+cFYIZvVW8lldR
	egmkjqbRuKs1TKOm762j8b1tjPOXyU3ly8UTbpBByDaQQAxVXzRD77FFe6eJzPOb
	0VaQ1O0QbFNBjHVohJKxojMSt8wES3v++IXxs28lqkfnGjIJSvrtwMYt88mJF3G3
	aavj7DLU52j0knmzl3BNlYy97C+USjxYzc+JxaYXD/FQlDOcOd1s1uKsk7HKmE7F
	qJc5Z3oIdvCosGCoWiNRU9LDULWNyGVtsteH2KqGnxYgPPcuaD+TE/scKoNt7/eH
	q8PpPJMr4xvY2sQG/f3me9eWwn3oji9gf7JenlZLJvQxogWdpXqgGAbrQ==
X-ME-Sender: <xms:IocIY8uutC5wLp_bSLS-IEchqNcDaLYWthRJyVL0dpHxhjqOFq1uuQ>
    <xme:IocIY5fqEq2h0TDo7CiUb8M0cmyugL_6vuHbl9c2v-w1Mg2oz2AbfPSDmsVcH-HFU
    H_7VZkOdvaqG8MEKAQ>
X-ME-Received: 
 <xmr:IocIY3zkZdy86ugOYacAAezFwuMwtRNPDWfzyqfb-NK6Pvzy4kVQz964YLA_16BGGaRZKUjcV0QdlB764pIROxM>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvfedrvdejhedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefrrghvvghlucgkhhhukhhovhcuoehprghvvghlseiihhhu
    khhofhhfrdhnvghtqeenucggtffrrghtthgvrhhnpeehfeevgfdtleekledvudeuuedutd
    dukeetudfhffejtddvtdegfffgjeeifeduteenucffohhmrghinhepghhoohhglhgvrdgt
    ohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepph
    grvhgvlhesiihhuhhkohhffhdrnhgvth
X-ME-Proxy: <xmx:IocIY_Mc3dFdYcpwMz-ujcAuhyL_O5TjRBvzQZgH1QdCBFE1TO9_Mw>
    <xmx:IocIY89pb6ng76Nr4m0zzClPI9tbCH7q-u_rwJkuPZ8pvzdGqK9-yQ>
    <xmx:IocIY3WjOsuiTGDsDEJcB3V37zBSZ96A4Cp8orRhmZbSq7oS79faKQ>
    <xmx:IocIYxGVROQOUeb5OFwPuwl5UEzFQ7EdbQF2umB6FXo5nbyYbKBbng>
Feedback-ID: ib94946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Aug 2022 04:41:05 -0400 (EDT)
From: Pavel Zhukov <pavel@zhukoff.net>
To: bitbake-devel@lists.openembedded.org
Cc: Pavel Zhukov <pavel@zhukoff.net>
Subject: [PATCH 2/3] tests:  Add Timeout class
Date: Fri, 26 Aug 2022 10:40:30 +0200
Message-Id: <20220826084031.11919-2-pavel@zhukoff.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220826084031.11919-1-pavel@zhukoff.net>
References: <20220826084031.11919-1-pavel@zhukoff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 26 Aug 2022 08:41:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13935

The class and exception aim to test rare cases there deadlocks are
possible.
Can be used in context managers:
with Timeout(<value>):
        do_deadlock()

Signed-off-by: Pavel Zhukov <pavel@zhukoff.net>
---
 lib/bb/tests/fetch.py | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 7fcf57e7..e69b4b05 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -11,6 +11,7 @@ import hashlib
 import tempfile
 import collections
 import os
+import signal
 import tarfile
 from bb.fetch2 import URI
 from bb.fetch2 import FetchMethod
@@ -22,6 +23,24 @@ def skipIfNoNetwork():
         return unittest.skip("network test")
     return lambda f: f
 
+class TestTimeout(Exception):
+    pass
+
+class Timeout():
+
+    def __init__(self, seconds):
+        self.seconds = seconds
+
+    def handle_timeout(self, signum, frame):
+        raise TestTimeout("Test failed: timeout reached")
+
+    def __enter__(self):
+        signal.signal(signal.SIGALRM, self.handle_timeout)
+        signal.alarm(self.seconds)
+
+    def __exit__(self, exc_type, exc_val, exc_tb):
+        signal.alarm(0)
+
 class URITest(unittest.TestCase):
     test_uris = {
         "http://www.google.com/index.html" : {
-- 
2.35.1


