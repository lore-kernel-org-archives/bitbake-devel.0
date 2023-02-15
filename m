Return-Path: <pedro.miguel.baptista@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1CCC636D4
	for <webhook@archiver.kernel.org>; Wed, 15 Feb 2023 22:51:23 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web11.7735.1676501479952587609
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Feb 2023 14:51:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=AL9gNeLd;
 spf=pass (domain: gmail.com, ip: 209.85.221.50, mailfrom: pedro.miguel.baptista@gmail.com)
Received: by mail-wr1-f50.google.com with SMTP id h16so168569wrz.12
        for <bitbake-devel@lists.openembedded.org>; Wed, 15 Feb 2023 14:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rlFaKMwN+akowqBAljAuT0uSG6/31v06IdtJ9SOjbws=;
        b=AL9gNeLd9UuCcRGwlmdnBCnXwAmj8+iLKqdtmXsbOFxHryAK3QX9bO+SHT/iAHK+Bf
         bpbVFStFii+KMcNjskBj55TfZYuVntkwFicpJOsrAw0CkXXnfSsPwC4e2pfLSUdI5ik6
         OKjrv0aDAgHxWmqVMdjfi15nr7gfoyCIwcPB55LqhSRfRohf/kXA7+q+A6E5fU501zxK
         Wvjwjt+j1hF9dv3KdByrYfaFp8qYV9NG8g7iQ5H8rtw5hFrjo7NkrhPT9dqnSt9S0+iY
         EqT1p/D44zmCsjH8vcv9tvwxcmM6ntCQcI/95hUTqmQ1s4ZfzQYk/EgWvnSCxdFYxnyQ
         c6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rlFaKMwN+akowqBAljAuT0uSG6/31v06IdtJ9SOjbws=;
        b=JW67B9GezVxOom//uIDEYX18Wjvy7W4ThBFpk66HSZARbenEEgjeB36qPOankHRTJh
         /5IjyAxvr+0bnHilQG+VB2wkvUyS+JLlrdTNUU9ZLUynBjT///Vg0KhipYAVjSY0vup6
         s4eAaqo7b5w00+YCOjTp12i1qLuvWxfx9TypIy96GSOUiyn8s8NlTm4iWqscv4Eh7pky
         4A+V4xME9IzAqfcno4r6S+u6EuSvIO0hdskH8euSBdfkq7XWAo1yZ8S+KEj6rdaFbJCr
         PrNOXDgQ0Q4pGETO38d/lYmlRBa+P+aEnwnfRL93fdaL7nElFiO639G3A0xG4LJaGtPj
         dgTQ==
X-Gm-Message-State: AO0yUKXXcQvQiW6RgOmj6+OtDBN7Sf/0MZWrdFhaofzgSJs/GhyLWfQm
	1Ixiu64LsyILmOpjGk10wUzk1GZ3eIk=
X-Google-Smtp-Source: AK7set+0545fvfzIyRluvQQ7DpGygGdPyOL+wuNyXzvLO+N+VDrYJK+gnO3NTh3k6hjowD8xH8bUVA==
X-Received: by 2002:a5d:4b41:0:b0:2c5:4f41:e0 with SMTP id w1-20020a5d4b41000000b002c54f4100e0mr2714324wrs.62.1676501478056;
        Wed, 15 Feb 2023 14:51:18 -0800 (PST)
Received: from localhost.localdomain ([213.13.226.153])
        by smtp.gmail.com with ESMTPSA id d1-20020adff841000000b002c5640f9bf9sm5294476wrq.85.2023.02.15.14.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 14:51:17 -0800 (PST)
From: pedro.miguel.baptista@gmail.com
To: bitbake-devel@lists.openembedded.org
Cc: Pedro Baptista <pedro.miguel.baptista@gmail.com>
Subject: [bitbake][PATCHv3 1/2] action.py: add topdir in bblayers_conf path for add-layer
Date: Wed, 15 Feb 2023 22:51:09 +0000
Message-Id: <20230215225110.4288-1-pedro.miguel.baptista@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Feb 2023 22:51:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14441

From: Pedro Baptista <pedro.miguel.baptista@gmail.com>

By including the full path to bblayers.conf the add-layer
command can be executed from any location, not only from the
build directory.

Signed-off-by: Pedro Baptista <pedro.miguel.baptista@gmail.com>
---
 bitbake/lib/bblayers/action.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bblayers/action.py b/bitbake/lib/bblayers/action.py
index 454c251410..d1ba101de2 100644
--- a/bitbake/lib/bblayers/action.py
+++ b/bitbake/lib/bblayers/action.py
@@ -11,6 +11,7 @@ import shutil
 import sys
 import tempfile
 
+from bb.cookerdata import findTopdir
 import bb.utils
 
 from bblayers.common import LayerPlugin
@@ -37,7 +38,7 @@ class ActionPlugin(LayerPlugin):
                 sys.stderr.write("Specified layer directory %s doesn't contain a conf/layer.conf file\n" % layerdir)
                 return 1
 
-        bblayers_conf = os.path.join('conf', 'bblayers.conf')
+        bblayers_conf = os.path.join(findTopdir(),'conf', 'bblayers.conf')
         if not os.path.exists(bblayers_conf):
             sys.stderr.write("Unable to find bblayers.conf\n")
             return 1
-- 
2.34.1


