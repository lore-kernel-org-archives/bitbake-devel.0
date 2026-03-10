Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EA5EB1056
	for <webhook@archiver.kernel.org>; Tue, 10 Mar 2026 14:10:48 +0000 (UTC)
Received: from mx-relay39-hz2.antispameurope.com (mx-relay39-hz2.antispameurope.com [94.100.136.239])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.40359.1773150123895767939
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 Mar 2026 06:42:04 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=softfail (domain: ew.tq-group.com, ip: 94.100.136.239, mailfrom: prvs=05227c41ac=alexander.feilke@ew.tq-group.com)
ARC-Authentication-Results: i=1; mx-gate39-hz2.hornetsecurity.com 1;
 spf=softfail reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out02-hz1.hornetsecurity.com;
 dmarc=fail header.from=ew.tq-group.com orig.disposition=quarantine
ARC-Message-Signature: a=rsa-sha256;
 bh=79jxoX5LYkz6Mx9cHqDXUvVMEx+qyJs7RsHcmkILmPY=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1773148948;
 b=O/WHJ5mWU5iu+UiGc5v/O3+sqimikkoKSlOxocDNSakIIuBj0RBswTJw6u/8rgk+EiPSOBQo
 haN+v4wY/kPgcGaUmV7b8RAFXY8l2m3+Rn8OOUrAYhxASXQ+DxWf80pCbQq3gzG9MEUNR5LQ3RC
 Rg/RE099EM/2qWGNltuvc8Qgd9EhLnMCWC+ILaEMBX1p/eN/Etctt4hbvgVLl1faBMoh98neJEl
 KSbTNPnh+0dZKPdCfhVi2q43JYdPsQXkF4YPXj4j6Fo9GGeqoB42keEtpeNEvGWQ4hUOSQAbS7h
 WOXuPdokN/KJjIJPxD8Cr0UInFCAOAhBouZ84JCpLGp6w==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1773148948;
 b=H6FSqB8AhW1diBmkfm5j78cYi69Bbo36h/KmiFhr2Naiu/U3RqcFPCshisVFIXnc4EoWA7+k
 IDi3O8ShbE0JIdfT6oxD0q0FITiY8FDXJ90HSzBbo97mJTEUcoxZBRmD8I7wVz4mIFFeL7SpS6W
 pkCv68oMWZ0gk/OMUkhwL0knL4w0zM0lLCaXlXddp/4drxPw1qI+zQHVX62oc576FIHUycAvt70
 W42gYmmoJFoH+opv6wNI6ugWZdgQau4/PmVJalioiJ5BRpRmGiwdecvwDtpJ85mitn3ix9Ho0IN
 AgBDBpcbbXYrVAIWFcGi62YdlQPYl/47sYdcNB0mseYTA==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay39-hz2.antispameurope.com;
 Tue, 10 Mar 2026 14:22:28 +0100
Received: from FEILKEA-LNX-W.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.feilke@ew.tq-group.com)
	by smtp-out02-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 2681B5A0B46;
	Tue, 10 Mar 2026 14:22:23 +0100 (CET)
From: "Alexander Feilke" <alexander.feilke@ew.tq-group.com>
To: bitbake-devel@lists.openembedded.org
Cc: Ross Burton <ross.burton@arm.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
Subject: [PATCH] fetch2: don't try to preserve all attributes when unpacking files
Date: Tue, 10 Mar 2026 14:22:15 +0100
Message-ID: <20260310132215.864868-1-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-cloud-security-sender: alexander.feilke@ew.tq-group.com
X-cloud-security-recipient: bitbake-devel@lists.openembedded.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: alexander.feilke@ew.tq-group.com
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay39-hz2.antispameurope.com with 4fVZL73qcYz2Bgg7
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest: a262fbdddd33bea01794f485c106e7a6
X-cloud-security: scantime:1.653
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 Mar 2026 14:10:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19142

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


