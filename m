Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FE4C433EF
	for <webhook@archiver.kernel.org>; Mon, 18 Jul 2022 14:02:22 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web12.27587.1658152937132859539
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 Jul 2022 07:02:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=fSB00kR7;
 spf=pass (domain: gmail.com, ip: 209.85.128.50,
 mailfrom: quaresma.jose@gmail.com)
Received: by mail-wm1-f50.google.com with SMTP id
 ay11-20020a05600c1e0b00b003a3013da120so7913379wmb.5
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 Jul 2022 07:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fqIh8GZSPYHkcbcKeOKsmLEd3Nyk2UYepWU+tJE5PVA=;
        b=fSB00kR7b1GxAYGNWEJReYcaIkFtxAw7cWx9NYPxM2v65peayZdKOgNIoIXwknmOqI
         VgMz1MjGh+snEiHpXmsmG9XP6wxGO5EIvY84asx+9Rxa5md7P1XjbVwLF4RQKIjXwvro
         tx+5WrnuwLfWS9N66MgJ+rPs65lyeAX+jaL75SyNIBPrUjmXtYakXQ2wYo4ab1ITXb3e
         /SOgiMvP06P2QqBM+2RDiwkcKlqX0HH/kxjv+GWbBnC9LUocxN3e//CiFqFm5Mq9b3rj
         CRC6ogSVxKwVgMop+SwqO/mBiWpkQtwPxmMpYI8Myzy2OW6oZkvm5zFzbGYXevrMVCph
         zNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fqIh8GZSPYHkcbcKeOKsmLEd3Nyk2UYepWU+tJE5PVA=;
        b=T4pVh6c091rQ199TmpxNTTaHyWxnbvfCpFHTnmnI+J5EUyQPU86TP9kcb8ARf87vY9
         vfE94es4l1LK/ZFVKNQ10bxgCKHmH2OqI8UiHFWMkBP+yDPMTlrvxHQYPlrsFE3Rnseg
         Jgq11rpLkUY7vQbIu+L1UDl9842dI0CeKUueSApQYIF4KJpQyr89bYYoY22o4ySYnMxW
         PbJAHVBZKKrBNEs9Untkbjb/ozA3VHU5YmNnQTDJGF7z28HZvWeLEejsEAMTC99ChaQm
         4SoR7ToC6M2BjnsKnn6E6jAdtWwsjYsc4K3w7z+feSQbK8rqWWwDyKluRJF6B2Ib0JJY
         EXew==
X-Gm-Message-State: AJIora/fBaNYT5Tk3TcCTWmxeAcm4OjCR2smbYvDQYXSABieWC4iTjk+
	ov1Cp9Ofo4wZInS1goV6KDQMMvq9Ko4=
X-Google-Smtp-Source: 
 AGRyM1vmqv8OUSHFptY8BmE0C0KOvfEgLzREoIoaJhh7TG/uW0WOU8xgFy1aaru+nmyw8mws41aIHQ==
X-Received: by 2002:a05:600c:4205:b0:3a3:1ad4:b886 with SMTP id
 x5-20020a05600c420500b003a31ad4b886mr5244410wmh.193.1658152935189;
        Mon, 18 Jul 2022 07:02:15 -0700 (PDT)
Received: from fio.lan (176.57.115.89.rev.vodafone.pt. [89.115.57.176])
        by smtp.gmail.com with ESMTPSA id
 b4-20020a05600c150400b003a03185231bsm14348067wmg.31.2022.07.18.07.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 07:02:14 -0700 (PDT)
From: Jose Quaresma <quaresma.jose@gmail.com>
X-Google-Original-From: Jose Quaresma <jose.quaresma@foundries.io>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Jose Quaresma <jose.quaresma@foundries.io>
Subject: [bitbake-devel][PATCH] bitbake: bitbake-user-manual: hashserv can be
 accessed on a dedicated domain
Date: Mon, 18 Jul 2022 15:02:08 +0100
Message-Id: <20220718140208.15388-1-jose.quaresma@foundries.io>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Jul 2022 14:02:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13831

Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
---
 doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index af4ff980..12aef3cb 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -401,7 +401,7 @@ overview of their function and contents.
 
       Example usage::
 
-         BB_HASHSERVE_UPSTREAM = "typhoon.yocto.io:8687"
+         BB_HASHSERVE_UPSTREAM = "hashserv.yocto.io:8687"
 
    :term:`BB_INVALIDCONF`
       Used in combination with the ``ConfigParsed`` event to trigger
-- 
2.37.1


