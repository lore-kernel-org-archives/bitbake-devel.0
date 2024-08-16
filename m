Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9633DC531DC
	for <webhook@archiver.kernel.org>; Fri, 16 Aug 2024 15:13:25 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web11.150341.1723821195956275347
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 16 Aug 2024 08:13:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=JTlgcFzT;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.169, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-201f2b7fe0dso14880475ad.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 16 Aug 2024 08:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1723821195; x=1724425995; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lTqnBRB49dP3A8mVc5xxPenmPFYmaojZ2jjQFpS45YY=;
        b=JTlgcFzT+iWGLPzVhXaFWwcmzcKCLV8Zpw0ajF5lS/fgJRCKpVw2Ac3dOmPVSO93yD
         eneWqYlCxKrWqSyLRX+8z3FRAN+wQf7C1mM+XWEKUTLD/0NIwcxy32l/WGfArj5YT+Vc
         7JnmetXiuhEUDfiSDNP3aXmcQJ51mliCQrsmMiYkTI/R7Yn8jOZXmzjW+fxqROaH6oNl
         VVTF8tqyartjIMDJ8JP1hN94iMNvzvKxtUMQqqRbIfeniYJXkSQs1IZ36vepFvSejZ7C
         KSrMP5XTiiEhf6h6cy0kBBZcdTPnQfWsthjbV7v2biDCmiteOhHubslZCEoXp74KJJfZ
         5k6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723821195; x=1724425995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lTqnBRB49dP3A8mVc5xxPenmPFYmaojZ2jjQFpS45YY=;
        b=h+XGa5/QfLX4seE5DGf9QX999eVpg73BNyWh3bx3CxrvQ9tf43P7PQti9gqOgdVn8a
         hGxKPuWeq1VPhuj29C3khxrZS7chMIJi+sOOCSG8SSPESI3xGhnuGEY4v3i0vQ8lE3UZ
         aAQLdWvfdPEN+0+giykQtqC3/C1bO0317g9nBZJm5gODT3rO639+yYEi/7pvirll7Duq
         cXb0wAdcb2d5MgSHtYS6KCAfdKAshklNQzPaH19t79dDysDge8He6ajlu4Ln063zRJSB
         ezzWuMT2mKp12jA2Vk2CcNtEfI9z8ARBthK0UO8qhGWy24dI1R76Sc22T5k7bBuBYp/h
         nJJQ==
X-Gm-Message-State: AOJu0YxPAK28IEkYBvL7lnJWVrqzdNZPor/4KJl4PCqfGY/r6j8kRsn7
	WJZ8PcIwdcrR1l4D9YRiwVqHXzYfO0Q3HdpPoG84XuFXBR0CHdkihrR63pNE4HSIUN2mUAjSmFN
	LRos=
X-Google-Smtp-Source: AGHT+IHLPQruIhaVjCCc4rF29jEDGSjnH892uMENb1eWZZYZls5R4SP/oq/Bf6e7u8PCEV1uvRQqyA==
X-Received: by 2002:a17:902:ce81:b0:201:fcd1:e40d with SMTP id d9443c01a7336-20203e4c4bcmr43459245ad.6.1723821194953;
        Fri, 16 Aug 2024 08:13:14 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f03b15bdsm26728815ad.303.2024.08.16.08.13.13
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 08:13:14 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 0/1] Pull request (cover letter only)
Date: Fri, 16 Aug 2024 08:13:09 -0700
Message-Id: <cover.1723821079.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 16 Aug 2024 15:13:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16491

The following changes since commit 734b0ea3dfe45eb16ee60f0c2c388e22af4040e0:

  tests/fetch: Tweak test to match upstream repo url change Upstream changed their urls, update our test to match. (2024-06-11 11:22:11 -0700)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.0-next
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.0-next

Robert Yang (1):
  data_smart: Improve performance for VariableHistory

 lib/bb/data_smart.py | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

-- 
2.34.1


