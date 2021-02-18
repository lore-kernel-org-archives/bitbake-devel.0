Received: from MTA-07-4.privateemail.com (MTA-07-4.privateemail.com [68.65.122.27])
 by mx.groups.io with SMTP id smtpd.web11.892.1613681642233622647
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Feb 2021 12:54:02 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: whitetree.xyz, ip: 68.65.122.27, mailfrom: charles.davies@whitetree.xyz)
Received: from MTA-07.privateemail.com (localhost [127.0.0.1])
	by MTA-07.privateemail.com (Postfix) with ESMTP id D80A86005E;
	Thu, 18 Feb 2021 15:54:01 -0500 (EST)
Received: from localhost.localdomain (unknown [10.20.151.232])
	by MTA-07.privateemail.com (Postfix) with ESMTPA id D9A196005B;
	Thu, 18 Feb 2021 20:54:00 +0000 (UTC)
From: "Charlie Davies" <charles.davies@whitetree.xyz>
To: bitbake-devel@lists.openembedded.org
Cc: Charlie Davies <charles.davies@whitetree.xyz>
Subject: [PATCH 7/9] bitbake: lib: add Required Version to Bitbake --show-versions command
Date: Thu, 18 Feb 2021 20:52:19 +0000
Message-Id: <20210218205221.55005-8-charles.davies@whitetree.xyz>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210218205221.55005-1-charles.davies@whitetree.xyz>
References: <20210218205221.55005-1-charles.davies@whitetree.xyz>
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Content-Transfer-Encoding: quoted-printable

This commit adds a new column to the Bitbake --show-versions command
called Required Version. This column will display any packages which
have a REQUIRED_VERSION successfully set.

Fixes [YOCTO #10096]

Signed-off-by: Charlie Davies <charles.davies@whitetree.xyz>
---
 bitbake/lib/bb/cooker.py    | 24 ++++++++++++++++--------
 bitbake/lib/bb/providers.py | 14 ++++++++------
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 0e492b9be9..03e311ee83 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -502,22 +502,30 @@ class BBCooker:
=20
     def showVersions(self):
=20
-        (latest_versions, preferred_versions) =3D self.findProviders()
+        (latest_versions, preferred_versions, required) =3D self.findPro=
viders()
=20
-        logger.plain("%-35s %25s %25s", "Recipe Name", "Latest Version",=
 "Preferred Version")
-        logger.plain("%-35s %25s %25s\n", "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D", "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D", "=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D")
+        logger.plain("%-35s %25s %25s %25s", "Recipe Name", "Latest Vers=
ion", "Preferred Version", "Required Version")
+        logger.plain("%-35s %25s %25s %25s\n", "=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D", "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D", "=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D", "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D")
=20
         for p in sorted(self.recipecaches[''].pkg_pn):
-            pref =3D preferred_versions[p]
+            preferred =3D preferred_versions[p]
             latest =3D latest_versions[p]
+            requiredstr =3D ""
+            preferredstr =3D ""
+            if required[p]:
+                if preferred[0] is not None:
+                    requiredstr =3D preferred[0][0] + ":" + preferred[0]=
[1] + '-' + preferred[0][2]
+                else:
+                    bb.fatal("REQUIRED_VERSION of package %s not availab=
le" % p)
+            else:
+                preferredstr =3D preferred[0][0] + ":" + preferred[0][1]=
 + '-' + preferred[0][2]
=20
-            prefstr =3D pref[0][0] + ":" + pref[0][1] + '-' + pref[0][2]
             lateststr =3D latest[0][0] + ":" + latest[0][1] + "-" + late=
st[0][2]
=20
-            if pref =3D=3D latest:
-                prefstr =3D ""
+            if preferred =3D=3D latest:
+                preferredstr =3D ""
=20
-            logger.plain("%-35s %25s %25s", p, lateststr, prefstr)
+            logger.plain("%-35s %25s %25s %25s", p, lateststr, preferred=
str, requiredstr)
=20
     def showEnvironment(self, buildfile=3DNone, pkgs_to_build=3DNone):
         """
diff --git a/bitbake/lib/bb/providers.py b/bitbake/lib/bb/providers.py
index 95152323ef..3ec11a40e1 100644
--- a/bitbake/lib/bb/providers.py
+++ b/bitbake/lib/bb/providers.py
@@ -38,15 +38,17 @@ def findProviders(cfgData, dataCache, pkg_pn =3D None=
):
     localdata =3D data.createCopy(cfgData)
     bb.data.expandKeys(localdata)
=20
+    required =3D {}
     preferred_versions =3D {}
     latest_versions =3D {}
=20
     for pn in pkg_pn:
-        (last_ver, last_file, pref_ver, pref_file) =3D findBestProvider(=
pn, localdata, dataCache, pkg_pn)
+        (last_ver, last_file, pref_ver, pref_file, req) =3D findBestProv=
ider(pn, localdata, dataCache, pkg_pn)
         preferred_versions[pn] =3D (pref_ver, pref_file)
         latest_versions[pn] =3D (last_ver, last_file)
+        required[pn] =3D req
=20
-    return (latest_versions, preferred_versions)
+    return (latest_versions, preferred_versions, required)
=20
 def allProviders(dataCache):
     """
@@ -221,16 +223,16 @@ def findBestProvider(pn, cfgData, dataCache, pkg_pn=
 =3D None, item =3D None):
     """
=20
     sortpkg_pn =3D sortPriorities(pn, dataCache, pkg_pn)
-    # Find the highest priority provider with a PREFERRED_VERSION set
-    (preferred_ver, preferred_file) =3D findPreferredProvider(pn, cfgDat=
a, dataCache, sortpkg_pn, item)
+    # Find the highest priority provider with a REQUIRED_VERSION or PREF=
ERRED_VERSION set
+    (preferred_ver, preferred_file, required) =3D findPreferredProvider(=
pn, cfgData, dataCache, sortpkg_pn, item)
     # Find the latest version of the highest priority provider
     (latest, latest_f) =3D findLatestProvider(pn, cfgData, dataCache, so=
rtpkg_pn[0])
=20
-    if preferred_file is None:
+    if not required and preferred_file is None:
         preferred_file =3D latest_f
         preferred_ver =3D latest
=20
-    return (latest, latest_f, preferred_ver, preferred_file)
+    return (latest, latest_f, preferred_ver, preferred_file, required)
=20
 def _filterProviders(providers, item, cfgData, dataCache):
     """
--=20
2.30.0

