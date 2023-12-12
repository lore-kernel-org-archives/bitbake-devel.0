Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5555C41535
	for <webhook@archiver.kernel.org>; Tue, 12 Dec 2023 15:02:42 +0000 (UTC)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
 by mx.groups.io with SMTP id smtpd.web10.3792.1702393361911977149
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 12 Dec 2023 07:02:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=otwCkR/W;
 spf=softfail (domain: sakoman.com, ip: 209.85.215.170, mailfrom: steve@sakoman.com)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5c239897895so2857817a12.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 12 Dec 2023 07:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1702393360; x=1702998160; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=67y+4xIxPqQh1Ws6fyn3Y8cTerbdOFB6UTwHfKxONWc=;
        b=otwCkR/WkvaZJekfkI2K9VWelVjKl1ZakWPm28Z/WQuhcWxJI6IDkVzA01dsF6qn3M
         y2cq/bu8GIEXuqlktMqqs2Rdmt7N7hmbEGHA1dy0etPa2AAb8ERstStYCIuQhFpB5s2X
         DSp2tHGvxDPlLOWLsW6e3lH4a4WJar0N4KYyqD0WWmar0BvBQwRIVilbpO1VP0oKOpme
         rRhGuOgiXQCdfh+WWvycJLeZ91lcDvneimH9aisPejPAmeve5RHi518ouH8vDkG17lOG
         563o/ROT+Vv9cK70c+tQ0dQxZk/QZ4vwNoFTKmeHJqdNy8I435aue9RiArFv3nWX39MB
         xcag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702393360; x=1702998160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=67y+4xIxPqQh1Ws6fyn3Y8cTerbdOFB6UTwHfKxONWc=;
        b=lvh8j//qQ6XXSxBQG5/i8n4nrqA/SVC0TVj4J5DXAOaaCopTXzQyRR2DoclucKyzaj
         zXDJngzj36l3X+QZTEYz4rE0/lh3/FUrJcEJyW6u7o0Eo8mUycqVbs8MmbSZwaiXU2eV
         VzQonchvZTTl2PzGCdyvUi7ns6/YziUWObypPCR/QS4nPYl5dJ30AFjuasnCd9IBngUd
         EARkhtKfU7tVGqjO4VZY6sRnevrFCYZ+yjrV0qWX4SRSy4oP6a3dG1HD28G7ACd8xt7V
         SrvFKz0GmvSNTJ/MsMmdJIhrCJyh0JOnAIaw514IKOqcODDRKHQbt/KfcJBUwHktcNyR
         zSkg==
X-Gm-Message-State: AOJu0YzySvjeCQphYsMEwtUr0qEQk3Nsd92gq1sPAGJDjQhJLlD4qKwq
	MzpAmP4uiHWbLh8sx+PVl+AkbtDx+l2xNdUry+g=
X-Google-Smtp-Source: AGHT+IHSHqT+E1ZN2PXKuBRA9ld/cj1+O2JTLUurFqTd6zQnxqKlAXMwEU/vtqdJWUYvnAsPXkOXDQ==
X-Received: by 2002:a17:90a:4983:b0:28a:81a2:422b with SMTP id d3-20020a17090a498300b0028a81a2422bmr1750015pjh.91.1702393360491;
        Tue, 12 Dec 2023 07:02:40 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-234-108-41.hawaiiantel.net. [72.234.108.41])
        by smtp.gmail.com with ESMTPSA id q2-20020a17090a430200b0028a4c85a55csm7226415pjg.27.2023.12.12.07.02.38
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 07:02:39 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][nanbield][2.6][PATCH 0/1] Pull request (cover letter only)
Date: Tue, 12 Dec 2023 05:02:33 -1000
Message-Id: <cover.1702393185.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 12 Dec 2023 15:02:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15655

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/6305

The following changes since commit 936fcec41efacc4ce988c81882a9ae6403702bea:

  SECURITY.md: add file (2023-10-24 12:50:27 +0100)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.6-next
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.6-next

Peter Kjellerstedt (1):
  command: Make parseRecipeFile() handle virtual recipes correctly

 lib/bb/command.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.34.1


