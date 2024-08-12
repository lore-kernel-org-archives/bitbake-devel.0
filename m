Return-Path: <enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC94C52D7F
	for <webhook@archiver.kernel.org>; Mon, 12 Aug 2024 12:28:44 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.44986.1723465722401830421
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Aug 2024 05:28:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=NyR7vIaY;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: enguerrand.de-ribaucourt@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id B3AEF9C5E53;
	Mon, 12 Aug 2024 08:28:41 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 8WOPUz9Cyuli; Mon, 12 Aug 2024 08:28:41 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id E602F9C5FE4;
	Mon, 12 Aug 2024 08:28:40 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com E602F9C5FE4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1723465720; bh=7wEomm+AxXaSg/Du+ZTXIrZokRdsAL98CZxQNSAOW/8=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=NyR7vIaYk/tzBuoQK237vc8pxlIWP/HidJW/PNQvSt1GIHybVJ7/AsU2KdfSOfmnu
	 P82QfRXgpkeX7fwKapTQZRyE14TjYcLzWJOmwM+6kNZdpN5aFsgNmLl1W5s+Ao/HZP
	 sK8MTcHPF7wiNPh5NO45BIq3B/NlhA57PozJIIJ4SSP6UbozcXimF/DE9wgq3DNipp
	 X3dvJ+k1NRc5NinxnS9LZiNPkUYjj9Wb+TH4Dib4FexCiydNee8K8V98MhXvuf6MJB
	 0N17Z9wFKovwPsig3Wzi0cfqXBe2K+3BsiuCTorQ6Zp+BNWkENLsPBqtDxkb7WVhvz
	 Mm8H/tYD0vutA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id BcHHy4cuhOm3; Mon, 12 Aug 2024 08:28:40 -0400 (EDT)
Received: from sfl-deribaucourt.rennes.sfl (80-15-101-118.ftth.fr.orangecustomers.net [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id F3E999C5E53;
	Mon, 12 Aug 2024 08:28:39 -0400 (EDT)
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: tanguy.raufflet@savoirfairelinux.com,
	richard.purdie@linuxfoundation.org,
	alexandre.belloni@bootlin.com,
	stefan.herbrechtsmeier@weidmueller.com,
	Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Subject: [OE-core][PATCH v4 4/4] recipetool: create_npm: reuse license utils
Date: Mon, 12 Aug 2024 14:28:29 +0200
Message-Id: <20240812122829.577515-5-enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240812122829.577515-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
References: <20240812122829.577515-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 12 Aug 2024 12:28:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16470

create_npm.py duplicated the logic for matching licenses from files and
also finding them. This patch refactors the code to reuse the license
utils. This will make the code more maintainable and also align both
behaviors. For instance, some licenses weren't matched properly because
the duplicate logic did not support the difference in format in the md5
tables for COMMON_LICENSE_DIR and licenses.csv.

This is also faster since the license files were being read twice.
The result is slightly more accurate since the utils have better
implementations, and I was able to reuse the logic for the root PN
package, as well as the base LICENSE variable.

I chose to extract generate_common_licenses_chksums into create.py
since it can be considered a general utility function to allow
other recipetool creators to refer to COMMON_LICENSE_DIR files.

I updated the wording in the code when appropriate.

v3:
 - added commit
 - this replaces the commit that added all the COMMON_LICENSE_DIR md5
   to licenses.csv

Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirf=
airelinux.com>
---
 scripts/lib/recipetool/create.py     |  8 +++
 scripts/lib/recipetool/create_npm.py | 92 +++++++++-------------------
 2 files changed, 36 insertions(+), 64 deletions(-)

diff --git a/scripts/lib/recipetool/create.py b/scripts/lib/recipetool/cr=
eate.py
index c626844370..ea2ef5be63 100644
--- a/scripts/lib/recipetool/create.py
+++ b/scripts/lib/recipetool/create.py
@@ -1295,6 +1295,14 @@ def split_pkg_licenses(licvalues, packages, outlin=
es, fallback_licenses=3DNone, pn
         outlicenses[pkgname] =3D licenses
     return outlicenses
=20
+def generate_common_licenses_chksums(common_licenses, d):
+    lic_files_chksums =3D []
+    for license in tidy_licenses(common_licenses):
+        licfile =3D '${COMMON_LICENSE_DIR}/' + license
+        md5value =3D bb.utils.md5_file(d.expand(licfile))
+        lic_files_chksums.append('file://%s;md5=3D%s' % (licfile, md5val=
ue))
+    return lic_files_chksums
+
 def read_pkgconfig_provides(d):
     pkgdatadir =3D d.getVar('PKGDATA_DIR')
     pkgmap =3D {}
diff --git a/scripts/lib/recipetool/create_npm.py b/scripts/lib/recipetoo=
l/create_npm.py
index 78dc248f31..3363a0e7ee 100644
--- a/scripts/lib/recipetool/create_npm.py
+++ b/scripts/lib/recipetool/create_npm.py
@@ -16,8 +16,7 @@ from bb.fetch2.npm import NpmEnvironment
 from bb.fetch2.npm import npm_package
 from bb.fetch2.npmsw import foreach_dependencies
 from recipetool.create import RecipeHandler
-from recipetool.create import get_license_md5sums
-from recipetool.create import find_licenses
+from recipetool.create import match_licenses, find_license_files, genera=
te_common_licenses_chksums
 from recipetool.create import split_pkg_licenses
 logger =3D logging.getLogger('recipetool')
=20
@@ -112,51 +111,53 @@ class NpmRecipeHandler(RecipeHandler):
         """Return the extra license files and the list of packages"""
         licfiles =3D []
         packages =3D {}
-        # Licenses from package.json point to COMMON_LICENSE_DIR so we n=
eed
-        # to associate them explicitely for split_pkg_licenses()
+        # Licenses from package.json will point to COMMON_LICENSE_DIR so=
 we need
+        # to associate them explicitely to packages for split_pkg_licens=
es()
         fallback_licenses =3D dict()
=20
-        # Handle the parent package
-        packages["${PN}"] =3D ""
-
-        def _licfiles_append_fallback_package_files(destdir):
-            """Append package.json files as fallback to license files if=
 a license files is missing"""
+        def _find_package_licenses(destdir):
+            """Either find license files, or use package.json metadata""=
"
             def _get_licenses_from_package_json(package_json):
                 with open(os.path.join(srctree, package_json), "r") as f=
:
                     data =3D json.load(f)
                     if "license" in data:
                         licenses =3D data["license"].split(" ")
                         licenses =3D [license.strip("()") for license in=
 licenses if license !=3D "OR" and license !=3D "AND"]
-                        return ["${COMMON_LICENSE_DIR}/" + license for l=
icense in licenses], licenses
+                        return [], licenses
                     else:
                         return [package_json], None
=20
-            fallback =3D True
             basedir =3D os.path.join(srctree, destdir)
-            for fn in os.listdir(basedir):
-                upper =3D fn.upper()
-                if upper.startswith("COPYING") or "LICENCE" in upper or =
"LICENSE" in upper:
-                    fallback =3D False
-            if fallback:
+            licfiles =3D find_license_files(basedir)
+            if len(licfiles) > 0:
+                return licfiles, None
+            else:
+                # A license wasn't found in the package directory, so we=
'll use the package.json metadata
                 pkg_json =3D os.path.join(basedir, "package.json")
                 return _get_licenses_from_package_json(pkg_json)
-            return [], None
+
+        def _get_package_licenses(destdir, package):
+            (package_licfiles, package_licenses) =3D _find_package_licen=
ses(destdir)
+            if package_licfiles:
+                licfiles.extend(package_licfiles)
+            else:
+                fallback_licenses[package] =3D package_licenses
=20
         # Handle the dependencies
         def _handle_dependency(name, params, destdir):
             deptree =3D destdir.split('node_modules/')
             suffix =3D "-".join([npm_package(dep) for dep in deptree])
             packages["${PN}" + suffix] =3D destdir
-            (fallback_licfiles, common_lics) =3D _licfiles_append_fallba=
ck_package_files(destdir)
-            licfiles.extend(fallback_licfiles)
-            if common_lics:
-                fallback_licenses["${PN}" + suffix] =3D common_lics
+            _get_package_licenses(destdir, "${PN}" + suffix)
=20
         with open(shrinkwrap_file, "r") as f:
             shrinkwrap =3D json.load(f)
-
         foreach_dependencies(shrinkwrap, _handle_dependency, dev)
=20
+        # Handle the parent package
+        packages["${PN}"] =3D ""
+        _get_package_licenses(srctree, "${PN}")
+
         return licfiles, packages, fallback_licenses
    =20
     # Handle the peer dependencies  =20
@@ -279,48 +280,11 @@ class NpmRecipeHandler(RecipeHandler):
=20
         bb.note("Handling licences ...")
         (licfiles, packages, fallback_licenses) =3D self._handle_license=
s(srctree, shrinkwrap_file, dev)
-
-        def _guess_odd_license(licfiles):
-            import bb
-
-            md5sums =3D get_license_md5sums(d, linenumbers=3DTrue)
-
-            def _resolve_licfile(srctree, licfile):
-                match =3D re.search(r'\$\{COMMON_LICENSE_DIR\}/(.+)$', l=
icfile)
-                if match:
-                    license =3D match.group(1)
-                    commonlicdir =3D d.getVar('COMMON_LICENSE_DIR')
-                    return os.path.join(commonlicdir, license)
-               =20
-                return os.path.join(srctree, licfile)
-
-            chksums =3D []
-            licenses =3D []
-            md5value =3D None
-            for licfile in licfiles:
-                f =3D _resolve_licfile(srctree, licfile)
-                try:
-                    md5value =3D bb.utils.md5_file(f)
-                except FileNotFoundError:
-                    logger.info("Could not determine license for '%s'" %=
 licfile)
-                (license, beginline, endline, md5) =3D md5sums.get(md5va=
lue,
-                    (None, "", "", ""))
-                if not license:
-                    license =3D "Unknown"
-                    logger.info("Please add the following line for '%s' =
to a "
-                        "'lib/recipetool/licenses.csv' and replace `Unkn=
own`, "
-                        "`X`, `Y` and `MD5` with the license, begin line=
, "
-                        "end line and partial MD5 checksum:\n" \
-                        "%s,Unknown,X,Y,MD5" % (licfile, md5value))
-                chksums.append("file://%s%s%s;md5=3D%s" % (licfile,
-                    ";beginline=3D%s" % (beginline) if beginline else ""=
,
-                    ";endline=3D%s" % (endline) if endline else "",
-                    md5 if md5 else md5value))
-                licenses.append((license, licfile, md5value))
-            return (licenses, chksums, fallback_licenses)
-
-        (licenses, extravalues["LIC_FILES_CHKSUM"], fallback_licenses) =3D=
 _guess_odd_license(licfiles)
-        split_pkg_licenses([*licenses, *find_licenses(srctree, d)], pack=
ages, lines_after, fallback_licenses)
+        licvalues =3D match_licenses(licfiles, srctree, d)
+        split_pkg_licenses(licvalues, packages, lines_after, fallback_li=
censes)
+        fallback_licenses_flat =3D [license for sublist in fallback_lice=
nses.values() for license in sublist]
+        extravalues["LIC_FILES_CHKSUM"] =3D generate_common_licenses_chk=
sums(fallback_licenses_flat, d)
+        extravalues["LICENSE"] =3D fallback_licenses_flat
=20
         classes.append("npm")
         handled.append("buildsystem")
--=20
2.34.1


