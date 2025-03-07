Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F76FC282DE
	for <webhook@archiver.kernel.org>; Fri,  7 Mar 2025 13:55:09 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web11.11363.1741355700411104850
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Mar 2025 05:55:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=zc1vp76/;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.46, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fec3176ef3so2839074a91.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 07 Mar 2025 05:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1741355699; x=1741960499; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2xPArIoslGTlnLyUNTpZqoEyCADLPgiYrnJDSQdo8/g=;
        b=zc1vp76/2Fy2qLvEiH/563sQCVEr3AOWNj4k4EPDE2YMggc9s0Socb4iiw6SYDsOos
         61ilKNMi8AFQYu+CsgtoXypdn9HopC9RdFrNipcCwQUR6/P3TUVh1Dg2/nutCUyx7xiw
         odwuo9fEwrcqaQGyvk+O/tfDPVy2BPZG9+sPVqadj1gL7wcLIqUblgMnWSBG8cZnEait
         FtJtBJec0GwyzLKHW9j7VVtCAzU61vWfRzjXr4ioeCn9bL3EjvGXbkhxpg64v72vy6An
         xOA/14BgAdA9qS7eoz/79c2DxobjAONnhtB0mUrI9klRNO1NZh+RTLegHCoXtL5xqMNd
         Pa1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741355699; x=1741960499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2xPArIoslGTlnLyUNTpZqoEyCADLPgiYrnJDSQdo8/g=;
        b=ld1BPlMVQfHxYXMItEc4V6v95GPly2UTWHoJZGncrfFOCDC87sOTFBgD+47ekVm+CN
         1u56dhJVmbDF7LzRhoIlx8EBfG3PJKd888rXJfZvgyvYXti7HuaR5M6+KgFSf6wM4qiF
         MWs8Bvj3CeKeRbrU5GwOS8nX36YVZuXqCej/uHvmWwuWMAtAJdvDaYNcmSs2Bmbd+WrI
         I12nHsfF2LUHrDyU6xnX76tBVCe2UlhUC6Oomin68WD5CM83tN3v7C/Pz9e1UZf9mIe6
         lkVAF9iGsOlKcyH8Xb/DDndtt9c7aF7KiNNU9i1YPdexp/3sNEfwimgkqqWVTvg+mnb7
         aaNQ==
X-Gm-Message-State: AOJu0YxG17drX6ra8LZg3T68pfwpeW0omFiVYR3HLE59fKgZtSv36W7u
	YmDt4QhKQXRcuzvtRwkMCM+GaeDwYmvKuF8oTCw6CCKqllPgSmy9CB/sClDEHVek1LTQ8QWedpk
	s
X-Gm-Gg: ASbGncski2hStaYuBmEwzbVDAtj9GAQnuIUm4Un0im1cK6bDP7VJUqtFAGrGM9ysED6
	kckg540i5c0MQ2VnlxLWMkqivihfc3PJR79GLK9MennKO/YaXt0pLNYPUAv0Gvqmf0objFF9oFI
	jhv6IY/vfWOkqX5q3I1dcOZkB0W2CNSlYp/+D5aJnxXZOu0j5lFJ70LaKw5OF/0xkvUMJgIFcYc
	BJb7tauFOUz6+AeSen74ibOggcs5L8G5POkFSGHnsZtc+CpP/5yghdO2yzKqSzWkvuKoHv95px7
	4xSNxdqryS7jnh5jTVxQJMeH6VPS3woTNdl0
X-Google-Smtp-Source: AGHT+IH9hJbIC4k/jXiG0EwyX8a+OSjYy86QPBjoWIy/KVLuvAtht6/nOweBjnbwkrgYSXSnPaHH9Q==
X-Received: by 2002:a17:90b:38cf:b0:2f9:c144:9d13 with SMTP id 98e67ed59e1d1-2ff7cee84d3mr5634258a91.24.1741355699481;
        Fri, 07 Mar 2025 05:54:59 -0800 (PST)
Received: from hexa.. ([2602:feb4:3b:2100:cfcd:40b4:f918:b895])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e75edc9sm5488032a91.10.2025.03.07.05.54.58
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 05:54:59 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][styhead][2.10][PATCH 0/4] Patch review
Date: Fri,  7 Mar 2025 05:54:50 -0800
Message-ID: <cover.1741355508.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Mar 2025 13:55:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17407

Please review this set of changes for 2.10/styhead and have comments back
by end of day Monday, March 10

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/1138

The following changes since commit 58e5c70a0572ff5994dc181694e05cd5d3ddaf66:

  bblayers/query: Fix using "removeprefix" string method (2025-02-21 13:14:07 +0000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.10-nut
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.10-nut

Richard Purdie (4):
  utils: Print information about lock issue before exiting
  utils: Tweak lock_timeout logic
  utils: Add signal blocking for lock_timeout
  event/utils: Avoid deadlock from lock_timeout() and recursive events

 lib/bb/event.py | 10 +++++++++-
 lib/bb/utils.py | 20 +++++++++++++++++++-
 2 files changed, 28 insertions(+), 2 deletions(-)

-- 
2.43.0


