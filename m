Return-Path: <john.ernberg@actia.se>
X-Greylist: delayed 308 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 08 Dec 2016 08:43:12 UTC
Received: from mail.actia.se (195-67-112-82.customer.telia.com [195.67.112.82])
	by mail.openembedded.org (Postfix) with ESMTP id 8C4FE606BF
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  8 Dec 2016 08:43:12 +0000 (UTC)
Received: from S005ANL.actianordic.se ([::1]) by S005ANL.actianordic.se
	([::1]) with mapi id 14.03.0319.002; Thu, 8 Dec 2016 09:38:04 +0100
From: John Ernberg <john.ernberg@actia.se>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [PATCH] fetch2: Copy out-of-tree files instead of symlinking
Thread-Index: AQHSUS5jLioRv49QjUaqdmS/l+nM9w==
Date: Thu, 8 Dec 2016 08:38:02 +0000
Message-ID: <1481186277-29924-1-git-send-email-john.ernberg@actia.se>
Accept-Language: en-US, sv-SE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.15.236]
x-esetresult: clean, is OK
x-esetid: 37303A29A4A04866637360
MIME-Version: 1.0
Subject: [PATCH] fetch2: Copy out-of-tree files instead of symlinking
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
X-List-Received-Date: Thu, 08 Dec 2016 08:43:14 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

From: Thomas Axelsson <thomas.axelsson@actia.se>

If not doing this, generating a file mirror using
BB_GENERATE_MIRROR_TARBALLS will not generate a complete mirror due to
out-of-tree symlinks, and patching files may fail, due to source file
permissions.
---
 lib/bb/fetch2/__init__.py | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index d6d7850..2ab0ba3 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -35,6 +35,7 @@
 import collections
 import subprocess
 import pickle
+import shutil
 import bb.persist_data, bb.utils
 import bb.checksum
 from bb import data
@@ -982,7 +983,18 @@ def try_mirror_url(fetch, origud, ud, ld, check =3D Fa=
lse):
                 # Broken symbolic link
                 os.unlink(origud.localpath)
=20
-            os.symlink(ud.localpath, origud.localpath)
+            # Copy out-of-tree files into the tree, so the local download =
dir will be complete
+            copyfile =3D True
+            bblayers =3D re.split(' +', ld.getVar("BBLAYERS", True).strip(=
))
+            for layerpath in bblayers:
+                if ud.localpath.startswith(layerpath):
+                    copyfile =3D False
+                    break
+
+            if copyfile:
+                shutil.copyfile(ud.localpath, origud.localpath)
+            else:
+                os.symlink(ud.localpath, origud.localpath)
         update_stamp(origud, ld)
         return ud.localpath
=20
--=20
1.9.1

