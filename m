Return-Path: <enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24748C41513
	for <webhook@archiver.kernel.org>; Mon,  8 Jul 2024 13:34:08 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.79800.1720445647692541029
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Jul 2024 06:34:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=yG1vAjbc;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: enguerrand.de-ribaucourt@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 0F2019C5BAC;
	Mon,  8 Jul 2024 09:34:07 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id cWbDnIiljbG1; Mon,  8 Jul 2024 09:34:05 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id B03F59C5D3D;
	Mon,  8 Jul 2024 09:34:05 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com B03F59C5D3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1720445645; bh=EhzQ8wNaLqO2ae9g+r4pUxup5brrhibk6lif/pebQBQ=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=yG1vAjbcorsW3taSmZuzEbNLszSfT0igQuPQ5flMCEQo/EnxmQ+/Gt8XR7SMwxo2S
	 sDlX2euTKkgty+ajkR4XQ6wdtxd8djSqeR+rCuBFzP6CMCv6otgpvEZqvFNWOjjdYZ
	 5zF9kLXEMEq6VUjdHwcUpWIuoQ5hBTFngmgfzPc6jFtI/WmvZA6azdMdoSp3ozlxut
	 8BGBxOBjkwvqKnF7uZtVc1M7L3Oobi1zwAEoL6FeI2x65ce9LZRhCSgCTmaQwYDmF/
	 a1iLrMTibpePpEnrUnLT33z1/cBN+PL9P6Z/c96lA9Xftgm1GWsdzUjLzDVcZAtnEf
	 OOp3prQWxefww==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id iE-Ws6GUxeb4; Mon,  8 Jul 2024 09:34:05 -0400 (EDT)
Received: from sfl-deribaucourt.rennes.sfl (80-15-101-118.ftth.fr.orangecustomers.net [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id F19519C5D1A;
	Mon,  8 Jul 2024 09:34:04 -0400 (EDT)
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: tanguy.raufflet@savoirfairelinux.com,
	richard.purdie@linuxfoundation.org,
	Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Subject: [PATCH v2 3/4] recipetool: create_npm: resolve licenses defined in package.json
Date: Mon,  8 Jul 2024 15:33:56 +0200
Message-Id: <20240708133357.306422-4-enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240708133357.306422-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
References: <20240708133357.306422-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 08 Jul 2024 13:34:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16404

Some npm packages do not copy the LICENSE or COPY file into their
git repository. They'll instead simply use SPDX identifiers in their
package.json. A fallback for those repositories attempted to match
the README file to a license file instead, which had a very low
probability of success.

This commit replaces this fallback with parsing the package.json and
looking for the license in COMMON_LICENSE_DIR. If the license is not
found, "Unknown" will still be produced.

This also generates "Unknown" for packages which had no README file,
which could silently not appear in the generated recipe. The user was
more likely to miss them.

Co-authored-by: Tanguy Raufflet <tanguy.raufflet@savoirfairelinux.com>
Signed-off-by: Tanguy Raufflet <tanguy.raufflet@savoirfairelinux.com>
Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirf=
airelinux.com>
---
 scripts/lib/recipetool/create_npm.py | 57 ++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 16 deletions(-)

diff --git a/scripts/lib/recipetool/create_npm.py b/scripts/lib/recipetoo=
l/create_npm.py
index 113a89f6a6..dd0ac01c3e 100644
--- a/scripts/lib/recipetool/create_npm.py
+++ b/scripts/lib/recipetool/create_npm.py
@@ -112,40 +112,52 @@ class NpmRecipeHandler(RecipeHandler):
         """Return the extra license files and the list of packages"""
         licfiles =3D []
         packages =3D {}
+        # Licenses from package.json point to COMMON_LICENSE_DIR so we n=
eed
+        # to associate them explicitely for split_pkg_licenses()
+        fallback_licenses =3D dict()
=20
         # Handle the parent package
         packages["${PN}"] =3D ""
=20
-        def _licfiles_append_fallback_readme_files(destdir):
-            """Append README files as fallback to license files if a lic=
ense files is missing"""
+        def _licfiles_append_fallback_package_files(destdir):
+            """Append package.json files as fallback to license files if=
 a license files is missing"""
+            def _get_licenses_from_package_json(package_json):
+                with open(os.path.join(srctree, package_json), "r") as f=
:
+                    data =3D json.load(f)
+                    if "license" in data:
+                        licenses =3D data["license"].split(" ")
+                        licenses =3D [license.strip("()") for license in=
 licenses if license !=3D "OR" and license !=3D "AND"]
+                        return ["${COMMON_LICENSE_DIR}/" + license for l=
icense in licenses], licenses
+                    else:
+                        return [package_json], None
=20
             fallback =3D True
-            readmes =3D []
             basedir =3D os.path.join(srctree, destdir)
             for fn in os.listdir(basedir):
                 upper =3D fn.upper()
-                if upper.startswith("README"):
-                    fullpath =3D os.path.join(basedir, fn)
-                    readmes.append(fullpath)
                 if upper.startswith("COPYING") or "LICENCE" in upper or =
"LICENSE" in upper:
                     fallback =3D False
             if fallback:
-                for readme in readmes:
-                    licfiles.append(os.path.relpath(readme, srctree))
+                pkg_json =3D os.path.join(basedir, "package.json")
+                return _get_licenses_from_package_json(pkg_json)
+            return [], None
=20
         # Handle the dependencies
         def _handle_dependency(name, params, destdir):
             deptree =3D destdir.split('node_modules/')
             suffix =3D "-".join([npm_package(dep) for dep in deptree])
             packages["${PN}" + suffix] =3D destdir
-            _licfiles_append_fallback_readme_files(destdir)
+            (fallback_licfiles, common_lics) =3D _licfiles_append_fallba=
ck_package_files(destdir)
+            licfiles.extend(fallback_licfiles)
+            if common_lics:
+                fallback_licenses["${PN}" + suffix] =3D common_lics
=20
         with open(shrinkwrap_file, "r") as f:
             shrinkwrap =3D json.load(f)
=20
         foreach_dependencies(shrinkwrap, _handle_dependency, dev)
=20
-        return licfiles, packages
+        return licfiles, packages, fallback_licenses
    =20
     # Handle the peer dependencies  =20
     def _handle_peer_dependency(self, shrinkwrap_file):
@@ -266,18 +278,31 @@ class NpmRecipeHandler(RecipeHandler):
         fetcher.unpack(srctree)
=20
         bb.note("Handling licences ...")
-        (licfiles, packages) =3D self._handle_licenses(srctree, shrinkwr=
ap_file, dev)
+        (licfiles, packages, fallback_licenses) =3D self._handle_license=
s(srctree, shrinkwrap_file, dev)
=20
         def _guess_odd_license(licfiles):
             import bb
=20
             md5sums =3D get_license_md5sums(d, linenumbers=3DTrue)
=20
+            def _resolve_licfile(srctree, licfile):
+                match =3D re.search(r'\$\{COMMON_LICENSE_DIR\}/(.+)$', l=
icfile)
+                if match:
+                    license =3D match.group(1)
+                    commonlicdir =3D d.getVar('COMMON_LICENSE_DIR')
+                    return os.path.join(commonlicdir, license)
+               =20
+                return os.path.join(srctree, licfile)
+
             chksums =3D []
             licenses =3D []
+            md5value =3D None
             for licfile in licfiles:
-                f =3D os.path.join(srctree, licfile)
-                md5value =3D bb.utils.md5_file(f)
+                f =3D _resolve_licfile(srctree, licfile)
+                try:
+                    md5value =3D bb.utils.md5_file(f)
+                except FileNotFoundError:
+                    logger.info("Could not determine license for '%s'" %=
 licfile)
                 (license, beginline, endline, md5) =3D md5sums.get(md5va=
lue,
                     (None, "", "", ""))
                 if not license:
@@ -292,10 +317,10 @@ class NpmRecipeHandler(RecipeHandler):
                     ";endline=3D%s" % (endline) if endline else "",
                     md5 if md5 else md5value))
                 licenses.append((license, licfile, md5value))
-            return (licenses, chksums)
+            return (licenses, chksums, fallback_licenses)
=20
-        (licenses, extravalues["LIC_FILES_CHKSUM"]) =3D _guess_odd_licen=
se(licfiles)
-        split_pkg_licenses([*licenses, *guess_license(srctree, d)], pack=
ages, lines_after)
+        (licenses, extravalues["LIC_FILES_CHKSUM"], fallback_licenses) =3D=
 _guess_odd_license(licfiles)
+        split_pkg_licenses([*licenses, *guess_license(srctree, d)], pack=
ages, lines_after, fallback_licenses)
=20
         classes.append("npm")
         handled.append("buildsystem")
--=20
2.34.1


