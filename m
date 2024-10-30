Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E66D6B6C9
	for <webhook@archiver.kernel.org>; Wed, 30 Oct 2024 19:12:30 +0000 (UTC)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.web10.23852.1730315545502937394
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 30 Oct 2024 12:12:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=eSsbf2q7;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.54, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e2bb1efe78so156749a91.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 30 Oct 2024 12:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1730315544; x=1730920344; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q5ZdMEZnNDndoiECHv09aaVOYa6PzdQLXWVDWcyVpvo=;
        b=eSsbf2q72lMhPjYH3jGBZH+X/FZx8d3dJGKoS5/CIgsGfeeXQitajrCc6Tl8ELrS8o
         jaVSQDzhWwu+30xvvijHSARiv944YUwd2PW+4WJ9UaWC6yGVCPdARz8ePCA5+hC9Q5u+
         nRgY7hTR1DYIfwWdadBdPKAtOipio+3zD4ueJ3J0pjRV5/d+/Fcrp6aNtXdWTZ881nDe
         HHc8T2CNupPP1/XI0+JKNH5Ea+hTNmGEywl4FSSYdx2o9j5D6v3axNTZaRE9KiNfBwLb
         FuU4gyklEpUiO4n5fz4adva8wgEs6/OiYViqLHrgu44jF73t5BWGXZwKJeWDykuvkgBN
         uosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730315544; x=1730920344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q5ZdMEZnNDndoiECHv09aaVOYa6PzdQLXWVDWcyVpvo=;
        b=tmlmzsc2bwGl2129IsHy254kdOvVdKib974WDqoVCUsg2wXXBXmpE/UWFotGdtySwt
         p7T6KATeDEm20R1XefZNIFer0aG1BTdyj9FO9nOZCUFXcHL6D7t8w+m13s03unbccoBP
         7ZpA3/7ML+fkmco5AUDq4B3ceBmqyzVBykOjKvpWEozyDSJaoTWRTmVFpYncFMCMv+hm
         nBX65djEqzdsc5CwJTcGNjej9XwgWcHNP6POce6YK3u3om/10uy+FofCKCVbgmgjvoyl
         ZB8f6MUUbrxtLYAONG8j39gNC3Ic+uuK371sjufVmViHPB5PCxevaVA6iRE22bqr8KWj
         vMdg==
X-Gm-Message-State: AOJu0YxY1/UoCKxKDO768YyP7I1/zg0rSpPXA9GhZA4kFQHwRqp4RfsF
	y+3dtG2zYkp/7Lsl8xkNJVFuBJR+4t5K3dos17pu+UU18uK0zKEq2lUVzssaj+J8ioU7V0OXF+W
	+
X-Google-Smtp-Source: AGHT+IEfRQVWgYi70I9kCxBi8eL2teQrRCrUZI1je+m+udSOIf1d2BT8bPZ0IKC/2isk5iElky7qXg==
X-Received: by 2002:a17:90a:69e5:b0:2e2:af80:8f7a with SMTP id 98e67ed59e1d1-2e9224eaab3mr8693187a91.20.1730315544553;
        Wed, 30 Oct 2024 12:12:24 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa36672sm2248203a91.14.2024.10.30.12.12.23
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 12:12:24 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 2/4] gitsm: Remove downloads/tmpdir when failed
Date: Wed, 30 Oct 2024 12:12:06 -0700
Message-Id: <ee464103c971ca9a94cd861d75f69847a7956eb2.1730315315.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1730315315.git.steve@sakoman.com>
References: <cover.1730315315.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 30 Oct 2024 19:12:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16758

From: Robert Yang <liezhi.yang@windriver.com>

The tmpdir such as downloads/tmplp3cnemv won't be removed without this fix.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 2ba8d3214759142afc11f0a88d80eb30a8bcde3a)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/fetch2/gitsm.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 17aac6357..fab4b1164 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -152,9 +152,11 @@ class GitSM(Git):
         # unpacked temporarily so that we can examine the .gitmodules file
         if ud.shallow and os.path.exists(ud.fullshallow) and extra_check:
             tmpdir = tempfile.mkdtemp(dir=d.getVar("DL_DIR"))
-            runfetchcmd("tar -xzf %s" % ud.fullshallow, d, workdir=tmpdir)
-            self.process_submodules(ud, tmpdir, subfunc, d)
-            shutil.rmtree(tmpdir)
+            try:
+                runfetchcmd("tar -xzf %s" % ud.fullshallow, d, workdir=tmpdir)
+                self.process_submodules(ud, tmpdir, subfunc, d)
+            finally:
+                shutil.rmtree(tmpdir)
         else:
             self.process_submodules(ud, ud.clonedir, subfunc, d)
 
-- 
2.34.1


