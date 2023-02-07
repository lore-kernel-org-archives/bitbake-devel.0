Return-Path: <george.kelly1097@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020FFC636CC
	for <webhook@archiver.kernel.org>; Tue,  7 Feb 2023 22:11:15 +0000 (UTC)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
 by mx.groups.io with SMTP id smtpd.web11.4105.1675807866586295710
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Feb 2023 14:11:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=n4OVzzB9;
 spf=pass (domain: gmail.com, ip: 209.85.166.48, mailfrom: george.kelly1097@gmail.com)
Received: by mail-io1-f48.google.com with SMTP id y2so6239916iot.4
        for <bitbake-devel@lists.openembedded.org>; Tue, 07 Feb 2023 14:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o1wLtiXljxnrd1muFXzFKiHUtB4Ivf/QHlyj6U2OvNs=;
        b=n4OVzzB9OcBe63J7yYR1l+L4B+RVDZHaO8VBhdMPt4I/l6k3EMSl3Q2PZUVSjnLT4s
         RGsBHWEtTzrhEFi4JiSl4miSTcSKY3Opy0t5hzms74db0/BEn9xqbXLITeTSnDv5MJwB
         6T0yk/mi/Fc73R8WCySfRirg8etHcqXUlBCm9+YyGaHc2guAzxU6uxPQqNslcZZjWkH6
         tCUI6E4yaDWRn0fvazG/xEpTcEVJk2jcoajH3BJERJUcqvErnOeEbNycyrFlA+3nSgHM
         HFDBicJVqtc+WkK1W/Vzc7ydO7PKtzDDMVLM5Ezu7Dr69ns6VmZ8MeP997L8btc3V664
         hwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o1wLtiXljxnrd1muFXzFKiHUtB4Ivf/QHlyj6U2OvNs=;
        b=Lv1SmavKy7XPw4bHppIP4TxM0/+0s/5AiDrYMX5EajvnfwDpZ0Ac6eh+Yen4sqId4L
         Qgx+10XYX5+2TQNuXkaEyoZwyzimXNWCC8g0ndI00QsL8NfrNpAv5RoKV2/h4aActom0
         GK9O2Dw1a2yEjwgJat05FUoQtMoFfk6A70KOvK7u/dBkPmlHWiGkALTsXUKAWx/W2eEf
         cs5jVjDYP2QoD8sW9Ss7CVpAVUbjVOAEpikb00RDY+6mQMAoQ7tpxnnoV+TUTrm5kDaj
         8dkwpqPSlLFc6ULShSS2l5NmhIKR4nPwZ8vPfdAmQoHfjJ0udZBOqzu2Xpi3N/BHrpyW
         baHA==
X-Gm-Message-State: AO0yUKUmgcFgtpLWf6xZObg49HbTanmfm4Y/G8hFFveIOmvbo3t+VB3w
	gcQQYB7j1eUc9IY808DPeYrG/b6PSR1fjA==
X-Google-Smtp-Source: AK7set/Qg6hOfvPS5btVUDNwcjI8udPoAvMhgJHUY5gyE/PIeOpv3v7XgjAFDblXlIqepZGnEYXnPA==
X-Received: by 2002:a5d:9ac1:0:b0:6e0:7dd:5976 with SMTP id x1-20020a5d9ac1000000b006e007dd5976mr279428ion.12.1675807865353;
        Tue, 07 Feb 2023 14:11:05 -0800 (PST)
Received: from gk-ubuntu.. ([50.201.15.182])
        by smtp.gmail.com with ESMTPSA id m12-20020a5d898c000000b0071c66d1a2fcsm4167305iol.0.2023.02.07.14.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 14:11:04 -0800 (PST)
From: George Kelly <george.kelly1097@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: George Kelly <george.kelly1097@gmail.com>
Subject: [bitbake][PATCHv2] Add NODE_EXTRA_CA_CERTS to export list
Date: Tue,  7 Feb 2023 17:10:22 -0500
Message-Id: <20230207221022.4346-1-george.kelly1097@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Feb 2023 22:11:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14384

If you are behind a corporate proxy, the npm fetcher uses
the proxy IP address already passed in the list of exports.
However, it will error if the proxy injects its own root
CA certificate. Thus, the NODE_EXTRA_CA_CERTS environment
variable must be passed so the user can include their
company's root CA as a trusted CA inside node's
certificate store.

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


