Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3833BC4167B
	for <webhook@archiver.kernel.org>; Fri,  8 Dec 2023 15:18:05 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web10.38245.1702048681444231841
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 08 Dec 2023 07:18:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=1fkLRynO;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.182, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6cea2a38b48so1712615b3a.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 08 Dec 2023 07:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1702048680; x=1702653480; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wom4Boz+0udlwMz8yNNL8vf7jIRJddM1wBMJBTpQY/M=;
        b=1fkLRynO+ZePvvt4XKyBcS+QAn34sI+UDBSdc2dAhn33KgpaMoUJzgbGJqv1ELdLvR
         xySCFeWxCW6dsj4vFEgpWOmF7/+cGl2J1wwyUYkTs/WxznmW+RFUydll4gdjNdcLIcLh
         teJroEIwhI8yrn4vh5flgYYE5YLQnkBGiyM1cnCieIEKGn8VdMRA9U7O+YsP+8OUSy3X
         UriMvit4KpnD0WmxNSObhEKKYTzsgnrv9i/3YXFjO+WcRZzsP5j/3qzOLzoklsos4o7C
         l2M7iYoq1sOoXO9Yapbvm4ezInB2/bh14guCQKnxvPNAc0C5Sbb4dMOVsrOod6WG7WSG
         CiyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702048680; x=1702653480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wom4Boz+0udlwMz8yNNL8vf7jIRJddM1wBMJBTpQY/M=;
        b=CCZg64wEDFbFMy+vA90llqGGYI2qXPCUHv2KUSCZtqzoV0zwp/7cntYRDRNvixXq3r
         +uGHNwAmtx+DLIwkid0RiG2F96GjD+fbmT+2LLaRTO023JoGeDNFvlY3AvygB427pQkX
         9NlsyT+wOQvma5AnBzdO6//8V8N4U8f1QRFJ3zFu6nTyWS57lH/4dpeOhaBcPMQwfFby
         1uN4I4aUuexT6shEUmmnN/Yp0hdvIp6gXp++Of+gHsY/tEIBdMxEpJucpXERqOjSoRTP
         Kaw60P47etNkoQ29KyWRvM5QuMlDYKmu9qt3vqLa/yti4Qw4bd0SUAe/ihA4bN7ri61h
         fbEg==
X-Gm-Message-State: AOJu0YyXcl8AEzmr/RMk5ADvIwej5zZI/h4Mp2ioqklN1KlwarP8jcO+
	PMGT+lXK/FkbUPZWGkp5pnTfEYjtR7U0KYJKACk=
X-Google-Smtp-Source: AGHT+IH0D3hJTwbaaanVymv1HJuyRhDJnnvT/x64gnpaAahT5rHpC1hfKyzQ1ZQCHjVEN08d6MQWVQ==
X-Received: by 2002:a05:6a00:1742:b0:6ce:5288:f75c with SMTP id j2-20020a056a00174200b006ce5288f75cmr203049pfc.34.1702048680448;
        Fri, 08 Dec 2023 07:18:00 -0800 (PST)
Received: from hexa.lan (dhcp-72-234-108-41.hawaiiantel.net. [72.234.108.41])
        by smtp.gmail.com with ESMTPSA id fb32-20020a056a002da000b006ce7ed5ba41sm1668431pfb.55.2023.12.08.07.17.59
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 07:18:00 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 0/5] Pull request (cover letter only)
Date: Fri,  8 Dec 2023 05:17:53 -1000
Message-Id: <cover.1702048336.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 08 Dec 2023 15:18:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15641

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/6300

The following changes since commit a7f6c3e67bd9170e93b2b94676e84018faf0df91:

  Fix disk space monitoring on cephfs (2023-11-09 12:49:31 +0000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.0-next
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.0-next

Chen Qi (2):
  runqueue: fix PSI check calculation
  runqueue.py: fix PSI check logic

Martin Jansa (2):
  runqueue: show more pressure data
  runqueue: show number of currently running bitbake threads when
    pressure changes

Richard Purdie (1):
  runqueue: Add pressure change logging

 lib/bb/runqueue.py | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

-- 
2.34.1


