Return-Path: <ptsneves@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6059C54EE9
	for <webhook@archiver.kernel.org>; Tue, 20 Sep 2022 11:46:07 +0000 (UTC)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com
 [209.85.167.54])
 by mx.groups.io with SMTP id smtpd.web11.10791.1663674359311991008
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Sep 2022 04:45:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=cX8VIz/E;
 spf=pass (domain: gmail.com, ip: 209.85.167.54, mailfrom: ptsneves@gmail.com)
Received: by mail-lf1-f54.google.com with SMTP id o2so3274422lfc.10
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Sep 2022 04:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=tOIUcdaaiNYdL47mx5QgzZo/U3m3Kpc0mznMTgmjo68=;
        b=cX8VIz/EOl/nTn7k/h6fpo6ZWYH9fnVnziEmsNLoWGof3JLFkSwV5NwGVcGJiK2Dn6
         hBXkdyVV9YbGF4841T0IoCvK93EbB78bTbBBsfBlFFk96DyWekS18bvJJnZBXu5Hsr9z
         C74BxL41yKWJCsAQ1bLU+jJSxhIcjBSMyZ2UaaxthlhCDyKbDt4br4C/8g455eo4/lku
         8SRnpRC9IAGUNlzsFbjDp4UxqLLQAGJlFxrdbjL+yy1n7UjyFz/2/w90c4W0Q35ZrClf
         IwoZoXzYngVTHzsX4ikb00LliPCKEgLAYDFdWltXbnuRXrKOFNO6bWxGqdjHaZkjDa7u
         /Kfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=tOIUcdaaiNYdL47mx5QgzZo/U3m3Kpc0mznMTgmjo68=;
        b=YnDMLo5U199tYEgMi8LbTd3xJ4a1fFUp8niDOlt4XZcgMBFwDeiDKoiGX/IYBO9Muh
         vYf5b4ZRlvaFp5KmCTpnp+MJeEEEHrszTKnsVSXF0H0t5HLV+wPz25YmrVHWcn7A8QT1
         Hjtdv+SPb6EAsN1U5vbv1D3f467eIfJShlq0mjLhUNT/fLWbyx71npoJuMDs2AUXNzoI
         oGr5B7PLKrVTFblVQV+ck0ZiqgwuYRtuYXL76VXuMVy9GnHUvAFP55bzEpbhtCJad2FK
         oPxYc1d27JVBcEryKptx3XjKrPeo2WKSN/xZLwYlj6L5MOXH3b89Hdw8tCQ6pCsARJ/W
         d4JQ==
X-Gm-Message-State: ACrzQf19+5/+S3nKkdiLKyqM3EVrOwOKyafVrE9UvcTz/N4b0r02zswB
	uEuzEwyrXHfTdiHVjgPUoa+LUR6bwOzY
X-Google-Smtp-Source: 
 AMsMyM4jAZfCcgTA+N4aKst/t6rCWvCxh4WPqEIPEZ+vpUnJK/SPUN85HwwQtwwYMLo34bq6WjJ/3w==
X-Received: by 2002:ac2:4bc1:0:b0:49f:3518:864a with SMTP id
 o1-20020ac24bc1000000b0049f3518864amr8704279lfq.155.1663674357400;
        Tue, 20 Sep 2022 04:45:57 -0700 (PDT)
Received: from localhost.localdomain
 (031011128148.dynamic-3-poz-k-0-2-0.vectranet.pl. [31.11.128.148])
        by smtp.gmail.com with ESMTPSA id
 w11-20020ac25d4b000000b004979da67114sm269440lfd.255.2022.09.20.04.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 04:45:56 -0700 (PDT)
From: Paulo Neves <ptsneves@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Paulo Neves <ptsneves@gmail.com>
Subject: [PATCH 1/1] fetch2: Remove unneeded conditional
Date: Tue, 20 Sep 2022 13:45:53 +0200
Message-Id: <20220920114553.41656-1-ptsneves@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 20 Sep 2022 11:46:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13983

The condition will always evaluate to true and
thus is redundant.

Signed-off-by: Paulo Neves <ptsneves@gmail.com>
---
 lib/bb/fetch2/git.py | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 4534bd758..17d490492 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -567,13 +567,12 @@ class Git(FetchMethod):
         source_found = False
         source_error = []
 
-        if not source_found:
-            clonedir_is_up_to_date = not self.clonedir_need_update(ud, d)
-            if clonedir_is_up_to_date:
-                runfetchcmd("%s clone %s %s/ %s" % (ud.basecmd, ud.cloneflags, ud.clonedir, destdir), d)
-                source_found = True
-            else:
-                source_error.append("clone directory not available or not up to date: " + ud.clonedir)
+        clonedir_is_up_to_date = not self.clonedir_need_update(ud, d)
+        if clonedir_is_up_to_date:
+            runfetchcmd("%s clone %s %s/ %s" % (ud.basecmd, ud.cloneflags, ud.clonedir, destdir), d)
+            source_found = True
+        else:
+            source_error.append("clone directory not available or not up to date: " + ud.clonedir)
 
         if not source_found:
             if ud.shallow:
-- 
2.25.1


