Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AAACD6E6E
	for <webhook@archiver.kernel.org>; Fri,  5 Jun 2026 22:12:53 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5827.1780697565976577450
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Jun 2026 15:12:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=1HaWTaTh;
 spf=pass (domain: smile.fr, ip: 209.85.128.50, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490b2b037d2so21031255e9.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 05 Jun 2026 15:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1780697564; x=1781302364; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=225I9pj2nw3C5oocY+5Wn1sz1l8uiB1VdC+nUoZGBsA=;
        b=1HaWTaThYCFWDNWaFsSny+C9UUaULwSoW/ZNI1HUsrkV5UkxEcRBTikgJDiTjPNzru
         2P6c23OctO/8aqAXec9/6hflZY7YxiEmmNhsIEuvgCVwQt6yFwR1yUXvKvHvBQ6YhJnI
         yfvoJZNNuxKtF5vb0fFGQoI3D4JFgs/y/PZuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780697564; x=1781302364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=225I9pj2nw3C5oocY+5Wn1sz1l8uiB1VdC+nUoZGBsA=;
        b=meJor57TsJ+BqR4gPeBkM78+ylsbPJqXo8/itao1WQ+tGNrvG8CTigESgPZcxQrxNO
         z/EQczDfzRSu/tVLdPdr8B/BtXaDSfZjY+RUoeO3SnWHarSK5nm7RWEgs12Ma/qZSDCx
         CkkvM+0fwpfcIHu353X3cjVWof6bnQSMvzHln9OBcGIxIp7Hr/E/XAnZ18pDQYNneIIa
         48/8X4Hz2tKFGU+flzL0VvtqBXTCO9PX0zx69Hx0qXyFNcYa35oPzbgU5hqu8wMASOnf
         3j2hp47Uxp88cJ1KV2bCNKKNV7KuZaCyBwLReDNFt48vmYr7oiNaWK31Vfdtq4wLmTki
         owUg==
X-Gm-Message-State: AOJu0YxoqH/t8CnvHu9dBDXyJrsfqH8fZ4QfExN8g4C4b7ZUMbdG9YXA
	Fl/5PToQNHEYZnkrssfyLOapni74D5T4rbccZwxXIVR2Yq7dLtC6JeFHxQYxWi9hXNxX2B2cbPc
	A4fDe
X-Gm-Gg: Acq92OG1+UgxOjqSOdjz8r75Ho3FsCY1atfoenFeo6n8na5CDjDb700ciJKwyN6yO8G
	2muUjBfn8Ze5w4/SrkozA67GSJ+LpOmm2Sd+T/kKRDx7MYI2iZSBvLKDkVgpya7ihNqjTW92E3A
	YPXlCESThVQyvCoEdziAXDQhcNGdQJvgsORlSq3/lKKDoA32zBoG7YujIqcSYIGg3eQXgwXWqlP
	aXfCKOn2eKP5sWesGe8NOjHcx8Xo2PF3uHWxQ7meutMo2sg5Ta5nPqtEJayYTtPRPwiGKOzZgsL
	aG1RDs7KepZaSwnROekSn94tyI89Mj6X/DpxROkbm2duyJaQSnP/uJuGfz9BFlETbvRlyJsttOC
	AUou1ug4PqcMbRFjEH4UPV53TGR/cJ9YFl27ckIWpvXRejoHDK7XII6a9fhHh3XjQ4uMxBWXD4E
	vbL6HNlRMCgwmreVslq10pXXt95p9gXuUfBt6yynuXxtkcid3zfGnl932E0KwubMAbSCdcrkw5t
	oxXYUkn1ioP31x21fQ4szbLoKY40daKBMTLe50sFlMRpmLYRw==
X-Received: by 2002:a05:600c:a117:b0:490:c2a3:3302 with SMTP id 5b1f17b1804b1-490c2a3336dmr59694645e9.35.1780697564319;
        Fri, 05 Jun 2026 15:12:44 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00b3e1ccc1be2b2798.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:b3e1:ccc1:be2b:2798])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcae2sm30770393f8f.6.2026.06.05.15.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 15:12:43 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [bitbake][scarthgap][2.8][PATCH 4/4] fetch2: Unpack RPMs with --no-absolute-filenames
Date: Sat,  6 Jun 2026 00:12:28 +0200
Message-ID: <37beb06ba9329cd16976273efbb341f781d4e749.1780697470.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1780697470.git.yoann.congal@smile.fr>
References: <cover.1780697470.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Jun 2026 22:12:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19625

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
index 7f6cf8ba9..f2835397a 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1563,11 +1563,11 @@ class FetchMethod(object):
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

