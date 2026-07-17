Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E84C44507
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 09:53:06 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10210.1784281976743165822
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Jul 2026 02:52:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=24X5IcLT;
 spf=pass (domain: smile.fr, ip: 209.85.128.45, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4954a752718so3891835e9.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 17 Jul 2026 02:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1784281975; x=1784886775; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6zClpAbGqp9+fH5brpHD8L9MfHTa4qNlwl95aREuGlk=;
        b=24X5IcLTq6o6lcUMQ9b9uLkA6n/UNTTJXcAWIB3iw3UWuuJOqG8WlhbDIcdSensVAs
         +/5gRY7/YtD3g5jW84gOmkmwF+n5q2vamnpJodzbL9i7t/6lcdQzNDMCHxc92OtNt47s
         Dg2SXdtuMdZ3g9AkSnd6KkS3SE7/dL9dL4DQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784281975; x=1784886775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6zClpAbGqp9+fH5brpHD8L9MfHTa4qNlwl95aREuGlk=;
        b=r+Q20G+1zyy2dWS59nBt+V1SbBtu8Pvyog+HT76Yoi5w8OD1si5vfYsfucRrnOxPSt
         Yt6br8HcBTcfrH/TM5chvU8/UBFjQKxV4BCBPncNkBpKd79Drwz/FC/uKmUdNW9G9WW/
         eAikfZD5y/VjzyXVGhCF3/+SBsw02B/38miZ1FYRkU4rHJXhRuxgdyA5nfdpgsueBFnz
         aKhRSAYmrUki2Zfv+dDLma5iSKHNhBb6LHHi6nCCa9kJBBESg5xX2Hhhlz5/U7YRhfpb
         5OhK0ER/A3BtqBApfC9GxfJczdqU8LksY4jbqnKGDba4Pv0ZXA+bF30++2Dh5oMPw+8t
         eosQ==
X-Gm-Message-State: AOJu0YyDj8AP80u7GjuPhDSx02xtsTPHMHMaB87entYgybuRo8zxQuHP
	HMqEcWm8cVt0a3DB3izbOVB3rYU8u1DHA+CWRFa+2fpu0McJlTebXE0TPLaJiKVAYdjsH0TcoS6
	vU1rb3/E=
X-Gm-Gg: AfdE7cmutPA4A9W/UxXx0E8pS6Eios5iU6Znk77osYI6/sxHsu5zI2cKzhTg1GY3fvi
	iL+0SEhByvgezbkEIaVjLNUOIvj+7fnLFG3bsvWi2mlAwYdSP5GE0wwtoUoFF49bhZofN22vH2z
	lc8nLYLAuzq2+5nJRtPEQxX0MiAPj0WnIhU/GLlRkwavlDPpMuYWHFlmmn6rzrkxE4PD7dXxJ7o
	VEF+BwlAK/6HN7u6xAHDqmouTt8SVYF63qKXfQOY6DReuzd80hByo1ENcAaaC7NtS27nyKA/haA
	q7fFH8E1mijEFK7wnebS4GhIB8sNjcpFJ/LCkjRWORcIVapDX4JtlNM5wk3zde6mxGJyvcBi6PK
	eI0UTuxGXQhCi4N6T1WO1R8iHCXIbPuvskfL732vgJhIDBRjz+2PLaMjM75a0Ubd6BIZgCtJ2v0
	pG0BMbf0mA+3ylw1Rp2+3JkiKogT1O/0juq+iHO8Cm49HaCYnSjvmUq2XKeLav6QSfgavUBwx8s
	vqxQJA=
X-Received: by 2002:a05:600c:3153:b0:493:e97c:216e with SMTP id 5b1f17b1804b1-4954a41382fmr25180915e9.39.1784281974835;
        Fri, 17 Jul 2026 02:52:54 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa0093f4151e9fe9f4b8.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:93f4:151e:9fe9:f4b8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49549c9c929sm32932095e9.12.2026.07.17.02.52.54
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 02:52:54 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH 2/2] utils: Add NFS EEXISTS/isdir failure workaround
Date: Fri, 17 Jul 2026 11:52:16 +0200
Message-ID: <fae9db3168dbff1b8c76fe9c6726a9687ff97514.1784281828.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1784281828.git.yoann.congal@smile.fr>
References: <cover.1784281828.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Jul 2026 09:53:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19843

From: Richard Purdie <richard.purdie@linuxfoundation.org>

We're seeing cases where we see tracebacks when creating directories in
SSTATE_DIR on an NFS server. The issue is that we see EEXISTS being returned
but isdir() is False, likely when multiple clients try and create the same
directory at the same time.

This is likely a relatively well known issue with NFS's attribute cache.
There is also a way to clear the attribute cache, which is to call
opendir() on the parent directory. That is what this workaround does. In
the rare case we're about to fail, try that using os.listdir() and
see if it helps. Testing showed that it would "fix" several cases
where we'd have had failures otherwise.

[YOCTO #16351]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 3a99c26fa581d70ed67bd08a5e0e0d0b18369a7c)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/utils.py | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index b04ff6ffc..a91bebf5f 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -944,8 +944,20 @@ def mkdirhier(directory):
     try:
         os.makedirs(directory)
     except OSError as e:
-        if e.errno != errno.EEXIST or not os.path.isdir(directory):
+        if e.errno != errno.EEXIST:
             raise e
+        if os.path.isdir(directory):
+            return
+        # We can end up here if there is a race between two mkdirs on an NFS mount,
+        # which happens more often with sstate that you'd think. The server returns
+        # EEXIST but the local attribute cache is out of date. It can be refreshed with
+        # an opendir call, so try that (via listdir) and check the directory again
+        # before we really fail.
+        os.listdir(os.path.dirname(directory))
+        if os.path.isdir(directory):
+            return
+        bb.warn("mkdir: %s is not a directory?")
+        raise e
 
 def movefile(src, dest, newmtime = None, sstat = None):
     """Moves a file from ``src`` to ``dest``, preserving all permissions and

