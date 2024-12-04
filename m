Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E746E77170
	for <webhook@archiver.kernel.org>; Wed,  4 Dec 2024 20:33:56 +0000 (UTC)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
 by mx.groups.io with SMTP id smtpd.web10.25354.1733344432238301197
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Dec 2024 12:33:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=pFvUxXYF;
 spf=softfail (domain: sakoman.com, ip: 209.85.215.179, mailfrom: steve@sakoman.com)
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7f43259d220so136617a12.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 04 Dec 2024 12:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1733344431; x=1733949231; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FjL+ncbBx2u9ZdZksX+ANMOeqVtYoEy5f8mOcfdXBfI=;
        b=pFvUxXYFLAEq/wbQLrwDw8bAFSVw9ODR1quuddnm6L+iSSUNFuvVAXcKL0vc/kYzIL
         TBaB5F0fS/t2x7RYBApsbkIC36T6KM5g1udlrB8ZV6Zedu6ceGmNdwo4d4YIVepuKui2
         FrY8t8FfqxpEFVN4jFLTPdaR9BVDnxpAgxMbaK0fTvry9Nrcn7yOmyrTFd3JamIg+VY2
         5//aa7ZSxBb50i6QGJn9nVG0DCUCT0oqQj8/NI+VKRslu2oMOrdFigioQzd6VV5/rLyd
         zUrfEQoMAbJSQQA4upL0tgvy3hj313zOLITjPyYAm3mUO1vCfEvoJPWa1BQK8cD38axX
         6OGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733344431; x=1733949231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FjL+ncbBx2u9ZdZksX+ANMOeqVtYoEy5f8mOcfdXBfI=;
        b=dw/QgHpwI0taqa4RN9QVpfkQS4BCoTWoFDPj1xmNwZNZNTtxBlv98LYJw+zdRCYAhb
         V9lTO1jtBYEFJIcqT7Rz6x3+U68D8LYWLbDGLkX7OIpeF1J46FlVuT8XMEBhx0Yfs2LW
         4IXZtFb7g1CdFQToDWzFmdR12r7KN9vP5ZQ7xqBSMCnf8BT6CepgN6oSjVDZCAkMgMlD
         APLRzr49xMHu/jEgHmaCwno6AOWnq5/IucPZl9E0VcrH0LP+fv/yqk+0J1ufHKXdr/2H
         FuWWZTOd6gNfJmIIj6JTneq+8TTeIKdQU1QE6z4Nd6JzHlbybAflon+yU2ymLNVw76ZK
         mxoQ==
X-Gm-Message-State: AOJu0YxydD9OrabdC91rFGJDyyoBte43Y8nSZQM9l/GJ4RD1MvselEQ2
	VKH4NGoT03elvfiZWQmEK+TbqPRBCUd/V/5U/UOHQMQNODe4+wk4JzOkvbqD2Hubsd8+5SAiSPp
	2
X-Gm-Gg: ASbGnctvLQ9aSOXTlEwjMPfnSUJAc0qSAp4RlBQgyY/M8KXZBCKjQj/WPO0SsawMTSU
	wgV4K17NImlGJeLnqCCQq7bjLcpL/N8xOlsaBCs1Vf5bqnBZf8xrRx1EpJti3Nql7UmMVNUPMP/
	mH77UNtO+B41vCT0M87m0y1J/HF9VwI69gyTiNNxF7MsY4kxF9RpxIscgtceFDWZqaEA+2oqUXJ
	5nTNqtNZd+a/Waei9v3vZy/lR7C/hpwxfC+hcs=
X-Google-Smtp-Source: AGHT+IELdOKYixTMwUktyUc6sF4D7FYf/dwlOlfrjMWDIMlVDnJ1kQhK+SiPeP4wtsDZ0HZP94h/uw==
X-Received: by 2002:a17:90b:4c4d:b0:2ee:b666:d14a with SMTP id 98e67ed59e1d1-2ef0120f386mr11730645a91.17.1733344431583;
        Wed, 04 Dec 2024 12:33:51 -0800 (PST)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef27062fa1sm1873984a91.45.2024.12.04.12.33.51
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 12:33:51 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 3/3] runqueue: Fix scenetask processing performance issue
Date: Wed,  4 Dec 2024 12:33:40 -0800
Message-Id: <f40a3a477d5241b697bf2fb030dd804c1ff5839f.1733344286.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1733344286.git.steve@sakoman.com>
References: <cover.1733344286.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 04 Dec 2024 20:33:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16872

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Analysis shows that "bitbake core-image-ptest-all" spends a lot of
time in scenequeue_updatecounters and much of it is rebuilding a set
which doens't change. Reorder the code to avoid that performance
glitch.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 923c19b9713e398d8e66e6d4422dfd4c18a03486)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/runqueue.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 75aef96a0..439da2bb4 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2759,8 +2759,12 @@ class RunQueueExecute:
                 logger.debug2("%s was unavailable and is a hard dependency of %s so skipping" % (task, dep))
                 self.sq_task_failoutright(dep)
                 continue
+
+        # For performance, only compute allcovered once if needed
+        if self.sqdata.sq_deps[task]:
+            allcovered = self.scenequeue_covered | self.scenequeue_notcovered
         for dep in sorted(self.sqdata.sq_deps[task]):
-            if self.sqdata.sq_revdeps[dep].issubset(self.scenequeue_covered | self.scenequeue_notcovered):
+            if self.sqdata.sq_revdeps[dep].issubset(allcovered):
                 if dep not in self.sq_buildable:
                     self.sq_buildable.add(dep)
 
-- 
2.34.1


