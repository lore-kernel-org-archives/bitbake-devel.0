Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web10.5408.1611226218074632479
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 21 Jan 2021 02:50:18 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7C7414FF
	for <bitbake-devel@lists.openembedded.org>; Thu, 21 Jan 2021 02:50:17 -0800 (PST)
Received: from oss-tx204.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 572BC3F719
	for <bitbake-devel@lists.openembedded.org>; Thu, 21 Jan 2021 02:50:17 -0800 (PST)
From: "Ross Burton" <ross@burtonini.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] tests/fetch: add test for empty query parameters
Date: Thu, 21 Jan 2021 10:50:11 +0000
Message-Id: <20210121105011.3766882-2-ross.burton@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121105011.3766882-1-ross.burton@arm.com>
References: <20210121105011.3766882-1-ross.burton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

To exercise the previous patch, add a test case.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 bitbake/lib/bb/tests/fetch.py | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.p=
y
index 1452d76151..20beab3855 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -87,6 +87,25 @@ class URITest(unittest.TestCase):
             },
             'relative': False
         },
+        # Check that trailing semicolons are handled correctly
+        "http://www.example.org/index.html?qparam1=3Dqvalue1;param2=3Dva=
lue2;" : {
+            'uri': 'http://www.example.org/index.html?qparam1=3Dqvalue1;=
param2=3Dvalue2',
+            'scheme': 'http',
+            'hostname': 'www.example.org',
+            'port': None,
+            'hostport': 'www.example.org',
+            'path': '/index.html',
+            'userinfo': '',
+            'username': '',
+            'password': '',
+            'params': {
+                'param2': 'value2'
+            },
+            'query': {
+                'qparam1': 'qvalue1'
+            },
+            'relative': False
+        },
         "http://www.example.com:8080/index.html" : {
             'uri': 'http://www.example.com:8080/index.html',
             'scheme': 'http',
--=20
2.25.1

