Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79180C433EF
	for <webhook@archiver.kernel.org>; Thu, 13 Jan 2022 14:10:27 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web11.9279.1642083026216009131
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Jan 2022 06:10:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=Gk4Y7A88;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.50,
 mailfrom: steve@sakoman.com)
Received: by mail-pj1-f50.google.com with SMTP id hv15so10842753pjb.5
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Jan 2022 06:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1LyU1GF7kruQQGhqF0GpHYXUS7foOSWCtjogKkAuYrU=;
        b=Gk4Y7A8804nsE5V8qQM8q+jtOtYG7OooQhZ9Pt5MEBzPEcBY/ZXwBsMzhabOOnLzH4
         Q8NbbpuyrPTeXludunUbEZR4k91UW3CM2OetCjbVYftTlpHBGwy4zdqx6VW5/SiY8AkD
         TIfVxj6bkC5RaSNhNkvSRqHAGufaTFRLAGioV+rMils00SRokaxqIe9xgFKYx8o8FvvK
         kLucK8EL3q5OYK/PpX+9EZL3H4FfR7vt7M2JvwGyfnkQiAoy6oTo73zpwV468ve88Tkz
         6pJEaaJzdv+7rjrSeRLbYOZmYwJ5Sc009L0/dsLN3dIA6ric3HHqX7V7SZlvkBQQruk3
         y1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1LyU1GF7kruQQGhqF0GpHYXUS7foOSWCtjogKkAuYrU=;
        b=5QlkWAKeakSdHjN852xhL+VGbPzsdq0vRbWlDp3/iv9V63MYN1YcvXXkaMsaYKJjM7
         SuY14WdgpXiV0YWX4Eoq3DALdmn9wrrA16JmrBWQuUZ9GBt2IH0C/E8RE2Tq60Epel7W
         mKDI/xrKdAQ1QiJRKeJKiyr1U99V80V2DQZM+BVTn2f7M8e/d6caSOkC92bDYp8m0vCU
         paHrAjwHWsVXb7QBAfMl6IosiIqW4E5bErUqh08bY8B2h1VW329vomBmv9VTzO1B+/15
         DuNaat6RmBex3vCsBThtDf3fn/6PM0JnpjkBALhteaYo9ymfHVPgY2f0fBB4tt+IDMRD
         T5YA==
X-Gm-Message-State: AOAM5300lJKNRJacx6V4gAS7D3YsXHirJSBwE4K8iRXA26BfgZcIclIP
	TjQsr1nfU4qQ7MOCzlpy6/XJzslA3r8VpXku/T8=
X-Google-Smtp-Source: 
 ABdhPJxvyZQLehRSV0cYEeMXyUD5YsMNe16mL1KTNop5XmyWaVdVzoBGM9vueLmX8sISCeL14hZBGA==
X-Received: by 2002:a63:4186:: with SMTP id
 o128mr4053135pga.450.1642083025042;
        Thu, 13 Jan 2022 06:10:25 -0800 (PST)
Received: from hexa.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com.
 [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id
 go19sm8521033pjb.25.2022.01.13.06.10.23
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 06:10:24 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 0/2] Patch review
Date: Thu, 13 Jan 2022 04:10:12 -1000
Message-Id: <cover.1642082551.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Jan 2022 14:10:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13230

Please review this set of patches for dunfell/1.46 and have comments back by
end of day Monday.

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/3112

The following changes since commit c5969eedd035648e3258bade386cc67ce3bb0e03:

  cooker/command: Add a dummy event for tinfoil testing (2022-01-07 23:43:41 +0000)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.46-nut
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-nut

Richard Purdie (2):
  utils: Update to use exec_module() instead of load_module()
  tests/fetch: Drop gnu urls from wget connectivity test

 lib/bb/tests/fetch.py | 3 ---
 lib/bb/utils.py       | 7 +++++--
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.25.1


