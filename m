Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE9EC43334
	for <webhook@archiver.kernel.org>; Tue, 19 Jul 2022 09:39:18 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web08.38670.1658223555951211586
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 Jul 2022 02:39:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=YSWTX15i;
 spf=pass (domain: gmail.com, ip: 209.85.221.51,
 mailfrom: quaresma.jose@gmail.com)
Received: by mail-wr1-f51.google.com with SMTP id z13so1145960wro.13
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 Jul 2022 02:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YCDWIMXddPkzjm5Luk7zemhLvqsHzFrbQZRaN8EfSAA=;
        b=YSWTX15iFW1HqbNBqPmZtrrJHTJvP/Ksbgw2eyASCZiK7/PLoSkVBl/JB9zUzqMEtz
         BtTaQ5kBTu9K8VBQ086y9ahLrw6DzExVAKm+6HxLuq383QZzGXU7uHCPR/AslDVT8+8O
         RkZkvbB3f8hZ++a6+bz/idu14tH472wsmCalMK31m6Ux7DN1nlXJqQSSCTIZDcxsqJHW
         c6lZpC6oYnlNso5BvzK8enUAztpP3oVgh0tePerKPmrC9kgDCsF+rU/SBC4EmnHy2igD
         xiApd3Rbkz8n+nHc/JjKTni6x9Ws8nvuXFkq3+9ucb4gNUblt/ppezDByX7BQ3q/yZDD
         Ev2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YCDWIMXddPkzjm5Luk7zemhLvqsHzFrbQZRaN8EfSAA=;
        b=fToMZQK0dxNqqAklCOt+DWaq4hyPf8FmKLhHoFbBU88k6tcv9H3tFYaAiV5S3S8l8y
         eFknMlV9WAUKkAkX3nO+DuE/PHeQhvo9kJnDnsqStHck4LOOcSIGffAmYMu89tb4jTsR
         uaknK0IjwLB0rPhoCgFvGgsmmMXejcTWo9gc+z2GZ/Cz47r8cJLL0T/VhyBn9rhuRwNE
         c2S1IkB4ttBx8i47LaK2cbcSMvmT1Qqmuk5MeELHXoT//4QFMoYJE5dHu60kfdX8xh62
         +deU0eosCKbG22foMRUTdsHa/2L0WKnoX5unuByun7/UZhveI/O1dRxQZ5Tqic7CHLOB
         Qavg==
X-Gm-Message-State: AJIora8iazkpuWT8slrnEBY2Q0qXJEeIHVQC8XdvNmP4P7FYtBUYReb5
	CVdEmmy6ce7gW1VlDEjZWpPgV5vwt1E=
X-Google-Smtp-Source: 
 AGRyM1uYllGMJkUxUB5PjkP6g4lCb4Nv+2GPASmpfVE++IOIm+mOunPPlancxoyf4T7U4VoD+zl0Kw==
X-Received: by 2002:adf:e111:0:b0:21d:665e:2fa5 with SMTP id
 t17-20020adfe111000000b0021d665e2fa5mr26699192wrz.652.1658223554057;
        Tue, 19 Jul 2022 02:39:14 -0700 (PDT)
Received: from fio.lan (176.57.115.89.rev.vodafone.pt. [89.115.57.176])
        by smtp.gmail.com with ESMTPSA id
 bo28-20020a056000069c00b0021dd3e2fb60sm12146106wrb.0.2022.07.19.02.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 02:39:13 -0700 (PDT)
From: Jose Quaresma <quaresma.jose@gmail.com>
X-Google-Original-From: Jose Quaresma <jose.quaresma@foundries.io>
To: bitbake-devel@lists.openembedded.org
Cc: Jose Quaresma <jose.quaresma@foundries.io>
Subject: [bitbake-devel][PATCH] bb/utils: remove: check the path again the
 expand python glob
Date: Tue, 19 Jul 2022 10:39:02 +0100
Message-Id: <20220719093902.91911-1-jose.quaresma@foundries.io>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 19 Jul 2022 09:39:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13832

When we call the remove with recurse=True we first check if the
remove operation is safe in _check_unsafe_delete_path.
But the check is been done on the path instaed of the expanded
python glog.

Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
---
 lib/bb/utils.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 3abc4938..19ed68ea 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -692,8 +692,8 @@ def remove(path, recurse=False, ionice=False):
         return
     if recurse:
         for name in glob.glob(path):
-            if _check_unsafe_delete_path(path):
-                raise Exception('bb.utils.remove: called with dangerous path "%s" and recurse=True, refusing to delete!' % path)
+            if _check_unsafe_delete_path(name):
+                raise Exception('bb.utils.remove: called with dangerous path "%s" and recurse=True, refusing to delete!' % name)
         # shutil.rmtree(name) would be ideal but its too slow
         cmd = []
         if ionice:
-- 
2.37.1


