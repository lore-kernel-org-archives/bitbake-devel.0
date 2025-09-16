Return-Path: <alexander.stein@ew.tq-group.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B48BCAC599
	for <webhook@archiver.kernel.org>; Tue, 16 Sep 2025 09:44:14 +0000 (UTC)
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
 by mx.groups.io with SMTP id smtpd.web11.15454.1758015850883548795
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Sep 2025 02:44:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tq-group.com header.s=key1 header.b=g9hknW5U;
 dkim=fail reason="dkim: no key for signature: lookup dkim._domainkey.ew.tq-group.com on 100.100.100.100:53: no such host" header.i=@ew.tq-group.com header.s=dkim header.b=VrfmRN+M;
 spf=pass (domain: ew.tq-group.com, ip: 93.104.207.81, mailfrom: alexander.stein@ew.tq-group.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1758015851; x=1789551851;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=b0HmbTRyq8O85EeMVYsq7o805Rsw4UTBsTZdNQk7Hgo=;
  b=g9hknW5U4VvgRZOkpmn4WsRpItaBnJdIYK9QXN8Y3FTpnGnsMrF3LqC8
   cE4CQo4TWdMAtCBqJlWgaATSBn8pylB2gec3pXzqX7RqjPdrXBs3s7glY
   09aCO/yh9XzulPnw6VvQVLuRtMyXawRaRYd4jjDIQezNfsgr1psjA4eNf
   z2ftnJtP6y9lbb6YU50cXrx+xW0jF+RIjJF9X46mkxtZYYTDmoZrN+ZUa
   uGG7jGOrNTlqDbgROAvGsnriMrdqtQs8plw0Ct/vrY4A+cJWchfHgeidH
   yLJV88W9u9I/1CV7esuJJTeR+KU/HkpN2HzWbOa+H9J8NQ9Myy4Nuz8j7
   w==;
X-CSE-ConnectionGUID: lnJoNCYbTuiiqGxzTw7Xtw==
X-CSE-MsgGUID: fTvpVd7sQWqzfOzqZwfSKg==
X-IronPort-AV: E=Sophos;i="6.18,268,1751234400"; 
   d="scan'208";a="46162311"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 16 Sep 2025 11:44:08 +0200
X-CheckPoint: {68C93168-2F-404C3CD4-EC9FB5BB}
X-MAIL-CPID: 1975884329F3DEC9498B53F4DBDFF815_4
X-Control-Analysis: str=0001.0A2D0312.68C93169.000D,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D5F7E163D19;
	Tue, 16 Sep 2025 11:44:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1758015844;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=b0HmbTRyq8O85EeMVYsq7o805Rsw4UTBsTZdNQk7Hgo=;
	b=VrfmRN+MRAahMRS4mIlJ2Kj/nKjnE73O2leV+6Ol4BeLjuVvRJ225S0+uUp1klNfIbsYXH
	UgnLQlwkPfbB4FjwwQMihfQ/unPSXvH5wFsvdYk8P5kmNtMIi1pO585G7HojpW87vcDHKO
	5pj5tWEaL4i3B7cRzmJGQbSipx1gLZ/4iENLXvnlJWeD7mPlNN6nRQLQqS0x/EHwLjT6iG
	DsBc8eVNDptuWXrWvAV0qgGK0V7dTVJ/vXBVsoJRXGTCinb7Tf3lp5KCHzjpoclogrofLW
	9gOxbI1Eo0gYaCXA6TT4lQGHcHbV62SQemvFHfkEq+y2WL3rWxQa4iyrn/a3OA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: bitbake-devel@lists.openembedded.org
Cc: Ross Burton <ross.burton@arm.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [scarthgap][PATCH] bitbake: fetch2: don't try to preserve all attributes when unpacking files
Date: Tue, 16 Sep 2025 11:43:54 +0200
Message-ID: <20250916094357.417559-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Sep 2025 09:44:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18042

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


