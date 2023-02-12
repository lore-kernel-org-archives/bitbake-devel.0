Return-Path: <pedro.miguel.baptista@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFACCC61DA4
	for <webhook@archiver.kernel.org>; Sun, 12 Feb 2023 00:21:01 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web10.2156.1676161253844072769
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 11 Feb 2023 16:20:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=fJ3pxfKx;
 spf=pass (domain: gmail.com, ip: 209.85.128.52, mailfrom: pedro.miguel.baptista@gmail.com)
Received: by mail-wm1-f52.google.com with SMTP id m20-20020a05600c3b1400b003e1e754657aso399924wms.2
        for <bitbake-devel@lists.openembedded.org>; Sat, 11 Feb 2023 16:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u4yMormXEVWKkqm2ofu7rt1tZdqU1ALrYK9tYrfatM8=;
        b=fJ3pxfKxH2oH/2u++OoFAyCqIRNrQDtjRRVzQtQJfQtscz86MGL7rlK2nXu9v6Uc2R
         Z7wJi4tpxML/5FUEyAmNxo/9HVs3FkSAsp4Nl1chtgtwRg2IwCTv5c+Azvz2/aFnv/90
         3noFNSd4Gw2bBbyzTZMGwJJz/cV4PD6nvXv5VUnvpz/KHLCLznY7JWBt8KiHGBuVjYuJ
         5ZDUqcqnhAHic9IsyVKjmoCcxD2SdGomLUL/uU9oMx/iu6i99Gvvp1XEsaGv6UZ1ajYn
         HsATmujRwN4YHxDNoeF2GRwlbrOFmHVDS8PP9KNBUv85+/7g/lBZMC45PA1ckDmkn5ZL
         R2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u4yMormXEVWKkqm2ofu7rt1tZdqU1ALrYK9tYrfatM8=;
        b=m1qLrJR145uASoWHx+YxK1JL2UXgQ6ykKdYoonQW6H54izua8+LGD8iWckVY+uDh3L
         4AMFC+vQGLE7VIVfAhF/l7iNPmbC4Bcoa34nul6Lx6lqp7080pKOszr21n2EBL0i0oML
         dSSyDWtOCxcrdAAFDyNpsAKvdo2HEQNVUCVw2VT6E7qo4xj4vebftiJ0jTosE9wTGK+5
         rNkcojY2numPbPNHyGsuEKX9zTrCMVXo/E/b/KG/M/7z4biYIDB9XGJ6MkZ8gkCHIe3M
         5T17AlTWoyRV9iUG+dUemS+xGFuZyrIElicNDiS/8Mh+YYa7IJbLnt4TKh2R7SZEhiJS
         V2ew==
X-Gm-Message-State: AO0yUKVH8YsD6RqJfS+Tn0jFR0NBeBCQNYAnSQL1zfEHlvtmewSo6VH5
	RlEMEsaJOzVZTKZEXdZZBRzrE9sffcw=
X-Google-Smtp-Source: AK7set/JLzhOIgEnMjR3dhTZ0c0UywE3L3Aj9kjSdl8of5WFssUKg9SFfCk5g7TFmg8Ms7uKpR4utA==
X-Received: by 2002:a05:600c:998:b0:3dc:59ee:7978 with SMTP id w24-20020a05600c099800b003dc59ee7978mr15739639wmp.38.1676161252029;
        Sat, 11 Feb 2023 16:20:52 -0800 (PST)
Received: from localhost.localdomain (dsl-120-219.bl27.telepac.pt. [176.79.120.219])
        by smtp.gmail.com with ESMTPSA id s21-20020a1cf215000000b003e001119927sm12232081wmc.24.2023.02.11.16.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 16:20:51 -0800 (PST)
From: pedro.miguel.baptista@gmail.com
To: bitbake-devel@lists.openembedded.org
Cc: Pedro Baptista <pedro.miguel.baptista@gmail.com>
Subject: [PATCH 1/2] action.py: add BUILDDIR in bblayers_conf path for add-layer
Date: Sun, 12 Feb 2023 00:20:23 +0000
Message-Id: <20230212002024.5430-1-pedro.miguel.baptista@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 12 Feb 2023 00:21:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14394

From: Pedro Baptista <pedro.miguel.baptista@gmail.com>

By including the full path to bblayers.conf the add-layer
command can be executed from any location, not only from the
build directory.

Signed-off-by: Pedro Baptista <pedro.miguel.baptista@gmail.com>
---
 bitbake/lib/bblayers/action.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bblayers/action.py b/bitbake/lib/bblayers/action.py
index 454c251410..76a2c5acd2 100644
--- a/bitbake/lib/bblayers/action.py
+++ b/bitbake/lib/bblayers/action.py
@@ -37,7 +37,7 @@ class ActionPlugin(LayerPlugin):
                 sys.stderr.write("Specified layer directory %s doesn't contain a conf/layer.conf file\n" % layerdir)
                 return 1
 
-        bblayers_conf = os.path.join('conf', 'bblayers.conf')
+        bblayers_conf = os.path.join(os.environ['BUILDDIR'], 'conf', 'bblayers.conf')
         if not os.path.exists(bblayers_conf):
             sys.stderr.write("Unable to find bblayers.conf\n")
             return 1
-- 
2.34.1


