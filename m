Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DC0D6B6AD
	for <webhook@archiver.kernel.org>; Wed, 30 Oct 2024 16:49:40 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.web11.19868.1730306977264113774
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 30 Oct 2024 09:49:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=BqTA0HiX;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.181, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e983487a1so4787b3a.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 30 Oct 2024 09:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1730306976; x=1730911776; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hqtJAurG+hQ8UWaiX0XrC+akTE2KwvPE9n7/sd/Jhsk=;
        b=BqTA0HiX2Pmw+vTxS1mO61wT+DxTBeY9rUufi8XskwLgKAlQ+bEM17qR8ogYsLSoAW
         XPTi0douMGzElgC4n6ZAGTnW9Ojmkxuni9wccBatWQkrKJEEWKEWzAdtT6rplJn94R3H
         p5xRLOqp/vhaW+AuS+T42kE3kHoLtJTx39H0irkZ7HzBQdUStd0i22mvl/XKwH93MikB
         14Zvmsr3zKI7v9nQxzkSUU1UJrCAAQT+TASHV16Mw/fMJwUoXHIQjdu5fQLXoi8sK9Cy
         M+Ve3+nuX7CKtdGxMZk/7Xi7ldQIusxFIcuMUTZYOcVO9HLmO+kyi4fPv22Uu2k1oV/V
         xZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730306976; x=1730911776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hqtJAurG+hQ8UWaiX0XrC+akTE2KwvPE9n7/sd/Jhsk=;
        b=CV5glvX3D/bbxGdm3GYimjYVW5EAjKS0uszFri/GZxP8ERpDZKWknM4fXMngjoLU7U
         6Ml0ALPSEnN0U+1YHV5xFRjCSwcxEsLZKl+f2kKhNaNIOKeRMwD92paue+TRsaYE3jTZ
         W1CtI5WjfjBmsieCacDsXLiipCObXCDDTV/0sie0QYarc5YY0/0IbmwUloI2P/5/lv0g
         2SU0HDn53CnEmNSOWsmzkJNNfkqGh2UVWeo7ez8ygF1DaPoz/BLYdi/UafAw3HG3B1if
         cHf/2+P+ava88eGKe++N6GArbnmHWAcGlQ2xwww+GcY8iJh3+N0FbQ7WcxX7/r/ZeK5z
         94BQ==
X-Gm-Message-State: AOJu0Yz+a5iJvH+NkzZ53OJd3u9Jr0Bhs++khJp0/GpzRktI46I7gDgN
	qDxuoWEMPQVwJIfANIYBvbGnKl/4k6Uo9X/eN4PpGKQWUXUj6JpYzUfBsTxlj5QYTkSNETolnL8
	8
X-Google-Smtp-Source: AGHT+IElhuPVQGIoP+u3gvwRa0dfG/HVz4rlfSMErXYPTROjZ6qP/SPzQD7ipDy2ALC7RFg9OGI3Xw==
X-Received: by 2002:a05:6a00:3d56:b0:71e:5d1d:1aaf with SMTP id d2e1a72fcca58-720b9de1421mr428285b3a.23.1730306976459;
        Wed, 30 Oct 2024 09:49:36 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205791e49asm9466200b3a.32.2024.10.30.09.49.35
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 09:49:36 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 0/5] Patch review
Date: Wed, 30 Oct 2024 09:49:24 -0700
Message-Id: <cover.1730306845.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 30 Oct 2024 16:49:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16750

Please review this set of changes for kirkstone/2.0 and have comments back
by end of day Friday, November 1

Passed a-full on autobuilder:

https://valkyrie.yoctoproject.org/#/builders/29/builds/368

The following changes since commit 53264dc14554890b3a2afc83cb1749cf10d86854:

  fetch2/git: Use quote from shlex, not pipes (2024-10-27 21:12:34 +0000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.0-nut
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.0-nut

Richard Purdie (2):
  tests/fetch: Use our own mirror of sysprof to decouple from gnome
    gitlab
  tests/fetch: Use our own mirror of mobile-broadband-provider to
    decouple from gnome gitlab

Robert Yang (2):
  gitsm: Add call_process_submodules() to remove duplicated code
  gitsm: Remove downloads/tmpdir when failed

Steve Sakoman (1):
  bitbake-user-manual-ref-variables: update BB_HASHSERVE_UPSTREAM for
    new infrastructure

 .../bitbake-user-manual-ref-variables.rst     |  2 +-
 lib/bb/fetch2/gitsm.py                        | 44 +++++++------------
 lib/bb/tests/fetch.py                         |  4 +-
 3 files changed, 19 insertions(+), 31 deletions(-)

-- 
2.34.1


