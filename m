Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A177CAC582
	for <webhook@archiver.kernel.org>; Fri, 12 Sep 2025 14:10:26 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web10.17668.1757686219904898553
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Sep 2025 07:10:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=tAV3XOaL;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.177, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-251ace3e7caso24884855ad.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 12 Sep 2025 07:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1757686219; x=1758291019; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=b9JaZGQ47aJpZb0wy0CriV0TL0k/momOdaGkw7/a1Xs=;
        b=tAV3XOaL+uOMvM3NF3ddUq7OXbO2pwOSh86w7+br/WERf7bVb3qF/E5+o9CDtBd+23
         hsGc+v+D5nd5EQkbGWiTYwhXt3WJhrP6GJpjeARpKvZI3amt1jhP+hbUGhl1nuc96iQX
         A8H0LbORom/J1eT4BHspbWxZzSXG6uDDvhCpedLeCbaOO52SzSDWwOqQeWDDQXJMyODi
         /sS+K7uDcPdlapO3lsGB+C3+jkRZk1O3VfcT0YWICLm/yzuaOkwsA/aNskPADXDu9Svr
         7P2h+SROCJstUNhv7J6f6GSUlUtRTUO+eMaLkZzVJWA1qUYJQ8Irwj8tnW0eq+zsnhfH
         tysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757686219; x=1758291019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b9JaZGQ47aJpZb0wy0CriV0TL0k/momOdaGkw7/a1Xs=;
        b=LV4nAn8ghQN6v0v/QmdKJusg+6qZBPrBh/r3+wvt2EXcscwOouEgO5hj1k6ZVUddW2
         ez6B7HtBTjIDuietUeuYYuj0a2EmOb4zlN5m0Q9IuNJTyzn6u8HSd7akuCdenrRBBCd/
         nHFKYaqCQifDQhVm2pH2OGw8G0JqUlQ3FCVW1/4RyJJtnctew/RU4Xf2Q1ZLRYjXA64E
         cNTN7Nf8wYBybx71ho1V4WZNwz76qSFfqzgtgJjYa62BYQbT1FZIA6yMHyaPfL+z+yII
         9XimFamzV0yVBkvcf/01PAK2dRn/dDv6do6/kc9WVBP25JePQkYMY79a+huOgCZH6yc/
         6Rcg==
X-Gm-Message-State: AOJu0Yxfe2sy8Fjeh6zv0GnfEhRTD+wUdrtP1TMAWpEB3uMCsg8RGe0S
	psUhnMPU0f6uHm/184Ih9gUl87UUF3E9TCYa+mvbDRND57rtzK0DwMC0dwpekfCcRkun+wJiEh7
	OzucK
X-Gm-Gg: ASbGnctpui2RrZknIvjYxwa8voMZyy0PElq4bMXLjM/h51nK63d8eri40k3JGrGuMNa
	ju8fxrT7BKUAu118rEop2UnhGD1OV1PzlgB7ZusS5Fw4tNq2CCe6urMD3hvOySZBQtoXOwdUzwb
	WrjbUpxkUAIiQN6WymI3BnDd1g2fid2O+AuqNqjuCUfRYJZk1mH/3rd+6ftXbDbPaG54vWAfSEh
	oz+ac+HYJQTG7UK0AuB5enXSCoPH9pg/6JyHHGW5RTJQt9SMh3sg8jGJ5WVYETMizWQ7v1NrQDj
	/2x8JntlMMxkQTp4jZBZjp7phGZfOAivNSRCl+DJW/FPTj//OsCKQBSp1ygv3589pXxORC3OoYr
	MVp2HuJuQFM2nhcWJjxcWP+b6
X-Google-Smtp-Source: AGHT+IHrBa+xG81RZMQjeOF+4HC2exSg4EFuiT7Wj5UENuX0cok+u5Om5FZwJTqX8wi9BNu8YjQOKA==
X-Received: by 2002:a17:902:e548:b0:246:e230:a99c with SMTP id d9443c01a7336-25d24ea163dmr34146425ad.20.1757686217671;
        Fri, 12 Sep 2025 07:10:17 -0700 (PDT)
Received: from hexa.. ([2602:feb4:3b:2100:5e34:462b:e2f0:5898])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25f4935db09sm5354005ad.61.2025.09.12.07.10.16
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 07:10:17 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 0/3] Pull request (cover letter only)
Date: Fri, 12 Sep 2025 07:10:11 -0700
Message-ID: <cover.1757686167.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Sep 2025 14:10:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18011

The following changes since commit 982645110a19ebb94d519926a4e14c8a2a205cfd:

  utils: Optimise signal/sigmask performance (2025-07-31 09:21:27 -0700)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.8-next
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.8-next

Bin Lan (1):
  bb/fetch2/__init__.py: remove a DeprecationWarning in uri_replace()

Joshua Watt (1):
  Use a "fork" multiprocessing context

Martin Jansa (1):
  bitbake: Bump version to 2.8.1

 bin/bitbake                        |  2 +-
 lib/bb/__init__.py                 | 30 +++++++++++++++++++++++++++++-
 lib/bb/asyncrpc/serv.py            |  2 +-
 lib/bb/cooker.py                   |  2 +-
 lib/bb/fetch2/__init__.py          |  2 +-
 lib/bb/server/process.py           |  2 +-
 lib/bb/tests/support/httpserver.py |  4 ++--
 lib/bb/utils.py                    |  4 +---
 lib/hashserv/tests.py              |  2 +-
 9 files changed, 38 insertions(+), 12 deletions(-)

-- 
2.43.0


