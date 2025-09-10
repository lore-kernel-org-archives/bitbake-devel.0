Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FB7CA101F
	for <webhook@archiver.kernel.org>; Wed, 10 Sep 2025 16:56:52 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web10.24319.1757523405425596577
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Sep 2025 09:56:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=nSgpAmNW;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.182, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7722c88fc5fso6479687b3a.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 10 Sep 2025 09:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1757523405; x=1758128205; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b9yO81M5eJaSsNa4tXpscSOpU3GQgN58Bh9vwOf8Qhs=;
        b=nSgpAmNWa1G30co1TkejLDlNZCJ0dMcf2yePpffIXltpjwB3uk1F+vHiAspeqWAuYk
         IQAtf2Mi+k6+ng8eR3NuFEwAN4fV+3k6jA1kaZdST5z9Bo+WdwtpSLg69avn7CQqqIdk
         8Ve7BliOQmhywV0hnIWgc3hB+VbHGBh5MeeqSEi4tLds+gkpxhF6eBlJazx5ysTJ5Amo
         mTYp8+LWGU4zU5Fg3KvL4NlKYEvGiW+hWzm/B/8uR3XVUs2pvtuCwAHPkQ2zC3tIdSe7
         FDjV+Huf8wqjB4GVPkNRwqmURBrLwtc4Pj8I2ivpiAeCD8evJ0sY2FKA89V5rYm5NG1h
         JY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757523405; x=1758128205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b9yO81M5eJaSsNa4tXpscSOpU3GQgN58Bh9vwOf8Qhs=;
        b=Xm5qs9sqUJxLK8+O7sH0n5cbsQvPsTUCAAjQ5KAxCP/UbkXPlUBiRTmQaIxxLN/X1X
         tiKgsdHXzfwr7YwipqueecQ9ExA3Cge/xjkd8jodLjW+ycLbUNKJ77ivuOp3v4ujis4s
         sQj+C5xlhOJ/sxDr6W22guJZe4cFgBKRyjyF+3FvJuqBxOZ6vk04lx5ueYIAg1bFfjIy
         qTRulFNwofa4qey6xR0rPoZ1tOLfEDizCRlFP+tv/2LVF6iIw4ZVgxOFGikPMqgCgQ5f
         cZTOivgJ2mL8VPjgACk7JLebDHYBffcCjlVFGQ3RCOVoRGuTux4SBeDuHmJnkCsvf5bS
         7tOQ==
X-Gm-Message-State: AOJu0Yzkic35H03Fr7rz3zOVMF1D4zB0tybsHcui15Lwc+UgZSparcfP
	4OCxnCrW3H9+YxkXisSjP+drC4q8olw5BvTpCrhoUp1ILwTrdHVvJQcjXpyqHlFxFCe4jFyu4Ri
	n9bPL
X-Gm-Gg: ASbGncsrZwewBmCtGuJJUEqn/CpbImIBtflowbNjKcCKt82yrDe2iJYB1ooO5hQPvs1
	bHnWfOecBX6Q8GPzU95pR9KE88xXsg8whZ72keZxNbFnI3iwBxhKTyMy0uis/qriRYT1XaL4yrb
	ZMM3duhpNZdDVsKtDSXAkfBNkPt9fGB2goeSemgxOsQtfqrxU6vm55f3wGykvlho7KOrJj/vldc
	E/NNL+K39xVftUhagyyYK29IuVCW3KV3l7noBjwNLstdTjMpS3/+9Cw/VqMTw5sQvmnfQC1FeZP
	XHG5NjHe1fuE/7omcHQV1Pl9i2QqDt0Ll7iZIfo8jx6f5A275cnBx7cgjbN0IA9YiK2bnf11GSU
	auoIgDLDR5VFNmA==
X-Google-Smtp-Source: AGHT+IHh4h6rY9u9KPU0Tb7HgnFRYgOYeOb6xHSVAmg+EGbK2OFtDD8DL8ewNDRbYWVK/oeS2aHWDw==
X-Received: by 2002:a05:6a00:3e09:b0:772:59c6:433a with SMTP id d2e1a72fcca58-7742de8f0c3mr22879850b3a.24.1757523404657;
        Wed, 10 Sep 2025 09:56:44 -0700 (PDT)
Received: from hexa.. ([2602:feb4:3b:2100:5b33:a32c:9e59:27d3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77466118071sm5673608b3a.24.2025.09.10.09.56.44
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 09:56:44 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 3/3] bb/fetch2/__init__.py: remove a DeprecationWarning in uri_replace()
Date: Wed, 10 Sep 2025 09:56:35 -0700
Message-ID: <5bdc63d1647e21a530568c0635d95c17354a18db.1757523235.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1757523235.git.steve@sakoman.com>
References: <cover.1757523235.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Sep 2025 16:56:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18006

From: Bin Lan <bin.lan.cn@windriver.com>

There is the following warning when executing to bitbake linux-yocto:
  bitbake/lib/bb/fetch2/__init__.py:464: DeprecationWarning: 'count' is passed as positional argument

This is because the 4th parameter of re.sub(pattern, repl, string, count=0, flags=0)
is a keyword parameter. We use keyword arguments for parameters that are not positional.

Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 1a6ff25d4..7b75d5d83 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -460,7 +460,7 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
                 for k in replacements:
                     uri_replace_decoded[loc] = uri_replace_decoded[loc].replace(k, replacements[k])
                 #bb.note("%s %s %s" % (regexp, uri_replace_decoded[loc], uri_decoded[loc]))
-                result_decoded[loc] = re.sub(regexp, uri_replace_decoded[loc], uri_decoded[loc], 1)
+                result_decoded[loc] = re.sub(regexp, uri_replace_decoded[loc], uri_decoded[loc], count=1)
             if loc == 2:
                 # Handle path manipulations
                 basename = None
-- 
2.43.0


