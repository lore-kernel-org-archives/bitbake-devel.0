Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6069BEB64D7
	for <webhook@archiver.kernel.org>; Fri, 30 Jun 2023 17:24:09 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web11.19825.1688145845265293406
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 30 Jun 2023 10:24:05 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@sakoman-com.20221208.gappssmtp.com header.s=20221208 header.b=vDonN1iZ;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.172, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-666e3b15370so1386558b3a.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 30 Jun 2023 10:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20221208.gappssmtp.com; s=20221208; t=1688145844; x=1690737844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UBdyQkK1IPqnWaiLh2MuN81HMWOE224I2mOwYaOH/II=;
        b=vDonN1iZawN+YKkuFhTIR2LoHsqL6LqVkjGWWyd8ekDEfR2nOjDi0cwTZyWlA9vW2X
         xtIlsYc3/YaAKoIDsRCQdIqJM1AFaIl3XmS1Dupt48wA5s4hnlZ6ykKnJDE1kFe5BvJ9
         e3+WQydypqy3mFfZ+3Cpa0Lo3fgzHquSyV/RfvI5E3krJMSrcoUbxGuljNdv+IIg1t5A
         5fk2OjgWf8KxlagczEDh1g+TYWzeg091/g+CdG80IvRFMUNOz/87+/k79F8b2tdcYLMu
         7muKxqGOgyIUlLqsM+cYlqZil3yjCZJSf+riq5DYhxr28xgYP0xXkR7DwkYLAJZEXhYT
         h6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688145844; x=1690737844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UBdyQkK1IPqnWaiLh2MuN81HMWOE224I2mOwYaOH/II=;
        b=Hh22SV7E5UIlhj7hBRGj/w+aWOVAo4+s4OF+nAvlNRJUBls1UnhKheT5U0MzqBYBW9
         wzVBowDVeygxwNaHn2f7DhMjhlmKzWRUTNlbMUGjSlXlw6pjvIye1zmOajRgybeWWhEu
         1NYjKqNXvrEe17Kk6p1vNloPB6CfS39xWFlmaLZVh/5DeHI3Ow2lMBY9svPh+q+ODOBU
         IThoBwksnCKwe+QvBIwvb46DXeMkodq67Q3UTg/SbHNq9APu4kii+uX2QjjXAy53LT3v
         VPNJXXHsfai3C97DCt47qd4l1ZpUmpcc90eiHn0G6DJ1xgkhY9o3dUrylnBJ2+iBYdlT
         RSNg==
X-Gm-Message-State: ABy/qLbDE8B/ijjmv3Sv2kHOK87D1xnNqMB0mOlOFUcVnJsByAHwak+T
	edLXj/fFYgHLNilgRfksvWq31V/Y4f84i6odymVgSQ==
X-Google-Smtp-Source: APBJJlE3EzEZfadNwy4koWScv7gaJtFon26uU5/aD2P60840V1PSpHS8ohWYAFt33rJDS/8ehn9V0g==
X-Received: by 2002:a05:6a00:248f:b0:668:852a:ffc4 with SMTP id c15-20020a056a00248f00b00668852affc4mr3794895pfv.4.1688145844078;
        Fri, 30 Jun 2023 10:24:04 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-234-106-30.hawaiiantel.net. [72.234.106.30])
        by smtp.gmail.com with ESMTPSA id d29-20020a631d5d000000b0051b8172fa68sm10788651pgm.38.2023.06.30.10.24.03
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 10:24:03 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][mickledore][2.4][PATCH 0/1] Pull request (cover letter only)
Date: Fri, 30 Jun 2023 07:23:59 -1000
Message-Id: <cover.1688145709.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 30 Jun 2023 17:24:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14872

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/5547

The following changes since commit d97d62e2cbe4bae17f0886f3b4759e8f9ba6d38c:

  bitbake-user-manual: add BB_HASH_CODEPARSER_VALS (2023-04-22 10:29:49 +0100)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.4-next
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/2.4-next

Richard Purdie (1):
  runqueue: Fix deferred task/multiconfig race issue

 lib/bb/runqueue.py | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

-- 
2.34.1


