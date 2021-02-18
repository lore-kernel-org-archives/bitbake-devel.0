Received: from MTA-07-4.privateemail.com (MTA-07-4.privateemail.com [68.65.122.27])
 by mx.groups.io with SMTP id smtpd.web12.914.1613681639146018463
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Feb 2021 12:53:59 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: whitetree.xyz, ip: 68.65.122.27, mailfrom: charles.davies@whitetree.xyz)
Received: from MTA-07.privateemail.com (localhost [127.0.0.1])
	by MTA-07.privateemail.com (Postfix) with ESMTP id C4EF960054;
	Thu, 18 Feb 2021 15:53:58 -0500 (EST)
Received: from localhost.localdomain (unknown [10.20.151.232])
	by MTA-07.privateemail.com (Postfix) with ESMTPA id 9D01860052;
	Thu, 18 Feb 2021 20:53:57 +0000 (UTC)
From: "Charlie Davies" <charles.davies@whitetree.xyz>
To: bitbake-devel@lists.openembedded.org
Cc: Charlie Davies <charles.davies@whitetree.xyz>
Subject: [PATCH 5/9] bitbake: providers: introduce logic for REQUIRED_VERSION variable
Date: Thu, 18 Feb 2021 20:52:17 +0000
Message-Id: <20210218205221.55005-6-charles.davies@whitetree.xyz>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210218205221.55005-1-charles.davies@whitetree.xyz>
References: <20210218205221.55005-1-charles.davies@whitetree.xyz>
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Content-Transfer-Encoding: quoted-printable

This commit adds checks during the findPreferredProvider function for a
new variable REQUIRED_VERSION. This can be set, in exactly the same
manner as PREFERRED_VERSION, on a per package basis to enforce the use
of a particular version of a package.

REQUIRED_VERSION is similar in behaviour to PREFERRED_VERSION except if
the version specified by REQUIRED_VERSION is not found an error occurs
and the execution of Bitbake stops.

Fixes [YOCTO #10096]

Signed-off-by: Charlie Davies <charles.davies@whitetree.xyz>
---
 bitbake/lib/bb/providers.py | 56 +++++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 15 deletions(-)

diff --git a/bitbake/lib/bb/providers.py b/bitbake/lib/bb/providers.py
index e8241d90c0..09e5701f2e 100644
--- a/bitbake/lib/bb/providers.py
+++ b/bitbake/lib/bb/providers.py
@@ -85,6 +85,21 @@ def sortPriorities(pn, dataCache, pkg_pn =3D None):
=20
     return tmp_pn
=20
+def versionVariableMatch(cfgData, keyword, pn):
+    """
+    Return the value of the <keyword>_VERSION variable if set.
+    """
+
+    # pn can contain '_', e.g. gcc-cross-x86_64 and an override cannot
+    # hence we do this manually rather than use OVERRIDES
+    ver =3D cfgData.getVar("%s_VERSION_pn-%s" % (keyword, pn))
+    if not ver:
+        ver =3D cfgData.getVar("%s_VERSION_%s" % (keyword, pn))
+    if not ver:
+        ver =3D cfgData.getVar("%s_VERSION" % keyword)
+
+    return ver
+
 def preferredVersionMatch(pe, pv, pr, preferred_e, preferred_v, preferre=
d_r):
     """
     Check if the version pe,pv,pr is the preferred one.
@@ -100,19 +115,28 @@ def preferredVersionMatch(pe, pv, pr, preferred_e, =
preferred_v, preferred_r):
=20
 def findPreferredProvider(pn, cfgData, dataCache, pkg_pn =3D None, item =
=3D None):
     """
-    Find the first provider in pkg_pn with a PREFERRED_VERSION set.
+    Find the first provider in pkg_pn with REQUIRED_VERSION or PREFERRED=
_VERSION set.
     """
=20
     preferred_file =3D None
     preferred_ver =3D None
+    required =3D False
=20
-    # pn can contain '_', e.g. gcc-cross-x86_64 and an override cannot
-    # hence we do this manually rather than use OVERRIDES
-    preferred_v =3D cfgData.getVar("PREFERRED_VERSION_pn-%s" % pn)
-    if not preferred_v:
-        preferred_v =3D cfgData.getVar("PREFERRED_VERSION_%s" % pn)
-    if not preferred_v:
-        preferred_v =3D cfgData.getVar("PREFERRED_VERSION")
+    required_v =3D versionVariableMatch(cfgData, "REQUIRED", pn)
+    preferred_v =3D versionVariableMatch(cfgData, "PREFERRED", pn)
+
+    itemstr =3D ""
+    if item:
+        itemstr =3D " (for item %s)" % item
+
+    if required_v is not None:
+        if preferred_v is not None:
+            logger.warn("REQUIRED_VERSION and PREFERRED_VERSION for pack=
age %s%s are both set using REQUIRED_VERSION %s", pn, itemstr, required_v=
)
+        else:
+            logger.debug("REQUIRED_VERSION is set for package %s%s", pn,=
 itemstr)
+        # REQUIRED_VERSION always takes precedence over PREFERRED_VERSIO=
N
+        preferred_v =3D required_v
+        required =3D True
=20
     if preferred_v:
         m =3D re.match(r'(\d+:)*(.*)(_.*)*', preferred_v)
@@ -145,11 +169,9 @@ def findPreferredProvider(pn, cfgData, dataCache, pk=
g_pn =3D None, item =3D None):
             pv_str =3D preferred_v
         if not (preferred_e is None):
             pv_str =3D '%s:%s' % (preferred_e, pv_str)
-        itemstr =3D ""
-        if item:
-            itemstr =3D " (for item %s)" % item
         if preferred_file is None:
-            logger.warn("preferred version %s of %s not available%s", pv=
_str, pn, itemstr)
+            if not required:
+                logger.warn("preferred version %s of %s not available%s"=
, pv_str, pn, itemstr)
             available_vers =3D []
             for file_set in pkg_pn:
                 for f in file_set:
@@ -162,11 +184,15 @@ def findPreferredProvider(pn, cfgData, dataCache, p=
kg_pn =3D None, item =3D None):
             if available_vers:
                 available_vers.sort()
                 logger.warn("versions of %s available: %s", pn, ' '.join=
(available_vers))
+            if required:
+                logger.error("required version %s of %s not available%s"=
, pv_str, pn, itemstr)
         else:
-            logger.debug("selecting %s as PREFERRED_VERSION %s of packag=
e %s%s", preferred_file, pv_str, pn, itemstr)
-
-    return (preferred_ver, preferred_file)
+            if required:
+                logger.debug("selecting %s as REQUIRED_VERSION %s of pac=
kage %s%s", preferred_file, pv_str, pn, itemstr)
+            else:
+                logger.debug("selecting %s as PREFERRED_VERSION %s of pa=
ckage %s%s", preferred_file, pv_str, pn, itemstr)
=20
+    return (preferred_ver, preferred_file, required)
=20
 def findLatestProvider(pn, cfgData, dataCache, file_set):
     """
--=20
2.30.0

