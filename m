Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web12.252.1628614513737050219
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 Aug 2021 09:55:14 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 312FB106F
	for <bitbake-devel@lists.openembedded.org>; Tue, 10 Aug 2021 09:55:13 -0700 (PDT)
Received: from oss-tx204.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D127D3F718
	for <bitbake-devel@lists.openembedded.org>; Tue, 10 Aug 2021 09:55:12 -0700 (PDT)
From: "Ross Burton" <ross@burtonini.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v3 3/4] fetch2/wget: ensure all variables are set when calling urllib
Date: Tue, 10 Aug 2021 17:55:08 +0100
Message-Id: <20210810165509.19121-3-ross.burton@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210810165509.19121-1-ross.burton@arm.com>
References: <20210810165509.19121-1-ross.burton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Instead of just exporting the proxy variables when calling into urllib,
use bb.utils.environment() to export all of the known variables that are
needed for proper connectivity.

Specifically, this ensures that SSL_CERT_FILE is set, so that libssl can
find the certificates in buildtools environments

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 bitbake/lib/bb/fetch2/wget.py | 43 ++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.p=
y
index 784df70c9f6..d67f9b889cc 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -282,19 +282,36 @@ class Wget(FetchMethod):
                 newreq =3D urllib.request.HTTPRedirectHandler.redirect_r=
equest(self, req, fp, code, msg, headers, newurl)
                 newreq.get_method =3D req.get_method
                 return newreq
-        exported_proxies =3D export_proxies(d)
-
-        handlers =3D [FixedHTTPRedirectHandler, HTTPMethodFallback]
-        if exported_proxies:
-            handlers.append(urllib.request.ProxyHandler())
-        handlers.append(CacheHTTPHandler())
-        # Since Python 2.7.9 ssl cert validation is enabled by default
-        # see PEP-0476, this causes verification errors on some https se=
rvers
-        # so disable by default.
-        import ssl
-        if hasattr(ssl, '_create_unverified_context'):
-            handlers.append(urllib.request.HTTPSHandler(context=3Dssl._c=
reate_unverified_context()))
-        opener =3D urllib.request.build_opener(*handlers)
+
+        # We need to update the environment here as both the proxy and H=
TTPS
+        # handlers need variables set. The proxy needs http_proxy and fr=
iends to
+        # be set, and HTTPSHandler ends up calling into openssl to load =
the
+        # certificates. In buildtools configurations this will be lookin=
g at the
+        # wrong place for certificates by default: we set SSL_CERT_FILE =
to the
+        # right location in the buildtools environment script but as Bit=
Bake
+        # prunes prunes the environment this is lost. When binaries are =
executed
+        # runfetchcmd ensures these values are in the environment, but t=
his is
+        # pure Python so we need to update the environment.
+        #
+        # Avoid tramping the environment too much by using bb.utils.envi=
ronment
+        # to scope the changes to the build_opener request, which is whe=
n the
+        # environment lookups happen.
+        newenv =3D {}
+        for name in bb.fetch2.FETCH_EXPORT_VARS:
+            value =3D d.getVar(name) or d.getVar("BB_ORIGENV").getVar(na=
me)
+            if value:
+                newenv[name] =3D value
+
+        with bb.utils.environment(**newenv):
+            import ssl
+
+            context =3D ssl._create_unverified_context()
+            handlers =3D [FixedHTTPRedirectHandler,
+                        HTTPMethodFallback,
+                        urllib.request.ProxyHandler(),
+                        CacheHTTPHandler(),
+                        urllib.request.HTTPSHandler(context=3Dcontext)]
+            opener =3D urllib.request.build_opener(*handlers)
=20
         try:
             uri =3D ud.url.split(";")[0]
--=20
2.25.1

