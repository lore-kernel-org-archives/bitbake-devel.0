Return-Path: <enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC82AC531DD
	for <webhook@archiver.kernel.org>; Mon, 12 Aug 2024 12:28:44 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.44998.1723465721292247190
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Aug 2024 05:28:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=YxjOZmdj;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: enguerrand.de-ribaucourt@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 9B3629C5D24;
	Mon, 12 Aug 2024 08:28:40 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id MyZfd5lWhrN9; Mon, 12 Aug 2024 08:28:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id D991B9C5F35;
	Mon, 12 Aug 2024 08:28:39 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com D991B9C5F35
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1723465719; bh=qDLER9r/6v2yuNogmpzJQCTRRxjRP0i1NCl8XefCBvg=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=YxjOZmdjgpCduwVX7woNuYe7wRlCP7X/T90MtpbbL/g96Pf8C2hHzEfanmZIv6kpX
	 Z2UdbV4JSOyYRS8MXjJLIcVVA2kE6GdoaVwS9kZ3DRbRj+cf6kCvYxyUMxFeNyySxZ
	 WjvuGzZroFN2hhFW113EJW5LVpfelaw7MiHkYc52DNKT3lnF8Pe5cVRINoYdOVhwrg
	 gnS3TT0ZUkC1MsNG+TzmyoAtzV7o5qfYEo7iIz7vu9BH0cHGzjhmQwfuk+olibRNum
	 WU+v9QOvX9XWZsu/GTKmXQniVT+JXfqiE0V172h5DCZDh15Ney4C7TiVVdufDBdqHG
	 DcXbESun6xN1w==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id XF_Yshg8659Q; Mon, 12 Aug 2024 08:28:39 -0400 (EDT)
Received: from sfl-deribaucourt.rennes.sfl (80-15-101-118.ftth.fr.orangecustomers.net [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id EA0E79C5E53;
	Mon, 12 Aug 2024 08:28:38 -0400 (EDT)
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: tanguy.raufflet@savoirfairelinux.com,
	richard.purdie@linuxfoundation.org,
	alexandre.belloni@bootlin.com,
	stefan.herbrechtsmeier@weidmueller.com,
	Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Subject: [OE-core][PATCH v4 3/4] recipetool: create: split guess_license function
Date: Mon, 12 Aug 2024 14:28:28 +0200
Message-Id: <20240812122829.577515-4-enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240812122829.577515-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
References: <20240812122829.577515-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 12 Aug 2024 12:28:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16469

The npm recipetool handler redefines the license code the could be
unified. In order to do this refactoring, extract the bits we'll
need into separate functions.

guess_license() is renamed to find_licenses() and is split into
find_license_files() and match_licenses().

Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirf=
airelinux.com>
---
v4:
 - fixed oe-selftest recipetool.RecipetoolTests.test_recipetool_handle_li=
cense_vars
v3:
 - added commit
---
 meta/classes-global/license.bbclass        |  8 ++---
 meta/lib/oeqa/selftest/cases/recipetool.py |  1 +
 scripts/lib/recipetool/create.py           | 34 ++++++++++++++--------
 scripts/lib/recipetool/create_go.py        |  4 +--
 scripts/lib/recipetool/create_npm.py       |  4 +--
 5 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/meta/classes-global/license.bbclass b/meta/classes-global/li=
cense.bbclass
index b2e0d3faba..4e39ec1d44 100644
--- a/meta/classes-global/license.bbclass
+++ b/meta/classes-global/license.bbclass
@@ -39,7 +39,7 @@ python do_populate_lic() {
 }
=20
 PSEUDO_IGNORE_PATHS .=3D ",${@','.join(((d.getVar('COMMON_LICENSE_DIR') =
or '') + ' ' + (d.getVar('LICENSE_PATH') or '') + ' ' + d.getVar('COREBAS=
E') + '/meta/COPYING').split())}"
-# it would be better to copy them in do_install:append, but find_license=
_filesa is python
+# it would be better to copy them in do_install:append, but find_license=
_files is python
 python perform_packagecopy:prepend () {
     enabled =3D oe.data.typed_value('LICENSE_CREATE_PACKAGE', d)
     if d.getVar('CLASSOVERRIDE') =3D=3D 'class-target' and enabled:
@@ -149,14 +149,14 @@ def find_license_files(d):
             # and "with exceptions" being *
             # we'll just strip out the modifier and put
             # the base license.
-            find_license(node.s.replace("+", "").replace("*", ""))
+            find_licenses(node.s.replace("+", "").replace("*", ""))
             self.generic_visit(node)
=20
         def visit_Constant(self, node):
-            find_license(node.value.replace("+", "").replace("*", ""))
+            find_licenses(node.value.replace("+", "").replace("*", ""))
             self.generic_visit(node)
=20
-    def find_license(license_type):
+    def find_licenses(license_type):
         try:
             bb.utils.mkdirhier(gen_lic_dest)
         except:
diff --git a/meta/lib/oeqa/selftest/cases/recipetool.py b/meta/lib/oeqa/s=
elftest/cases/recipetool.py
index 42202b7831..f742dd4d64 100644
--- a/meta/lib/oeqa/selftest/cases/recipetool.py
+++ b/meta/lib/oeqa/selftest/cases/recipetool.py
@@ -1068,6 +1068,7 @@ class RecipetoolTests(RecipetoolBase):
=20
         d =3D DataConnectorCopy
         d.getVar =3D Mock(return_value=3Dcommonlicdir)
+        d.expand =3D Mock(side_effect=3Dlambda x: x)
=20
         srctree =3D tempfile.mkdtemp(prefix=3D'recipetoolqa')
         self.track_for_cleanup(srctree)
diff --git a/scripts/lib/recipetool/create.py b/scripts/lib/recipetool/cr=
eate.py
index 066366e34f..c626844370 100644
--- a/scripts/lib/recipetool/create.py
+++ b/scripts/lib/recipetool/create.py
@@ -960,7 +960,7 @@ def handle_license_vars(srctree, lines_before, handle=
d, extravalues, d):
         # Someone else has already handled the license vars, just return=
 their value
         return lichandled[0][1]
=20
-    licvalues =3D guess_license(srctree, d)
+    licvalues =3D find_licenses(srctree, d)
     licenses =3D []
     lic_files_chksum =3D []
     lic_unknown =3D []
@@ -1216,13 +1216,7 @@ def crunch_license(licfile):
         lictext =3D ''
     return md5val, lictext
=20
-def guess_license(srctree, d):
-    import bb
-    md5sums =3D get_license_md5sums(d)
-
-    crunched_md5sums =3D crunch_known_licenses(d)
-
-    licenses =3D []
+def find_license_files(srctree):
     licspecs =3D ['*LICEN[CS]E*', 'COPYING*', '*[Ll]icense*', 'LEGAL*', =
'[Ll]egal*', '*GPL*', 'README.lic*', 'COPYRIGHT*', '[Cc]opyright*', 'e[dp=
]l-v10']
     skip_extensions =3D (".html", ".js", ".json", ".svg", ".ts", ".go")
     licfiles =3D []
@@ -1235,11 +1229,22 @@ def guess_license(srctree, d):
                     fullpath =3D os.path.join(root, fn)
                     if not fullpath in licfiles:
                         licfiles.append(fullpath)
+
+    return licfiles
+
+def match_licenses(licfiles, srctree, d):
+    import bb
+    md5sums =3D get_license_md5sums(d)
+
+    crunched_md5sums =3D crunch_known_licenses(d)
+
+    licenses =3D []
     for licfile in sorted(licfiles):
-        md5value =3D bb.utils.md5_file(licfile)
+        resolved_licfile =3D d.expand(licfile)
+        md5value =3D bb.utils.md5_file(resolved_licfile)
         license =3D md5sums.get(md5value, None)
         if not license:
-            crunched_md5, lictext =3D crunch_license(licfile)
+            crunched_md5, lictext =3D crunch_license(resolved_licfile)
             license =3D crunched_md5sums.get(crunched_md5, None)
             if lictext and not license:
                 license =3D 'Unknown'
@@ -1249,13 +1254,19 @@ def guess_license(srctree, d):
         if license:
             licenses.append((license, os.path.relpath(licfile, srctree),=
 md5value))
=20
+    return licenses
+
+def find_licenses(srctree, d):
+    licfiles =3D find_license_files(srctree)
+    licenses =3D match_licenses(licfiles, srctree, d)
+
     # FIXME should we grab at least one source file with a license heade=
r and add that too?
=20
     return licenses
=20
 def split_pkg_licenses(licvalues, packages, outlines, fallback_licenses=3D=
None, pn=3D'${PN}'):
     """
-    Given a list of (license, path, md5sum) as returned by guess_license=
(),
+    Given a list of (license, path, md5sum) as returned by match_license=
s(),
     a dict of package name to path mappings, write out a set of
     package-specific LICENSE values.
     """
@@ -1418,4 +1429,3 @@ def register_commands(subparsers):
     parser_create.add_argument('--devtool', action=3D"store_true", help=3D=
argparse.SUPPRESS)
     parser_create.add_argument('--mirrors', action=3D"store_true", help=3D=
'Enable PREMIRRORS and MIRRORS for source tree fetching (disabled by defa=
ult).')
     parser_create.set_defaults(func=3Dcreate_recipe)
-
diff --git a/scripts/lib/recipetool/create_go.py b/scripts/lib/recipetool=
/create_go.py
index a85a2f2786..5cc53931f0 100644
--- a/scripts/lib/recipetool/create_go.py
+++ b/scripts/lib/recipetool/create_go.py
@@ -14,7 +14,7 @@ from collections import namedtuple
 from enum import Enum
 from html.parser import HTMLParser
 from recipetool.create import RecipeHandler, handle_license_vars
-from recipetool.create import guess_license, tidy_licenses, fixup_licens=
e
+from recipetool.create import find_licenses, tidy_licenses, fixup_licens=
e
 from recipetool.create import determine_from_url
 from urllib.error import URLError, HTTPError
=20
@@ -624,7 +624,7 @@ class GoRecipeHandler(RecipeHandler):
=20
         licenses =3D []
         lic_files_chksum =3D []
-        licvalues =3D guess_license(tmp_vendor_dir, d)
+        licvalues =3D find_licenses(tmp_vendor_dir, d)
         shutil.rmtree(tmp_vendor_dir)
=20
         if licvalues:
diff --git a/scripts/lib/recipetool/create_npm.py b/scripts/lib/recipetoo=
l/create_npm.py
index dd0ac01c3e..78dc248f31 100644
--- a/scripts/lib/recipetool/create_npm.py
+++ b/scripts/lib/recipetool/create_npm.py
@@ -17,7 +17,7 @@ from bb.fetch2.npm import npm_package
 from bb.fetch2.npmsw import foreach_dependencies
 from recipetool.create import RecipeHandler
 from recipetool.create import get_license_md5sums
-from recipetool.create import guess_license
+from recipetool.create import find_licenses
 from recipetool.create import split_pkg_licenses
 logger =3D logging.getLogger('recipetool')
=20
@@ -320,7 +320,7 @@ class NpmRecipeHandler(RecipeHandler):
             return (licenses, chksums, fallback_licenses)
=20
         (licenses, extravalues["LIC_FILES_CHKSUM"], fallback_licenses) =3D=
 _guess_odd_license(licfiles)
-        split_pkg_licenses([*licenses, *guess_license(srctree, d)], pack=
ages, lines_after, fallback_licenses)
+        split_pkg_licenses([*licenses, *find_licenses(srctree, d)], pack=
ages, lines_after, fallback_licenses)
=20
         classes.append("npm")
         handled.append("buildsystem")
--=20
2.34.1


