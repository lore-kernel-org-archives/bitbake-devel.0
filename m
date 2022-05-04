Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F4FC433FE
	for <webhook@archiver.kernel.org>; Wed,  4 May 2022 11:56:17 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web11.5501.1651665368364291417
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 May 2022 04:56:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=gC0cL3J2;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id x18so1721572wrc.0
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 May 2022 04:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P0vNLISOEAykDNS8ifHwP4dWGX2U0+QhLacl+6sZxpg=;
        b=gC0cL3J2e/jcRkjYiKXevz/zcjAxzQebb7uP4bqWShcBND3UYMUxHQtpZMQmnGFy17
         kzUuSZZIgOXL2qMEYfmBgqSvQLRDXD0wzHMRyyXeP9TY+GlVsrsUVr2j0cEBvzOGJUFJ
         mQ1qoXaYBA8rvD3PDPVsbokwaqIc/5ml6Wbzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P0vNLISOEAykDNS8ifHwP4dWGX2U0+QhLacl+6sZxpg=;
        b=Fow9YqdNUZArdU2MoKg4LNi7omu8KrWPFxHueAVplxw6pYG1J0Iym+E5mZgoYuPzlp
         nXd4gUTAVY/jVB3IKv9NkZT+CGH4AtZjSCUqD1ViTmLKQKG2RYr3sUhZIV2N9+aarxny
         nwHEeuyDaTfhM8eqT9DXPvpPr9fej5Aat4+dj4Mjl+zhjLuKk+wl4b4sTx75H8Ejd+hl
         UDtElsfkJ9LoFL0gsOqdLqgFQ4B/bMQuJE3iEC6NtLGFf7t2/kQtwfAKYqy6ps3qZYtd
         n6VH3hItrWzy8qD9T+D44/2zDLAqFpgzpslUT+RK4TVR6dAbe8YssZ3o5sDaAQMQKL9S
         G85w==
X-Gm-Message-State: AOAM533gqxxPQYpwqbpiE0ZU7SYjYKbT5ZhGUerIM7oU0VOo2/zR9XYf
	8EmSxoi8elDdybVBYpzr0tvijEa+56r2jQ==
X-Google-Smtp-Source: 
 ABdhPJxbyUaSzp8o4GZQDeX1gCmphumPCQbGzW0eWmBbYzlIZRFLX6oIf9/JKMwDamAEp1F+/SIgcA==
X-Received: by 2002:a5d:5847:0:b0:20c:525b:49d0 with SMTP id
 i7-20020a5d5847000000b0020c525b49d0mr16281774wrf.13.1651665366276;
        Wed, 04 May 2022 04:56:06 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:d387:a418:2b62:bd29])
        by smtp.gmail.com with ESMTPSA id
 c1-20020adfc041000000b0020c5253d8desm11945376wrf.42.2022.05.04.04.56.05
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 04:56:05 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] cookerdata: Change emphasis in error message to be clearer to
 users
Date: Wed,  4 May 2022 12:56:04 +0100
Message-Id: <20220504115604.3056455-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 04 May 2022 11:56:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13671

Users are misreading this message. Reorder the wording to make
the empahsis clearer on the shell environment.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cookerdata.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index fe5696c704..d54ac932e5 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -248,7 +248,7 @@ class CookerDataBuilder(object):
         for k in cookercfg.env:
             self.savedenv.setVar(k, cookercfg.env[k])
             if k in bb.data_smart.bitbake_renamed_vars:
-                bb.error('Variable %s from the shell environment has been renamed to %s' % (k, bb.data_smart.bitbake_renamed_vars[k]))
+                bb.error('Shell environment variable %s has been renamed to %s' % (k, bb.data_smart.bitbake_renamed_vars[k]))
                 bb.fatal("Exiting to allow enviroment variables to be corrected")
 
         filtered_keys = bb.utils.approved_variables()
-- 
2.32.0


