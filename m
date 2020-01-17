Return-Path: <jean-marie.lemetayer@savoirfairelinux.com>
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
	[208.88.110.44])
	by mail.openembedded.org (Postfix) with ESMTP id 9F6977FA27
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Jan 2020 16:52:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id F05AB9C0445;
	Fri, 17 Jan 2020 11:45:58 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id 7h2Y6fp3A5JQ; Fri, 17 Jan 2020 11:45:57 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id DBF829C0423;
	Fri, 17 Jan 2020 11:45:57 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id RZB5DkvaZPs5; Fri, 17 Jan 2020 11:45:57 -0500 (EST)
Received: from sulaco.example.com (40.73.12.109.rev.sfr.net [109.12.73.40])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 08EB89C0427;
	Fri, 17 Jan 2020 11:45:56 -0500 (EST)
From: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 17 Jan 2020 17:45:39 +0100
Message-Id: <20200117164548.28453-4-jean-marie.lemetayer@savoirfairelinux.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200117164548.28453-1-jean-marie.lemetayer@savoirfairelinux.com>
References: <20200117164548.28453-1-jean-marie.lemetayer@savoirfairelinux.com>
MIME-Version: 1.0
Cc: rennes-dev@savoirfairelinux.com, paul.eggleton@linux.intel.com
Subject: [PATCH v4 03/12] bitbake: fetch2: refactor checksum verification
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

This commit refactors the way checksums are verified to be more generic.

The support of new hash functions is now limited to the update of the
CHECKSUM_LIST variable.

Signed-off-by: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinu=
x.com>
---
 lib/bb/fetch2/__init__.py | 157 +++++++++++++++++++++-----------------
 1 file changed, 85 insertions(+), 72 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 731c1608..b4122aee 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -33,6 +33,8 @@ _checksum_cache =3D bb.checksum.FileChecksumCache()
=20
 logger =3D logging.getLogger("BitBake.Fetcher")
=20
+CHECKSUM_LIST =3D [ "md5", "sha256" ]
+
 class BBFetchException(Exception):
     """Class all fetch exceptions inherit from"""
     def __init__(self, message):
@@ -131,10 +133,9 @@ class NonLocalMethod(Exception):
         Exception.__init__(self)
=20
 class MissingChecksumEvent(bb.event.Event):
-    def __init__(self, url, md5sum, sha256sum):
+    def __init__(self, url, **checksums):
         self.url =3D url
-        self.checksums =3D {'md5sum': md5sum,
-                          'sha256sum': sha256sum}
+        self.checksums =3D checksums
         bb.event.Event.__init__(self)
=20
=20
@@ -552,71 +553,81 @@ def verify_checksum(ud, d, precomputed=3D{}):
     downloading. See https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D=
5571.
     """
=20
-    _MD5_KEY =3D "md5"
-    _SHA256_KEY =3D "sha256"
-
     if ud.ignore_checksums or not ud.method.supports_checksum(ud):
         return {}
=20
-    if _MD5_KEY in precomputed:
-        md5data =3D precomputed[_MD5_KEY]
-    else:
-        md5data =3D bb.utils.md5_file(ud.localpath)
+    def compute_checksum_info(checksum_id):
+        checksum_name =3D getattr(ud, "%s_name" % checksum_id)
=20
-    if _SHA256_KEY in precomputed:
-        sha256data =3D precomputed[_SHA256_KEY]
-    else:
-        sha256data =3D bb.utils.sha256_file(ud.localpath)
+        if checksum_id in precomputed:
+            checksum_data =3D precomputed[checksum_id]
+        else:
+            checksum_data =3D getattr(bb.utils, "%s_file" % checksum_id)=
(ud.localpath)
=20
-    if ud.method.recommends_checksum(ud) and not ud.md5_expected and not=
 ud.sha256_expected:
-        # If strict checking enabled and neither sum defined, raise erro=
r
-        strict =3D d.getVar("BB_STRICT_CHECKSUM") or "0"
-        if strict =3D=3D "1":
-            logger.error('No checksum specified for %s, please add at le=
ast one to the recipe:\n'
-                             'SRC_URI[%s] =3D "%s"\nSRC_URI[%s] =3D "%s"=
' %
-                             (ud.localpath, ud.md5_name, md5data,
-                              ud.sha256_name, sha256data))
-            raise NoChecksumError('Missing SRC_URI checksum', ud.url)
+        checksum_expected =3D getattr(ud, "%s_expected" % checksum_id)
=20
-        bb.event.fire(MissingChecksumEvent(ud.url, md5data, sha256data),=
 d)
+        return {
+            "id": checksum_id,
+            "name": checksum_name,
+            "data": checksum_data,
+            "expected": checksum_expected
+        }
=20
-        if strict =3D=3D "ignore":
-            return {
-                _MD5_KEY: md5data,
-                _SHA256_KEY: sha256data
-            }
+    checksum_infos =3D []
+    for checksum_id in CHECKSUM_LIST:
+        checksum_infos.append(compute_checksum_info(checksum_id))
=20
-        # Log missing sums so user can more easily add them
-        logger.warning('Missing md5 SRC_URI checksum for %s, consider ad=
ding to the recipe:\n'
-                       'SRC_URI[%s] =3D "%s"',
-                       ud.localpath, ud.md5_name, md5data)
-        logger.warning('Missing sha256 SRC_URI checksum for %s, consider=
 adding to the recipe:\n'
-                       'SRC_URI[%s] =3D "%s"',
-                       ud.localpath, ud.sha256_name, sha256data)
+    checksum_dict =3D {ci["id"] : ci["data"] for ci in checksum_infos}
=20
-    # We want to alert the user if a checksum is defined in the recipe b=
ut
-    # it does not match.
-    msg =3D ""
-    mismatch =3D False
-    if ud.md5_expected and ud.md5_expected !=3D md5data:
-        msg =3D msg + "\nFile: '%s' has %s checksum %s when %s was expec=
ted" % (ud.localpath, 'md5', md5data, ud.md5_expected)
-        mismatch =3D True;
+    checksum_lines =3D ["SRC_URI[%s] =3D \"%s\"" % (ci["name"], ci["data=
"]) for ci in checksum_infos]
=20
-    if ud.sha256_expected and ud.sha256_expected !=3D sha256data:
-        msg =3D msg + "\nFile: '%s' has %s checksum %s when %s was expec=
ted" % (ud.localpath, 'sha256', sha256data, ud.sha256_expected)
-        mismatch =3D True;
+    # If no checksum has been provided
+    if ud.method.recommends_checksum(ud) and all(ci["expected"] is None =
for ci in checksum_infos):
+        strict =3D d.getVar("BB_STRICT_CHECKSUM") or "0"
=20
-    if mismatch:
-        msg =3D msg + '\nIf this change is expected (e.g. you have upgra=
ded to a new version without updating the checksums) then you can use the=
se lines within the recipe:\nSRC_URI[%s] =3D "%s"\nSRC_URI[%s] =3D "%s"\n=
Otherwise you should retry the download and/or check with upstream to det=
ermine if the file has become corrupted or otherwise unexpectedly modifie=
d.\n' % (ud.md5_name, md5data, ud.sha256_name, sha256data)
+        # If strict checking enabled and neither sum defined, raise erro=
r
+        if strict =3D=3D "1":
+            messages =3D []
+            messages.append("No checksum specified for '%s', please add =
at " \
+                            "least one to the recipe:" % ud.localpath)
+            messages.extend(checksum_lines)
+            logger.error("\n".join(messages))
+            raise NoChecksumError("Missing SRC_URI checksum", ud.url)
=20
-    if len(msg):
-        raise ChecksumError('Checksum mismatch!%s' % msg, ud.url, md5dat=
a)
+        if strict =3D=3D "ignore":
+            return checksum_dict
=20
-    return {
-        _MD5_KEY: md5data,
-        _SHA256_KEY: sha256data
-    }
+        # Log missing sums so user can more easily add them
+        else:
+            messages =3D []
+            messages.append("Missing checksum for '%s', consider adding =
at " \
+                            "least one to the recipe:" % ud.localpath)
+            messages.extend(checksum_lines)
+            logger.warning("\n".join(messages))
=20
+    # We want to alert the user if a checksum is defined in the recipe b=
ut
+    # it does not match.
+    messages =3D []
+    messages.append("Checksum mismatch!")
+    bad_checksum =3D None
+
+    for ci in checksum_infos:
+        if ci["expected"] and ci["expected"] !=3D ci["data"]:
+            messages.append("File: '%s' has %s checksum %s when %s was "=
 \
+                            "expected" % (ud.localpath, ci["id"], ci["da=
ta"], ci["expected"]))
+            bad_checksum =3D ci["data"]
+
+    if bad_checksum:
+        messages.append("If this change is expected (e.g. you have upgra=
ded " \
+                        "to a new version without updating the checksums=
) " \
+                        "then you can use these lines within the recipe:=
")
+        messages.extend(checksum_lines)
+        messages.append("Otherwise you should retry the download and/or =
" \
+                        "check with upstream to determine if the file ha=
s " \
+                        "become corrupted or otherwise unexpectedly modi=
fied.")
+        raise ChecksumError("\n".join(messages), ud.url, bad_checksum)
+
+    return checksum_dict
=20
 def verify_donestamp(ud, d, origud=3DNone):
     """
@@ -1230,24 +1241,26 @@ class FetchData(object):
             self.pswd =3D self.parm["pswd"]
         self.setup =3D False
=20
-        if "name" in self.parm:
-            self.md5_name =3D "%s.md5sum" % self.parm["name"]
-            self.sha256_name =3D "%s.sha256sum" % self.parm["name"]
-        else:
-            self.md5_name =3D "md5sum"
-            self.sha256_name =3D "sha256sum"
-        if self.md5_name in self.parm:
-            self.md5_expected =3D self.parm[self.md5_name]
-        elif self.type not in ["http", "https", "ftp", "ftps", "sftp", "=
s3"]:
-            self.md5_expected =3D None
-        else:
-            self.md5_expected =3D d.getVarFlag("SRC_URI", self.md5_name)
-        if self.sha256_name in self.parm:
-            self.sha256_expected =3D self.parm[self.sha256_name]
-        elif self.type not in ["http", "https", "ftp", "ftps", "sftp", "=
s3"]:
-            self.sha256_expected =3D None
-        else:
-            self.sha256_expected =3D d.getVarFlag("SRC_URI", self.sha256=
_name)
+        def configure_checksum(checksum_id):
+            if "name" in self.parm:
+                checksum_name =3D "%s.%ssum" % (self.parm["name"], check=
sum_id)
+            else:
+                checksum_name =3D "%ssum" % checksum_id
+
+            setattr(self, "%s_name" % checksum_id, checksum_name)
+
+            if checksum_name in self.parm:
+                checksum_expected =3D self.parm[checksum_name]
+            elif self.type not in ["http", "https", "ftp", "ftps", "sftp=
", "s3"]:
+                checksum_expected =3D None
+            else:
+                checksum_expected =3D d.getVarFlag("SRC_URI", checksum_n=
ame)
+
+            setattr(self, "%s_expected" % checksum_id, checksum_expected=
)
+
+        for checksum_id in CHECKSUM_LIST:
+            configure_checksum(checksum_id)
+
         self.ignore_checksums =3D False
=20
         self.names =3D self.parm.get("name",'default').split(',')
--=20
2.20.1


