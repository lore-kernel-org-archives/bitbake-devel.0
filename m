Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40670CD8C95
	for <webhook@archiver.kernel.org>; Tue, 10 Oct 2023 14:37:30 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web11.92970.1696948648712564002
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 Oct 2023 07:37:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=b9esHZbA;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.174, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1c63164a2b6so49888555ad.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 10 Oct 2023 07:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1696948648; x=1697553448; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9iGnxi+U/N1gQvJXrcRsIj4elJKWyHgVjNq4ua6IPGc=;
        b=b9esHZbANcodVcL1o17t9JDNYwcc1hk6Lf+jE/6gvbmAd+lmofJbVwHJ/VcYc3K9cm
         Zx0efnimzbTIIrQnBeWfBUs1Cp0abxDU8ethwMx1p+i2AMNZtcKGHYilx9FaR/N0k3dI
         E7J3m4aljLOaAQkDE1zGiQ2QW0XMtjtHABm4me55ENO4QYf6RdApfCQ3ROLjFP1Lk36g
         Al7KgpzP4zgPxAK8RtNAodgBflIXODEiIcMQlqc5GIFLEvXc9Ji6S644pdKhyxa5s7r6
         qXBfufHBA2eVhJwfam+5MdVl5dPDtdpf2u934vqeVJOVWMclZfwRe9HcRPKh/ZAIcSqn
         jO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696948648; x=1697553448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9iGnxi+U/N1gQvJXrcRsIj4elJKWyHgVjNq4ua6IPGc=;
        b=qOi3Eh8XhX8/quj07A47Px3vWVEIRSLQfWzwmzUO6g+rUPBOAWWAo3KRgXEuVFeAOG
         J5eNx+YnMm7qFLH5dxJmKFv/GMsErmC76NgU20M7B/Q740pOgkgOzMeox8PSJD/ppIoB
         0xt62pZjTbiR2UoHeHgzxR+59BUJwgrQdQJ/O/pmM0sizk83TkNoU+o/56D5pgst39Fm
         xKMXDRU7FWR0FXnYGIVH9hfBUiILL0JKyz67W3ikiRWw0qgzMz7T4h0JGZaYmkicC+1V
         JhvW/MY8DVzmhzxezseH8nyVKhFmIcQUyNIypnrYliFUKQZJCrXma13HO3wdew5SPoa2
         WAzg==
X-Gm-Message-State: AOJu0YzVRgCthfosZXtXc19gcfZ0xpBQC1LzHdRa/6iOWtbkLoAeoYKE
	fExc6ZCLrjQaZHy941/o4ePzv7HtIZ33dkdBJR4=
X-Google-Smtp-Source: AGHT+IEVs4vSGi+sdMD4xCto3hqPfDS31971CJglb2imccXshQJcX9dM26FeMBE0Ay6w3N1C7TU9mg==
X-Received: by 2002:a17:903:228c:b0:1b7:f64b:379b with SMTP id b12-20020a170903228c00b001b7f64b379bmr26783296plh.17.1696948647770;
        Tue, 10 Oct 2023 07:37:27 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-234-106-30.hawaiiantel.net. [72.234.106.30])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902f54900b001c47541ecd7sm11843084plf.250.2023.10.10.07.37.26
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 07:37:27 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 0/2] Pull request (cover letter only)
Date: Tue, 10 Oct 2023 04:37:06 -1000
Message-Id: <cover.1696948240.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 Oct 2023 14:37:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15205

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/5998

The following changes since commit 41b6684489d0261753344956042be2cc4adb0159:

  bitbake-layers: initialize tinfoil before registering command line arguments (2023-08-04 15:39:16 +0100)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.0-next
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/2.0-next

Etienne Cordonnier (1):
  bitbake-worker/runqueue: Avoid unnecessary bytes object copies

Paulo Neves (1):
  bitbake-getvar: Add a quiet command line argument

 bin/bitbake-getvar |  3 ++-
 bin/bitbake-worker | 14 +++++++-------
 lib/bb/runqueue.py |  4 ++--
 3 files changed, 11 insertions(+), 10 deletions(-)

-- 
2.34.1


