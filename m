Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780D7C25B75
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 15:03:00 +0000 (UTC)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
 by mx.groups.io with SMTP id smtpd.web10.16604.1716994972582957565
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 May 2024 08:02:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=cxLdWqcJ;
 spf=pass (domain: gmail.com, ip: 209.85.210.45, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6f8d2ec8652so1200059a34.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 29 May 2024 08:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716994971; x=1717599771; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CY/1giVLD7hy0N12O9MmJviWdrfIVIlVcv7nqeY27S4=;
        b=cxLdWqcJwhoIGEcQB3hZIiX7FkSQ9dfcsw5NRILc3uOaxbjRwKN6/h5k0o6iQkz9Sa
         IrEY5XDCIXyoHeg4EBWmIp4dqli2RfAoyBYIqzUmAAwBgqLkh75OiBc8s2l/4GvoR40j
         Qd5Nr+PRAB1L7fme46FnfQC9LGe4yR8qkR0Ahvfu00bma5blx7WRMutyRc2apGxHgrDF
         k6/Ia1HjDOjZyiXtffJll5OUF4HZn1tFsmc+i43WFPAN6hanabJC+Goda3RAmuKxtnGn
         owvqwdD3Q1eGZII96ZV0IYTUhUkc/lWQmi0CNVX/et+gIDcHxnxsQ06iXvSUkTzqu+uP
         X5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716994971; x=1717599771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CY/1giVLD7hy0N12O9MmJviWdrfIVIlVcv7nqeY27S4=;
        b=SkBBgQ+w4dB5lC11TrXH6cydRIJOpFnc8z4j2nbdBv9T4XZkPfMkb6snzAu0hPDfyL
         9QBeG78Hr+2kDSQGu+235V1TeRvls7Hu5KOwlQzR8iqOJj39wSZT/umIkndFVv15BGgC
         FSyJ1YT42FvxVuBn2JGSewrXlKk7KCcvJI13lQYE/BYmKB+K0tFa7ArFm6kW+OfIExF9
         sVVEfTB0bCYgFTdB17QHKIyjznwxOSRr+tEWonlYDdTBg2eU14x/B/Or88W/cQU7QPEv
         tBi1S6nhmdc7eFZucg898tV/1/8gd7m2PNdkcdAGdghLVozEamBva+lrBnaIEGQcwGxN
         hcvw==
X-Gm-Message-State: AOJu0YyEE4gAgC9DpTnim+KEjNwN0bdZdgZwf3Omtu5Wte3YkrPuqgyh
	AJkJDn180WsTxK+UhlGDsfrQzFd6Q9v/qdL+G9z7r+/h2OAXPGK1nogXOA==
X-Google-Smtp-Source: AGHT+IFBHYqNV6b/bFCTWW1UThDbITpIskPbpOgSWwaKsIa3b0ezRZKi61keLZB8Uitxyue/YQywXQ==
X-Received: by 2002:a9d:76c9:0:b0:6f0:4720:67c1 with SMTP id 46e09a7af769-6f8d0a80891mr14793448a34.18.1716994970626;
        Wed, 29 May 2024 08:02:50 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::980])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f8d0daf302sm2338944a34.20.2024.05.29.08.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 08:02:50 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH 0/2] Batch queries to hash server
Date: Wed, 29 May 2024 09:00:09 -0600
Message-ID: <20240529150234.3321732-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 May 2024 15:03:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16279

Improves the way that stream queries are sent to the hash server by
"batching" them so that multiple can be in flight at once. This should
help to reduce the round trip latency when communicating with the
server.

Joshua Watt (2):
  hashserv: client: Add batch stream API
  siggen: Enable batching of unihash queries

 bitbake/lib/bb/siggen.py       |  9 ++--
 bitbake/lib/hashserv/client.py | 87 ++++++++++++++++++++++++++++++----
 bitbake/lib/hashserv/tests.py  | 75 +++++++++++++++++++++++++++++
 3 files changed, 159 insertions(+), 12 deletions(-)

-- 
2.43.2


