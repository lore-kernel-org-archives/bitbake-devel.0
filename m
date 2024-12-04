Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E42E77171
	for <webhook@archiver.kernel.org>; Wed,  4 Dec 2024 20:41:47 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web11.25257.1733344901637228642
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Dec 2024 12:41:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=yIq2avwt;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.179, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2156e078563so1203595ad.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 04 Dec 2024 12:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1733344901; x=1733949701; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P5UjxKCeqORqIFtQI/GncQ99E6vfBAFKQY2Y54aSOIM=;
        b=yIq2avwtGInT/GD7QGbv5i5TxnytX0gDEPoDarmVcVh7a15PTgWde8WmqL7Z6aPcux
         6k7Z5FMwOt2IbI44viGt8hboTc9LoquvuEGfTJnyxDbzZ8bfULoibyOPIhEkV833fefl
         +w16VPTNxM9tK7SFpzoSU+I9SvLPpOW52DSLaSdOFMFmI93kEYiWCnt+ZWXfGdEjCyXt
         mZI2TjwQMj14xLAWdcHhnIjy65NLAmDnddnFEmG4JQWxzo5hThbV3bXnTclZzs/tfMj7
         48/dQjHZzl3x5KHeEwiaD+edPpIdcvjF5AW2bE2zD9P1Z2/oteUUHxWGNINVSeqnYHn1
         OywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733344901; x=1733949701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P5UjxKCeqORqIFtQI/GncQ99E6vfBAFKQY2Y54aSOIM=;
        b=rZpcU9be3Ke9FCb7WSsAgixjwkZ/4XHSI5Yxnx4KUhNtyoWUcGpkFa7deeKQecQvNE
         q3EA1y1ADAznzr9DufrytAu4m4n2KI0ILRjCek8lQ8QyZf21Brtbn1YUj2LGRjJzrb+o
         ngUXSAMSY0Tg+eQsJbtdHVEYE6Wte3DX6fi/EnpdbKbqpeB9yKx1dT/WeYIVihDEl8hd
         1f7ztqKjq7U/b8EFktjA4JfBKnRrf4YZbVvHsY8yfbcqjeeCHl95CuWiMiXeP84tUCQm
         o12b9TpUoyeLeaMsYln25qXxsQkZ6096HpFq6eySQhOeMnjkhjtSWYZcNp+EO+cOGtV4
         5qpw==
X-Gm-Message-State: AOJu0Yz80E3ortZ9upIbbIaKmOa9Vt2vAuON62TCTUFlzkjWfFcB2jnJ
	HKk2/zp/R/9pJStFrzRfeV4tfxeTsgO42C73HGqqu848hzSytt5PF66o9Up97N2r7uk6lANKwFu
	n
X-Gm-Gg: ASbGncuTc4LsyjoSh0jo2V0WTkyD5Z3Xxzr7AWd9pr0v39LxZfHp6s6EC4pfL9woKYy
	4HNSDWPFchhuHiP7vmoOVLiABcTUcFmJcJ4tGi7iU9EPhw2GaOOtXcTAkTkkdWbGLT7Vzg/2cBI
	eMdLuSH4SDvsQv8OgX5nRziGBXIOPM6/RHNm+pg/qLgfBIDcdzdA3iWKIzXVGyL/auJ5HFIq3ZN
	a++auq9+t1XulXcGf/Yu9cS0lHglW0p+1Dds20=
X-Google-Smtp-Source: AGHT+IGRWEgzyTmMLBlaYh7xOZSZCsZWMCMTVpu9ZjRw/owwK1kmRUeEWxE4MeSKZ6s5JbYilgM2Aw==
X-Received: by 2002:a17:902:ec8e:b0:215:7a1a:cb9b with SMTP id d9443c01a7336-215bd1cd7ebmr83075875ad.21.1733344900921;
        Wed, 04 Dec 2024 12:41:40 -0800 (PST)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2155abd92ecsm80057415ad.200.2024.12.04.12.41.40
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 12:41:40 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][styhead][2.10][PATCH 3/3] runqueue: Fix scenetask processing performance issue
Date: Wed,  4 Dec 2024 12:41:27 -0800
Message-Id: <1452e74cc4ddfaadc6537a049877a66cec253c8d.1733344775.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1733344775.git.steve@sakoman.com>
References: <cover.1733344775.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 04 Dec 2024 20:41:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16876

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
index b34e2d560..7f95140c4 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2756,8 +2756,12 @@ class RunQueueExecute:
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


