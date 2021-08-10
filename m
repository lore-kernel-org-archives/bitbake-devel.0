Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web11.267.1628614514370976454
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 Aug 2021 09:55:14 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9ECFB1063
	for <bitbake-devel@lists.openembedded.org>; Tue, 10 Aug 2021 09:55:12 -0700 (PDT)
Received: from oss-tx204.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A6373F718
	for <bitbake-devel@lists.openembedded.org>; Tue, 10 Aug 2021 09:55:12 -0700 (PDT)
From: "Ross Burton" <ross@burtonini.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v3 2/4] fetch2: expose environment variable names that need to be exported
Date: Tue, 10 Aug 2021 17:55:07 +0100
Message-Id: <20210810165509.19121-2-ross.burton@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210810165509.19121-1-ross.burton@arm.com>
References: <20210810165509.19121-1-ross.burton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is a list of environment variable names that need to be exported
when executing external commands, such as 'http_proxy'.  To avoid
duplication, make this a top-level variable.

Also add SSL_CERT_FILE, which is used by OpenSSL to locate the
certificate bundle. This is needed in buildtools environments where the
default path isn't valid.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 46 ++++++++++++++++---------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__=
init__.py
index ad898680ff7..914fa5c0243 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -808,6 +808,29 @@ def localpath(url, d):
     fetcher =3D bb.fetch2.Fetch([url], d)
     return fetcher.localpath(url)
=20
+# Need to export PATH as binary could be in metadata paths
+# rather than host provided
+# Also include some other variables.
+FETCH_EXPORT_VARS =3D ['HOME', 'PATH',
+                     'HTTP_PROXY', 'http_proxy',
+                     'HTTPS_PROXY', 'https_proxy',
+                     'FTP_PROXY', 'ftp_proxy',
+                     'FTPS_PROXY', 'ftps_proxy',
+                     'NO_PROXY', 'no_proxy',
+                     'ALL_PROXY', 'all_proxy',
+                     'GIT_PROXY_COMMAND',
+                     'GIT_SSH',
+                     'GIT_SSL_CAINFO',
+                     'GIT_SMART_HTTP',
+                     'SSH_AUTH_SOCK', 'SSH_AGENT_PID',
+                     'SOCKS5_USER', 'SOCKS5_PASSWD',
+                     'DBUS_SESSION_BUS_ADDRESS',
+                     'P4CONFIG',
+                     'SSL_CERT_FILE',
+                     'AWS_ACCESS_KEY_ID',
+                     'AWS_SECRET_ACCESS_KEY',
+                     'AWS_DEFAULT_REGION']
+
 def runfetchcmd(cmd, d, quiet=3DFalse, cleanup=3DNone, log=3DNone, workd=
ir=3DNone):
     """
     Run cmd returning the command output
@@ -816,28 +839,7 @@ def runfetchcmd(cmd, d, quiet=3DFalse, cleanup=3DNon=
e, log=3DNone, workdir=3DNone):
     Optionally remove the files/directories listed in cleanup upon failu=
re
     """
=20
-    # Need to export PATH as binary could be in metadata paths
-    # rather than host provided
-    # Also include some other variables.
-    # FIXME: Should really include all export varaiables?
-    exportvars =3D ['HOME', 'PATH',
-                  'HTTP_PROXY', 'http_proxy',
-                  'HTTPS_PROXY', 'https_proxy',
-                  'FTP_PROXY', 'ftp_proxy',
-                  'FTPS_PROXY', 'ftps_proxy',
-                  'NO_PROXY', 'no_proxy',
-                  'ALL_PROXY', 'all_proxy',
-                  'GIT_PROXY_COMMAND',
-                  'GIT_SSH',
-                  'GIT_SSL_CAINFO',
-                  'GIT_SMART_HTTP',
-                  'SSH_AUTH_SOCK', 'SSH_AGENT_PID',
-                  'SOCKS5_USER', 'SOCKS5_PASSWD',
-                  'DBUS_SESSION_BUS_ADDRESS',
-                  'P4CONFIG',
-                  'AWS_ACCESS_KEY_ID',
-                  'AWS_SECRET_ACCESS_KEY',
-                  'AWS_DEFAULT_REGION']
+    exportvars =3D FETCH_EXPORT_VARS
=20
     if not cleanup:
         cleanup =3D []
--=20
2.25.1

