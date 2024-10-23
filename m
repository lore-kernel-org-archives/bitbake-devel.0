Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2845FCFA444
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 15:40:26 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web10.581.1729698021597593930
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Oct 2024 08:40:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=bvUFYxiW;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.177, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20cf3e36a76so68742015ad.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 08:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1729698021; x=1730302821; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fuxn0hvoLRzbPL9RH7JoCbZN79MsU7NlDRJkIS5nHRE=;
        b=bvUFYxiWrT3bX7Mz9QcGD0MDxu+3Z0dyYTTCCJ++lWcDS0ZICSTj0NdGtXjOX6oJJJ
         NceoxoUU7CqGbtUzwDI9lSyXtwrkpkqE15TEzAALsVcj2fZmC8/UjxREp55/w/acaM2t
         G6v8mYYdU2wes34e1ED+QRCDT98uO3Nh+E/5nnIr/c06wHk4kmbMv9ooKlFhG31q81iS
         roZysC/UpGGwbo87mC22/i4liTzfMdk6LLf07pHJAVIUndJZUTYz1PX1gwSeklUqq7Ub
         eFbDINYeRRMXspa++dcnx9FxphosMF7BQ62QUGYUzsp8vNHdFbjtCE9bM72nICWG4J/A
         9zTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729698021; x=1730302821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fuxn0hvoLRzbPL9RH7JoCbZN79MsU7NlDRJkIS5nHRE=;
        b=cMSb3UBs8GANKcYieedCk/cu+5m+60fZ5ldYeIztNRzhRTCM4MPtqW9frIquBcIK0I
         R7pCA3xHrkJ9Wf16zyW50YyF9mfHuWIUZzZSF2QBltbRaKtsB0+DmWb9p3xT2lq6MzlJ
         fPnr5yGhEW2jAyCxyxSrdz7bmu6KQJHPHHImepgp8LCPL4RZLdP3Fplnzshq3N4+k5Xb
         yHgWIGLszdQgGAZpye1m5qVHkc+w6wIYyMlMRYg5zh2RHbdj5yQnSIJR7g+i+pLDgqNb
         G7hUY5mZVCPLAp1rd+ENqignEJHk5mKZkhFnuod5klHJQoSq1mj+uujVMsWhCiqjMaQM
         DEew==
X-Gm-Message-State: AOJu0YzJ2LVV/4gOQQNrgohcyDxURRl7mPcTtfc44gDFieR3ZoWMZNVB
	rNuC9eoCEAcfpa6PCkeC+FeaDZ1pQSPxvF2HzTBvIyiW5OtyoIb7rCeDrY3JDhbCh1ssuk23sGV
	z
X-Google-Smtp-Source: AGHT+IEtEwxOYf1f9GNshY+Ykktfl8T2tntySfQ9nNxsRp0/Pjq8p1VraKGL4cuWyhLYZBIBV2C1zw==
X-Received: by 2002:a17:902:f686:b0:20b:8ef3:67a with SMTP id d9443c01a7336-20fa9deb678mr37873385ad.7.1729698020692;
        Wed, 23 Oct 2024 08:40:20 -0700 (PDT)
Received: from hexa.. ([2602:feb4:3b:2100:8a3a:42f2:dbca:b2f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0f32f0sm59161655ad.249.2024.10.23.08.40.20
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 08:40:20 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 0/1] Pull request (cover letter only)
Date: Wed, 23 Oct 2024 08:40:16 -0700
Message-Id: <cover.1729697951.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 15:40:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16722

The following changes since commit d251668d9a7a8dd25bd8767efb30d6d9ff8b1ad3:

  data_smart: Improve performance for VariableHistory (2024-08-08 09:20:02 -0700)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.8-next
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.8-next

Joshua Watt (1):
  asyncrpc: Use client timeout for websocket open timeout

 lib/bb/asyncrpc/client.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.34.1


