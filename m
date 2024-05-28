Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C544C25B78
	for <webhook@archiver.kernel.org>; Tue, 28 May 2024 13:15:22 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web11.21942.1716902116264489480
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 28 May 2024 06:15:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=cWhEfPwJ;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.182, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f32a3b9491so6015195ad.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 28 May 2024 06:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1716902115; x=1717506915; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aKo8NMmIhQO4wF4GdLLK0RrBVovmJ+T01Vbk/s0muyA=;
        b=cWhEfPwJfQHRKy+gE01c9UvKr4F+HQvcG3Jo7gHP012gtETe3eHPZCAiu4BmQs3Jvx
         e9qoqdeXyF84rf9NiIDG8Chh/UeT6+sdV3jNDpgIHRj85G++X8PyIJROmRnfejAV0TZ4
         zxAu+TnZwCSJ0yOMdIBtLDgQNMqSKF7kZ8caiPXX0cJTNm7aRj2LWvvY3tt8qrMg2PLf
         hV31g/IQ1lKDQVZkekGMWP/UVtl0Qn9PfJu3YOLU0PwEI4ypWRCsvzoeXxWYaYh60AIq
         sZiUkER5+qMtPbpRCmEyWMB9mzT/hzlrTT5fb4ujeZUp93zKLybUPJzM9epLnj9Raeuz
         +Amg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716902115; x=1717506915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aKo8NMmIhQO4wF4GdLLK0RrBVovmJ+T01Vbk/s0muyA=;
        b=INthe2+nZJCCQ8y3XzeBG9gojge6Cfzs44/ttphcpHuY7Mo5Td4f6rUxdq3Ie5OP71
         K1ItprC5xIRRsKhcLJsnut5vjaX8r/vhfKKg0akoFw7G1hxxEUAYxgAqZmfJbjGZe9rF
         nGSURAcy3pHIAzKJrslNm1vXuIVk6dHPQWzztcs/0TLV4hBkYcqG1vYSz6AZQ9TaT7mA
         72hnp184/GY1+rFA/TmtJkeLpWtI7GB6A/gshpCm9QcTMifFMpSwHeSu78Q8aBEe/TrT
         Jz/7sW8+9UBh2MFcGx4ikrFeDgKaFJYotszHZJJGnbPJQDNziqiRFC95ZnHn5LpoL13y
         bf3g==
X-Gm-Message-State: AOJu0YxC3B62OqFROa30pw069BAkB8JwBaodjKk034o09sdoptlZQHq8
	NuD8G3QztzNRyY/giU8BdfGnFusoyAgUzMmND17a3XJ9/5G9ri1WZXyYq5FUrhW4t1basnv2lbH
	e
X-Google-Smtp-Source: AGHT+IG64kkxwLNfV6CuxIjjHCIjc5EZC8RpF5wRy49r7UlI9dR8S9QDs1WRhetubP3twvyPA1VDzA==
X-Received: by 2002:a17:902:dacc:b0:1f4:be9b:d306 with SMTP id d9443c01a7336-1f4be9bd71dmr29983285ad.31.1716902115312;
        Tue, 28 May 2024 06:15:15 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f456c68f2bsm75561305ad.67.2024.05.28.06.15.14
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 06:15:14 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 0/2] Pull request (cover letter only)
Date: Tue, 28 May 2024 06:15:06 -0700
Message-Id: <cover.1716901975.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 28 May 2024 13:15:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16271

The following changes since commit 8f90d10f9efc9a32e13f6bd031992aece79fe7cc:

  cooker: Use hash client to ping upstream server (2024-05-02 16:07:18 +0100)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.8-next
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.8-next

Richard Purdie (1):
  parse: Improve/fix cache invalidation via mtime

joshua Watt (1):
  cooker: Handle ImportError for websockets

 lib/bb/cooker.py         |  3 ++-
 lib/bb/parse/__init__.py | 12 ++++++++----
 2 files changed, 10 insertions(+), 5 deletions(-)

-- 
2.34.1


