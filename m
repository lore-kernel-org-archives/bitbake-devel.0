Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B67C433EF
	for <webhook@archiver.kernel.org>; Thu, 14 Oct 2021 22:27:40 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web09.1991.1634250459168121062
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Oct 2021 15:27:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=E5+ReU4s;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id
 g193-20020a1c20ca000000b0030d55f1d984so921615wmg.3
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Oct 2021 15:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RuyxEHcJK1UR5qBVBUWaR4BED04gIODpEQTzvHfOMHY=;
        b=E5+ReU4sHL67lXRzvs8Q5d3HIjxe7YSJ0mByUXT330d81P1243aE54heL9/CZoiL2I
         WrXPhaSkz6mvP7jAwPjGCOOy+nnxE6jyAoqat2QXCyyBuT649nFT9GW8OiBbwAfEaDX+
         YXp3ayEe5CRdRsSu/X7JRrUXC3epeH8qnHa5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RuyxEHcJK1UR5qBVBUWaR4BED04gIODpEQTzvHfOMHY=;
        b=zHyoDDhyvI4s9mHWBBr5DWfAqrIFv2Lt1RIzHcX5gMkUhFFcgbQgANgxHL+H92z9CB
         z93OcbnLSmPAnXiwEkaZp26rHBrnGNg/P/mGfm4ewBv7BXc1lI9VvyLhrnDRhEugAT8I
         YpkQQATHdZeQ7Zmnl53CnEs6PdclgsyZ5+mDApJTnkb3crC8h9EVzmkGoc2dMuWiNan6
         E+D83oK737s8Nht9597719PWtVfVvriA7YTgnQDH47QxE//OsRSGFBUiYLhpS7JHrQS3
         ++JPx+qOMJmbwlSE0iQXzqJNK0YlBTirFw/mXdVe8UUhm5yMZEU4UCCF5bEXe6fhUiXv
         PYFA==
X-Gm-Message-State: AOAM531GSyrt+mom5S3DA/kACL99q5vWvFKf/657cVvcAhIDnMNB7gkJ
	8gUzicTv4Ork4o4z/lFTJ25LfmrnArY8rw==
X-Google-Smtp-Source: 
 ABdhPJx6p19fkHUa2yULYvpHCBmgG2rlTsOnarAXyLhQNLxoW1QjvSG7YuStofC1oLrbK27ej8Zweg==
X-Received: by 2002:a1c:4645:: with SMTP id t66mr8874979wma.179.1634250457698;
        Thu, 14 Oct 2021 15:27:37 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:3c2a:82f4:3a7b:54b1])
        by smtp.gmail.com with ESMTPSA id
 73sm3486699wmb.40.2021.10.14.15.27.37
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 15:27:37 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] tests/runqueue: Ensure hashserv exits before deleting files
Date: Thu, 14 Oct 2021 23:27:36 +0100
Message-Id: <20211014222736.2937575-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 Oct 2021 22:27:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12778

We've seen races where the socket may be gone but the server is still writing
out it's database. Handle that case too to avoid cleanup tracebacks.

[YOCTO #14440]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/runqueue.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/tests/runqueue.py b/lib/bb/tests/runqueue.py
index 3d51779d6c..4f335b8f19 100644
--- a/lib/bb/tests/runqueue.py
+++ b/lib/bb/tests/runqueue.py
@@ -361,7 +361,7 @@ class RunQueueTests(unittest.TestCase):
 
     def shutdown(self, tempdir):
         # Wait for the hashserve socket to disappear else we'll see races with the tempdir cleanup
-        while os.path.exists(tempdir + "/hashserve.sock"):
+        while (os.path.exists(tempdir + "/hashserve.sock") or os.path.exists(tempdir + "cache/hashserv.db-wal")):
             time.sleep(0.5)
 
 
-- 
2.32.0


