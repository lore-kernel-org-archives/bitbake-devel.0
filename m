Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web09.14199.1624900364598358048
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Jun 2021 10:12:44 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2AF41042
	for <bitbake-devel@lists.openembedded.org>; Mon, 28 Jun 2021 10:12:42 -0700 (PDT)
Received: from oss-tx204.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B8643F718
	for <bitbake-devel@lists.openembedded.org>; Mon, 28 Jun 2021 10:12:42 -0700 (PDT)
From: "Ross Burton" <ross@burtonini.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2] fetch2/wget: fetch securely by default
Date: Mon, 28 Jun 2021 18:12:40 +0100
Message-Id: <20210628171240.950640-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The days of broken certificates are behind us now, so instead of always
passing --no-check-certificate to wget, don't pass it by default and
instead only pass it BB_CHECK_SSL_CERTS =3D "0".

[ YOCTO #14108 ]

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 .../bitbake-user-manual-fetching.rst            |  4 ++++
 .../bitbake-user-manual-ref-variables.rst       |  4 ++++
 bitbake/lib/bb/fetch2/wget.py                   | 17 ++++++++++++++---
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching=
.rst b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index bd1fb4fc74e..5980349ed55 100644
--- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -144,6 +144,10 @@ download without a checksum triggers an error messag=
e. The
 make any attempted network access a fatal error, which is useful for
 checking that mirrors are complete as well as other things.
=20
+If :term:`BB_CHECK_SSL_CERTS` is set to ``0`` then SSL certificate check=
ing will
+be disabled. This variable defaults to ``1`` so SSL certificates are nor=
mally
+checked.
+
 .. _bb-the-unpack:
=20
 The Unpack
diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-vari=
ables.rst b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-varia=
bles.rst
index 2dca52c4a09..4f989b0fcd2 100644
--- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.r=
st
+++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.r=
st
@@ -92,6 +92,10 @@ overview of their function and contents.
       fetcher does not attempt to use the host listed in ``SRC_URI`` aft=
er
       a successful fetch from the ``PREMIRRORS`` occurs.
=20
+   :term:`BB_CHECK_SSL_CERTS`
+      Specifies if SSL certificates should be checked when fetching. The=
 default
+      value is ``1`` and certificates are not checked if the value is se=
t to ``0``.
+
    :term:`BB_CONSOLELOG`
       Specifies the path to a log file into which BitBake's user interfa=
ce
       writes output during the build.
diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.p=
y
index 784df70c9f6..cbd88b81026 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -52,13 +52,19 @@ class WgetProgressHandler(bb.progress.LineFilterProgr=
essHandler):
=20
=20
 class Wget(FetchMethod):
+    """Class to fetch urls via 'wget'"""
=20
     # CDNs like CloudFlare may do a 'browser integrity test' which can f=
ail
     # with the standard wget/urllib User-Agent, so pretend to be a moder=
n
     # browser.
     user_agent =3D "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:84.0) Gec=
ko/20100101 Firefox/84.0"
=20
-    """Class to fetch urls via 'wget'"""
+    def check_certs(self, d):
+        """
+        Should certificates be checked?
+        """
+        return (d.getVar("BB_CHECK_SSL_CERTS") or "1") !=3D "0"
+
     def supports(self, ud, d):
         """
         Check to see if a given url can be fetched with wget.
@@ -82,7 +88,10 @@ class Wget(FetchMethod):
         if not ud.localfile:
             ud.localfile =3D d.expand(urllib.parse.unquote(ud.host + ud.=
path).replace("/", "."))
=20
-        self.basecmd =3D d.getVar("FETCHCMD_wget") or "/usr/bin/env wget=
 -t 2 -T 30 --passive-ftp --no-check-certificate"
+        self.basecmd =3D d.getVar("FETCHCMD_wget") or "/usr/bin/env wget=
 -t 2 -T 30 --passive-ftp"
+
+        if not self.check_certs(d):
+            self.basecmd +=3D " --no-check-certificate"
=20
     def _runwget(self, ud, d, command, quiet, workdir=3DNone):
=20
@@ -288,12 +297,14 @@ class Wget(FetchMethod):
         if exported_proxies:
             handlers.append(urllib.request.ProxyHandler())
         handlers.append(CacheHTTPHandler())
+
         # Since Python 2.7.9 ssl cert validation is enabled by default
         # see PEP-0476, this causes verification errors on some https se=
rvers
         # so disable by default.
         import ssl
-        if hasattr(ssl, '_create_unverified_context'):
+        if not self.check_certs(d) and hasattr(ssl, '_create_unverified_=
context'):
             handlers.append(urllib.request.HTTPSHandler(context=3Dssl._c=
reate_unverified_context()))
+
         opener =3D urllib.request.build_opener(*handlers)
=20
         try:
--=20
2.25.1

