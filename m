Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web09.42.1615937702580153642
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Mar 2021 16:35:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=Cyl3wKbm;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.172, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f172.google.com with SMTP id c16so17726999ply.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 16 Mar 2021 16:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6ZvpWkGdHx+YPc3gwiWdW5qUZ40g2zylMgPjgnC2xAM=;
        b=Cyl3wKbmMD/w+dEpMKhv/t64oBbYC/PxEH4cQx8YFhvIBsRQZfiO/MgAscmDDwKA0v
         vZt5OnlR0xVYucN2z3yyywkBEcH6mnCMlN/KaDC42Fw0/W114DvG4MA3h6QQTsQok39z
         VG+SjqvM0P0h+GMpdH8uKTWjSUxbCA8cRjGeNluyz0w15WQStPAa3LcWvL6LUukOg0lP
         DQM8+KCXyez8yiAv17U2mquU5aEAea21CkxWcv3n07gQn5c4cSTc9EMka6skoj7o7RjW
         FEpwZQYFh2FvI+TDn8eeiw6ZYhguWmqvyMlX91rjFGGwe6tn5HxHf21PrhjUBLhzc6Df
         vVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6ZvpWkGdHx+YPc3gwiWdW5qUZ40g2zylMgPjgnC2xAM=;
        b=iop4X1JwtC3Un6Dtv/lth8fZPPWTrLvbkDuPmkDq4QhCtTVLe1ls88f7T6+afEvgvM
         3paPi3DqYYhnPtw0dG/HjkV3krCIjX2HXPKLO4FUbUcULFyOHu/kZuSyAuQRg5ru7gmU
         7/lzR2IN0fhLkzV2Bf7vKN0s37o9STzuBLnk35B6XBBY60KPy2o+L1Q9TY+KbIcvGQHU
         TyCBUfYjXsIHy1XGxJU1gM6Cw7Qtxy7KPLv7gH2xGhNTkzM8Ogyh6RicX+v4VANn7jKA
         NCGU71kM0xt95w+zIWPHyiBCFgAdPLtLNeKu7M+nKjIwgelKvCWRi3eOqfjA5Bc+RFeR
         VH7w==
X-Gm-Message-State: AOAM533EiXrL5UoLQ/6PetTXEsG7lKhesy9hZbwvceEOp6eP4dg4YSlN
	6RuXM2bafPG2Awx6Wy8cUu4zhZn6Ev0Aphms
X-Google-Smtp-Source: ABdhPJw6oejsnHvRXJQbjeD1WRqgGyt6UzIDwUhRbeAVDklVg3JbWjIIJnhUAUuD/XnwxW1BJb2YoA==
X-Received: by 2002:a17:90a:2c09:: with SMTP id m9mr1469298pjd.3.1615937701585;
        Tue, 16 Mar 2021 16:35:01 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from localhost.localdomain ([72.173.249.164])
        by smtp.gmail.com with ESMTPSA id c12sm18766610pfp.17.2021.03.16.16.34.58
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 16:35:01 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 0/2] Pull request (cover letter only)
Date: Tue, 16 Mar 2021 13:34:40 -1000
Message-Id: <cover.1615937623.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit e0dd20a006ce6fdc656e6be6ac581e93e2ed4a95:

  __init__.py: Fix bitbake debug log handling (2021-03-09 00:03:26 +0000)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.46-next
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-next

Richard Purdie (2):
  runqueue: Fix task execution corruption issue
  runqueue: Add setscene task overlap sanity check

 lib/bb/runqueue.py | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
2.25.1

