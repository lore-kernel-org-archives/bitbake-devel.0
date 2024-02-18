Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF413C48BC4
	for <webhook@archiver.kernel.org>; Sun, 18 Feb 2024 23:00:05 +0000 (UTC)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
 by mx.groups.io with SMTP id smtpd.web10.29038.1708297204436394186
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 18 Feb 2024 15:00:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=H7eqMeS5;
 spf=pass (domain: gmail.com, ip: 209.85.166.174, mailfrom: jpewhacker@gmail.com)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3650b558a8cso6627995ab.3
        for <bitbake-devel@lists.openembedded.org>; Sun, 18 Feb 2024 15:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708297202; x=1708902002; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0j13Ez771e49kPSlQ0/taP4Oo5+z6D6Y8E2ZG+e5MMc=;
        b=H7eqMeS5roR5p6D8RyJGN6gYTTAm0YzuRnYdJNZ3SwQmm9y4o+KbmGsJmgR6sqrEso
         tIpGrJoPwHlVXEXiKpBFegnBx4AGxTGgpaeKARNDY/mDb/c3bhwHhL/1eleouaFzha+I
         lRn1xm/5NDS6KRabtuscDR2jJbWrhr0hRjwsvTRY+Zn6XleDmBwFObjudl4n61nIkzFN
         0Qu9k+N0gs80dx/7pxMyWGcT5bhyTF8YbplNA2eexplEdCuUxpxmmkYowAfiT/XiBszF
         lsom5c6fl/WUXTRvRh1y9q2sVRmT0j/BAXfV6/touJwpMjcJFsr87QOfm/WPBr938kEh
         Je0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708297202; x=1708902002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0j13Ez771e49kPSlQ0/taP4Oo5+z6D6Y8E2ZG+e5MMc=;
        b=SjbZJcxnCnjkeDjMLdTx5RAVJxARStbwLx8Qf0PVpE3TJPjD6uTsoVke4eGuZRLTpO
         +at7bbZkH204wraQbVmw1OZj/wW+UcYvsIRaAK9KAxI9fe7m0wsFfklKTFZSRywtnnmK
         kiwfIc2yw+lo/wfe4InaL2d4xQm8IinVGghvYiYYSg+c/aTzsLRxiPQLiIiXUPpWI4Je
         /S8pPhlfiqiz9+071Z2EVhQ1AixODgg7HlIApUbX0d6MqciBmd1i1RC7HSBo46epHBC4
         j25PRyvCn5otckGJjibSV/vsqpReEbeb+MGgSBrgGfGXHrOZxVC3OBC6B1h+qQ039Yji
         5bpg==
X-Gm-Message-State: AOJu0YyCQ1FubDbRgos9VIhVW1A0KP6N89Jds+tGZwAJWvQRjfmRMPz9
	kA0RelpiUZL525HsqnHetjViDtw9/V2qk5t6cytLmPbJFtTqIMUArXaWnFsW
X-Google-Smtp-Source: AGHT+IG1gV73fLi6nO7FgJQt3gNgzzU8JczUCyD/WbWMmYCG/xD+0ow1ZonJrDiVSBf+1aYOmoBkhQ==
X-Received: by 2002:a5d:9c0b:0:b0:7c4:61e7:9d77 with SMTP id 11-20020a5d9c0b000000b007c461e79d77mr13608723ioe.19.1708297202294;
        Sun, 18 Feb 2024 15:00:02 -0800 (PST)
Received: from localhost.localdomain ([2601:282:4300:19e0::44fb])
        by smtp.gmail.com with ESMTPSA id n3-20020a02cc03000000b004712a778fb4sm1214848jap.28.2024.02.18.15.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 15:00:01 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v2 0/8] Implement parallel Query API
Date: Sun, 18 Feb 2024 15:59:45 -0700
Message-Id: <20240218225953.2997239-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240218200743.2982923-1-JPEWhacker@gmail.com>
References: <20240218200743.2982923-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 18 Feb 2024 23:00:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15922

Implements API to allows querying if a hash exists in the server, and to
do so using multiple connections to the server in parallel. This will be
used to query if an sstate object exists before actually looking for it
in the sstate cache, which is important for e.g. on a CDN where negative
lookups are expensive

V2: Added some patches that were missed in the first series, and also
rebased Tobias patch on top of my changes, as it was easier than
rebasing the other way around.

Joshua Watt (7):
  hashserv: Add Unihash Garbage Collection
  hashserv: sqlalchemy: Use _execute() helper
  hashserv: Add unihash-exists API
  asyncrpc: Add Client Pool object
  hashserv: Add Client Pool
  siggen: Add parallel query API
  siggen: Add parallel unihash exist API

Tobias Hagelborn (1):
  bitbake: hashserv: Postgres adaptations for ignoring duplicate inserts

 bitbake/bin/bitbake-hashclient      |  48 +++
 bitbake/lib/bb/asyncrpc/__init__.py |   2 +-
 bitbake/lib/bb/asyncrpc/client.py   |  77 +++++
 bitbake/lib/bb/siggen.py            | 153 +++++++--
 bitbake/lib/hashserv/client.py      | 155 ++++++++-
 bitbake/lib/hashserv/server.py      | 164 +++++----
 bitbake/lib/hashserv/sqlalchemy.py  | 515 ++++++++++++++++++----------
 bitbake/lib/hashserv/sqlite.py      | 221 ++++++++++--
 bitbake/lib/hashserv/tests.py       | 320 +++++++++++++++++
 9 files changed, 1336 insertions(+), 319 deletions(-)

-- 
2.34.1


