Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web10.306.1628614514211404976
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 Aug 2021 09:55:14 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7F1F113E
	for <bitbake-devel@lists.openembedded.org>; Tue, 10 Aug 2021 09:55:13 -0700 (PDT)
Received: from oss-tx204.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63D883F718
	for <bitbake-devel@lists.openembedded.org>; Tue, 10 Aug 2021 09:55:13 -0700 (PDT)
From: "Ross Burton" <ross@burtonini.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v3 4/4] fetch2/wget: fetch securely by default
Date: Tue, 10 Aug 2021 17:55:09 +0100
Message-Id: <20210810165509.19121-4-ross.burton@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210810165509.19121-1-ross.burton@arm.com>
References: <20210810165509.19121-1-ross.burton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Ross Burton <ross@burtonini.com>

The days of broken certificates are behind us now, so instead of always
passing --no-check-certificate to wget, don't pass it by default and
instead only pass it BB_CHECK_SSL_CERTS =3D "0".

[ YOCTO #14108 ]

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 .../bitbake-user-manual-fetching.rst          |  4 ++++
 .../bitbake-user-manual-ref-variables.rst     |  4 ++++
 bitbake/lib/bb/fetch2/wget.py                 | 19 ++++++++++++++++---
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching=
.rst b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index 593de61f242..40b245b6d30 100644
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
index 6283c2654c8..2392ec42563 100644
--- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.r=
st
+++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.r=
st
@@ -93,6 +93,10 @@ overview of their function and contents.
       fetcher does not attempt to use the host listed in :term:`SRC_URI`=
 after
       a successful fetch from the :term:`PREMIRRORS` occurs.
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
index d67f9b889cc..81c377ae6f2 100644
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
@@ -305,7 +314,11 @@ class Wget(FetchMethod):
         with bb.utils.environment(**newenv):
             import ssl
=20
-            context =3D ssl._create_unverified_context()
+            if self.check_certs(d):
+                context =3D ssl.create_default_context()
+            else:
+                context =3D ssl._create_unverified_context()
+
             handlers =3D [FixedHTTPRedirectHandler,
                         HTTPMethodFallback,
                         urllib.request.ProxyHandler(),
--=20
2.25.1

