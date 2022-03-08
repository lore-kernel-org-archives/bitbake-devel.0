Return-Path: <rybczynska@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4F1C433EF
	for <webhook@archiver.kernel.org>; Tue,  8 Mar 2022 09:08:19 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web08.6180.1646730498179241585
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 08 Mar 2022 01:08:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=QvXhScAv;
 spf=pass (domain: gmail.com, ip: 209.85.221.50,
 mailfrom: rybczynska@gmail.com)
Received: by mail-wr1-f50.google.com with SMTP id e24so14368014wrc.10
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 08 Mar 2022 01:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Yt4ztxIsn5/aLF7spnQGjXMstD/cGgEgpyhtqDUl+E=;
        b=QvXhScAv/u9565CiaQAWzvEn0Z/LbzFCXH4Bs1E6DNvKBDouICPsiGfwAEfVoZBK1o
         eh0oC8VoIksCUZPsL9t61QWANQ8q+waXVcdLIBZhk+u9+V2OJmUzQFVHWpeZ9NMHUk+h
         zbpOka5vaKeZSra2y1SSul0Iu3+KT9iLJduKJl3VTOAkVC3cm/8r98ldejiVmIyhplm6
         hu62MljhSYDHbHgnBPUpj9YLapFK279AFZLJ7Fsj85sq6xOytdQAPccc4DmE06bCLLj6
         qpb14CT+Mn5J94layuBbdPL4DHwg2Rt26wE/f3OVIRgAN5recFVtXHVz73bmELZ91Hnw
         sy5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Yt4ztxIsn5/aLF7spnQGjXMstD/cGgEgpyhtqDUl+E=;
        b=Ls28OFheEkgdTJB9Xw9hea2bUnGCF/KQYyhUcjB/IUNbsy6BFcK6JTi9IAcjtuvVEP
         kKQ6iFLTiPTO7XOjfhEkuPbOKBKn8xPRC5fvEUbZvECrQgYBqJGRJQE74rZQC6/rAQx6
         rqOvtzS8qlHMYLweLzru8mfvsPexocrzXToNr6aF5VaM3kHvShm3VRFIzT2av+8+hsak
         TUlQphPU9IjvUCejfukEoltP4ubqU96KCWionpjXBY6JZz6X973ErZa7QJOtTDokAJE3
         cDNselFOp+dfLZL6ZYOKl98UZ5fZFVi00d3+CFBogpwWTyQSZ5+qwG0zt0eMF68CJUGe
         rWSw==
X-Gm-Message-State: AOAM533KHfkTY+ghQI/mXjMCV9YT7fkHjL6ucU6nnNIQmOBKeMiFmaqW
	SDlrN7Wt0AFgAhsFNOphnYlrZjfRJLY=
X-Google-Smtp-Source: 
 ABdhPJw8SxWH3xPkxkAi2ic4HVMEBbCqvaxcnbjqyzsn805inHDr0XJcZKn68GI0+oXjq4vOS73xKQ==
X-Received: by 2002:a5d:6485:0:b0:1ff:20b6:fa9f with SMTP id
 o5-20020a5d6485000000b001ff20b6fa9fmr3650318wri.469.1646730496421;
        Tue, 08 Mar 2022 01:08:16 -0800 (PST)
Received: from localhost.localdomain ([80.215.234.43])
        by smtp.gmail.com with ESMTPSA id
 m18-20020a05600c3b1200b003899d242c3asm1659934wms.44.2022.03.08.01.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 01:08:15 -0800 (PST)
From: Marta Rybczynska <rybczynska@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org
Cc: Marta Rybczynska <marta.rybczynska@huawei.com>
Subject: [PATCH] lib/bb: more verbose error message
Date: Tue,  8 Mar 2022 10:07:58 +0100
Message-Id: <20220308090758.1171081-1-rybczynska@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 08 Mar 2022 09:08:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13440

From: Marta Rybczynska <marta.rybczynska@huawei.com>

The "Parsing halted due to errors" is shown when user has old-style
variables requiring renaming. Make it clear that it isn't an additional
error, but a result of earlier errors.

Signed-off-by: Marta Rybczynska <marta.rybczynska@huawei.com>
---
 lib/bb/cooker.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 0133a327..6996e623 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -2168,7 +2168,7 @@ class CookerParser(object):
 
             bb.event.fire(event, self.cfgdata)
         else:
-            bb.error("Parsing halted due to errors")
+            bb.error("Parsing halted due to errors, see error messages above")
 
         for process in self.processes:
             self.parser_quit.put(None)
-- 
2.33.0


