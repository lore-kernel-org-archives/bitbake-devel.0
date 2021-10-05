Return-Path: <ross@burtonini.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C0EC4332F
	for <webhook@archiver.kernel.org>; Tue,  5 Oct 2021 14:50:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web08.1657.1633445407044534586
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 Oct 2021 07:50:07 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92D3D113E;
	Tue,  5 Oct 2021 07:50:06 -0700 (PDT)
Received: from oss-tx204.lab.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D6DE3F70D;
	Tue,  5 Oct 2021 07:50:05 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: bitbake-devel@lists.openembedded.org
Cc: mark.hatle@kernel.crashing.org
Subject: [PATCH 4/4] fetch2/gitsm: remove the 'nugget' SRCREV caching
Date: Tue,  5 Oct 2021 15:50:01 +0100
Message-Id: <20211005145001.2717748-4-ross.burton@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005145001.2717748-1-ross.burton@arm.com>
References: <20211005145001.2717748-1-ross.burton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 05 Oct 2021 14:50:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12725

The cached revisions which are used to decide if a repository doesn't
need to be updated are misleading when used in conjunction with mirror
tarballs and can cause partial fetches to happen, resulting in unpack
errors as repositories were not fetched.

A concrete example: edk2-firmware in meta-arm is at version 202102
(ef91b0). This is built on the autobuilder so the source mirror contains
the repository as a mirror tarball.  If I build edk2-firmware 202102 the
gitsm fetcher will initially download the top-level repository and then
iterate into the submodules to also fetch those repositories, including
cmocka from cryptomilk.org.  edk2-firmware will then unpack and build
successfully.

I then update edk2-firmware to 202105 (e1999b) and build it.
Gitsm.needs_update() starts by calling Git.needs_update() which returns
False, as the mirror tarball contains this revision. It then looks at
the "nuggets" which are SRCREVs it has fetched before.  The mirror
tarball itself contains the nugget for e1999b as this has been built on
the autobuilder, so needs_update return False, no more fetching is done,
and the build proceeds to unpack.

However, as part of the 202105 upgrade the URL of the cmocka submodule
changed, and this new repository was never fetched. This means that
unpack fails as one of the required git repositories isn't available.

The nugget codepaths appear to be an attempt at optimising the fetch
process, but have demonstratable failure cases.  Just removing them
entirely solves the edk2-firmware example, and all of the fetcher test
cases still pass.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 bitbake/lib/bb/fetch2/gitsm.py | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/gitsm.py b/bitbake/lib/bb/fetch2/gitsm=
.py
index a4527bf364..a7110a988d 100644
--- a/bitbake/lib/bb/fetch2/gitsm.py
+++ b/bitbake/lib/bb/fetch2/gitsm.py
@@ -140,16 +140,6 @@ class GitSM(Git):
         if Git.need_update(self, ud, d):
             return True
=20
-        try:
-            # Check for the nugget dropped by the download operation
-            known_srcrevs =3D runfetchcmd("%s config --get-all bitbake.s=
rcrev" % \
-                                        (ud.basecmd), d, workdir=3Dud.cl=
onedir)
-
-            if ud.revisions[ud.names[0]] in known_srcrevs.split():
-                return False
-        except bb.fetch2.FetchError:
-            pass
-
         need_update_list =3D []
         def need_update_submodule(ud, url, module, modpath, workdir, d):
             url +=3D ";bareclone=3D1;nobranch=3D1"
@@ -172,11 +162,6 @@ class GitSM(Git):
             shutil.rmtree(tmpdir)
         else:
             self.process_submodules(ud, ud.clonedir, need_update_submodu=
le, d)
-            if len(need_update_list) =3D=3D 0:
-                # We already have the required commits of all submodules=
. Drop
-                # a nugget so we don't need to check again.
-                runfetchcmd("%s config --add bitbake.srcrev %s" % \
-                            (ud.basecmd, ud.revisions[ud.names[0]]), d, =
workdir=3Dud.clonedir)
=20
         if len(need_update_list) > 0:
             logger.debug('gitsm: Submodules requiring update: %s' % (' '=
.join(need_update_list)))
@@ -209,9 +194,6 @@ class GitSM(Git):
             shutil.rmtree(tmpdir)
         else:
             self.process_submodules(ud, ud.clonedir, download_submodule,=
 d)
-            # Drop a nugget for the srcrev we've fetched (used by need_u=
pdate)
-            runfetchcmd("%s config --add bitbake.srcrev %s" % \
-                        (ud.basecmd, ud.revisions[ud.names[0]]), d, work=
dir=3Dud.clonedir)
=20
     def unpack(self, ud, destdir, d):
         def unpack_submodules(ud, url, module, modpath, workdir, d):
--=20
2.25.1


