Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DC4C4167B
	for <webhook@archiver.kernel.org>; Tue, 20 Dec 2022 15:16:14 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web11.52658.1671549369839708108
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Dec 2022 07:16:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=hYOElbxk;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id f18so12053178wrj.5
        for <bitbake-devel@lists.openembedded.org>; Tue, 20 Dec 2022 07:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OJX9Z3oUFK8oiNNWZ5g2cehZXEB0ktG3pm9Lqncclew=;
        b=hYOElbxkF0B/NG7sCKNutJEM1KIhGXyZ2cQ6nZmcrtjsKLOFJs2ZarzNRFENswcgqF
         ueXGgu8ZL8QRmvO6+K/NdJYKLk8Thd98eDsga1cbhHL7ELda0MfeceVoFc4diMN/q4EY
         VG1+kD0kBVv8Sy2P7rIZ/uf08UlT1BlJxWBUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJX9Z3oUFK8oiNNWZ5g2cehZXEB0ktG3pm9Lqncclew=;
        b=oiblem9ZkLSTvY7e4dpyxu3ilX9WMBBRVs6PCWj8dUYjdmHD3RFUIUaSv2QG0CjwZy
         QwBepxraApQUQTfaGIv2Wd3M722LMsRjA8PvGKCwLY76NKpBOnfvsJyHb+S8zh68LuDB
         juWeBLBk5jHRZscaqFaPtY+fOpjZQDXdsRMcTiKstaaGnSIIPATmO3XjZ+evk3r6h8jz
         wsBWEz1aD2LEI1gyiwfshLx9KhqI/DybrYiZhHnzu/3h3Lsb+4MfzKxt6/eeRIHMH7mJ
         zkKrot//ULe7i93SZp4aK9upe75w2nScDHfQG2tL59ePlnbwPkQLBlSk50xzDFlnir+0
         tEJQ==
X-Gm-Message-State: ANoB5pnMnl762NNGJBuLH8vJ7gDPqEp8nqU/CLFTVKkPQ9HkqmR/H4GP
	odwdagSzOzgaDChXaYCay1qEwlfbPKBy/b3t
X-Google-Smtp-Source: AA0mqf6A1U5Yp9w8nR8yVIeflV++ALRGENyL0c30XbWZq6n0VW/QP+oP9QT3aVkOPo7CJ67cwpBqbw==
X-Received: by 2002:a5d:526a:0:b0:242:877d:ca63 with SMTP id l10-20020a5d526a000000b00242877dca63mr29886983wrc.44.1671549368156;
        Tue, 20 Dec 2022 07:16:08 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:1273:dbb7:632c:a9de])
        by smtp.gmail.com with ESMTPSA id k12-20020adff28c000000b0022e57e66824sm14896439wro.99.2022.12.20.07.16.07
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 07:16:07 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 6/6] server/process: Add bitbake.sock race handling
Date: Tue, 20 Dec 2022 15:16:04 +0000
Message-Id: <20221220151604.415637-6-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221220151604.415637-1-richard.purdie@linuxfoundation.org>
References: <20221220151604.415637-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 20 Dec 2022 15:16:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14214

We've seen cases where the bitbake.sock file appears to disappear but the
server continues to hold bitbake.lock. The most likely explaination is
that some previous build directory was moved out the way, a server there
kept running, eventually exited and removed the sock file from the wrong
directory.

To guard against this, save the inode information for the sock file and check
it before deleting the file. The new code isn't entirely race free but should
guard against what is a rare but annoying potential issue.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 95e2968742..6f43330fae 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -28,6 +28,7 @@ import datetime
 import pickle
 import traceback
 import gc
+import stat
 import bb.server.xmlrpcserver
 from bb import daemonize
 from multiprocessing import queues
@@ -94,6 +95,9 @@ class ProcessServer():
         self.bitbake_lock_name = lockname
         self.sock = sock
         self.sockname = sockname
+        # It is possible the directory may be renamed. Cache the inode of the socket file
+        # so we can tell if things changed.
+        self.sockinode = os.stat(self.sockname)[stat.ST_INO]
 
         self.server_timeout = server_timeout
         self.timeout = self.server_timeout
@@ -281,8 +285,14 @@ class ProcessServer():
 
         serverlog("Exiting (socket: %s)" % os.path.exists(self.sockname))
         # Remove the socket file so we don't get any more connections to avoid races
+        # The build directory could have been renamed so if the file isn't the one we created
+        # we shouldn't delete it.
         try:
-            os.unlink(self.sockname)
+            sockinode = os.stat(self.sockname)[stat.ST_INO]
+            if sockinode == self.sockinode:
+                os.unlink(self.sockname)
+            else:
+                serverlog("bitbake.sock inode mismatch (%s vs %s), not deleting." % (sockinode, self.sockinode))
         except Exception as err:
             serverlog("Removing socket file '%s' failed (%s)" % (self.sockname, err))
         self.sock.close()
-- 
2.37.2


