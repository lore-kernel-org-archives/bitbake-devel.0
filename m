Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40812CD6E7E
	for <webhook@archiver.kernel.org>; Fri,  5 Jun 2026 22:09:33 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5926.1780697364037366447
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Jun 2026 15:09:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=TQYQGxb5;
 spf=pass (domain: smile.fr, ip: 209.85.128.41, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490b613a17bso23357585e9.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 05 Jun 2026 15:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1780697362; x=1781302162; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NcTEzcEaZcPDMVmynXk3AYFKxrkw5WeUG+b0E2kD7D4=;
        b=TQYQGxb5ysyiPKpVxXyTQ+/+LejsdIGQKQNwz5ZmcjggIMYrV3kYcwwlr2mlsAdHz3
         1iXz+1RauNCsm9cPN/RgLwmW2Ho0eGtMZqHGVjNqmZifF+AnQSArGNnJR5sNk3IkYjfN
         qv5xN5Zn2EJ8H8LzB/1tt6ODH5IBo9ly9p/kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780697362; x=1781302162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NcTEzcEaZcPDMVmynXk3AYFKxrkw5WeUG+b0E2kD7D4=;
        b=l7uWClheOEgn78VVPWlE2LccjyKkkk8yEMcFLmlqzaoH19VMtDRFFlCmGj9dV0V7ti
         7te5lR2z1q855bzyzHl432lWEMYfcWya8eDSgNVmd0Gy/RE5ViFrSH44D/Fvtddb7Ufs
         cfJvjFKF9m4IQNbbew6Vz+xqYISZpUasXeosF6NOAA9i6UatjS9fs4FHwv2aRi0OHddp
         G7ZSR59xKvaq53sRl/loq48rdswyiqN/zGc6g3b2JyBQE4artBs/SlEKAXXSHtmI/iho
         ME2pCD4uaL/a9nU/4crpZDYt5iaEfOXUxdCF97KELxKoo2T/90dVwQDeM302ajV1uBc3
         aHWw==
X-Gm-Message-State: AOJu0YyJHhO7M+jHIMfPZmzSia5GuO1xhBx9LL8SAbHnl3Fun+ahZkY8
	jQ6b9CZI7y6GRZmcJutphon3HoNdcMycAsSReqZGevmqaJb4ibXsdww5VB5WdyUSNF0cr4ShOoC
	q3Un8
X-Gm-Gg: Acq92OGBuYc+tH4igObQbUlAD3FtYJr0NSuAohbcgPQmsQgf1nyIoXTxIun61WTYjiW
	MJEGwD0bF29/5JMqWajjNw5gR5SchRUrdL0m7cGUUMEQiDza/OPp9U+EJHF+eHwBL0yNlc1HjJ4
	T0eoMYfFFFk1nQ8BIbxvOusn/60g5YuMe1O2ddyROPlZ4gH7R3xdOizvCN8VP/DjvkyxdpGSJJk
	inRiKmpaZdiUKSG3PhAaEbV5XrXDTo36rEvjL9kJF4TIvqVPA85MWtToSdU6GvhiOCMhfkjnruO
	SP2FaqfbjqVwjd3UAJyqrk3I3+94dH2J6Dj45FnYs0eiCSeHHcGqi4g3/h8DMifjvmgf3LvH7U7
	+JbN3NTZGhgmJc9YBcXubEtPMd6OV+clbptyO9qTAM0sr6iosiFDtKNVvZkzKf48NY33X44fHr7
	P+wmWDKjXaFWLHYPo+vUO9TByNGtQgmZYe0aovEgAi/QcVuN8BOexy0c3PQdnGzieRaoBVjoryX
	dDWmXVWvjyRdynoPBFaW+N22xMEvN8bXCqPW8c=
X-Received: by 2002:a05:600c:458a:b0:48a:525b:e148 with SMTP id 5b1f17b1804b1-490c25adb21mr99458955e9.4.1780697362477;
        Fri, 05 Jun 2026 15:09:22 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00b3e1ccc1be2b2798.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:b3e1:ccc1:be2b:2798])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3fd502sm182367015e9.11.2026.06.05.15.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 15:09:22 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [bitbake][wrynose][2.18][PATCH 4/4] fetch2: Unpack RPMs with --no-absolute-filenames
Date: Sat,  6 Jun 2026 00:08:58 +0200
Message-ID: <edd1cd43eee1a1f87dcd1ca356ae4247c41eac8f.1780696925.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1780696925.git.yoann.congal@smile.fr>
References: <cover.1780696925.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Jun 2026 22:09:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19620

From: Anders Heimer <anders.heimer@est.tech>

Use cpio --no-absolute-filenames when unpacking RPM and SRPM archives so
absolute paths and parent-directory components in cpio member names are
extracted relative to the intended unpack directory.

Signed-off-by: Anders Heimer <anders.heimer@est.tech>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 1b1a71586aa93678c1d9ca40ef2c6fa518f89356)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/fetch2/__init__.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 3d39a1eeb..0e4f491ce 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1585,11 +1585,11 @@ class FetchMethod(object):
             elif file.endswith('.rpm') or file.endswith('.srpm'):
                 if 'extract' in urldata.parm:
                     unpack_file = urldata.parm.get('extract')
-                    cmd = 'rpm2cpio.sh %s | cpio -id %s' % (file, unpack_file)
+                    cmd = 'rpm2cpio.sh %s | cpio --no-absolute-filenames -id %s' % (file, unpack_file)
                     iterate = True
                     iterate_file = unpack_file
                 else:
-                    cmd = 'rpm2cpio.sh %s | cpio -id' % (file)
+                    cmd = 'rpm2cpio.sh %s | cpio --no-absolute-filenames -id' % (file)
             elif file.endswith('.deb') or file.endswith('.ipk'):
                 output = subprocess.check_output(['ar', '-t', file], preexec_fn=subprocess_setup)
                 datafile = None

