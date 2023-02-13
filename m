Return-Path: <pedro.miguel.baptista@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC31C636CC
	for <webhook@archiver.kernel.org>; Mon, 13 Feb 2023 13:55:58 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web10.14612.1676296553369017443
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 13 Feb 2023 05:55:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=dfCTDypk;
 spf=pass (domain: gmail.com, ip: 209.85.221.51, mailfrom: pedro.miguel.baptista@gmail.com)
Received: by mail-wr1-f51.google.com with SMTP id m10so3402884wrn.4
        for <bitbake-devel@lists.openembedded.org>; Mon, 13 Feb 2023 05:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KmZ7Jf+bgYoKUCDT5pfX3zDzEfU75AAssjSMx3XkDiA=;
        b=dfCTDypkHqXIG14LoZLftYUDeqcOhtEN19NhU7mTfT1bcyzEBf0CmOLERV20YKdR3c
         0vQ2cj4h/ZMbKj0q/NyOXG9XYd5wtmlYewq2ITPtVNlvtbv7jWZvUByXwo3iVKf/jFO/
         mS4i5US2sVC6Vu1viISXf56RTr7MFf5grcwTrXYuAWJA1+GTq3xfeWkt5smGAHNhzES5
         j1ME2mNQheui4qDQm7dmVQxyOC4PxmsJ5XMOjVKNIdpBycqZ+VqIrCzSQmBEVNs9HrR7
         R5ZFlyjujU7Ngd+K5hjnWKJZzkG1V2hJw8LbNrCWKWVSo3Mt1hNCTFxrzePdGUgp7Rnk
         tBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KmZ7Jf+bgYoKUCDT5pfX3zDzEfU75AAssjSMx3XkDiA=;
        b=dy1wjJu+97layUfr1WRAjL4LM//eSNKAYYDPhTDfKD4TGIAdjEpWusn2G6K2SGgEjc
         /OHpNWLXVLo3MgIGwmudtPTezrqe4PLoG/cKbOHJkxOFxo40DKFbv3KgnE3HEfs4RLmK
         1a2Uk4Khn5kxrR+lRxovOv5y9Lpqm7rxBhnYN1bKKKl4d+2FaOkgYWzK8Fz/TMiavqfa
         I/dw3RTWLsJD3sqTOvcHrJBc6yrcR3ZjDlIzFzFph5OiCZP/AyuYbcK3u0+KVO2Z0IlR
         r4AjphEWN5hJdJteLyT9XkTshv0u78f3ndvmqYLRZ1dbf33cNp2OYlPAJyI9OJ0bEC6Y
         ux1A==
X-Gm-Message-State: AO0yUKWaIogtSx6uEYjkP4tAbCNDWRRy8ciXspFJ1MkSD61doFaEx3Ww
	saYiDn20DZztUayo4eQ8C57kgrYw56c=
X-Google-Smtp-Source: AK7set9CP7Yp7InB6ulfEdGbMApogmdcIP2lYlZnSKG1rIinQ46AuOdpKF9Z2mJUjPrynE7qyVqdEA==
X-Received: by 2002:a5d:528f:0:b0:2bf:d285:b787 with SMTP id c15-20020a5d528f000000b002bfd285b787mr19855707wrv.56.1676296551402;
        Mon, 13 Feb 2023 05:55:51 -0800 (PST)
Received: from localhost.localdomain ([213.13.226.153])
        by smtp.gmail.com with ESMTPSA id j37-20020a05600c1c2500b003daf6e3bc2fsm24594799wms.1.2023.02.13.05.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 05:55:51 -0800 (PST)
From: pedro.miguel.baptista@gmail.com
To: bitbake-devel@lists.openembedded.org
Cc: Pedro Baptista <pedro.miguel.baptista@gmail.com>
Subject: [bitbake][PATCHv2 1/2] action.py: add BBPATH in bblayers_conf path for add-layer
Date: Mon, 13 Feb 2023 13:55:24 +0000
Message-Id: <20230213135525.3650-1-pedro.miguel.baptista@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 13 Feb 2023 13:55:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14397

From: Pedro Baptista <pedro.miguel.baptista@gmail.com>

By including the full path to bblayers.conf the add-layer
command can be executed from any location, not only from the
build directory.

Signed-off-by: Pedro Baptista <pedro.miguel.baptista@gmail.com>
---
 bitbake/lib/bblayers/action.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bblayers/action.py b/bitbake/lib/bblayers/action.py
index 454c251410..a2208db0bc 100644
--- a/bitbake/lib/bblayers/action.py
+++ b/bitbake/lib/bblayers/action.py
@@ -37,7 +37,7 @@ class ActionPlugin(LayerPlugin):
                 sys.stderr.write("Specified layer directory %s doesn't contain a conf/layer.conf file\n" % layerdir)
                 return 1
 
-        bblayers_conf = os.path.join('conf', 'bblayers.conf')
+        bblayers_conf = os.path.join(os.environ['BBPATH'], 'conf', 'bblayers.conf')
         if not os.path.exists(bblayers_conf):
             sys.stderr.write("Unable to find bblayers.conf\n")
             return 1
-- 
2.34.1


