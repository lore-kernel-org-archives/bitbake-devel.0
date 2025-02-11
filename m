Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40210C021A1
	for <webhook@archiver.kernel.org>; Tue, 11 Feb 2025 14:40:23 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web10.499.1739284814225953655
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Feb 2025 06:40:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=a8YJ9NZH;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.178, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21c2f1b610dso137375265ad.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 11 Feb 2025 06:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1739284813; x=1739889613; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+PF4TQ43B7YdX3aTjryG0NJFo3114xhWXLtgazyBiII=;
        b=a8YJ9NZHkLKyC5s8/7w4ksC1UfW55F/NLCVpYd3+m7Ntvl9GHN0iRIQmCBkZ05M0qb
         Yg57r2LDuSotTMXfIsKyixith69vhDeSxYryvpsl4RNEWiGf70NQPBmOlmezex6irlkX
         NdjijPeXlwVfWz15RfTZnHr/+U2F1OedroXmze7KtlCnj6/EExLA69qJ+uNjWx1sINe2
         oAOlwxgROBw1ElfN26suPtboZLCoXjYPYeB7G/m+Ha5hBCwSkivsdqQJRKCeB+tGYFH1
         wwIq2buFeJAQM054eS1rMtWmrVAJQf4BSJ69el+nwIf6WFzdkIDhQvdTjNOdvlvrHpzo
         tpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739284813; x=1739889613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+PF4TQ43B7YdX3aTjryG0NJFo3114xhWXLtgazyBiII=;
        b=lmEn4luz9t84ilDB+zXIWjXRI4ZUmTCd42I+tekB+bWvSG83aQXIzm3LbfClWRqQHX
         8qYFTjWQ6OHTbwE+PDg+Q+A12GrCL5UIsE9/wkgo/gyXyLiRUnuey4PUTnYqgMs+D9ed
         nQI/oWlXiLsDMAbh6vQrUCe7ZvSWProOHVRexZlqDqmKMsCgWsZV1ClJGodkTaqHKmtT
         7VVFdscPmDuD91eQe2lyBkMs1oUy64WxKJAIQdbzAZEP63v9UgUhHA320UDeHaCwzYvq
         ubhZAir8O6hqrGP0WtRhd58+aPbbvphCnWb8AYPWI4t7VYjtg5AKo+MtQek4RqcLs82W
         cpNA==
X-Gm-Message-State: AOJu0YyYRgKAwHSLCctKorbY+4P2hWxfy/PG2b12I1LKkctcjX7r6/l0
	omklFPcHyzH2EMvHdaTH50Lgkq2+Tx8ouns/RCPyPaoUcu4hG+O0CDJj2Ndu9P25qZQehda7wc6
	Q
X-Gm-Gg: ASbGnctXdFp4XYQkfJuGNWcwiUNnmkxVEUbbnGNGUvBxjfJBZUX9Smxs4IbwlvAVm/y
	hpUrNE46toEGMXIRgojhkACr7JRR8QbViiq3upsJNwTwbWbil/1Nr0Oll7Zz6CDWPfsfmqAqVac
	QV5ulHPrLcxt2mEjUvn/ymTOg6f48/3Z6CJ6ZQyCul7HJ6+3fSNKDZ3lw+ZmeowE+dCREBy9biK
	iyH3MTs2Ad6INDQN++QP33OL2wR9D7SobicCPfBZJh+8JNmSExW6zHqdEnoartCapMMvtfkCEpt
	uDJz
X-Google-Smtp-Source: AGHT+IEt4QbTqnKP9lsnFinF7/V/B28+x1XK8qazGWsDWFPOhktw0ZzOZ8M/cST5agAcPg7WCQEQ0Q==
X-Received: by 2002:a17:903:1c4:b0:21f:baa:80c1 with SMTP id d9443c01a7336-21f4e80a0eamr304934375ad.53.1739284813333;
        Tue, 11 Feb 2025 06:40:13 -0800 (PST)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3687b537sm96465955ad.160.2025.02.11.06.40.12
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 06:40:13 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][styhead][2.10][PATCH 0/1] Pull request (cover letter only)
Date: Tue, 11 Feb 2025 06:40:09 -0800
Message-ID: <cover.1739284761.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Feb 2025 14:40:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17191

The following changes since commit f4b2ae97a8dd745b463e5e10fbc8d30d29d223c5:

  tests/fetch: Fix git shallow test failure with git >= 2.48 (2025-01-24 16:18:06 +0000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.10-next
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.10-next

Chris Laplante (1):
  cooker: Make cooker 'skiplist' per-multiconfig/mc

 lib/bb/command.py     | 21 ++++++++++++++++++---
 lib/bb/cooker.py      | 11 ++++++-----
 lib/bb/tinfoil.py     | 16 ++++++++++++----
 lib/bblayers/query.py | 14 +++++++-------
 4 files changed, 43 insertions(+), 19 deletions(-)

-- 
2.43.0


