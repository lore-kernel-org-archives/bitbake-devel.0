Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4C9E74ACD
	for <webhook@archiver.kernel.org>; Tue,  3 Dec 2024 20:02:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web10.29405.1733256165572366793
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 03 Dec 2024 12:02:45 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12BAAFEC
	for <bitbake-devel@lists.openembedded.org>; Tue,  3 Dec 2024 12:03:13 -0800 (PST)
Received: from cesw-amp-gbt-1s-m12830-04.oss.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ADEB63F5A1
	for <bitbake-devel@lists.openembedded.org>; Tue,  3 Dec 2024 12:02:44 -0800 (PST)
From: Ross Burton <ross.burton@arm.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] fetch2/wget: handle HTTP 308 Permanent Redirect
Date: Tue,  3 Dec 2024 20:02:41 +0000
Message-Id: <20241203200242.2955858-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 03 Dec 2024 20:02:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16858

urllib2.HTTPRedirectHandler.redirect_request doesn't handle HTTP reponse
code 308 (Permanent Redirect). This was fixed in c379bc5 but can't be
worked around without copying the entire redirect_request() method.

When we can depend on Python 3.13, FixedHTTPRedirectHandler can be
removed.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 bitbake/lib/bb/fetch2/wget.py | 42 ++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.p=
y
index 773d41ca81a..fcb71246d9a 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -305,13 +305,45 @@ class Wget(FetchMethod):
=20
         class FixedHTTPRedirectHandler(urllib.request.HTTPRedirectHandle=
r):
             """
-            urllib2.HTTPRedirectHandler resets the method to GET on redi=
rect,
-            when we want to follow redirects using the original method.
+            urllib2.HTTPRedirectHandler before 3.13 has two flaws:
+           =20
+            It resets the method to GET on redirect when we want to foll=
ow
+            redirects using the original method (typically HEAD). This w=
as fixed
+            in 759e8e7.
+
+            It also doesn't handle 308 (Permanent Redirect). This was fi=
xed in
+            c379bc5.
+
+            Until we depend on Python 3.13 onwards, copy the redirect_re=
quest
+            method to fix these issues.
             """
             def redirect_request(self, req, fp, code, msg, headers, newu=
rl):
-                newreq =3D urllib.request.HTTPRedirectHandler.redirect_r=
equest(self, req, fp, code, msg, headers, newurl)
-                newreq.get_method =3D req.get_method
-                return newreq
+                m =3D req.get_method()
+                if (not (code in (301, 302, 303, 307, 308) and m in ("GE=
T", "HEAD")
+                    or code in (301, 302, 303) and m =3D=3D "POST")):
+                    raise urllib.HTTPError(req.full_url, code, msg, head=
ers, fp)
+
+                # Strictly (according to RFC 2616), 301 or 302 in respon=
se to
+                # a POST MUST NOT cause a redirection without confirmati=
on
+                # from the user (of urllib.request, in this case).  In p=
ractice,
+                # essentially all clients do redirect in this case, so w=
e do
+                # the same.
+
+                # Be conciliant with URIs containing a space.  This is m=
ainly
+                # redundant with the more complete encoding done in http=
_error_302(),
+                # but it is kept for compatibility with other callers.
+                newurl =3D newurl.replace(' ', '%20')
+
+                CONTENT_HEADERS =3D ("content-length", "content-type")
+                newheaders =3D {k: v for k, v in req.headers.items()
+                            if k.lower() not in CONTENT_HEADERS}
+                return urllib.request.Request(newurl,
+                            method=3D"HEAD" if m =3D=3D "HEAD" else "GET=
",
+                            headers=3Dnewheaders,
+                            origin_req_host=3Dreq.origin_req_host,
+                            unverifiable=3DTrue)
+
+            http_error_308 =3D urllib.request.HTTPRedirectHandler.http_e=
rror_302
=20
         # We need to update the environment here as both the proxy and H=
TTPS
         # handlers need variables set. The proxy needs http_proxy and fr=
iends to
--=20
2.34.1


