Return-Path: <AMardegan@luxoft.com>
X-Greylist: delayed 320 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 21 Sep 2017 14:39:13 UTC
Received: from ORO-EDGE-03.luxoft.com (oro-edge-03.luxoft.com [109.166.244.23])
	by mail.openembedded.org (Postfix) with ESMTP id D747E781F6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Sep 2017 14:39:13 +0000 (UTC)
Received: from ORO-HYBRID-01.luxoft.com (172.30.115.193) by
	oro-edge-03.luxoft.com (172.30.19.23) with Microsoft SMTP Server (TLS)
	id 14.3.319.2; Thu, 21 Sep 2017 17:33:52 +0300
Received: from ORO-MBOX-01.luxoft.com ([fe80::387f:bf07:869c:b95e]) by
	oro-hybrid-01.luxoft.com ([fe80::94b2:3f2:b715:23bd%11]) with mapi id
	14.03.0319.002; Thu, 21 Sep 2017 17:33:53 +0300
From: "Mardegan, Alberto" <AMardegan@luxoft.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [PATCH] bitbake: lib/bb/utils: fix movefile() copy to dir
	fallback
Thread-Index: AQHTMualWqbw1hN1wkO98MPWNpNRdw==
Date: Thu, 21 Sep 2017 14:33:52 +0000
Message-ID: <1506004425-11151-1-git-send-email-amardegan@luxoft.com>
Accept-Language: it-IT, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.31.240.120]
MIME-Version: 1.0
Subject: [PATCH] bitbake: lib/bb/utils: fix movefile() copy to dir fallback
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
X-List-Received-Date: Thu, 21 Sep 2017 14:39:14 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

When the destination is a directory, building the the destination file
path is always needed.  That's because even if the copy fallback is
taken, it's always followed by a rename.

Signed-off-by: Alberto Mardegan <amardegan@luxoft.com>
---
 bitbake/lib/bb/utils.py | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index 8550af3..c540b49 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -771,13 +771,14 @@ def movefile(src, dest, newmtime =3D None, sstat =3D =
None):
             return None

     renamefailed =3D 1
+    # os.rename needs to know the dest path ending with file name
+    # so append the file name to a path only if it's a dir specified
+    srcfname =3D os.path.basename(src)
+    destpath =3D os.path.join(dest, srcfname) if os.path.isdir(dest) \
+                else dest
+
     if sstat[stat.ST_DEV] =3D=3D dstat[stat.ST_DEV]:
         try:
-            # os.rename needs to know the dest path ending with file name
-            # so append the file name to a path only if it's a dir specifi=
ed
-            srcfname =3D os.path.basename(src)
-            destpath =3D os.path.join(dest, srcfname) if os.path.isdir(des=
t) \
-                        else dest
             os.rename(src, destpath)
             renamefailed =3D 0
         except Exception as e:
@@ -791,8 +792,8 @@ def movefile(src, dest, newmtime =3D None, sstat =3D No=
ne):
         didcopy =3D 0
         if stat.S_ISREG(sstat[stat.ST_MODE]):
             try: # For safety copy then move it over.
-                shutil.copyfile(src, dest + "#new")
-                os.rename(dest + "#new", dest)
+                shutil.copyfile(src, destpath + "#new")
+                os.rename(destpath + "#new", destpath)
                 didcopy =3D 1
             except Exception as e:
                 print('movefile: copy', src, '->', dest, 'failed.', e)
@@ -813,9 +814,9 @@ def movefile(src, dest, newmtime =3D None, sstat =3D No=
ne):
             return None

     if newmtime:
-        os.utime(dest, (newmtime, newmtime))
+        os.utime(destpath, (newmtime, newmtime))
     else:
-        os.utime(dest, (sstat[stat.ST_ATIME], sstat[stat.ST_MTIME]))
+        os.utime(destpath, (sstat[stat.ST_ATIME], sstat[stat.ST_MTIME]))
         newmtime =3D sstat[stat.ST_MTIME]
     return newmtime

--
2.7.4

________________________________

This e-mail and any attachment(s) are intended only for the recipient(s) na=
med above and others who have been specifically authorized to receive them.=
 They may contain confidential information. If you are not the intended rec=
ipient, please do not read this email or its attachment(s). Furthermore, yo=
u are hereby notified that any dissemination, distribution or copying of th=
is e-mail and any attachment(s) is strictly prohibited. If you have receive=
d this e-mail in error, please immediately notify the sender by replying to=
 this e-mail and then delete this e-mail and any attachment(s) or copies th=
ereof from your system. Thank you.

