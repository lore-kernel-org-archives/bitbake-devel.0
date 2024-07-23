Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E801C3DA49
	for <webhook@archiver.kernel.org>; Tue, 23 Jul 2024 13:17:22 +0000 (UTC)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
 by mx.groups.io with SMTP id smtpd.web11.43819.1721740641307043040
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 23 Jul 2024 06:17:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=lNrGv+ea;
 spf=softfail (domain: sakoman.com, ip: 209.85.215.176, mailfrom: steve@sakoman.com)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7a03ada9660so1593821a12.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 23 Jul 2024 06:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1721740640; x=1722345440; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RsHSmO+trcDLNcwLlCwKI+7g1bdriNVTN3YkC+Ay66k=;
        b=lNrGv+eatelGHb7KJm5o8gybz5AdxSVMTU8p9abPAvN5OCRERKj0AROBw3ARcfgmeb
         U7/hGQA2knPzXRSGiH0W3THjXGb89HcgBX/zE4hAQaGGeL653THIrultDfLEr8ZjlOzl
         vbjDow8kA0GAHBnfZ2JEycZ5rTW44RVibWjWwhAOEFBl1KtOCCefM8yUqK2a4MkNcT1p
         bknoNteu/1sGGnhIPT//8S86ZHJdOmTlo0ivGZ9bHZ0IopMNUFN1Rsg2ybBW+mOFqo0L
         HcxTJyCyMwIcpQuATYm8KeYoReCbCumi3pW7fvzZOXlDssCA9X8iN5w7i/x9bcJgD+Xp
         hV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721740640; x=1722345440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RsHSmO+trcDLNcwLlCwKI+7g1bdriNVTN3YkC+Ay66k=;
        b=hg6td/6JADnj7SGTL2FG/ONGKaI2y5qbe4xUHF4RZANbyJSVw2ClSfRkzROefiMcgD
         wOGI7Mwbivml4mzrQy1BUYJTfAX1goATVO4J2yvFv+KKzSHupE/s6r4BhL43cQ32ldew
         cpwyqwxpnHiNwlsn9TGFgcpNyMhxiA22Jo+rdJFqYpoxENv3NMYXezFSSx8ILGbJAma7
         nV76hxX2+ZiYvCA+5GEf5Sh7xGQgz+SxWDfmmFn+AIpLLRYMaepMQPzkcDs8Hb8sk5Ps
         tkUWT5qvdT6kcM8w0xMW7FPsJIleNpFZe3iiv4uen6XqFAgJuaBQg6my6d2Q4epj1KSc
         x6nQ==
X-Gm-Message-State: AOJu0YyMgLoAimr+wJsHFOC8zIPFLVP2ZH1l244eV9pAJNRP8s6uhNJY
	SKSx+sfEh7gnkT01P7Egwza+8HJTFUXEgTLQjpJKQ81zHiUEE63WYCN2eu4r4at+k7McqeeT69b
	j2QI=
X-Google-Smtp-Source: AGHT+IHgFKgUPhBcdGcSous9b3rKEJW25LLSqOx5x+S1OISB8Of0c+1AzKtaxILRTf46NcLOWPgsmw==
X-Received: by 2002:a17:90a:c68d:b0:2c9:8105:483 with SMTP id 98e67ed59e1d1-2cd27416869mr5953032a91.14.1721740640543;
        Tue, 23 Jul 2024 06:17:20 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb772c23a8sm10337009a91.1.2024.07.23.06.17.19
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 06:17:20 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH] Pull request (cover letter only)
Date: Tue, 23 Jul 2024 06:17:11 -0700
Message-Id: <cover.1721740520.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 23 Jul 2024 13:17:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16433

The following changes since commit 8714a02e13477a9d97858b3642e05f28247454b5:

  fetch2/wget: Fix failure path for files that are empty or don't exist (2024-06-14 08:48:23 -0700)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.8-next
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.8-next

Richard Purdie (2):
  codeparser/data: Ensure module function contents changing is accounted
    for
  codeparser: Skip non-local functions for module dependencies

 lib/bb/codeparser.py | 33 ++++++++++++++++++++++-----------
 lib/bb/data.py       |  2 +-
 2 files changed, 23 insertions(+), 12 deletions(-)

-- 
2.34.1


