Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
 by mx.groups.io with SMTP id smtpd.web12.7814.1600314004700657456
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 16 Sep 2020 20:40:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=S/jrOk1k;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.66, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f66.google.com with SMTP id mm21so528987pjb.4
        for <bitbake-devel@lists.openembedded.org>; Wed, 16 Sep 2020 20:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j3704LDg1V7EY5SB1kaW+RKCPHGp5sMDKuKQqy0mWYk=;
        b=S/jrOk1kCCmxGT1dzRQLLImch5VC8KiwzUPiZMCA/GSrIeI3bhLt6mjKuPHXx7NKYq
         nTnPR/KI8uyEYLYwGKaI8ijQvow3axF0TJ9hDNUyh1sqDByJea7nY3SJLsR6w+y2AIqZ
         mkxW1rjK36lpGPCnBCqRO3gvYuFq5HAc4gIBF3yZKRUT8BZHsL4/IGeqj10A0r3LtAan
         e5lTg5iKutiG2qUXnHZ4xO2cHPbiEQ6bDHQTP9SRt5hweHCy6CB6aS1M9YsoPwGcAku1
         Tci0EL06whVqIh1WwAoALZYoDI+g2Ad3BkMZloPGssR6x1CfpqI5g87NFlf1pZHpisEm
         l0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j3704LDg1V7EY5SB1kaW+RKCPHGp5sMDKuKQqy0mWYk=;
        b=SKNT7QuQEmlrMZz5Sn7Yp2lh1pkjJmyDtBRDtu1TAEd/3D1xdgtouBqy8oiLl8y7TM
         ldoyOVzG6B0gx/pAXJRAGKBNpxlb7twjOFZJYRQSd0S0y8T7vzjrLUnsdq4bZUcoPgKV
         DLw+7aQHf1mIVbrJlTLEaNUEqg5wQ04T8CE+m4O7HINznKAIc6kcl21hAXU4QgsidwqU
         u+Y76kAEoZoMNVEUm62INI3u7wGpT3+PEP0ghCy4j0ZkvXQpr2iECCIKSQrnIVsO3+UI
         Pnpf/NIdJbVtq2Vi0rf9+iRMnIK4nPhRAhqpBiqjEn4eNlDsSDEWgEaNBhzWawsKDDkh
         qoLA==
X-Gm-Message-State: AOAM5301bhvo7fOk3iRPMSyQJecJoYaDeVyp3m10F8Y2BcTtAJjLoB8p
	JhTn4mS/nochqbMt2ounp8C/sz8ntIQp2dqRbe8=
X-Google-Smtp-Source: ABdhPJyhQv0I7O1stp7eewOFsg6JWzL+YlMy7+iI6YBY0db2HerGEhhTpQ5tqsrE+Vb2m+b5kxqn7Q==
X-Received: by 2002:a17:902:c3d2:b029:d1:9bc8:15f8 with SMTP id j18-20020a170902c3d2b02900d19bc815f8mr25939123plj.29.1600314003631;
        Wed, 16 Sep 2020 20:40:03 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from octo.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id bv7sm3934608pjb.55.2020.09.16.20.40.02
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 20:40:02 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 0/2] Pull request (cover letter only)
Date: Wed, 16 Sep 2020 17:39:54 -1000
Message-Id: <cover.1600313935.git.steve@sakoman.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following changes since commit 838a89141fd6a75da9f982ad2b035e823b692d2a:

  server/process: Account for xmlrpc connections (2020-07-29 00:21:29 +0100)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.46-next
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-next

Jean-Francois Dagenais (1):
  siggen: clean_basepath: remove recipe full path when virtual:xyz
    present

Richard Purdie (1):
  fetch2: Drop cups.org from wget status checks

 lib/bb/siggen.py      | 2 +-
 lib/bb/tests/fetch.py | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

-- 
2.17.1

