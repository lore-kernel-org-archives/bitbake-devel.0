Return-Path: <insu0.park@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0C3C46CD2
	for <webhook@archiver.kernel.org>; Wed, 27 Dec 2023 14:54:51 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.web10.103002.1703688883144143361
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 27 Dec 2023 06:54:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=JENAlA8a;
 spf=pass (domain: gmail.com, ip: 209.85.210.181, mailfrom: insu0.park@gmail.com)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6d9b3a967dbso2097236b3a.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 27 Dec 2023 06:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703688882; x=1704293682; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sw7MqqooJz7x83DOEeePDjlUF0JD/DRb0A5cPq7QvGE=;
        b=JENAlA8aee0HBLQZ2oTpiFsP6IyWi73MWnnXUbmaN3poq4k4DuI8FS9+xEEEz70VJp
         NXT75rXD97hhaBw9gDkh1NA/h2A+xycdBnTamRaCQGfVLMWqqI6+UGlmoaB1FmYL6NfE
         cyH2YQoqaKWlN0vlTqyIW3SwC3p8BJh8oRcXWG4GW+yE9dZ37TlFa70hb3j+EebJz64X
         27RoziEaUDoGwcmfk4uYG17FHfAcHYENqEPQVpdV2EPNA2FFQUGYksjbu2XplJgiv88Z
         dCVyn7KJ65rW6jJxkBcnob15a1kyGceY3yknO2GgFa9yZe/kEH85uiywU6FJtSjI6Jbt
         cNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703688882; x=1704293682;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sw7MqqooJz7x83DOEeePDjlUF0JD/DRb0A5cPq7QvGE=;
        b=uW+IziZaa5YsI8lX/hzFAxwNhv5wc71/iz2VTNWX14nXZW1oZnIBCyZckGNuhs2Xmb
         zfmJxSTf/jgvyQbx00vD+SeKl1IOwC1+qG0DVHXRoNzKB55GNz0wN8xSVybe2NEkLA15
         Le3hFhMxtR1R4Gavu9ooCZw//AeetiRi9vqCQrV7UEMl+DhxhtufPdX6grQDfkLEpmdk
         hxRy0nZg6Tv0rBkuyQCvEBZYYwrbUH9//FtpRqqVkxbQ3z+s5VP+AwFI3+xT568vtfGA
         UMAhqvXRemeRAEZE5yhePTl95iELJewfbaMIn9f8rqOFphe6XSaaNl0Hy10ExZs8IBjR
         JMdw==
X-Gm-Message-State: AOJu0Yxdfd4IdBRbbsXnOGEn2m6S0p4N9O4BNjmDNm1Okbe68NJks+0P
	qZR6cCgrn0cZdHwvRB2WYzjjeQjBcw4=
X-Google-Smtp-Source: AGHT+IF5sUrFNjwxYm7yYWZz2CsPGkCmk7EIVwHZIOoMzYeCtwPbkfzSXZOLGYt3maLlKw+5qqw8lA==
X-Received: by 2002:a05:6a20:7491:b0:190:17a6:24c1 with SMTP id p17-20020a056a20749100b0019017a624c1mr11963872pzd.74.1703688882239;
        Wed, 27 Dec 2023 06:54:42 -0800 (PST)
Received: from insu1park-bee-ccnc1.bee-live.svc.cluster.local ([27.122.242.65])
        by smtp.gmail.com with ESMTPSA id 19-20020aa79253000000b006c3069547bfsm11734582pfp.79.2023.12.27.06.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 06:54:41 -0800 (PST)
From: Insu Park <insu0.park@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	steve@sakoman.com
Cc: Insu Park <insu0.park@gmail.com>
Subject: [kirkstone][2.0][PATCH 0/1] Fix dependency handling bug of remove operator
Date: Wed, 27 Dec 2023 23:54:17 +0900
Message-Id: <20231227145418.8776-1-insu0.park@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 27 Dec 2023 14:54:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15705

This commit has merged on Sep 19 on the master branch. (b90520eedb1dbc7f6a3928d089fe74fafb864eb5)
I think this bug should also be fixed on the LTS branches, kirkstone and dunfell.
This bug is not that common within the meta layers under the Yocto projects, but could be a problem in production domains.
I cherry-picked it by myself because it requires to resolve conflicts for each branch.
Please see the details on the previous post: https://lists.openembedded.org/g/bitbake-devel/message/15082

Insu Park (1):
  data: Add missing dependency handling of remove operator

 lib/bb/data.py             |  1 +
 lib/bb/tests/codeparser.py | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

-- 
2.25.1


