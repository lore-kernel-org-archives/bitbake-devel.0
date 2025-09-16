Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9783CAC5B0
	for <webhook@archiver.kernel.org>; Tue, 23 Sep 2025 08:40:09 +0000 (UTC)
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
 by mx.groups.io with SMTP id smtpd.web10.14760.1758014094170428664
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Sep 2025 02:14:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tq-group.com header.s=key1 header.b=aMc3w1uI;
 dkim=fail reason="dkim: no key for signature: lookup dkim._domainkey.ew.tq-group.com on 100.100.100.100:53: no such host" header.i=@ew.tq-group.com header.s=dkim header.b=H7jS9yF7;
 spf=pass (domain: ew.tq-group.com, ip: 93.104.207.81, mailfrom: alexander.stein@ew.tq-group.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1758014094; x=1789550094;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=b0HmbTRyq8O85EeMVYsq7o805Rsw4UTBsTZdNQk7Hgo=;
  b=aMc3w1uILiDgo7HX2Ha0fDivLObAbZfMr1phcQmqBZSGWJfsVyGFn97n
   SGHNT4bjCkk0pJNqfWe44EL94hS9Xnn+pT7ZpbCfUkJr6KCGT4alljYvO
   4s4U1BStrP4e5ssGl1h6sz1xHgG2KVsMytGaywqA7u9BNv0AsxDSVAzt1
   tlZmBcQwf1cIdbDC8taxRJDUmM4WxavjaGV4mGdWXkjI2iLbf0EIRkYBo
   TsQCAx+O2vxe/FJvjowOs2cI//7iqqXG5KMmkCEBXVmCWl7TqslMoaR1N
   2lg/FeXmRYG9iLKz9UaBtDC6mQGySR8q7BmwxIIebc145yc4q8gRGq6o9
   w==;
X-CSE-ConnectionGUID: AocccvFRSriDS833ENoEMA==
X-CSE-MsgGUID: 6wgDObZVTI+8COFuuPjqlw==
X-IronPort-AV: E=Sophos;i="6.18,268,1751234400"; 
   d="scan'208";a="46161908"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 16 Sep 2025 11:14:52 +0200
X-CheckPoint: {68C92A8C-2-404C3CD4-EC9FB5BB}
X-MAIL-CPID: C82584457BBEE0AA45BFC159F0FA47E9_4
X-Control-Analysis: str=0001.0A2D0344.68C92A8C.0061,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C19C01612A0;
	Tue, 16 Sep 2025 11:14:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1758014087;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=b0HmbTRyq8O85EeMVYsq7o805Rsw4UTBsTZdNQk7Hgo=;
	b=H7jS9yF76+fE7xNex5KGyLLTnSb8dAj7gwH9ZX9G7CWpKJ2B0ucJlD7lGawb8o3VfG5kg8
	tDUjpYnChU8ZY8OK+4heRIfVQMYBj1cYgHbc0+xNbpH14fvLoWmynMR5vYfLsLWo+s19vX
	iyVVCh+1obZcj4nCgvpnp7oMYPgypydAclqgZfg9tX8QvPBP0fozifF8XdSkllQ+1j5POs
	2v8oWxI6JY63OxrPb1HN2gkiyO3S8KkAs7Do2wlNfxA2hwQHDmBn0rMSN0YRbd7nEeWpdC
	bb1GLSPqpwUrltFhYz8+pw/OA2Zu3pA6toYNiVjNnkkmD6F5D2fJm0rFWGiVow==
From: "Alexander Stein" <alexander.stein@ew.tq-group.com>
To: bitbake-devel@lists.openembedded.org
Cc: Ross Burton <ross.burton@arm.com>
Subject: [scarthgap][PATCH] bitbake: fetch2: don't try to preserve all attributes when unpacking files
Date: Tue, 16 Sep 2025 11:14:45 +0200
Message-ID: <20250916091446.279654-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 23 Sep 2025 08:40:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18078

From: Ross Burton <ross.burton@arm.com>

When copying files as part of the unpack we currently use cp -p, which
is a shortcut for --preserve=mode,ownership,timestamps.

We do want to preserve timestamps, because some fetchers set these
explicitly.

We don't care about ownership. If the files are owned by us then they
ill remain owned by us, and if they're not then the attempt to change
ownership will be silently ignored.  In a shared DL_DIR where files have
group ownership this group access isn't relevant in the single-user build
tree.

We do want to preserve executable bits in the mode, but cp always does
this.  The difference between --preserve=mode and no --preserve is that
the mode isn't preserved exactly (no sticky bits, no suid, umask is
applied) but this also isn't a relevant difference in a build tree.

Also expand the arguments to be clearer about what options are being
passed.

The impetus for this is that coreutils 9.4 includes a change in gnulib[1]
and will now try to preserve permission-based xattrs if asked to preserve
the mode.  This can result in cp failing when copying a file from a
NFSv4 server with ACLs stored in xattrs to a non-NFS directory where
those xattrs cannot be written:

cp: preserving permissions for ‘./jquery-3.7.1.js’: Operation not supported

The error comes from the kernel refusing to write a system.nfs4_acl
xattr to a file on ext4.

This situation doesn't appear on all systems with coreutils 9.4, at the
time of writing it fails on Ubuntu 24.04 onwards but not Fedora 40. This
is because /etc/xattr.conf is used to determine which xattrs describe
permissions, and Fedora 40 has removed the NFSv4 attributes[2].

Also, use long-form options to make the cp command clearer.

[1] https://github.com/coreutils/gnulib/commit/eb6a8a4dfb
[2] https://src.fedoraproject.org/rpms/attr/blob/rawhide/f/0003-attr-2.4.48-xattr-conf-nfs4-acls.patch

[ YOCTO #15596 ]

(Bitbake rev: 2f35dac0c821ab231459922ed98e1b2cc599ca9a)

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bitbake/lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 1a6ff25d4d..21e39d0908 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -1606,7 +1606,7 @@ class FetchMethod(object):
                     if urlpath.find("/") != -1:
                         destdir = urlpath.rsplit("/", 1)[0] + '/'
                         bb.utils.mkdirhier("%s/%s" % (unpackdir, destdir))
-                cmd = 'cp -fpPRH "%s" "%s"' % (file, destdir)
+                cmd = 'cp --force --preserve=timestamps --no-dereference --recursive -H "%s" "%s"' % (file, destdir)
         else:
             urldata.unpack_tracer.unpack("archive-extract", unpackdir)
 
-- 
2.43.0


