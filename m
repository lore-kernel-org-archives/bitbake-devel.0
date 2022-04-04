Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B90C352B6
	for <webhook@archiver.kernel.org>; Mon,  4 Apr 2022 18:46:41 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web11.35739.1649081949396197784
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 04 Apr 2022 07:19:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=FMJimHOh;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.42,
 mailfrom: steve@sakoman.com)
Received: by mail-pj1-f42.google.com with SMTP id
 nt14-20020a17090b248e00b001ca601046a4so5167727pjb.0
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 04 Apr 2022 07:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W85pkbScQSFAj2CAzAAvKdE12uZJbjVQyytot8NpOsE=;
        b=FMJimHOhzSO83msMugJZ2LVxBOATt6YewTsl/CjYd3m97jcXFVCpek1K0d0PuYSrQ8
         Q6BY62QZ414SG7PxURImb0xIuExLvlpeNiPQtOuY+5P2SjWbFi+PPT1B1xSw7dic7buN
         +Y7VoqrB/8/F545GeQIt7luYzUiG31SEhK0WzF6newm6yCJ79YDIKQARaywx/QmH3pdw
         fhNo1q6o13cJBmWLZkydSGpXT0kIYbgu8n6Nun0IpnosRBtfIWtQ0yXmd9SIGdCq3wop
         Zk37r7omGMeyf5JlAaj5eyxiKWOEhL82+rGWiI0fjKRLd8+StCq+htiUR5gwjuveagEH
         BU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W85pkbScQSFAj2CAzAAvKdE12uZJbjVQyytot8NpOsE=;
        b=yfN+Olkgb97iKVXgk+O4CPfaV7h0g3X2uEBKGp28vxfbkfw+exi1WCcI1Ad+04ZXOz
         O8fh2NxyNF8p26FeVLwCSBJDDw3CspnzIIbfLrWeYzU79E3LZaTE4ED/ddKJ2b5TXmLJ
         e812NJLd1FU1JAYCEWl3j7fdDofoC1tC62KIrpqGpR8r0ESD0vPZfcORLMjPg6d+GOtq
         v7Rh+VCTtEipX17DX1Bb3gqEQT/m0z9vLzo6sxUN0wYkVox8nMpmOwc+qgUYCsjm4rGL
         B6nsZvNp8PkbDLra8oZlAYZ1KpSc4E5Qk/PWbSiOT1VWcCYmMzWSxegVTAlYajUVMcde
         GeaQ==
X-Gm-Message-State: AOAM531dr1GnbX2zoqbhMq5LTcNQVF6Z1Y7qF3MDTZ8VVAgk0iB6OP+e
	Eai79Ron5Q6IOzK4/9jbhx3bLoafUbN4TmCWCOw=
X-Google-Smtp-Source: 
 ABdhPJxUDVGRxVlH/F8gXrp9cilixi9uYaYgGacyp/+vq4UcqZOZds9ZQ8PSVpfTQt5eBJz4qRjvzA==
X-Received: by 2002:a17:902:f212:b0:156:a80c:e10d with SMTP id
 m18-20020a170902f21200b00156a80ce10dmr95276plc.11.1649081948129;
        Mon, 04 Apr 2022 07:19:08 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 u14-20020a056a00124e00b004fab8f3245fsm13116106pfi.149.2022.04.04.07.19.06
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 07:19:07 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 0/1] Pull request (cover letter only)
Date: Mon,  4 Apr 2022 04:18:54 -1000
Message-Id: <cover.1649081576.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 04 Apr 2022 18:46:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13578

The following changes since commit 41bf1fa85a540232dcf92fe473c3b3c4cd7259dd:

  tinfoil: Allow run_command not to wait on events (2022-03-28 13:30:40 +0100)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.46-next
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-next

Scott Weaver (1):
  fetch2: add check for empty SRC_URI hash string

 lib/bb/fetch2/__init__.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.25.1


