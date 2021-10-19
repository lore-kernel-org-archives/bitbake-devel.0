Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA041C433F5
	for <webhook@archiver.kernel.org>; Tue, 19 Oct 2021 20:06:38 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web10.15683.1634673997940284132
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 Oct 2021 13:06:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=FWWLckvD;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.172,
 mailfrom: steve@sakoman.com)
Received: by mail-pl1-f172.google.com with SMTP id y1so14472268plk.10
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 Oct 2021 13:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=AQ2MiKDrKxG4fYPuhKHQ0COzPfY8rybBeeRar91HEek=;
        b=FWWLckvDj3UhtKyt/ZLySSH9eXZ9FDWx0l0ezMnbA5dFhG0ZRpO+urBT5ucvFe5AqV
         qRL1uatgOMJpO2j/QQggsLkmFF2p18FbtCU1JVDoa33EIsMo9eRZkTHS/5YLoboPcoko
         JVwzH0PfZIP90i/bo7df+V1OQCsT+yy50xGqOyHYskXgtIE6JT5ykkunNSAINP7ylKXm
         F8dLqN27dMmoo8S29j6xMXKP2E7m8jCLIL0i6ACfKsnpaho3VUafc2Omeu0mC/8zRxm8
         PYsaCtl+0DB0QkdviJpOmgJvCxaJe5JEhnylbuMhhZsci30tDx4x2wkArD0xyfsYO0uM
         2kjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AQ2MiKDrKxG4fYPuhKHQ0COzPfY8rybBeeRar91HEek=;
        b=SNlfhHplPAZxxZcmU5IYa5jZSOVAaV+q6uuOB9O5BkxjcebhmbiQ0M5rTmK3PPBtj9
         K8X7FPznLnV0JHMsj2ydmSQ8cmhXDb4g/7yBjqCEPTvQFgYjXCbJVsERdC60HLa+uD7p
         ZUPSpZIii5+6eBQuyj9lfTFg4MRS4vM+BtPtCWd0xNaGP5F+RjER92osUsyS8YQ2fQFw
         +SteqPEIMw/q7SC12LKhPsEvjDdbIL91RuA6lpEy0mL8ly786mJkiWid2HJc82zngzuB
         9nMzVn6s3Fy0jjMP2V6e6wTwqiiaCsncEdZcwby/KbWQfuB2hzBISK4VsQoyfJOYmuak
         xwdg==
X-Gm-Message-State: AOAM533uIf2y7e0ceIQemAWosSNrenenzpzTQwAF+QWC6gbhT7DuVzco
	eOYpZk5FeGnfowLjaJZkEPirj7EEfucTgvLM
X-Google-Smtp-Source: 
 ABdhPJz7tDSCb4VVbdPfm9vXLbW1rriTHKi2tOd0xPhEUtMzX7nNf/N2d0E+pU94JmD1L9V+4kLN+g==
X-Received: by 2002:a17:90a:ee87:: with SMTP id
 i7mr2267583pjz.194.1634673997023;
        Tue, 19 Oct 2021 13:06:37 -0700 (PDT)
Received: from hexa.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com.
 [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id
 l6sm3533562pjy.23.2021.10.19.13.06.35
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 13:06:36 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 4/8] bitbake: do not import imp in
 layerindexlib
Date: Tue, 19 Oct 2021 10:06:12 -1000
Message-Id: 
 <f583bfa7895459882bb651e657bb21a4b49dca01.1634673786.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634673786.git.steve@sakoman.com>
References: <cover.1634673786.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 19 Oct 2021 20:06:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12806

From: Alexander Kanavin <alex.kanavin@gmail.com>

The module is deprecated and unused.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 76c9030d6c91cd776a1aa732fb92b7cd4539b503)
Signed-off-by: Justin Bronder <jsbronder@cold-front.org>
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/layerindexlib/__init__.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/layerindexlib/__init__.py b/lib/layerindexlib/__init__.py
index 77196b40..f30ee9e2 100644
--- a/lib/layerindexlib/__init__.py
+++ b/lib/layerindexlib/__init__.py
@@ -6,7 +6,6 @@
 import datetime
 
 import logging
-import imp
 
 from collections import OrderedDict
 from layerindexlib.plugin import LayerIndexPluginUrlError
-- 
2.25.1


