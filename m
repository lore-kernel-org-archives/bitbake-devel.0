Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBAEC54E94
	for <webhook@archiver.kernel.org>; Thu, 26 Jan 2023 14:39:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web10.74894.1674743978188296511
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Jan 2023 06:39:38 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9548BC14;
	Thu, 26 Jan 2023 06:40:19 -0800 (PST)
Received: from oss-tx204.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A93F3F5A1;
	Thu, 26 Jan 2023 06:39:37 -0800 (PST)
From: Ross Burton <ross.burton@arm.com>
To: bitbake-devel@lists.openembedded.org
Cc: nd@arm.com
Subject: [PATCH] bb/utils: include SSL certificate paths in export_proxies
Date: Thu, 26 Jan 2023 14:39:35 +0000
Message-Id: <20230126143935.1444197-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Jan 2023 14:39:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14348

bb.utils.export_proxies() is a poor-man's alternative for the
environment setup code in bb/fetch2, but it's used in several places
where recipes want to download manually (such as cve-update-db-native).

Notably, export_proxies() doesn't pass on the SSL certificate paths from
the original environment, so if SSL_CERT_FILE needs to be set (for
example, in a buildtools environment) then proxies work but SSL doesn't.

In an ideal world export_proxies and the same logic in fetch2 would
merge, but until then we can add the SSL_CERT_ variables and duplicate
the basic logic: check the datastore first and then the original
environment for variables.

Also remove the return value as nothing ever checked it.

[ YOCTO #15000 ]

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 bitbake/lib/bb/utils.py | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index 8c791595730..bfbc48b6cd9 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -1699,23 +1699,20 @@ def disable_network(uid=3DNone, gid=3DNone):
=20
 def export_proxies(d):
     """ export common proxies variables from datastore to environment ""=
"
-    import os
=20
     variables =3D ['http_proxy', 'HTTP_PROXY', 'https_proxy', 'HTTPS_PRO=
XY',
                     'ftp_proxy', 'FTP_PROXY', 'no_proxy', 'NO_PROXY',
-                    'GIT_PROXY_COMMAND']
-    exported =3D False
+                    'GIT_PROXY_COMMAND', 'SSL_CERT_FILE', 'SSL_CERT_DIR'=
]
=20
-    for v in variables:
-        if v in os.environ.keys():
-            exported =3D True
-        else:
-            v_proxy =3D d.getVar(v)
-            if v_proxy is not None:
-                os.environ[v] =3D v_proxy
-                exported =3D True
+    origenv =3D d.getVar("BB_ORIGENV")
=20
-    return exported
+    for name in variables:
+        value =3D d.getVar(name)
+        if not value and origenv:
+            value =3D origenv.getVar(name)
+        if value:
+            os.environ[name] =3D value
+    return os
=20
=20
 def load_plugins(logger, plugins, pluginpath):
--=20
2.34.1


