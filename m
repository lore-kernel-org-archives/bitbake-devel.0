Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C06C433F5
	for <webhook@archiver.kernel.org>; Tue,  9 Nov 2021 00:14:16 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web08.5298.1636416855143290116
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Nov 2021 16:14:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=S6Tiht7c;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.174,
 mailfrom: steve@sakoman.com)
Received: by mail-pl1-f174.google.com with SMTP id q17so5527797plr.11
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Nov 2021 16:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zjGd5KA4ACMeNTlplyRtVxaVKtl/ijqQIqbBTh7jCII=;
        b=S6Tiht7cKbRVJGx1PFdaB0HDGYASP0WSBmVpITjYBn1OpkyQcMyYB3AY+ma+VSJ6es
         VHj1ZRP9DFYBIrEYNWw7j3h+XAwfZ/PW4Fjj9QQhQPTgF98LnBvUQO3tODi/HsReMGTf
         OI/0u7fmAu1MmVmawblWaQCQvhE586GnDMALqwSmRZugIXL9VmZHkUMoMmm25JbknhC1
         jVc8Beo97eWmU9+APAB25SprJaHab2S0/p50ZXaqvBa1FPGZry8PzMQZJ6W52l7UtfyS
         THvL3gNUQv7bpTkQDGYrXJY6ph3XEPyDAK1buEwxkZUI1+AXbBzp1jjUM8a25Iez1oVA
         DRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zjGd5KA4ACMeNTlplyRtVxaVKtl/ijqQIqbBTh7jCII=;
        b=mWJOVgTFv+fb4XZ8HVxPvXZbdGwoPCQZVcsgtzevvquMF4Hv9+z9lhMOiivH5Mfon2
         kTGdVgtyDD1RFQZQEv/AM2KVSvIoSuo85MCyfbFz24wcZoNGi86bGTJdX1WKaTTzl29+
         MrMT7/JPo85cGGlqngfjdeOVIoi0G65D0GQA1XUGzKLGM+y1lIsxehknvOqDHYQJrwyw
         tXCfGhcKgt29jjxOfD0HXh6P8cf2nI07cBxa+6cMxN2lVdi9rIiXCnWK4yqI7qQ5+7fv
         Ih27nNxa/WiUgOWLpW5yXrs4kqHDsxwFMV1d9J6apzJJ1vptSGF/ZtYz5yS5MrQ4qDCu
         aG9g==
X-Gm-Message-State: AOAM533INgX767UhzNfBW/W2M0R54FwGPnTuqHTwhKmcjL8B211X008T
	XHiea/60rYfS9avp1fMJpkeetmmVNGTp4gry6GA=
X-Google-Smtp-Source: 
 ABdhPJyQHK7Bpi8TrLhZs0CvSwxN+xwaPTua8D1SYzM7HR2HQ6RC9ki+XFSjyo9lvPldJnmZCNIC5w==
X-Received: by 2002:a17:902:c3cc:b0:141:be17:405e with SMTP id
 j12-20020a170902c3cc00b00141be17405emr3048769plj.76.1636416854010;
        Mon, 08 Nov 2021 16:14:14 -0800 (PST)
Received: from hexa.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com.
 [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id
 nm13sm414946pjb.56.2021.11.08.16.14.12
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 16:14:13 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 0/3] Pull request (cover letter only)
Date: Mon,  8 Nov 2021 14:14:03 -1000
Message-Id: <cover.1636416772.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Nov 2021 00:14:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12952

The following changes since commit c222eddcebe892ae209aea7776cfc1147ac1df6e:

  fetch/git: Handle github dropping git:// support (2021-11-03 11:30:57 +0000)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.46-next
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-next

Richard Purdie (3):
  tests/fetch2: Fix quoting warning
  tests/fetch: Update github urls
  tests/fetch: Update pcre.org address after github changes

 lib/bb/tests/fetch.py | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

-- 
2.25.1


