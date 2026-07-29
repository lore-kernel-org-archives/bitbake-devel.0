Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FA0C54F5C
	for <webhook@archiver.kernel.org>; Wed, 29 Jul 2026 07:57:57 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6437.1785311868975892284
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 Jul 2026 00:57:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=hpKqS5FF;
 spf=pass (domain: smile.fr, ip: 209.85.128.46, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49550ec592cso11314575e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 29 Jul 2026 00:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1785311867; x=1785916667; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FHn3QuK8lFeOJ+WqtlC9F0ia2MuWgClUScatM174WSE=;
        b=hpKqS5FFvK3HA8b9GlqnGaT4HmNAsxztXdgLcAYxdeeh7NC5638G95vKJyy5DMAQIP
         swWswTJTUfcMOiOO8UjO8md/CAKgANVqSUAWRi2cFGYH//KVgLRH22P8Anc2R6OqRsc+
         yaHXzYVrV2fvd+khIuFBYEMCCnWnatX7wmQ6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785311867; x=1785916667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FHn3QuK8lFeOJ+WqtlC9F0ia2MuWgClUScatM174WSE=;
        b=cCOUGVrWEDWL7ILqYuCe7/mQwe79IKWkZxA4+EZl8/ynw8VskCOOLigiOxixJjJ+XN
         DglSmH8/z6M4+IYQQcd+XXcgN6zUbhB16A2PdsNE0MFfLIqY/LhYEz889+portS9JztB
         iwR2d4NapArsM175OFO1KbgL+NpYq3CLKoesFV6q66w0j4gw6B7i+2kW96fPzM+hs+Yt
         6yEK1KHo979yB/GxNzLIChyuEQ8qLWwio2ZK1ciZ6oziMNv4/fJg9+0Q/dfU4WAzazuy
         Xb5ES7v79+5MzHugojZhMV4znJVODDcAc5BbL2l8SLv356G+8RVMiK+EAoyg2b77Ax2i
         BVkA==
X-Gm-Message-State: AOJu0YwgEkA2ukAtagtIfAN99cQEbl6TBr2WpEnbi6Bs7LlXc+SJBM45
	mbUdZq905c9OxOhHq/TDZWGhCv7FiiyUAP64/ss9JLGTq26ER+efsJU4V5x51hPfIezskbFE020
	smHZ/MW8=
X-Gm-Gg: AR+sD11SanzRj26EzdmFnU8sCJoT2mIBYIz8KveJ3GjhxVT8/AILSvh+7v5s6oc6CbA
	MREE6VWbdRibh3KSj67R4f/Kp2IlFvBS15lCJ9sO/R6gIswNtFpB3iNMdNueKVyo9iLzAWVhzmV
	uiZLRla68JW4Vuh62aKPtfzaWVJphs0tYnP3wrpOpXLJ2be+V64OL3F9alckokSXdXaETWs+QR1
	twPxTxuLssMllgAAih6/rHxryMvsSTrPjSTl44O1rX8kt9nhsurhims6EDyW+z7/sP0VFtXj4Ui
	lHdSaVZ/j1tyvnXj6aYk9llmRisa0QT7G4MtlgPBDxnq23w68yoX31cQV66Uc6okwHuJtcgDeD3
	/j8xhoYAhcr8AJeZVdGJZJ/f82q3CkIDoJ+QP6XMXB4oKOcsw4xs8D+j21HHPFqxGojq5Z5/M1A
	PN50epLUaRx598jIQ/Whb2qTOSuMTTm3PFA4JvRFvHFSZkSOoQOvsUwbeCu6TVCdbq8gzUDlKb6
	kGzhnVO+4MjMTTgH0iQvEY6puu0Kb6PGGTRF6QDNMbB7sND7+zjdWTtgZJrzBNK
X-Received: by 2002:a05:600c:4746:b0:495:3c6f:7c18 with SMTP id 5b1f17b1804b1-497fd2f50bbmr11998585e9.3.1785311867250;
        Wed, 29 Jul 2026 00:57:47 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49764d77970sm39189595e9.5.2026.07.29.00.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 00:57:46 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [bitbake][scarthgap][2.8][PATCH 2/2] utils: Add NFS EEXISTS/isdir failure workaround
Date: Wed, 29 Jul 2026 09:57:22 +0200
Message-ID: <cff3be6f664f8f07a40727ff63eeeb24d6f5e00b.1785311679.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1785311679.git.yoann.congal@smile.fr>
References: <cover.1785311679.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 Jul 2026 07:57:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19871

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
index 1b4fb93a3..976fe73bc 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -763,8 +763,20 @@ def mkdirhier(directory):
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
     """Moves a file from src to dest, preserving all permissions and

