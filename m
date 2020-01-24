Return-Path: <jean-marie.lemetayer@savoirfairelinux.com>
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
	[208.88.110.44])
	by mail.openembedded.org (Postfix) with ESMTP id 433787FDD2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Jan 2020 17:08:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 7F5B09C02ED;
	Fri, 24 Jan 2020 12:08:26 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id 0iJKZZKKkodC; Fri, 24 Jan 2020 12:08:25 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id C6F4A9C02D7;
	Fri, 24 Jan 2020 12:08:25 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id pffSyZ0FVm4m; Fri, 24 Jan 2020 12:08:25 -0500 (EST)
Received: from sulaco.jml.bzh (91-167-182-132.subs.proxad.net [91.167.182.132])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id C91C29C02F3;
	Fri, 24 Jan 2020 12:08:24 -0500 (EST)
From: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 24 Jan 2020 18:08:07 +0100
Message-Id: <20200124170814.20510-6-jean-marie.lemetayer@savoirfairelinux.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124170814.20510-1-jean-marie.lemetayer@savoirfairelinux.com>
References: <20200124170814.20510-1-jean-marie.lemetayer@savoirfairelinux.com>
MIME-Version: 1.0
Cc: paul.eggleton@linux.intel.com, rennes-dev@savoirfairelinux.com
Subject: [PATCH v6 05/12] fetch2: allow fetchers to forward the donestamp management
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
X-List-Received-Date: Fri, 24 Jan 2020 17:08:25 -0000
Content-Transfer-Encoding: quoted-printable

This commit is necessary to introduce proxy fetchers and do not modify
the behavior of existing fetchers.

This commit allows fetchers to forwards the "verify_donestamp" and
"update_stamp" functions to a proxy fetcher.

Signed-off-by: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinu=
x.com>
---
 lib/bb/fetch2/__init__.py | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 28ded462..b3b92e5c 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1379,6 +1379,18 @@ class FetchMethod(object):
         """
         return False
=20
+    def verify_donestamp(self, ud, d):
+        """
+        Verify the donestamp file
+        """
+        return verify_donestamp(ud, d)
+
+    def update_donestamp(self, ud, d):
+        """
+        Update the donestamp file
+        """
+        update_stamp(ud, d)
+
     def _strip_leading_slashes(self, relpath):
         """
         Remove leading slash as os.path.join can't cope
@@ -1662,7 +1674,7 @@ class Fetch(object):
             try:
                 self.d.setVar("BB_NO_NETWORK", network)
=20
-                if verify_donestamp(ud, self.d) and not m.need_update(ud=
, self.d):
+                if m.verify_donestamp(ud, self.d) and not m.need_update(=
ud, self.d):
                     localpath =3D ud.localpath
                 elif m.try_premirror(ud, self.d):
                     logger.debug(1, "Trying PREMIRRORS")
@@ -1672,7 +1684,7 @@ class Fetch(object):
                         try:
                             # early checksum verification so that if the=
 checksum of the premirror
                             # contents mismatch the fetcher can still tr=
y upstream and mirrors
-                            update_stamp(ud, self.d)
+                            m.update_donestamp(ud, self.d)
                         except ChecksumError as e:
                             logger.warning("Checksum failure encountered=
 with premirror download of %s - will attempt other sources." % u)
                             logger.debug(1, str(e))
@@ -1682,7 +1694,7 @@ class Fetch(object):
                     self.d.setVar("BB_NO_NETWORK", "1")
=20
                 firsterr =3D None
-                verified_stamp =3D verify_donestamp(ud, self.d)
+                verified_stamp =3D m.verify_donestamp(ud, self.d)
                 if not localpath and (not verified_stamp or m.need_updat=
e(ud, self.d)):
                     try:
                         if not trusted_network(self.d, ud.url):
@@ -1694,7 +1706,7 @@ class Fetch(object):
                         localpath =3D ud.localpath
                         # early checksum verify, so that if checksum mis=
matched,
                         # fetcher still have chance to fetch from mirror
-                        update_stamp(ud, self.d)
+                        m.update_donestamp(ud, self.d)
=20
                     except bb.fetch2.NetworkAccess:
                         raise
@@ -1723,7 +1735,7 @@ class Fetch(object):
                         logger.error(str(firsterr))
                     raise FetchError("Unable to fetch URL from any sourc=
e.", u)
=20
-                update_stamp(ud, self.d)
+                m.update_donestamp(ud, self.d)
=20
             except IOError as e:
                 if e.errno in [errno.ESTALE]:
--=20
2.20.1


