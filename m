Return-Path: <george.kelly1097@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3691EC05027
	for <webhook@archiver.kernel.org>; Mon,  6 Feb 2023 19:11:56 +0000 (UTC)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
 by mx.groups.io with SMTP id smtpd.web11.63116.1675710712160790590
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 06 Feb 2023 11:11:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=YCRqR08P;
 spf=pass (domain: gmail.com, ip: 209.85.160.174, mailfrom: george.kelly1097@gmail.com)
Received: by mail-qt1-f174.google.com with SMTP id g8so14045394qtq.13
        for <bitbake-devel@lists.openembedded.org>; Mon, 06 Feb 2023 11:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EO/OoXHhMozQYC0vTCHk0BKdJOm1GGxtZpiA3FSS3vw=;
        b=YCRqR08PjVlCuMqSgsMQjsHONl/9LXh2YbU1WsjY1G30Ehp4l64NfGcMkdPNNeQHW7
         TGJfkdI/peL5axc2WHieNj8x5Krqsu17j+pujDwo+VIplJ1p3pPBSIa3mwYWNgm9dAca
         3Dpbe3RXUdyzWh9rYVJ4YqmGZg18srg5fYHhi4g3zI6wc29oUPU1hNMqVkJKVPg9s6ld
         eopKgCc+YZHVomukl8AFlqCmDY7ByJOIytDWd+30NUFCHlS/ZeIHR8/Z2s41deK4Nd1t
         Hzn5SRdoD2A9ClcqSS6wxogzkKCXeeDuytJ9utbNWlI7xufN7h+Mv9M/qutmsWPocAge
         2bRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EO/OoXHhMozQYC0vTCHk0BKdJOm1GGxtZpiA3FSS3vw=;
        b=p4TBn9+L6MVsaDoTF3MzDU9slV2c4xLB+2mAMnX2cjRk70cmCHeh7ngANwH0mQ1ewj
         nbgExLaELScEPfZbxH85FzMa5T06r7B2P8aENACS2z+xVcSJu781WKt7jBdZpA/gho3U
         73/qhirrwumrO3I9tZ/AI5uulyIdMKPgMMXi9SuEziKgI5Emf5OX0+c0b2ZX6I0/BKs8
         fSzWRt4WLQjg/Z33afly4gDeTGsPpC7cqRkqj5XobK809M/utJkRIfUkwj08L3j4UZo5
         ZRJ83oO5vFwbxavR0jcOX+h/O6tcNNVA/SOSALBPCiPj0ZGjmV6XyY6/R2z/drrdVVSp
         XaiQ==
X-Gm-Message-State: AO0yUKW9uah4CaZ4kDvOiM4i4ao/0QXdiLcSpv4cjZ+bUG2sPE2xAvy7
	5t+lbFbtTfkuCgexUEaZgl7MzuDAWf8=
X-Google-Smtp-Source: AK7set/g3Q1ZttVhG5dLeAMZBubCMBQ/Xs+lhTwGyiq8t/jUJXc2mhPHIeGbvoLC2WwFh+O4u3G0TQ==
X-Received: by 2002:a05:622a:44:b0:3b8:6043:daf8 with SMTP id y4-20020a05622a004400b003b86043daf8mr687300qtw.47.1675710710915;
        Mon, 06 Feb 2023 11:11:50 -0800 (PST)
Received: from gk-ubuntu.. (172-222-054-105.res.spectrum.com. [172.222.54.105])
        by smtp.gmail.com with ESMTPSA id i18-20020ac80052000000b003b82489d8acsm7702100qtg.21.2023.02.06.11.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 11:11:50 -0800 (PST)
From: George Kelly <george.kelly1097@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: George Kelly <george.kelly1097@gmail.com>
Subject: [[bitbake][PATCH]] If you are behind a corporate proxy, the npm fetcher uses the proxy IP address already passed in the list of exports. However, it will error if the proxy injects its own root CA certificate. Thus, the NODE_EXTRA_CA_CERTS environment variable must be passed so the user can include their company's root CA as a trusted CA inside node's certificate store.
Date: Mon,  6 Feb 2023 14:11:42 -0500
Message-Id: <20230206191142.17353-1-george.kelly1097@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 06 Feb 2023 19:11:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14373

Signed-off-by: George Kelly <george.kelly1097@gmail.com>
---
 lib/bb/fetch2/__init__.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 5a7a6024..747356df 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -851,6 +851,7 @@ FETCH_EXPORT_VARS = ['HOME', 'PATH',
                      'DBUS_SESSION_BUS_ADDRESS',
                      'P4CONFIG',
                      'SSL_CERT_FILE',
+                     'NODE_EXTRA_CA_CERTS',
                      'AWS_PROFILE',
                      'AWS_ACCESS_KEY_ID',
                      'AWS_SECRET_ACCESS_KEY',
-- 
2.37.2


