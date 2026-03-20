Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE68109193E
	for <webhook@archiver.kernel.org>; Fri, 20 Mar 2026 00:26:17 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2587.1773966376263907407
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 19 Mar 2026 17:26:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=tB3STAG2;
 spf=pass (domain: smile.fr, ip: 209.85.128.47, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48374014a77so12728665e9.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 19 Mar 2026 17:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1773966374; x=1774571174; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=StP/EC0pud6+GpElF36Z/0/2AJb8CoSqKp6msKAJ2LY=;
        b=tB3STAG2t8EqlGuxSQCgqsZD5nDjh9aVjRPF6oZyCSp3fkiNHwmcxG6W4YYDhJuBS7
         4bLrhrqgyYzl6f8MS/K/v5vNDZtAiyqzZzFFY03+AHx/D80ARlZ0S3fDQKokdWZW0eEN
         dW1cQDqH7lZLB5qvQUzbw7Wm2goUYSuHFO/D0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773966374; x=1774571174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=StP/EC0pud6+GpElF36Z/0/2AJb8CoSqKp6msKAJ2LY=;
        b=Wd2BXdK4cEJv5GZ1T26slJzxInkhGX7LV9RCpIGtxEJqvpUGyvGxKcQG0vJzcghDwW
         TFXRoZLtvdtYf/xEWBLKW0n3assC81nK0IIiHT7M23JbcY3aLpmIFeF9ET+Pzx1APYTt
         cgNW+oa4MvCeLeY0WsaRdiR3ColrqfuYVCWKtoe82UnXdImfCWHEVBG8MAJ4EXYA9OgX
         b58+p5Kecj910Q67SCkxFoDLs4vArmyShtH/i2CkP+AoPWwvGVdB0jzFhhkDZBf0et1D
         SNaP1cYOYouo4BgPsY57mFV0PUBadqp58xSGQEBTzsyKB2fiJB7MKfkMRtxRss5+LSDh
         piQg==
X-Gm-Message-State: AOJu0Yzollbhk2qjv4+brcQfXS8rOXsbbbUjpJX8lesteRAgtxwM3DKy
	67TYTwJ9dA5Tsn/cgct+X8xMeng8KB5kQsP6iHA4fmwMbmckBiTbSagFfkiHRbA81NgxtQh7AKC
	xWkMS
X-Gm-Gg: ATEYQzyC3BVzfTSB+kb49hIHqK5Tue0thsuoZL9xbAmhGU3gbFawMmp76oe3aNk+u7I
	utGjYKmH7mrz4C2es4U4vs5fh7n3Jw1pqoNeFSCJBt5e2dviDc4L0oSNEtX8MjXuOWS+aNGKxvN
	9b2BQ95m1Z0POtsmmIJS3IrMZUkUO4QARYm3CODIS45O0yaAmseYEagcI8m/9OfDqxOw1AUdml4
	4vItour/qjRKFUjuDQBnP+Sro6Cnwk9jHCCf/gNnFs4joWYMWxCdHNGok8dHdKaCKtSqf9E9gmv
	B5DKfhrWfNoLUBG7h4Hug6e0Icp2CXK2SQyI6ujPFPH6uF7EaVg1DNZXPdVP+6fg4XzwWgFfj1X
	Tak0txSHTCidMRoqUnWXYAilkpZfXOWaETIeBJVuPT6OqWYTPzkHSPSwDIp9EZEjZYFTnxer9Ry
	wd0a+jdV+pW6rrYkPO19vFIqn6U4roVsy9x2Kga4UI0ovDUZDznp4t4bJQbTxGLl6/xu73H1dc6
	xRF3VrTT/UKnjevn9pVsJtowjk=
X-Received: by 2002:a05:600c:8710:b0:485:35ba:1d81 with SMTP id 5b1f17b1804b1-486fee051camr15543545e9.21.1773966374210;
        Thu, 19 Mar 2026 17:26:14 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fb4309d1sm106036545e9.3.2026.03.19.17.26.13
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 17:26:13 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 1/4] fetch2: don't try to preserve all attributes when unpacking files
Date: Fri, 20 Mar 2026 01:26:08 +0100
Message-ID: <9580f15aae08ae6e3693ebb898b6fd5238f5a7f8.1773966318.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1773966318.git.yoann.congal@smile.fr>
References: <cover.1773966318.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Mar 2026 00:26:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19180

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

(cherry picked from commit 2f35dac0c821ab231459922ed98e1b2cc599ca9a)

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
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
 

