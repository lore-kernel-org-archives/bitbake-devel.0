Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68F9D6B6C7
	for <webhook@archiver.kernel.org>; Wed, 30 Oct 2024 19:12:30 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web10.23851.1730315542164000343
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 30 Oct 2024 12:12:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=GnllNXl3;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.179, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20c6f492d2dso2352355ad.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 30 Oct 2024 12:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1730315541; x=1730920341; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pxp2MpxayvRDw9tTkxsyAjr2KQZDI6bfH9E3/iRMqok=;
        b=GnllNXl3KakLCuISdrEuMjQ8OBQTvYj19jdk3WnDPKV5lLRIIfL47oJgPwOAQSUqvI
         27A7w3oZQU2ciDxaLRXFJ9yvRyqbvZIGnToAKeffhx/9UhWE6nOBcxqqqLhrLwonEKdo
         cjGvFwexk/ec4iWmkW5evvIPEr2e16WNXfOu2M19o+7iZT8odFBcRPhpID9MULIyKdAI
         0N+Z/IphlW+qHIl7klujRglyR7J7iz3ClYDwwRbj7mYkLEk/RMEJvxQTy3hUBAF20xzh
         R56aYYW/vr1iUDO0HcWHT4JSE7Dg2EhehKj4IkS+9X96tDsAP9t/lnsu8/yXeiTbhkKM
         GsiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730315541; x=1730920341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pxp2MpxayvRDw9tTkxsyAjr2KQZDI6bfH9E3/iRMqok=;
        b=TUs9rkMp0rNf70wJyCqhVvyQoqFtpahXr6uH9kUomTnHJYrV7mKY4Jv530HjMFl31E
         1pBj3uixB8HFmgOLANpHlMiBo0oThB1JR6GQYF7MHUXSfTjD3P9J9TmFYlxcWbdVUkfw
         JHSynCB33jqo2h6dh1wXBbuvWT3J+nJLF8t5lCr5ZdzxD/splW7Sghi67aWnoimLIvtK
         JCS7+FWvBurqannbEsD1SFoHlid6p1KbNzMRJAYlkkmNUVl/J9QrOk5YmaWQxnuMpsAP
         O5fYJdpAT6s+HWn5UuEOvWh84Fq0t3l3XxUGNsd2muad4TX/So5w4D0OS8pAWrDSDlJ/
         +yzg==
X-Gm-Message-State: AOJu0Ywd8Ah9jmuVk0EVFtsiEwwGCNsuGO+my8l4D+GUTXQ+Jzc1Geoo
	BF+RZPKBuP7OGV3ON0Z4peV6w9bLzOOQPchbHS/YVciB9DXJ4R9eWtSStw6kZoy5/bzUMfDzHCE
	S
X-Google-Smtp-Source: AGHT+IFUqd7pQPZ6UepL9H+M5ijAtdEHtjDY2M/OeJ5xRhUc/DzloycuhhzKeC1V1SFhZr+cWQZSmw==
X-Received: by 2002:a17:902:e5c3:b0:20c:705b:4123 with SMTP id d9443c01a7336-210c68e3bb9mr195017445ad.21.1730315541289;
        Wed, 30 Oct 2024 12:12:21 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa36672sm2248203a91.14.2024.10.30.12.12.20
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 12:12:20 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 0/4] Patch review
Date: Wed, 30 Oct 2024 12:12:04 -0700
Message-Id: <cover.1730315315.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 30 Oct 2024 19:12:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16756

Please review this set of changes for scarthgap/2.8 and have comments back
by end of day Friday, November 1

Passed a-full on autobuilder:

https://valkyrie.yoctoproject.org/#/builders/29/builds/370

The following changes since commit 270c0c8bdc802c04fd3021c082d58cf8e8d68d82:

  asyncrpc: Use client timeout for websocket open timeout (2024-10-14 15:44:00 -0700)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.8-nut
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.8-nut

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


