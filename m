Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1799CF042B
	for <webhook@archiver.kernel.org>; Tue,  8 Oct 2024 22:46:14 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web10.2247.1728427573098832569
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 08 Oct 2024 15:46:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=gtP0SJF4;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.169, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20b0b2528d8so70300475ad.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 08 Oct 2024 15:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1728427572; x=1729032372; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=m6lyRb06MlB/nn3yjpJmyhoHi8zdkndeZAY8/01x2LA=;
        b=gtP0SJF42y/NnDQerJIWYZ0CtoSyRqK2PRnKOXszLxbwJaZx06t3OiFyO7tDdNCr6p
         jZMFHldOQq6Z268FAPs8uDcah+qvw3OrO5RTOXd06ibOlT5XoMNDytzTbHrDYMGfFrzq
         MBZ7o+dzuaUZW3hpaZ7e9TAbgGPPWkwNZdec+W+2Nb72oT88iSYfBv2lfz0jORVTizC9
         +hrOR5h2rBMXXho4dw5eEh2ClNjJdd8yJOmaLmdVo6Ocq2RPHlJkplJhDPjMH4Eq7kNw
         3VUy1f1VCOXVXss8dkQtzsGWh0pGy4GwNFWf7sHqM4SOb9vZajpYYoO1lih5UA8xK+F+
         thBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728427572; x=1729032372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m6lyRb06MlB/nn3yjpJmyhoHi8zdkndeZAY8/01x2LA=;
        b=RfiMZaTksr/+8/LFpApmshH47TgZ2d2S8BpcmUtNLKZtIIfMr8CakvrKVzhL0av1UP
         z8kuKCv4M0ZA7CvIanjTST4Mo2VSgsjG0bKAcY4K3I6DJw2tAQevGASYMDnPEeR2Izqz
         9vNJv00vtSA2PHZqONU85KXS9S3eLXj1A6L34hDVSWBrBjsOCSimnRCDN+rFgB3BE57n
         0f350ldkEIAYd6Cvq8iMiBeLZl7lL/S0Hc+eAaMvX7ZJWMmcI4GzeZ0BG7Ut9WF2UKTF
         6WT/IqjSEG5Pmpldjm8wCSA4UTA4QfnxjcZ9Q2xgQRC2FdzGXJNkQLru/yRXvtXwM2j5
         FaBw==
X-Gm-Message-State: AOJu0Yx8LPOBIstc9ypiQfR16lMg5DT+uIeeAAt82gQl6rNEjSGj+Mq3
	im8ETQbbDC4tcmItQPG9EBGiyS7hq6as9ncH4IBg7tMqxxJ5yhas4DFu3M+lYv1Ags+oxt9JjEi
	/
X-Google-Smtp-Source: AGHT+IEPChQto1eT7OiS1Z4Tcbwzv4GwpiqOwxMWh6yinzV3XY1dmjsv9BT8VLed0JuOFrCS9N7DRw==
X-Received: by 2002:a17:902:d2cf:b0:202:4b65:65af with SMTP id d9443c01a7336-20c6378ea43mr8013645ad.52.1728427572175;
        Tue, 08 Oct 2024 15:46:12 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c575165dasm15236625ad.222.2024.10.08.15.46.11
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 15:46:11 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 0/4] Pull request (cover letter only)
Date: Tue,  8 Oct 2024 15:46:06 -0700
Message-Id: <cover.1728427515.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 08 Oct 2024 22:46:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16663

The following changes since commit ec2a99a077da9aa0e99e8b05e0c65dcbd45864b1:

  data_smart: Improve performance for VariableHistory (2024-08-08 09:19:30 -0700)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.0-next
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.0-next

Richard Purdie (2):
  tests/fetch: Tweak to work on Fedora40
  fetch/wget: Move files into place atomically

Rob Woolley (1):
  wget: Make wget --passive-ftp option conditional on ftp/ftps

Rudolf J Streif (1):
  fetch2/wget: Canonicalize DL_DIR paths for wget2 compatibility

 lib/bb/fetch2/wget.py | 21 ++++++++++++++-------
 lib/bb/tests/fetch.py |  6 +++---
 2 files changed, 17 insertions(+), 10 deletions(-)

-- 
2.34.1


