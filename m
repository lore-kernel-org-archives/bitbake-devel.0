Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB822D6B6A0
	for <webhook@archiver.kernel.org>; Wed, 30 Oct 2024 16:01:39 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web11.18603.1730304094181843952
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 30 Oct 2024 09:01:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=KzNJyLhn;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.50, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e2eb9dde40so5489519a91.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 30 Oct 2024 09:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1730304093; x=1730908893; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4DBmqaKPtGUs54EwBaYlnZIum5SOxTvi2UpkjTI+7tI=;
        b=KzNJyLhn2iTO2TSpxosguUHDhN3mSCEAExLN5de0zhPRce3/6qNUt3sMnRWlAibX2i
         gjTylpmcVl6LbBS5kyJuQwW3x6RLnChqcx7l5aYzLFKmMem4I6ES63E2BcVktTi3Qy3o
         K6EvXBITrPQuugpXXfccar7FVHtRGFO1Su4nYMNG4tgIqdG/gfRpdhNqQJkYQ3onwuhW
         92lTK0XF3bTpQVTwuhMMpZuvau0TxJFk/J+RW0re9SA45f5DSbV0F+W1ovUWGpL5nwFB
         jm3kgkv/HxA4sf3r5327CU+alh/GVa7JKGlgtJM7hKbBlXVW9heZ0Up0Dms0C3k6dxF1
         TCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730304093; x=1730908893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4DBmqaKPtGUs54EwBaYlnZIum5SOxTvi2UpkjTI+7tI=;
        b=v6bZfHN34zdU2Onnsmsulgn0HKNt1kifT2j3qNrjBR9riv8npz7Pl2DbLGVzOzznhD
         k3zqyY+5cR0n/ukckOXCazf7h9/m4Bjo0TGyTZrj9Gtn45USUBcWWJy1VLSeULnyqZ8u
         LsubSsVkg0oHVpyKt35i8zxr9MVkat5SqLjAuvs8HDQdA4TQLj2gMqaSB4yKVqtKfX2j
         vgUd7sB/XDei+tdmB/ENvg0H6iHeXeU+n+Xp8VVjyE5tvWEEyCujlJlRtXZ0xmK6fUIe
         VwvWO2M/Km2Q/GnyibOIzAqyZNyAJjpHlgPVo/DBF3vtQftOGfbTafawYVk0uBhCthZj
         Hrqg==
X-Gm-Message-State: AOJu0Yzr4CxaFH64yqdqTB6vEqLJVwMLBnmlvHAUcez6nJ+k77hhFjmp
	Hoecefxuay7VjDUYG+tnHOSYwhLHOTFWA9ecym8gZZ5vc4VTkr56VJo6KkfxLslxY0IrJZDgvZ1
	U
X-Google-Smtp-Source: AGHT+IENQFoqvvC+hTmaFm1wWjAT8TTkrH1QUiTYu48hHFTssFYcDQ5QaD8FOVAeE/jIu3PlVv0TdQ==
X-Received: by 2002:a17:90b:3ec9:b0:2e0:d1fa:fdd7 with SMTP id 98e67ed59e1d1-2e8f11a9e27mr18190400a91.27.1730304093154;
        Wed, 30 Oct 2024 09:01:33 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa26a4fsm1911814a91.23.2024.10.30.09.01.32
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 09:01:32 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][styhead][2.10][PATCH 0/4] Patch review
Date: Wed, 30 Oct 2024 09:01:20 -0700
Message-Id: <cover.1730303370.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 30 Oct 2024 16:01:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16745

Please review this set of changes for styhead/2.10 and have comments back
by end of day Friday, November 1

Passed a-full on autobuilder:

https://valkyrie.yoctoproject.org/#/builders/29/builds/369

The following changes since commit 9ef4f2a30127455562e38e869793a723eed6c07c:

  fetch2/git: Use quote from shlex, not pipes (2024-10-01 12:42:22 +0100)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.10-nut
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.10-nut

Richard Purdie (2):
  tests/fetch: Use our own mirror of sysprof to decouple from gnome
    gitlab
  tests/fetch: Use our own mirror of mobile-broadband-provider to
    decouple from gnome gitlab

Robert Yang (2):
  gitsm: Add call_process_submodules() to remove duplicated code
  gitsm: Remove downloads/tmpdir when failed

 lib/bb/fetch2/gitsm.py | 44 +++++++++++++++---------------------------
 lib/bb/tests/fetch.py  |  4 ++--
 2 files changed, 18 insertions(+), 30 deletions(-)

-- 
2.34.1


