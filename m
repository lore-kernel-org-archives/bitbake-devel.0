Return-Path: <jean-marie.lemetayer@savoirfairelinux.com>
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
	[208.88.110.44])
	by mail.openembedded.org (Postfix) with ESMTP id 27D9D7FA24
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Jan 2020 16:52:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 8D1D29C0468;
	Fri, 17 Jan 2020 11:46:02 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id mXeuZs_du0uj; Fri, 17 Jan 2020 11:46:01 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id B96439C044D;
	Fri, 17 Jan 2020 11:46:01 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id mjkEBaXC85la; Fri, 17 Jan 2020 11:46:01 -0500 (EST)
Received: from sulaco.example.com (40.73.12.109.rev.sfr.net [109.12.73.40])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id D96459C0451;
	Fri, 17 Jan 2020 11:46:00 -0500 (EST)
From: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 17 Jan 2020 17:45:43 +0100
Message-Id: <20200117164548.28453-8-jean-marie.lemetayer@savoirfairelinux.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200117164548.28453-1-jean-marie.lemetayer@savoirfairelinux.com>
References: <20200117164548.28453-1-jean-marie.lemetayer@savoirfairelinux.com>
MIME-Version: 1.0
Cc: rennes-dev@savoirfairelinux.com, paul.eggleton@linux.intel.com
Subject: [PATCH v4 07/12] bitbake: fetch2: allow fetchers to forward the done condition
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
X-List-Received-Date: Fri, 17 Jan 2020 16:52:10 -0000
Content-Transfer-Encoding: quoted-printable

This commit is necessary to introduce proxy fetchers and do not modify
the behavior of existing fetchers.

This commit allows fetchers to forwards the done condition to a
proxy fetcher.

Signed-off-by: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinu=
x.com>
---
 lib/bb/fetch2/__init__.py | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 0d060e19..5c89ef61 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1568,7 +1568,7 @@ class FetchMethod(object):
         """
         Try to use a mirror
         """
-        return try_mirrors(fetch, d, urldata, mirrors)
+        return bool(try_mirrors(fetch, d, urldata, mirrors))
=20
     def checkstatus(self, fetch, urldata, d):
         """
@@ -1609,6 +1609,16 @@ class FetchMethod(object):
         """
         return ('', '')
=20
+    def done(self, ud, d):
+        """
+        Is the download done ?
+        """
+        if os.path.exists(ud.localpath):
+            return True
+        if ud.localpath.find("*") !=3D -1:
+            return True
+        return False
+
 class Fetch(object):
     def __init__(self, urls, d, cache =3D True, localonly =3D False, con=
nection_cache =3D None):
         if localonly and cache:
@@ -1672,7 +1682,7 @@ class Fetch(object):
             ud =3D self.ud[u]
             ud.setup_localpath(self.d)
             m =3D ud.method
-            localpath =3D ""
+            done =3D False
=20
             if ud.lockfile:
                 lf =3D bb.utils.lockfile(ud.lockfile)
@@ -1681,12 +1691,12 @@ class Fetch(object):
                 self.d.setVar("BB_NO_NETWORK", network)
=20
                 if m.verify_donestamp(ud, self.d) and not m.need_update(=
ud, self.d):
-                    localpath =3D ud.localpath
+                    done =3D True
                 elif m.try_premirror(ud, self.d):
                     logger.debug(1, "Trying PREMIRRORS")
                     mirrors =3D mirror_from_string(self.d.getVar('PREMIR=
RORS'))
-                    localpath =3D m.try_mirrors(self, ud, self.d, mirror=
s)
-                    if localpath:
+                    done =3D m.try_mirrors(self, ud, self.d, mirrors)
+                    if done:
                         try:
                             # early checksum verification so that if the=
 checksum of the premirror
                             # contents mismatch the fetcher can still tr=
y upstream and mirrors
@@ -1694,14 +1704,14 @@ class Fetch(object):
                         except ChecksumError as e:
                             logger.warning("Checksum failure encountered=
 with premirror download of %s - will attempt other sources." % u)
                             logger.debug(1, str(e))
-                            localpath =3D ""
+                            done =3D False
=20
                 if premirroronly:
                     self.d.setVar("BB_NO_NETWORK", "1")
=20
                 firsterr =3D None
                 verified_stamp =3D m.verify_donestamp(ud, self.d)
-                if not localpath and (not verified_stamp or m.need_updat=
e(ud, self.d)):
+                if not done and (not verified_stamp or m.need_update(ud,=
 self.d)):
                     try:
                         if not trusted_network(self.d, ud.url):
                             raise UntrustedUrl(ud.url)
@@ -1709,7 +1719,7 @@ class Fetch(object):
                         m.download(ud, self.d)
                         if hasattr(m, "build_mirror_data"):
                             m.build_mirror_data(ud, self.d)
-                        localpath =3D ud.localpath
+                        done =3D True
                         # early checksum verify, so that if checksum mis=
matched,
                         # fetcher still have chance to fetch from mirror
                         m.update_donestamp(ud, self.d)
@@ -1734,9 +1744,9 @@ class Fetch(object):
                             m.clean(ud, self.d)
                         logger.debug(1, "Trying MIRRORS")
                         mirrors =3D mirror_from_string(self.d.getVar('MI=
RRORS'))
-                        localpath =3D m.try_mirrors(self, ud, self.d, mi=
rrors)
+                        done =3D m.try_mirrors(self, ud, self.d, mirrors=
)
=20
-                if not localpath or ((not os.path.exists(localpath)) and=
 localpath.find("*") =3D=3D -1):
+                if not done or not m.done(ud, self.d):
                     if firsterr:
                         logger.error(str(firsterr))
                     raise FetchError("Unable to fetch URL from any sourc=
e.", u)
--=20
2.20.1


