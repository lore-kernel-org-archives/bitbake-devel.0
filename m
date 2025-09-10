Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AC2CAC58C
	for <webhook@archiver.kernel.org>; Wed, 10 Sep 2025 15:55:22 +0000 (UTC)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
 by mx.groups.io with SMTP id smtpd.web11.22511.1757519716066405131
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Sep 2025 08:55:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=viyUyWUf;
 spf=softfail (domain: sakoman.com, ip: 209.85.215.180, mailfrom: steve@sakoman.com)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4ee87cc81eso6371014a12.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 10 Sep 2025 08:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1757519715; x=1758124515; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9vRb76Vbh3tPvYpYjqC09OKvAfNgcnBvfTxsAH6Le0Q=;
        b=viyUyWUfHbNDYFaj89jRbj58EObaw9mmapnXY6nrnEXXuAL/g0V/KXFqk/4VDqr2yD
         gXlEtOnzKM+nafqN4c+xUk11US/umJm3VH+siU+9a0FU+OwOblVZs0RnGrLoj66BY7S4
         v2PBVid5rz3jl4IjaCy9LVMd2BdXYRhkK4zr1/JpTUPg9vcHjcXieXreQ0HFr2qyd4R3
         rsI3QTE2pI2PIMPMUrQvty1mF6Mf+oCJa5qXQr3+IeEJfAb6cP5C/K3r9q57BDIm+liy
         rnSX/95dTjiBTxMOAQ5DnEt1yv1B7PFW2lv6nxU55lqeMg50rBhgOM6KjqhDjGScXQbr
         t8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757519715; x=1758124515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9vRb76Vbh3tPvYpYjqC09OKvAfNgcnBvfTxsAH6Le0Q=;
        b=KahIBr/uw2Q1j8rKmoMkH3L9s2VqTdsT5YMWJdJrk9dSsLhys6/WkbvVZVNdSqXSVL
         6Y3f5yFB6eGaBYvip72vO39WHKTC+Sdx3N05xi9wNTnC6fRmENDK8TqqennFDlOge44i
         wHcKMhG05xincfTX+BZhq6kwnjGRe+6Hh9E6iN5X0StP6apeWj6w7VWclKsCAJ0ken15
         +IkBGFq3N7lvdNEn6uKoPEXJUW5fws8FHc5CVdfPPwfniQr8EazNOBvV9ANoIWQvRx0v
         lAmx0pPRgqiodENQIYFvkMOezGJH7ctUlc1aEPZqAztcAi1Dvi3jRsWYVpUzboN6Uot0
         6PRg==
X-Gm-Message-State: AOJu0YwWBJocOimC+2ZGs/BqtauZ21xBsb11x+WMKmtny16KW/DOI9Bl
	Psu3+36n0TqXrUaDNvo44i51XANbgIWhPxPmu9TeJMez4EfE1dlzoh2CXKHwB6CLxtxXgTVUHO9
	n6GUi
X-Gm-Gg: ASbGncuwewrNJq736+UXBeXq5+MiWeba/zb0wnWczPkk1JCqd9YcdbyhUnHEHw5b7yK
	RdVjQWT0prb2O+D1FSUYJCRa3hEFuQmuud2bITRAOUsRFUuk7uLQIO8vMm/nqABY+Yxj4vfcOID
	BnIMspB1BQWlONqvjW/Un+y2YLe15/y1h1OpLAjLJDnkx4ybmn2WCdqhw2QHT/1HNbxfkBKiFgt
	FoN8hy3TYxWHHVTyRAE82260rrPPqOAhCIHGkZYfkLc+Zx776BD921JF94j1f59yC/O9sCct+vC
	lBLY07WF/bR7M/uDDYj2BNn1J0t5IduNRGT33CyK4In6we+22oLQuGxm17vTGx+NmFnlByRD99R
	oHETkjL4+NjvH3opdQmVPrlGr
X-Google-Smtp-Source: AGHT+IHcw6XV9+CjqeDcBAaqkSy55fwGxoOk33/A5/Lm+zU8rU2Hui08+Eh/3kL77pZwbl+DMeQeEg==
X-Received: by 2002:a17:903:19e5:b0:24d:6f65:7a91 with SMTP id d9443c01a7336-25171cbfe5emr229142175ad.29.1757519715034;
        Wed, 10 Sep 2025 08:55:15 -0700 (PDT)
Received: from hexa.. ([2602:feb4:3b:2100:5b33:a32c:9e59:27d3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a2acff3efsm31211655ad.123.2025.09.10.08.55.14
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 08:55:14 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][walnascar][2.12][PATCH 0/2] Patch review
Date: Wed, 10 Sep 2025 08:55:08 -0700
Message-ID: <cover.1757519577.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Sep 2025 15:55:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17997

Please review this set of changes for 2.12/walnascar and have comments back
by end of day Friday, September 12

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/2348

The following changes since commit 710f98844ae30416bdf6a01b655df398b49574ec:

  utils: Optimise signal/sigmask performance (2025-07-31 09:32:00 -0700)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.12-nut
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.12-nut

Joshua Watt (1):
  Use a "fork" multiprocessing context

Martin Jansa (1):
  bitbake: Bump version to 2.12.1

 bin/bitbake                        |  2 +-
 lib/bb/__init__.py                 | 30 +++++++++++++++++++++++++++++-
 lib/bb/asyncrpc/serv.py            |  2 +-
 lib/bb/cooker.py                   |  2 +-
 lib/bb/server/process.py           |  2 +-
 lib/bb/tests/support/httpserver.py |  4 ++--
 lib/bb/utils.py                    |  4 +---
 lib/hashserv/tests.py              |  2 +-
 8 files changed, 37 insertions(+), 11 deletions(-)

-- 
2.43.0


