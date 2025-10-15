Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C09FCCD193
	for <webhook@archiver.kernel.org>; Wed, 15 Oct 2025 20:51:26 +0000 (UTC)
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
 by mx.groups.io with SMTP id smtpd.web11.28901.1760561480132568749
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Oct 2025 13:51:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=nAc6hv0Q;
 spf=pass (domain: gmail.com, ip: 209.85.166.182, mailfrom: jpewhacker@gmail.com)
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-430a4bf6b6dso6762885ab.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 15 Oct 2025 13:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760561479; x=1761166279; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l7ONiNnFtse5ucZLNVVfANCpo/LArBj7TGdC3hvozYs=;
        b=nAc6hv0QvMsyeEQwkRAsBG1ZxUCVvhaUGVVtd3mF5y/sWQaKIXPr/DS/sygBYbWPGE
         PD0pj5+Z5JG5CI9JfOczRY29Zdjn6abjVr2kIEdymaprhlPTVF3Qmd0hrkPqF4GI6OgJ
         RWrW0SUet0XVp7kEYbr+YZtcfHDbHdRnG5XYucrM6xiXDWmRjy/FDc1EKpJgUf9gvCrb
         wODc7Uk6KbmOX+73I17u64xeLIJtuBi77ZFf2YqTI4YDILq47Qlo5enAloX8nC7GN233
         yN/vkW5RQqfPeuCcBYIczjKUCzGa6VIDjyXAOF4cNtJ6x0qmdvUy5lNSQ/ysmjNf7veC
         POwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760561479; x=1761166279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l7ONiNnFtse5ucZLNVVfANCpo/LArBj7TGdC3hvozYs=;
        b=Bew6z0a+C1y8dZdkGV/tNpGqcoWWNpRrGIj7i4mrLN6EfcTpvu1iXet8X6G8P6vZbf
         Jj9UsJRiEkr748p3f/MbKSx86xvOn11kCZu0ZPYe8GbEBMDtpeMoBpftBR5picUwfhUB
         7vbrdpi8y7XcA99xdzeMkiGhSvvIsqf+u0Oq0mk8H4B/USvIwh2IWHoQXZqIJpDej/bG
         Qzc7mi9ui4m4tqUud/N4xfn9pMFEQayzpmffhpTkyK1Mn+JWsfv0MbRNxCvCLw43k59m
         V44SDrEmOMoJWpVEVTn8LXqWsxlx5uUBnVe4uQ940tTuu0kPXtybXFgXgQJNdOAuDxo+
         +nIQ==
X-Gm-Message-State: AOJu0YxH0R+xQ/XEbJEJG6flHWOhQweED+9LudrbIsn9RpI2PhShvZjz
	577WRBBYqp91HKGbGktXkLxBDjaS1gOZ6stDhKqLjvFGTT7Dv+kNjhwth8/ZDA==
X-Gm-Gg: ASbGnctfHl16Je2GcXOdXHq8AOZj35z1gMDpcq7neok8UMQd33e/a0IqSDUnXk1mvpM
	yHwW0izywPUeV3oLbm2PH47LSI9lanBCAnyufYg54v5WnFUY+iPFLWmD1DRE1Q420cp/+UhNU3Q
	0lWEw6jmk7z1YIVq66LB7iqOh5ijAOuP2YnHrWv4V5f1kERoMk7vz55qY801iR33LnQFd4iCgfb
	8cq/4Z7ijq3WSb3/CFycuNmq6xPKLDALm3YJbTKKDu4L4ydlS7JZFzLgQQwGAoFwNCgHBySKpQI
	0Vpfb+VwuG7HKsdBMrBQujZIPJh2/G0YhV3J0NlBqc/Q+1e0zkLR4ov7BK9iSQ3+9an5PjCFgyo
	r9mgt196KQp0Dp8a9Rke/s1DvmjhugBXvLksGJQA=
X-Google-Smtp-Source: AGHT+IEsm0Gw0w9xaAuSpnF5+pTuTZ7QxZ/6ctgU8YIDpqrwBVt5dyfWfeXhxXOjeyi+NZj0rb8fwA==
X-Received: by 2002:a05:6e02:4516:10b0:430:b467:1af8 with SMTP id e9e14a558f8ab-430b4671e9amr14977035ab.2.1760561479126;
        Wed, 15 Oct 2025 13:51:19 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::4979])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-430b50b5672sm2928725ab.2.2025.10.15.13.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 13:51:18 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] contrib: vim: Update file detection regex
Date: Wed, 15 Oct 2025 14:51:16 -0600
Message-ID: <20251015205116.1547832-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Oct 2025 20:51:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18183

The regex used to detect bitbake files was improved in patch 9.1.1732.
Update the plugin to match that logic and fix a bug where the wrong
expression was used to set the file type

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 contrib/vim/ftdetect/bitbake.vim | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/vim/ftdetect/bitbake.vim b/contrib/vim/ftdetect/bitbake.vim
index 427ab5b9..1d958fec 100644
--- a/contrib/vim/ftdetect/bitbake.vim
+++ b/contrib/vim/ftdetect/bitbake.vim
@@ -14,12 +14,12 @@ endif
 au BufNewFile,BufRead *.{bb,bbappend,bbclass}  setfiletype bitbake
 
 " .inc -- meanwhile included upstream
-if !has("patch-9.0.0055")
+if !has("patch-9.1.1732")
     au BufNewFile,BufRead *.inc                call s:BBIncDetect()
     def s:BBIncDetect()
-        l:lines = getline(1) .. getline(2) .. getline(3)
-        if l:lines =~# '\<\%(require\|inherit\)\>' || lines =~# '[A-Z][A-Za-z0-9_:${}]*\s\+\%(??\|[?:+]\)\?= '
-            set filetype bitbake
+        var lines = getline(1) .. getline(2) .. getline(3)
+        if lines =~# '\<\%(require\|inherit\)\>' || lines =~# '[A-Z][A-Za-z0-9_:${}/]*\s\+\%(??\|[?:+.]\)\?=.\? '
+            set filetype=bitbake
         endif
     enddef
 endif
-- 
2.51.0


