Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C62C433F5
	for <webhook@archiver.kernel.org>; Wed, 30 Mar 2022 16:39:51 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web10.154.1648658390547877072
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 30 Mar 2022 09:39:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=O+dV3JJB;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.170,
 mailfrom: steve@sakoman.com)
Received: by mail-pf1-f170.google.com with SMTP id f3so18007376pfe.2
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 30 Mar 2022 09:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BkeHDp38HpZYe7bCgoXsSd1cGJ0g6jCCpeDAMhb98Uo=;
        b=O+dV3JJBYkTLUrPyBqTP32VG3VFYHTC7HWtbu5oDw8fjPRHxbbR8N1iOWPDOAdUCfM
         m3xYwLw7eMViO9zq0GWFmxuTImmwqaPW02YXqcE3vUXEZYOvWYGgekI2vRgNhny3xrKh
         ijIRiMKiHpcdLv63Ke2NbpbIU430HJRCFCJPhE3muUU9saPCVNBQWIi/4itEFIZg1yQi
         QcWbmCO3DH1o0BGaXdD5s+kTuzcIgns9b7AX5uRNin611suMmfQN6iGbj6HVgFP7zkIN
         HcSr71yhe3qW/+S7eaVRs/xHWAlLDymPR3OzPcpFISJzW1wKCpvj7J6/eLFxYviggQo3
         o66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BkeHDp38HpZYe7bCgoXsSd1cGJ0g6jCCpeDAMhb98Uo=;
        b=ViJZvg+FPnKuVp3vokGo0ykb49rxn+ZBREKeyqxkYlcMXkQ8nz0RuTkVY49gCMZjVa
         uOijS5s7PUpcYdIlOEFKKNKTicTFoIuaHR3QmQ5EUqYDS1AYM/DviD/5OCRd4HkL90bJ
         5mC0CJgt4dj4vTGbqKdIzfdYlqU7tI3O51j1+/tIF4SSA9dcKteSoRq3Toru7jeAvekB
         B2m22DPZswi/y7MJD0YZGrkcM4Ev2cVSO6+B5ixYcp2IrxhKAJ4BEbdY16GxpFm1/mX+
         i5/7Z5QGcdpkljdC7K4Eph4JtXGoAk1vyzz3J8hXhpQe4EObLPOVXZ/khc2Kt7OaP/ye
         CpIQ==
X-Gm-Message-State: AOAM532GB/rUpTG5S1xsm71C740z1+D4YRoOBhrgk5jpaWsMMW90K1v2
	Cmeo2fP2AgW9Q0H6uzD0nf8syKb3hkUTbiXgH3M=
X-Google-Smtp-Source: 
 ABdhPJxW6S4u/E6fDazVvnljUVATbzE2CuweokH2clilU04wXC7gqqzaWOclAJqdpqnuGhxeTYH3jg==
X-Received: by 2002:a05:6a00:21c6:b0:4fa:914c:2c2b with SMTP id
 t6-20020a056a0021c600b004fa914c2c2bmr374607pfj.56.1648658389301;
        Wed, 30 Mar 2022 09:39:49 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 a16-20020a17090a6d9000b001c9c3e2a177sm6815030pjk.27.2022.03.30.09.39.48
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 09:39:48 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 0/1] Patch review
Date: Wed, 30 Mar 2022 06:39:37 -1000
Message-Id: <cover.1648658231.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 30 Mar 2022 16:39:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13551

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/3445

The following changes since commit 41bf1fa85a540232dcf92fe473c3b3c4cd7259dd:

  tinfoil: Allow run_command not to wait on events (2022-03-28 13:30:40 +0100)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.46-nut
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-nut

Scott Weaver (1):
  fetch2: add check for empty SRC_URI hash string

 lib/bb/fetch2/__init__.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.25.1


