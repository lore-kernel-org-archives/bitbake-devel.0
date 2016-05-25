Return-Path: <prvs=946746f3a=Ulf.Magnusson@bmw.de>
X-Greylist: delayed 636 seconds by postgrey-1.34 at layers.openembedded.org;
	Wed, 25 May 2016 11:43:47 UTC
Received: from esa2.bmw.c3s2.iphmx.com (esa2.bmw.c3s2.iphmx.com
	[68.232.133.169])
	by mail.openembedded.org (Postfix) with ESMTP id 3ACA062135
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 May 2016 11:43:47 +0000 (UTC)
Received: from esagw1.bmwgroup.com (HELO esagw1.muc) ([160.46.252.34]) by
	esa2.bmw.c3s2.iphmx.com with ESMTP/TLS; 25 May 2016 13:33:06 +0200
Received: from unknown (HELO esabb3.muc) ([160.50.100.30]) by esagw1.muc with
	ESMTP/TLS; 25 May 2016 13:33:04 +0200
Received: from smuch53a.muc (HELO SMUCH53A.europe.bmw.corp) ([160.46.137.113])
	by esabb3.muc with ESMTP/TLS; 25 May 2016 13:32:57 +0200
Received: from SMUCM59B.europe.bmw.corp ([160.46.136.59]) by
	SMUCH53A.europe.bmw.corp ([160.46.137.113]) with mapi id 14.03.0279.002;
	Wed, 25 May 2016 13:32:57 +0200
From: <Ulf.Magnusson@bmw.de>
To: <bitbake-devel@lists.openembedded.org>
Thread-Topic: [PATCH] bitbake: fetch2/svn: Fix SVN repository concurrent
	update race
Thread-Index: AdG2eS8sZb9c8iY5To22Ot6K0H5Y+A==
Date: Wed, 25 May 2016 11:32:56 +0000
Message-ID: <91CC97698835684980CD15EFCBE86BDC26CD32E0@smucm59b>
Accept-Language: en-US, de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [160.48.96.19]
MIME-Version: 1.0
Subject: [PATCH] bitbake: fetch2/svn: Fix SVN repository concurrent update race
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
X-List-Received-Date: Wed, 25 May 2016 11:43:49 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The ${DL_DIR}/svn directory is used by BitBake to keep checked-out SVN=0A=
repositories from which tarballs are generated. These repositories were=0A=
protected from concurrent update with a lock on the tarballs. However,=0A=
the tarballs are specific to the SRCREV and module checked out (many=0A=
tarballs can come from the same repository), meaning a repository could=0A=
be modified concurrently if two recipes checked out two different=0A=
SRCREVs or modules from it in parallel.=0A=
=0A=
This caused errors like the following:=0A=
=0A=
ERROR: Fetcher failure: Fetch command failed with exit code 1, output:=0A=
svn: E155004: Run 'svn cleanup' to remove locks (type 'svn help cleanup' fo=
r details)=0A=
svn: E155004: Working copy '/home/foo/downloads/svn/repo/trunk' locked.=0A=
svn: E155004: '/home/foo/downloads/svn/repo/trunk' is already locked.=0A=
=0A=
Fix it by adding a per-repository lock that's independent of the module=0A=
and SRCREV.=0A=
---=0A=
 bitbake/lib/bb/fetch2/svn.py | 69 +++++++++++++++++++++++++---------------=
----=0A=
 1 file changed, 39 insertions(+), 30 deletions(-)=0A=
=0A=
diff --git a/bitbake/lib/bb/fetch2/svn.py b/bitbake/lib/bb/fetch2/svn.py=0A=
index 8a29193..f83b740 100644=0A=
--- a/bitbake/lib/bb/fetch2/svn.py=0A=
+++ b/bitbake/lib/bb/fetch2/svn.py=0A=
@@ -63,6 +63,9 @@ class Svn(FetchMethod):=0A=
         relpath =3D self._strip_leading_slashes(ud.path)=0A=
         ud.pkgdir =3D os.path.join(data.expand('${SVNDIR}', d), ud.host, r=
elpath)=0A=
         ud.moddir =3D os.path.join(ud.pkgdir, ud.module)=0A=
+        # Protects the repository from concurrent updates, e.g. from two=
=0A=
+        # recipes fetching different revisions at the same time=0A=
+        ud.svnlock =3D os.path.join(ud.pkgdir, "svn.lock")=0A=
 =0A=
         ud.setup_revisons(d)=0A=
 =0A=
@@ -123,38 +126,44 @@ class Svn(FetchMethod):=0A=
 =0A=
         logger.debug(2, "Fetch: checking for module directory '" + ud.modd=
ir + "'")=0A=
 =0A=
-        if os.access(os.path.join(ud.moddir, '.svn'), os.R_OK):=0A=
-            svnupdatecmd =3D self._buildsvncommand(ud, d, "update")=0A=
-            logger.info("Update " + ud.url)=0A=
-            # update sources there=0A=
-            os.chdir(ud.moddir)=0A=
-            # We need to attempt to run svn upgrade first in case its an o=
lder working format=0A=
-            try:=0A=
-                runfetchcmd(ud.basecmd + " upgrade", d)=0A=
-            except FetchError:=0A=
-                pass=0A=
-            logger.debug(1, "Running %s", svnupdatecmd)=0A=
-            bb.fetch2.check_network_access(d, svnupdatecmd, ud.url)=0A=
-            runfetchcmd(svnupdatecmd, d)=0A=
-        else:=0A=
-            svnfetchcmd =3D self._buildsvncommand(ud, d, "fetch")=0A=
-            logger.info("Fetch " + ud.url)=0A=
-            # check out sources there=0A=
-            bb.utils.mkdirhier(ud.pkgdir)=0A=
-            os.chdir(ud.pkgdir)=0A=
-            logger.debug(1, "Running %s", svnfetchcmd)=0A=
-            bb.fetch2.check_network_access(d, svnfetchcmd, ud.url)=0A=
-            runfetchcmd(svnfetchcmd, d)=0A=
+        lf =3D bb.utils.lockfile(ud.svnlock)=0A=
+=0A=
+        try:=0A=
+            if os.access(os.path.join(ud.moddir, '.svn'), os.R_OK):=0A=
+                svnupdatecmd =3D self._buildsvncommand(ud, d, "update")=0A=
+                logger.info("Update " + ud.url)=0A=
+                # update sources there=0A=
+                os.chdir(ud.moddir)=0A=
+                # We need to attempt to run svn upgrade first in case its =
an older working format=0A=
+                try:=0A=
+                    runfetchcmd(ud.basecmd + " upgrade", d)=0A=
+                except FetchError:=0A=
+                    pass=0A=
+                logger.debug(1, "Running %s", svnupdatecmd)=0A=
+                bb.fetch2.check_network_access(d, svnupdatecmd, ud.url)=0A=
+                runfetchcmd(svnupdatecmd, d)=0A=
+            else:=0A=
+                svnfetchcmd =3D self._buildsvncommand(ud, d, "fetch")=0A=
+                logger.info("Fetch " + ud.url)=0A=
+                # check out sources there=0A=
+                bb.utils.mkdirhier(ud.pkgdir)=0A=
+                os.chdir(ud.pkgdir)=0A=
+                logger.debug(1, "Running %s", svnfetchcmd)=0A=
+                bb.fetch2.check_network_access(d, svnfetchcmd, ud.url)=0A=
+                runfetchcmd(svnfetchcmd, d)=0A=
+=0A=
+            scmdata =3D ud.parm.get("scmdata", "")=0A=
+            if scmdata =3D=3D "keep":=0A=
+                tar_flags =3D ""=0A=
+            else:=0A=
+                tar_flags =3D "--exclude '.svn'"=0A=
 =0A=
-        scmdata =3D ud.parm.get("scmdata", "")=0A=
-        if scmdata =3D=3D "keep":=0A=
-            tar_flags =3D ""=0A=
-        else:=0A=
-            tar_flags =3D "--exclude '.svn'"=0A=
+            os.chdir(ud.pkgdir)=0A=
+            # tar them up to a defined filename=0A=
+            runfetchcmd("tar %s -czf %s %s" % (tar_flags, ud.localpath, ud=
.path_spec), d, cleanup =3D [ud.localpath])=0A=
 =0A=
-        os.chdir(ud.pkgdir)=0A=
-        # tar them up to a defined filename=0A=
-        runfetchcmd("tar %s -czf %s %s" % (tar_flags, ud.localpath, ud.pat=
h_spec), d, cleanup =3D [ud.localpath])=0A=
+        finally:=0A=
+            bb.utils.unlockfile(lf)=0A=
 =0A=
     def clean(self, ud, d):=0A=
         """ Clean SVN specific files and dirs """=0A=
-- =0A=
2.7.4=0A=

