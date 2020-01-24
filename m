Return-Path: <jean-marie.lemetayer@savoirfairelinux.com>
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
	[208.88.110.44])
	by mail.openembedded.org (Postfix) with ESMTP id 362CA7FDD2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Jan 2020 17:08:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 73F249C02BE;
	Fri, 24 Jan 2020 12:08:27 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id N5-Ct5ETpaxp; Fri, 24 Jan 2020 12:08:26 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id CC7569C02D7;
	Fri, 24 Jan 2020 12:08:26 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id PlR3YaK24gVf; Fri, 24 Jan 2020 12:08:26 -0500 (EST)
Received: from sulaco.jml.bzh (91-167-182-132.subs.proxad.net [91.167.182.132])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id CFAC09C02E8;
	Fri, 24 Jan 2020 12:08:25 -0500 (EST)
From: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 24 Jan 2020 18:08:08 +0100
Message-Id: <20200124170814.20510-7-jean-marie.lemetayer@savoirfairelinux.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124170814.20510-1-jean-marie.lemetayer@savoirfairelinux.com>
References: <20200124170814.20510-1-jean-marie.lemetayer@savoirfairelinux.com>
MIME-Version: 1.0
Cc: paul.eggleton@linux.intel.com, rennes-dev@savoirfairelinux.com
Subject: [PATCH v6 06/12] fetch2: allow fetchers to forward the mirrors management
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 24 Jan 2020 17:08:26 -0000
Content-Transfer-Encoding: quoted-printable

This commit is necessary to introduce proxy fetchers and do not modify
the behavior of existing fetchers.

This commit allows fetchers to forwards the "try_mirrors" functions to
a proxy fetcher.

Signed-off-by: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinu=
x.com>
---
 lib/bb/fetch2/__init__.py | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index b3b92e5c..9a0e396f 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1565,6 +1565,12 @@ class FetchMethod(object):
         """
         return True
=20
+    def try_mirrors(self, fetch, urldata, d, mirrors, check=3DFalse):
+        """
+        Try to use a mirror
+        """
+        return try_mirrors(fetch, d, urldata, mirrors, check)
+
     def checkstatus(self, fetch, urldata, d):
         """
         Check the status of a URL
@@ -1679,7 +1685,7 @@ class Fetch(object):
                 elif m.try_premirror(ud, self.d):
                     logger.debug(1, "Trying PREMIRRORS")
                     mirrors =3D mirror_from_string(self.d.getVar('PREMIR=
RORS'))
-                    localpath =3D try_mirrors(self, self.d, ud, mirrors,=
 False)
+                    localpath =3D m.try_mirrors(self, ud, self.d, mirror=
s)
                     if localpath:
                         try:
                             # early checksum verification so that if the=
 checksum of the premirror
@@ -1728,7 +1734,7 @@ class Fetch(object):
                             m.clean(ud, self.d)
                         logger.debug(1, "Trying MIRRORS")
                         mirrors =3D mirror_from_string(self.d.getVar('MI=
RRORS'))
-                        localpath =3D try_mirrors(self, self.d, ud, mirr=
ors)
+                        localpath =3D m.try_mirrors(self, ud, self.d, mi=
rrors)
=20
                 if not localpath or ((not os.path.exists(localpath)) and=
 localpath.find("*") =3D=3D -1):
                     if firsterr:
@@ -1766,14 +1772,14 @@ class Fetch(object):
             logger.debug(1, "Testing URL %s", u)
             # First try checking uri, u, from PREMIRRORS
             mirrors =3D mirror_from_string(self.d.getVar('PREMIRRORS'))
-            ret =3D try_mirrors(self, self.d, ud, mirrors, True)
+            ret =3D m.try_mirrors(self, ud, self.d, mirrors, True)
             if not ret:
                 # Next try checking from the original uri, u
                 ret =3D m.checkstatus(self, ud, self.d)
                 if not ret:
                     # Finally, try checking uri, u, from MIRRORS
                     mirrors =3D mirror_from_string(self.d.getVar('MIRROR=
S'))
-                    ret =3D try_mirrors(self, self.d, ud, mirrors, True)
+                    ret =3D m.try_mirrors(self, ud, self.d, mirrors, Tru=
e)
=20
             if not ret:
                 raise FetchError("URL %s doesn't work" % u, u)
--=20
2.20.1


