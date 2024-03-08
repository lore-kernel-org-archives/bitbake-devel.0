Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8E7C54E4A
	for <webhook@archiver.kernel.org>; Fri,  8 Mar 2024 14:14:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web10.22868.1709907283927094660
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 08 Mar 2024 06:14:44 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DD41C15
	for <bitbake-devel@lists.openembedded.org>; Fri,  8 Mar 2024 06:15:20 -0800 (PST)
Received: from oss-tx204.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 17D113F762
	for <bitbake-devel@lists.openembedded.org>; Fri,  8 Mar 2024 06:14:42 -0800 (PST)
From: ross.burton@arm.com
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch2: handle URIs with single-valued query parameters
Date: Fri,  8 Mar 2024 14:14:39 +0000
Message-Id: <20240308141439.1119130-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 08 Mar 2024 14:14:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15994

From: Ross Burton <ross.burton@arm.com>

Whilst typically the URI query is a list of key-value pairs, that's not
actually required by the URI specification.

For example:  http://example.com/foo?bar is a valid query, but this will
result in the fetcher raising an exception:

  File "bitbake/lib/bb/fetch2/__init__.py", line 265, in __init__
    self.query =3D self._param_str_split(urlp.query, "&")
  File "bitbake/lib/bb/fetch2/__init__.py", line 293, in _param_str_split
    for k, v in [x.split(kvdelim, 1) for x in string.split(elmdelim) if x=
]:
ValueError: not enough values to unpack (expected 2, got 1)

In this case the query is just "bar", but the fetcher is trying to split
it into a key-value pair.

The URI object exposes the parsed query explicitly as a dictionary of
key-value pairs, so we have to be a little creative here: if a value is
None then it isn't a key-value pair, but a bare key.

Fix this by handling elements without the deliminator in _param_str_split=
()
(by assigning the value to None), and handle a None value when formatting
the query in _param_str_join().

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 bitbake/lib/bb/fetch2/__init__.py |  4 ++--
 bitbake/lib/bb/tests/fetch.py     | 15 +++++++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__=
init__.py
index 3529531ca1e..37fed16e4e0 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -290,12 +290,12 @@ class URI(object):
=20
     def _param_str_split(self, string, elmdelim, kvdelim=3D"=3D"):
         ret =3D collections.OrderedDict()
-        for k, v in [x.split(kvdelim, 1) for x in string.split(elmdelim)=
 if x]:
+        for k, v in [x.split(kvdelim, 1) if kvdelim in x else (x, None) =
for x in string.split(elmdelim) if x]:
             ret[k] =3D v
         return ret
=20
     def _param_str_join(self, dict_, elmdelim, kvdelim=3D"=3D"):
-        return elmdelim.join([kvdelim.join([k, v]) for k, v in dict_.ite=
ms()])
+        return elmdelim.join([kvdelim.join([k, v]) if v else k for k, v =
in dict_.items()])
=20
     @property
     def hostport(self):
diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.p=
y
index e988e26c0aa..85c1f79ff32 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -308,6 +308,21 @@ class URITest(unittest.TestCase):
             'params': {"someparam" : "1"},
             'query': {},
             'relative': True
+        },
+        "https://www.innodisk.com/Download_file?9BE0BF6657;downloadfilen=
ame=3DEGPL-T101.zip": {
+            'uri': 'https://www.innodisk.com/Download_file?9BE0BF6657;do=
wnloadfilename=3DEGPL-T101.zip',
+            'scheme': 'https',
+            'hostname': 'www.innodisk.com',
+            'port': None,
+            'hostport': 'www.innodisk.com',
+            'path': '/Download_file',
+            'userinfo': '',
+            'userinfo': '',
+            'username': '',
+            'password': '',
+            'params': {"downloadfilename" : "EGPL-T101.zip"},
+            'query': {"9BE0BF6657": None},
+            'relative': False
         }
=20
     }
--=20
2.34.1


