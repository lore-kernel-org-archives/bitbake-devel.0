Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AB6C6379F
	for <webhook@archiver.kernel.org>; Tue, 14 Feb 2023 15:28:55 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web10.10122.1676388529746511584
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Feb 2023 07:28:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=oUhpqrRx;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.42, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f42.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so20782335pjq.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 14 Feb 2023 07:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tgshcu4U8QinuoBBDfzyTMvgYg6FsgsiRK29oBEgD7w=;
        b=oUhpqrRxyL2KMPlYKzjKuyigoiNDwCjcOvhcfBqQzP8ynaazv7LMGw0Un9/JVLEW3A
         WeCmhjU+ZAzM81/BoxrlALzIa+ZzpnPfVUuywtltfDDayiQvC5zMMA3W2OpjNnwksjzb
         A4N/65Q/oxzWX2wDhZFlyASAGJprdf5TYAjX1W4HnufH1O05ODbxRaJTHcQ8U3r7aXVe
         VB2OelKsYcTwt0qHw5K5nsAlumQ1KQQyBq3Z/V2n/+KbFckpf7udzJzU1Z9N3NaZAgmJ
         ZIfHsqUiBVUiEaXjXbn8OzGux9AvuVHGdoNx0LypRqBh/QadtfzBXy3OfFZ4JyjmddUB
         sugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tgshcu4U8QinuoBBDfzyTMvgYg6FsgsiRK29oBEgD7w=;
        b=IxdY+S3zz8EhWIIPi2V9eh2HV0pzGrIn8Zl1WmWxurfCkz8VNmbo6X6ZIu9Prym+3j
         eolybDbtvVLrTaUOG+xm++B96tucDdKXgYbaXUCZVvmLSdonN+LyqTnKilq4K0owawaO
         hbvJk0HYRgutxlCDJmYC+7fgO1GlE7cdjwzseAAt4L5KITDdYjLNN/7/eR4hkjHvp4Db
         pYFiQbGMDCVjA2UbHpPecRcdLStssY6QR6NfGKjcinkYeV2OwfDj1X9dG2vH+tFDsuiM
         A21WVBMkaX1re2Oi66QnSir8n7/Bu/IPPNUMuLB0804q//1GDZK/efeTC5zyBaEYUQ0c
         H5TA==
X-Gm-Message-State: AO0yUKWTw/kTJqUuT865AIZGw8REmlgLv12tCb9HHAJbs8DcEbcuoDgn
	s7FTWB1osFe1SDrC7i4asAiCiGrF1BamqujYQUE=
X-Google-Smtp-Source: AK7set9X3VIibJZHgIsb0eXbBVbDsa61FebStMDJB5djdwkY+hy2A04LOx8dLvaAEZaox1DaaS7B1A==
X-Received: by 2002:a17:90b:1c0c:b0:22c:b1c5:ae87 with SMTP id oc12-20020a17090b1c0c00b0022cb1c5ae87mr2778925pjb.45.1676388528666;
        Tue, 14 Feb 2023 07:28:48 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-253-4-112.hawaiiantel.net. [72.253.4.112])
        by smtp.gmail.com with ESMTPSA id m3-20020a17090a5a4300b00233cde36909sm5624203pji.21.2023.02.14.07.28.47
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 07:28:48 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 0/4] Patch review
Date: Tue, 14 Feb 2023 05:28:40 -1000
Message-Id: <cover.1676388410.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 14 Feb 2023 15:28:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14414

Please review this set of patches for 2.0/kirkstone and have comments back by
end of day Thursday.

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/4921

The following changes since commit 86f2fa5261da959cda706c794a0047e5e89d4d6b:

  fetch2/git: Clarify the meaning of namespace (2023-02-01 09:03:36 -1000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.0-nut
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/2.0-nut

Etienne Cordonnier (1):
  siggen: Fix inefficient string concatenation

Marius Kriegerowski (1):
  bitbake-diffsigs: Make PEP8 compliant

Mark Hatle (1):
  utils/ply: Update md5 to better report errors with hashlib

Schmidt, Adriaan (1):
  bitbake-diffsigs: break on first dependent task difference

 bin/bitbake-diffsigs | 49 ++++++++++++++++++++++++--------------------
 lib/bb/siggen.py     | 11 +++++-----
 lib/bb/utils.py      |  7 ++++++-
 lib/ply/yacc.py      |  7 +++++++
 4 files changed, 46 insertions(+), 28 deletions(-)

-- 
2.34.1


