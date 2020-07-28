Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
 by mx.groups.io with SMTP id smtpd.web12.1280.1595977149075355378
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 28 Jul 2020 15:59:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=IN+Utbz4;
 spf=softfail (domain: sakoman.com, ip: 209.85.215.196, mailfrom: steve@sakoman.com)
Received: by mail-pg1-f196.google.com with SMTP id l12so2057493pgt.13
        for <bitbake-devel@lists.openembedded.org>; Tue, 28 Jul 2020 15:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=iS8VnEHyiHUws/+0G4UpriBCPAUsPobILRXmvD6mIV8=;
        b=IN+Utbz40FL1knI1jR3gRFCKN+YQWY9SDkvkFte/JHivUS2zJTkqKyTelM5HPycK3l
         yFzH3QHztRPDEkbAUU06yjAUHefIbioHe33tmgTGlfBU+KQgYiB8UbVAENpZtY1B0g8m
         9qT/TsU8CMGiSSG8A7wqkGY4lCoz3J/5wdLLu/Msf7Ig/NdtAGVFNq4Q0Ju3nz83kS6o
         BZmHoMrMubPNfVdwtv3M4HuJTvov+PTliDk/HPwlk/fEp/moA5oZI0XRf61G1AkFch87
         +GvFFOgWSj+KOlZ2x/jgPcZApmuzKq7EE+yeGkqvdnjEicCofsL6aTMonY5Fn9ot0psF
         fFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=iS8VnEHyiHUws/+0G4UpriBCPAUsPobILRXmvD6mIV8=;
        b=uAX646/weG6kUodKS6xlAOzhctGKg5UPI9VRQ89zp8D+HQOnx88VrAR3WUfI9stCua
         Cf4exC2b6kwJf9OfFQ3aAOMI+WM3ad+NeOEUiZmrHdyGOzZiswn7MyhWirgh+c0D25w+
         IaI84YBZYSNKvVMYDFTVMZaRETurM3Yd83wLYx0TVb3GvVXlTpgJEjCBeqWzE+eQr4gE
         gCLh+g7D8wUHl0XuRTSk7+gBQP5vdh9rip0+/9w59JnDzhmIQzPuJb1NixSosQ+rFS+2
         nMAdYhal/A1sdsxGnmR0Lk1BUW1DECSe9WgB07Q+QaJv+AdtPj68HZwMp2umy6qbMQJn
         kOig==
X-Gm-Message-State: AOAM5316FYVYxlVqR1MH2cMM8OL0Y1esgDVhTk295MN2K3hItAXV1T8w
	Rqhh/RkXNPsuGxqjxwXysXACcL7MYyw=
X-Google-Smtp-Source: ABdhPJxf8fim9iCVN6/7nxCy3FABazkIrb2U02rP69zdbzWljEwFxrAOGMsuTNxV3OYEykmNzDm2dw==
X-Received: by 2002:a05:6a00:84d:: with SMTP id q13mr12954956pfk.167.1595977147770;
        Tue, 28 Jul 2020 15:59:07 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from octo.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id p11sm157658pjb.3.2020.07.28.15.59.06
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 15:59:07 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 0/2] Patch review
Date: Tue, 28 Jul 2020 12:58:55 -1000
Message-Id: <cover.1595977046.git.steve@sakoman.com>
X-Mailer: git-send-email 2.17.1

These patches cherry-picked from master should fix the toaster issue.

The following changes since commit cc11dfa4eb3616547a8a3909f89da0cc4f35dc57:

  cooker: Handle multiconfig name mappings correctly (2020-07-23 16:50:51 +0100)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.46-nut
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-nut

Richard Purdie (2):
  server/process: Fix UI first connection tracking
  server/process: Account for xmlrpc connections

 lib/bb/server/process.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.17.1

