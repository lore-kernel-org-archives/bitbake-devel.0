Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE89C77B71
	for <webhook@archiver.kernel.org>; Fri, 14 Apr 2023 16:44:52 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web11.15709.1681490689436425761
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Apr 2023 09:44:49 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@sakoman-com.20221208.gappssmtp.com header.s=20221208 header.b=zoTsHp0Y;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.170, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-63b5312bd4fso2356183b3a.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 14 Apr 2023 09:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20221208.gappssmtp.com; s=20221208; t=1681490688; x=1684082688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PMq6/WbWluBx+41SwcWj7DrtA1/vsCvh932BZwsbEyk=;
        b=zoTsHp0YmwhgRyihWzJK8s4idxCekizj+aEZtRuJUrKWUh3755DxkriPZUwzY7Yi6c
         HQ578GKMRNznYoyhcz5TfOb1KZTdXvDKK8STcDq5GCgne8RVT3EHFZvIyPobUh8MwssR
         yIudXvhhUFj+YWyMa8NBzzpG0q6TXEu7HEykpnqaXSAq6q0ATH0srLKEMDfQgDFj6rx6
         yjO6enzVvlW1V6PGCU7MrYXhHRJfW2sttz24NUFmY0pRnCf8bWQMsaPmyiTP1Aw4yfM1
         HZOBSRyxeHjtPiMR489esrXwrVrZSSFnwC0IGNnPb1rZoewKvAL3SyMIbaHDVZ75tYXJ
         pkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681490688; x=1684082688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PMq6/WbWluBx+41SwcWj7DrtA1/vsCvh932BZwsbEyk=;
        b=SeFYrAe2NUhSat+0BJFp9XW6wvWt/iatgfm5WOSeIzSarg+NGcaIOfKB+dasISj1bB
         UviVg1edSNuMgrojRiV3IjdVgOim5CG/6djk3ImcGN/zcpY6rlkOkZXiruGSKPb/eFG+
         Ib6elRKCkYIpcogIEmCJX1XuvKouiZSLtQjOFdZUIxMsctO7vMUR+6UO3xNqK9nOw8qv
         qwm1809qQ6T15um8ZPJyfhgCti+d9vksYN7VJlBdCbcb/fT209oWQzEwgr0Q91Gd7civ
         zGB4T96bv8Wgn+jkCDo4xpJpIBlDeAT3FSo/8wUsA7gyGaCgC6SmlJcglNFrHEnLAXuL
         wOuA==
X-Gm-Message-State: AAQBX9dLOA4hYwTdF6F45GERvkI2SuFvQfSGVXIAd2CyviAXh7EavMKw
	+XIg3fWCa9nRc/z5BwAzsUPByomu+TKhIY40Cog=
X-Google-Smtp-Source: AKy350bXnI3eh0WaAq1qBYZGE0Pdf+/FjgyzZ05XIRzde8ADsgsYGIvGTI3M+CIwauASTAT/u1irbQ==
X-Received: by 2002:a05:6a00:2e9b:b0:5a8:9858:750a with SMTP id fd27-20020a056a002e9b00b005a89858750amr6966364pfb.13.1681490688150;
        Fri, 14 Apr 2023 09:44:48 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-4-112.hawaiiantel.net. [72.253.4.112])
        by smtp.gmail.com with ESMTPSA id a22-20020a62e216000000b0063b642c5230sm1626192pfi.177.2023.04.14.09.44.47
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 09:44:47 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][langdale][2.2][PATCH 0/1] Pull request (cover letter only)
Date: Fri, 14 Apr 2023 06:44:42 -1000
Message-Id: <cover.1681490568.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Apr 2023 16:44:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14701

The following changes since commit 88a9cc0318c6ef01976d8b09dfc1a92cf0a1e498:

  toaster: Add refreshed oe-core and poky fixtures (2023-03-15 23:15:20 +0000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.2-next
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/2.2-next

Robert Yang (1):
  fetch/git: Fix local clone url to make it work with repo

 lib/bb/fetch2/git.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
2.34.1


