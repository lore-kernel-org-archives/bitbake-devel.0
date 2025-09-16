Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45B7CAC5B1
	for <webhook@archiver.kernel.org>; Tue, 23 Sep 2025 08:40:09 +0000 (UTC)
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
 by mx.groups.io with SMTP id smtpd.web11.15081.1758014062195048966
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Sep 2025 02:14:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tq-group.com header.s=key1 header.b=BQo7PnsB;
 dkim=fail reason="dkim: no key for signature: lookup dkim._domainkey.ew.tq-group.com on 100.100.100.100:53: no such host" header.i=@ew.tq-group.com header.s=dkim header.b=i67/XM3M;
 spf=pass (domain: ew.tq-group.com, ip: 93.104.207.81, mailfrom: alexander.stein@ew.tq-group.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1758014062; x=1789550062;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=b0HmbTRyq8O85EeMVYsq7o805Rsw4UTBsTZdNQk7Hgo=;
  b=BQo7PnsBVlnF4JVbKpRYKyM4nuhs7uz9Rej4CqupLI7uK2EQ051rHGTi
   96eNWIFCTGKQjlJGLzw7on54XwkY0mA5FMQyTvnBA2x/9wkOeGDPt2OZc
   SccOvS7dCMF9A2oIC7OtsAWreItWLHQEoQ4VXAJv7euh94YT7YSdwLfYD
   kD/S4IpmWgiHoJV48MiCFhSBeBx9sNSXp9WdEZaoLDEPFGwltUYHKG9Al
   cyaVM0rk36v3EZQjmIuUo6NvFd3PntcJn7ApSRK1x3lfWSqBSudFSMdjL
   xhCzw6it5sWT2o2iaOpevuQphzkwtltDiZAdFsiQmhMeXfNZkasTEGMBf
   Q==;
X-CSE-ConnectionGUID: RiQcd2atRhWBwbkyyHUxEQ==
X-CSE-MsgGUID: nkZPoiJjQdCP4JcGFUwpEA==
X-IronPort-AV: E=Sophos;i="6.18,268,1751234400"; 
   d="scan'208";a="46161907"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 16 Sep 2025 11:14:19 +0200
X-CheckPoint: {68C92A6B-C-276C2876-DD58D4B1}
X-MAIL-CPID: A893138712C8CC0C0F9F966366E379C3_0
X-Control-Analysis: str=0001.0A2D035C.68C92A6C.0020,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D2858161412;
	Tue, 16 Sep 2025 11:14:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1758014055;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=b0HmbTRyq8O85EeMVYsq7o805Rsw4UTBsTZdNQk7Hgo=;
	b=i67/XM3M4sfFAWnbzyFc6rCv3AcJbZMYDVpLp/bvq3/AhjKQ7m2nElOP4NUX7qUZHlrwTj
	TzqvMrHFTmQ6WGDyPlHjt8XjZ6mE0QBtMnocmRlLMyMvBUhRuap7uUDSQ620jWkqR0CUUt
	0my9HZZL7daalhpoypdWcH2Cc4mosBs1JLYmXzj08JbbgkZA3xAI5h1mKnSyPxFeKaE7hV
	53nq+R46LNCmCUYHElG5u0xxN/OJwcIOCYtOiFTZBWIPE11vBfLjZfFJYAXwI06O2XHULm
	sA25bcJva8I8tSwFwgfFWiBnj6yjxhAOzXh1Ut5s27DJv6S+Lf9yJbpg1RzpbQ==
From: "Alexander Stein" <alexander.stein@ew.tq-group.com>
To: bitbake-devel@lists.openembedded.org
Cc: Ross Burton <ross.burton@arm.com>
Subject: [scarthgap][PATCH] bitbake: fetch2: don't try to preserve all attributes when unpacking files
Date: Tue, 16 Sep 2025 11:14:12 +0200
Message-ID: <20250916091413.274870-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 23 Sep 2025 08:40:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18077

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


