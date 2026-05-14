Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A99CCD4F3C
	for <webhook@archiver.kernel.org>; Thu, 14 May 2026 18:22:17 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18290.1778782933611432452
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 May 2026 11:22:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=dIvI4I+Y;
 spf=pass (domain: smile.fr, ip: 209.85.128.54, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48909558b3aso80434985e9.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 14 May 2026 11:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1778782932; x=1779387732; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iDnFuS0F1KCeoakdfC6jdNScxQS4jBVuAcJ9tPWJ69E=;
        b=dIvI4I+Y7ucWU8ZhMvzRSYl73UsPaXGq7OyCC/4ikEApi7iAKzVeqRCd8Zt179ZDXE
         85nxU27yiWBZtg9ABR3Oqq2s42wnnBPcxOS3L8bMgLJ8QwaqcwXruhFtMG7s8ntc9q3r
         e7mpd4KKB9pFgQaI9ymYpuKRfGf4YyYHE1Uzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778782932; x=1779387732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDnFuS0F1KCeoakdfC6jdNScxQS4jBVuAcJ9tPWJ69E=;
        b=d87XN8hD3e6HRpc5sPpHAN+lgnT6rqroIK+ofCa8G42KfvSzPyOtU5U99kihK93jzd
         +uOXwyVoxbDw1v3PgGhDLq1WiuqWk4E5oDgeniJiNNvBarcVb5bM1HzmHwrLOuaGkMOF
         OeM9KuGB/E6brrzhyfMkObyb4EjqKBgUrmcgvpzK9SqXI1HZIaNszA0tKhAnMHriFMi7
         YGTDrPMXpY10O18yjfKxW/QgTX+DN7cckJ2gPaVvSuAfcza795TpdgIhbCMlsXSGuO8Q
         Aitt6Iw3IMdvf5IS1b5jn1ZW1WzQUuCkSPb2mHhqznHZxNpX4U/vk/s7j08pYaIDgGiS
         JoQQ==
X-Gm-Message-State: AOJu0Yze6k14AyLpnpjN1sr3F8f9tckM1SMKF/LqVumOaIbfuu9XbVrD
	O9KHJGx7Ln7ZrCpT6+KJag9lSL6e7jjSZ7onL0tUocDRhIzW9KW6QFkytVG8mKz2GAJrawWlasH
	1EY/Asnk=
X-Gm-Gg: Acq92OE1ZK5IcfNwRfC5+EI+NFh+rFqZQzDuF+dU+0Sz8VgtVRMAKDstq2Pszj+iJRt
	yXZ6Q5stFYcIQw7rWECf9d2sMPKRA1N7VBEr2tjR5ryRiq3wgCdjvqNsq23RT/u7tB0pCBInR43
	aYvL9423HemzW0TFbbG+8sILg9sKna9FXswnnxTX31wLyAtUT+dpjh0XlT7oWcPrt4PEutdhaqT
	I9Xmaqrf+XfVm04kijoa2GM4NC/epn4jAlGHRoG8mx8WxptCoEjCu+pe1KF1V+urxcauloNi5LF
	7/i7wAboXczkjA5Rse7UuZB9N8BE+aVtQHFdIvJ2/udoK7DyqUKy7dItkUCbtRoNXOoHEPoPNYP
	mdYQZAXLYQ7WT2Wx1ex2EqvJvxLnanALdS6crf1yCEIHt00V3pUKu2kDarbFXxaDOOq2GBNr3D0
	sSg0wbSfyL4LV9YkrgLebtJ6PQvDVgnzdX5lYg
X-Received: by 2002:a05:600c:3b12:b0:488:b14f:b8ed with SMTP id 5b1f17b1804b1-48fe59ab80emr8633945e9.0.1778782931772;
        Thu, 14 May 2026 11:22:11 -0700 (PDT)
Received: from localhost.localdomain ([45.11.68.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe53804aesm7806275e9.15.2026.05.14.11.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 11:22:10 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [bitbake][scarthgap][2.8][PATCH 0/1] Pull request
Date: Thu, 14 May 2026 20:20:52 +0200
Message-ID: <cover.1778782313.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 May 2026 18:22:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19523

Note: This PR has not followed the usual 2 days review cycle and is
aimed at (quikly) fixing the 5.0.18 build.

This is the last piece (I hope) of the migration out of git:// URLs for
YP/OE infra.

Passed a-full on autobuilder:
https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/3827
* oe-selftest-debian failed on a slow yp.org mirror access that I
  attribute to current heavy load created by bots
  https://autobuilder.yoctoproject.org/valkyrie/#/builders/35/builds/3855
  * Successfully retried as https://autobuilder.yoctoproject.org/valkyrie/#/builders/35/builds/3860

The following changes since commit 1a62878a790ed9630d5ca2fa099d1604540e153a:

  fetch/git: Fix leaking of temporary directory (2026-05-13 17:51:42 +0100)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.8-next
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.8-next

for you to fetch changes up to 82abbfcdbda949851a03bb2cb2049ea689564ad6:

  tests/fetch: Avoid using git protocol in tests (2026-05-13 22:22:20 +0200)

----------------------------------------------------------------

Richard Purdie (1):
  tests/fetch: Avoid using git protocol in tests

 lib/bb/tests/fetch.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)


