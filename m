Received: from MTA-07-4.privateemail.com (MTA-07-4.privateemail.com [68.65.122.27])
 by mx.groups.io with SMTP id smtpd.web11.895.1613681645497796036
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Feb 2021 12:54:05 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: whitetree.xyz, ip: 68.65.122.27, mailfrom: charles.davies@whitetree.xyz)
Received: from MTA-07.privateemail.com (localhost [127.0.0.1])
	by MTA-07.privateemail.com (Postfix) with ESMTP id 26C0460052;
	Thu, 18 Feb 2021 15:54:05 -0500 (EST)
Received: from localhost.localdomain (unknown [10.20.151.232])
	by MTA-07.privateemail.com (Postfix) with ESMTPA id 1813E60054;
	Thu, 18 Feb 2021 20:54:03 +0000 (UTC)
From: "Charlie Davies" <charles.davies@whitetree.xyz>
To: bitbake-devel@lists.openembedded.org
Cc: Charlie Davies <charles.davies@whitetree.xyz>
Subject: [PATCH 9/9] multilib_global: handle REQUIRED_VERSION
Date: Thu, 18 Feb 2021 20:52:21 +0000
Message-Id: <20210218205221.55005-10-charles.davies@whitetree.xyz>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210218205221.55005-1-charles.davies@whitetree.xyz>
References: <20210218205221.55005-1-charles.davies@whitetree.xyz>
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Content-Transfer-Encoding: quoted-printable

Add logic to multilib_global.bbclass to handle new REQUIRED_VERSION
variable.

Fixes [YOCTO #10096]

Signed-off-by: Charlie Davies <charles.davies@whitetree.xyz>
---
 meta/classes/multilib_global.bbclass | 67 ++++++++++++++++------------
 1 file changed, 38 insertions(+), 29 deletions(-)

diff --git a/meta/classes/multilib_global.bbclass b/meta/classes/multilib=
_global.bbclass
index 98f65c8aae..96257de5ca 100644
--- a/meta/classes/multilib_global.bbclass
+++ b/meta/classes/multilib_global.bbclass
@@ -1,6 +1,7 @@
 def preferred_ml_updates(d):
-    # If any PREFERRED_PROVIDER or PREFERRED_VERSION are set,
-    # we need to mirror these variables in the multilib case;
+    # If any of PREFERRED_PROVIDER, PREFERRED_RPROVIDER, REQUIRED_VERSIO=
N
+    # or PREFERRED_VERSION are set, we need to mirror these variables in
+    # the multilib case;
     multilibs =3D d.getVar('MULTILIBS') or ""
     if not multilibs:
         return
@@ -11,43 +12,51 @@ def preferred_ml_updates(d):
         if len(eext) > 1 and eext[0] =3D=3D 'multilib':
             prefixes.append(eext[1])
=20
-    versions =3D []
+    required_versions =3D []
+    preferred_versions =3D []
     providers =3D []
     rproviders =3D []
     for v in d.keys():
+        if v.startswith("REQUIRED_VERSION_"):
+            required_versions.append(v)
         if v.startswith("PREFERRED_VERSION_"):
-            versions.append(v)
+            preferred_versions.append(v)
         if v.startswith("PREFERRED_PROVIDER_"):
             providers.append(v)
         if v.startswith("PREFERRED_RPROVIDER_"):
             rproviders.append(v)
=20
-    for v in versions:
-        val =3D d.getVar(v, False)
-        pkg =3D v.replace("PREFERRED_VERSION_", "")
-        if pkg.endswith("-native") or "-crosssdk-" in pkg or pkg.startsw=
ith(("nativesdk-", "virtual/nativesdk-")):
-            continue
-        if '-cross-' in pkg and '${' in pkg:
+    def sort_versions(versions, keyword):
+        version_str =3D "_".join([keyword, "VERSION", ""])
+        for v in versions:
+            val =3D d.getVar(v, False)
+            pkg =3D v.replace(version_str, "")
+            if pkg.endswith("-native") or "-crosssdk-" in pkg or pkg.sta=
rtswith(("nativesdk-", "virtual/nativesdk-")):
+                continue
+            if '-cross-' in pkg and '${' in pkg:
+                for p in prefixes:
+                    localdata =3D bb.data.createCopy(d)
+                    override =3D ":virtclass-multilib-" + p
+                    localdata.setVar("OVERRIDES", localdata.getVar("OVER=
RIDES", False) + override)
+                    if "-canadian-" in pkg:
+                        newname =3D localdata.expand(v)
+                    else:
+                        newname =3D localdata.expand(v).replace(version_=
str, version_str + p + '-')
+                    if newname !=3D v:
+                        newval =3D localdata.expand(val)
+                        d.setVar(newname, newval)
+                # Avoid future variable key expansion
+                vexp =3D d.expand(v)
+                if v !=3D vexp and d.getVar(v, False):
+                    d.renameVar(v, vexp)
+                continue
             for p in prefixes:
-                localdata =3D bb.data.createCopy(d)
-                override =3D ":virtclass-multilib-" + p
-                localdata.setVar("OVERRIDES", localdata.getVar("OVERRIDE=
S", False) + override)
-                if "-canadian-" in pkg:
-                    newname =3D localdata.expand(v)
-                else:
-                    newname =3D localdata.expand(v).replace("PREFERRED_V=
ERSION_", "PREFERRED_VERSION_" + p + '-')
-                if newname !=3D v:
-                    newval =3D localdata.expand(val)
-                    d.setVar(newname, newval)
-            # Avoid future variable key expansion
-            vexp =3D d.expand(v)
-            if v !=3D vexp and d.getVar(v, False):
-                d.renameVar(v, vexp)
-            continue
-        for p in prefixes:
-            newname =3D "PREFERRED_VERSION_" + p + "-" + pkg
-            if not d.getVar(newname, False):
-                d.setVar(newname, val)
+                newname =3D version_str + p + "-" + pkg
+                if not d.getVar(newname, False):
+                    d.setVar(newname, val)
+
+    sort_versions(required_versions, "REQUIRED")
+    sort_versions(preferred_versions, "PREFERRED")
=20
     for prov in providers:
         val =3D d.getVar(prov, False)
--=20
2.30.0

