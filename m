Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E562EB1058
	for <webhook@archiver.kernel.org>; Tue, 10 Mar 2026 14:10:48 +0000 (UTC)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.40471.1773150451784561405
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 Mar 2026 06:47:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ew.tq-group.com header.s=default2602 header.b=qFK7U7nq;
 spf=pass (domain: ew.tq-group.com, ip: 188.40.3.216, mailfrom: alexander.feilke@ew.tq-group.com)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=79jxoX5LYkz6Mx9cHqDXUvVMEx+qyJs7RsHcmkILmPY=; b=qFK7U7nq0n5xlZLwGAkTM9l0SX
	bFjLe9csv+DcNnFl64Xzgh6iqIENbwTlc/p3sc9nQKfKKgt9GRbjFFvOMd9GFwa6GmuKrSTFR4HDn
	cM3VLZ8Vavo1gq44WM0qOLSLCetocEdx9A9S0Bd9tzJURay168NdgoqL9EtBrQWGofEpyy6LCwh3b
	/cckzwFmGczGPr6//gnn6kLJ2WzLUz8r1KLZv21uKEguA7+VT6oHK6FroyllcOe1xTKkvsaB604bb
	4/PzBLwKr5c6y8oF3101gr4YQpKAyRZrpVfIZyGR7oP/CsO4WzZAWCMarPoHMl80NxNR0+sK6axCd
	43F6F7DQ==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <Alexander.Feilke@ew.tq-group.com>)
	id 1vzxQn-000FZa-0M;
	Tue, 10 Mar 2026 14:47:29 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <Alexander.Feilke@ew.tq-group.com>)
	id 1vzxQm-0002pc-2k;
	Tue, 10 Mar 2026 14:47:28 +0100
From: "Alexander Feilke" <alexander.feilke@ew.tq-group.com>
To: bitbake-devel@lists.openembedded.org
Cc: Ross Burton <ross.burton@arm.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
Subject: [PATCH 1/1] fetch2: don't try to preserve all attributes when unpacking files
Date: Tue, 10 Mar 2026 14:46:56 +0100
Message-ID: <20260310134659.882794-2-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310134659.882794-1-Alexander.Feilke@ew.tq-group.com>
References: <20260310134659.882794-1-Alexander.Feilke@ew.tq-group.com>
MIME-Version: 1.0
X-Virus-Scanned: Clear (ClamAV 1.4.3/27936/Tue Mar 10 07:24:39 2026)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 Mar 2026 14:10:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19143

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

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 2f35dac0c821ab231459922ed98e1b2cc599ca9a)
Signed-off-by: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
---
 lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 7b75d5d83..224408de0 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
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


