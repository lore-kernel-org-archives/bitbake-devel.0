Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080A7C369D0
	for <webhook@archiver.kernel.org>; Wed, 25 Sep 2024 11:10:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web11.13194.1727262654729135185
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 25 Sep 2024 04:10:55 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2951212FC
	for <bitbake-devel@lists.openembedded.org>; Wed, 25 Sep 2024 04:11:23 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.oss.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5E8543F6A8
	for <bitbake-devel@lists.openembedded.org>; Wed, 25 Sep 2024 04:10:53 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2] fetch2: don't try to preserve all attributes when unpacking files
Date: Wed, 25 Sep 2024 12:10:46 +0100
Message-Id: <20240925111046.1286362-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 25 Sep 2024 11:10:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16600

When copying files as part of the unpack we currently use cp -p, which
is a shortcut for --preserve=3Dmode,ownership,timestamps.

We do want to preserve timestamps, because some fetchers set these
explicitly.

We don't care about ownership. If the files are owned by us then they
ill remain owned by us, and if they're not then the attempt to change
ownership will be silently ignored.  In a shared DL_DIR where files have
group ownership this group access isn't relevant in the single-user build
tree.

We do want to preserve executable bits in the mode, but cp always does
this.  The difference between --preserve=3Dmode and no --preserve is that
the mode isn't preserved exactly (no sticky bits, no suid, umask is
applied) but this also isn't a relevant difference in a build tree.

Also expand the arguments to be clearer about what options are being
passed.

The impetus for this is that coreutils 9.4 includes a change in gnulib[1]
and will now try to preserve permission-based xattrs if asked to preserve
the mode.  This can result in cp failing when copying a file from a
NFSv4 server with ACLs stored in xattrs to a non-NFS directory where
those xattrs cannot be written:

cp: preserving permissions for =E2=80=98./jquery-3.7.1.js=E2=80=99: Opera=
tion not supported

The error comes from the kernel refusing to write a system.nfs4_acl
xattr to a file on ext4.

This situation doesn't appear on all systems with coreutils 9.4, at the
time of writing it fails on Ubuntu 24.04 onwards but not Fedora 40. This
is because /etc/xattr.conf is used to determine which xattrs describe
permissions, and Fedora 40 has removed the NFSv4 attributes[2].

Also, use long-form options to make the cp command clearer.

[1] https://github.com/coreutils/gnulib/commit/eb6a8a4dfb
[2] https://src.fedoraproject.org/rpms/attr/blob/rawhide/f/0003-attr-2.4.=
48-xattr-conf-nfs4-acls.patch

[ YOCTO #15596 ]

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__=
init__.py
index ddee4400bbe..33a8086f279 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -1606,7 +1606,7 @@ class FetchMethod(object):
                     if urlpath.find("/") !=3D -1:
                         destdir =3D urlpath.rsplit("/", 1)[0] + '/'
                         bb.utils.mkdirhier("%s/%s" % (unpackdir, destdir=
))
-                cmd =3D 'cp -fpPRH "%s" "%s"' % (file, destdir)
+                cmd =3D 'cp --force --preserve=3Dtimestamps --no-derefer=
ence --recursive -H "%s" "%s"' % (file, destdir)
         else:
             urldata.unpack_tracer.unpack("archive-extract", unpackdir)
=20
--=20
2.34.1


