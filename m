Return-Path: <rehsack@gmail.com>
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com
	[209.85.212.174])
	by mail.openembedded.org (Postfix) with ESMTP id 301C877122
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Oct 2015 17:14:08 +0000 (UTC)
Received: by wicgb1 with SMTP id gb1so17944092wic.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Oct 2015 10:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:content-type:content-transfer-encoding:subject:message-id:date
	:to:mime-version;
	bh=wwnw4WkbMYMVzG+H3SOrdxlPmxCRRHcQGvMyomXeA7M=;
	b=XHRGHaW4pGtacB8OZ5NzTmHC6WA7oJBBFK7LtZUt+fDpve1PvIEWoS4zNKN2Ib0XW7
	4btV6P1t6FqfBgxQrrn7zMnh/Dv3tvHXgmLJmgs52uIb6fD2iD60+DjZGjXOUpYgXLIs
	vrqAsJOn/kfuCJ6QR6sn2SlUQ6ZAwTu/UOJ2zhid/507FjUh31aJj1O7R2Aixo3bTbEZ
	8ErTd0/MsJivnb1aUMwyVIu7gvJYPXuy4BpyWU9IXtEStViWMw7YhAVnRynYDzGGuitM
	sO/ct5yz6WMxW6C3FHBuLJY0oO3ABXkfZeggzDuCXTk8hNqf/FVFFuV9P6EpDFfJnIpy
	LlpA==
X-Received: by 10.194.206.38 with SMTP id ll6mr18693838wjc.116.1445015648676; 
	Fri, 16 Oct 2015 10:14:08 -0700 (PDT)
Received: from ernie.muppets.liwing.de (p578b540c.dip0.t-ipconnect.de.
	[87.139.84.12]) by smtp.gmail.com with ESMTPSA id
	l1sm23614096wjx.13.2015.10.16.10.14.07
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Fri, 16 Oct 2015 10:14:08 -0700 (PDT)
From: Jens Rehsack <rehsack@gmail.com>
Message-Id: <2BE45156-5280-4DFC-9773-F761B9F4B48B@gmail.com>
Date: Fri, 16 Oct 2015 19:14:04 +0200
To: bitbake-devel@lists.openembedded.org
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
X-Mailer: Apple Mail (2.2104)
Subject: [PATCH] fetcher: svn: Add support for checkout to a custom path
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
X-List-Received-Date: Fri, 16 Oct 2015 17:14:12 -0000
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable


Add support for the Subversion fetcher to checkout modules to a custom =
path
than the module name to avoid checkout is always module - svn is path
based and tag/branch-checkout might break builds because of invaid path =
specs.

Signed-off-by: Jens Rehsack <sno@netbsd.org>
---
 bitbake/lib/bb/fetch2/svn.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/svn.py b/bitbake/lib/bb/fetch2/svn.py
index 1733c2b..8a29193 100644
--- a/bitbake/lib/bb/fetch2/svn.py
+++ b/bitbake/lib/bb/fetch2/svn.py
@@ -54,6 +54,11 @@ class Svn(FetchMethod):
=20
         ud.module =3D ud.parm["module"]
=20
+        if not "path_spec" in ud.parm:
+            ud.path_spec =3D ud.module
+        else:
+            ud.path_spec =3D ud.parm["path_spec"]
+
         # Create paths to svn checkouts
         relpath =3D self._strip_leading_slashes(ud.path)
         ud.pkgdir =3D os.path.join(data.expand('${SVNDIR}', d), =
ud.host, relpath)
@@ -102,7 +107,7 @@ class Svn(FetchMethod):
=20
             if command =3D=3D "fetch":
                 transportuser =3D ud.parm.get("transportuser", "")
-                svncmd =3D "%s co %s %s://%s%s/%s%s %s" % (ud.basecmd, =
" ".join(options), proto, transportuser, svnroot, ud.module, suffix, =
ud.module)
+                svncmd =3D "%s co %s %s://%s%s/%s%s %s" % (ud.basecmd, =
" ".join(options), proto, transportuser, svnroot, ud.module, suffix, =
ud.path_spec)
             elif command =3D=3D "update":
                 svncmd =3D "%s update %s" % (ud.basecmd, " =
".join(options))
             else:
@@ -149,7 +154,7 @@ class Svn(FetchMethod):
=20
         os.chdir(ud.pkgdir)
         # tar them up to a defined filename
-        runfetchcmd("tar %s -czf %s %s" % (tar_flags, ud.localpath, =
ud.module), d, cleanup =3D [ud.localpath])
+        runfetchcmd("tar %s -czf %s %s" % (tar_flags, ud.localpath, =
ud.path_spec), d, cleanup =3D [ud.localpath])
=20
     def clean(self, ud, d):
         """ Clean SVN specific files and dirs """
--=20
2.4.3

--=20
Jens Rehsack - rehsack@gmail.com


