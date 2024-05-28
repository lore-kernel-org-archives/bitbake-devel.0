Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81B8C25B7E
	for <webhook@archiver.kernel.org>; Tue, 28 May 2024 20:49:44 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web11.2073.1716929375886180422
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 28 May 2024 13:49:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=QKeP0bB6;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.180, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f693fb0ab6so1142252b3a.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 28 May 2024 13:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1716929375; x=1717534175; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nFTy0CLbNSIu1lN52M0iHaI2TEs+owbWGruA9ZWhonQ=;
        b=QKeP0bB6j0zfJ9WDKPiJ2JpI2IrfRigEWTlmWtddgQxV6GFB9bZRJL2KlnRhVLMkhL
         BM62H2nL2LCcrfQhVsbyAYI3stLVtVBWR7rVPVbzJ9gcowJEiK7CfaS/ZZTZz2JXomnP
         NJgeh+8NZREbacLmXCQWzt+j7hI9WX7pD6+D4fknXYO2sfINfoVPgbIItK5HxPoY488W
         0ftB4T4s2hMMPab9R9Vjw1FiBXdZ/sgQen6qLHQ8e34crDZ/0RZrKXiiaj/Qrbbxoyo/
         D/DdZCoXJY8Lke2OGO1x6yEtUAmfPbRirMfPlZ+grl7xrWwYZPHEpxT4I+Qm6/t3SDLm
         5Ujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716929375; x=1717534175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nFTy0CLbNSIu1lN52M0iHaI2TEs+owbWGruA9ZWhonQ=;
        b=SFd19uLnA2a2D/OxQCELciBXItwT+IIT3zF07Z0dj6KVLH9zYGIvR3sT/1cz5Hhzmw
         w1SGs4pj7ucKAcDl0ssRhUqKCl1UvrpqTHcMKf3g/bUywI3XJdTvah0l/2BsdHdN4GGr
         cMsKVoP9v2aIXl1qAoTZ4zW6Q+bMaWFORUC3nCW5H3TJx3y9fmC5/3cIY9I8cTUG3WEK
         FamD09PhuIhqQy8FnGDzOa4Kd/Yi/d7qbBkk4u/qGQuMKtBlG5SAq4Byelf91irJOeLa
         1NuYL8RXDuwcAeHYcgSw1ZWbxrYsvnQq4HygxWeas4VIi/ssR32F7ahSKRaTKlBOHtsx
         oZog==
X-Gm-Message-State: AOJu0Yy9P3YRsnLdpQAvuuiNR3R+kPtvi4qs4dml0EFQs7hA08yikaRx
	ZeG1VIxQ4zx6Dg+oFXe5csUSTby8gQG/0ijCc6c0iWxQoOKAonPiqIelxGOsKajmZcNAQS4jUhW
	E
X-Google-Smtp-Source: AGHT+IESuEy0xZN2BqeaP3fzETm9Au+xhDVfqo8yzE0IE289iJKd90VWxM5l/Gvc9W6SkkJzJx881Q==
X-Received: by 2002:a05:6a00:1c83:b0:6f3:8468:f9d1 with SMTP id d2e1a72fcca58-6f8f33b17e4mr12366511b3a.14.1716929375056;
        Tue, 28 May 2024 13:49:35 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-701d59b94adsm1371153b3a.121.2024.05.28.13.49.34
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 13:49:34 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 0/1] Pull request (cover letter only)
Date: Tue, 28 May 2024 13:49:31 -0700
Message-Id: <cover.1716929320.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 28 May 2024 20:49:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16276

The following changes since commit 40fd5f4eef7460ca67f32cfce8e229e67e1ff607:

  fetch2: Ensure that git LFS objects are available (2024-02-27 04:20:42 -1000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.0-next
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.0-next

Richard Purdie (1):
  parse: Improve/fix cache invalidation via mtime

 lib/bb/parse/__init__.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

-- 
2.34.1


