Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93293C43334
	for <webhook@archiver.kernel.org>; Tue,  7 Jun 2022 14:17:41 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web11.12808.1654611460026640319
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Jun 2022 07:17:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=U/rqBz7t;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id x17so24392711wrg.6
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Jun 2022 07:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=hk1MOm/dn7Atwiib8i/3PyKJPqST7zE20Fp914FJBeo=;
        b=U/rqBz7tS5eoXwNP5OKahgEvSRUqb86VwJ1QveSG94kTEgG9hbi/h7/73O9kAWMNIA
         3uNUfszJvVzLtikVZum7LKTa00PJlC/DfChtOS0Fv7mdV6v4iueGL/qcpQutI+kRIH+B
         GrvrcXeP38Sc3Uzr0tx/1YzYCFjBYxsq+NOuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hk1MOm/dn7Atwiib8i/3PyKJPqST7zE20Fp914FJBeo=;
        b=GT54TfXEA57G2xNgiQOy3612yd+uB01yavY06IBZLCWWOQ7IH3B8LX8eZLC0CLFcmV
         38I5Bisoxynp+HL2ZWNB5h54qXlVRfmf2KaCmgAzAwriF12jpat3CGRTjqjLrkWW8TzM
         QXTHPqD7pHD7YJceqIPPFa829f/sHqSF19lXkOLZ+PiYUB1pppCJibux5z5nwywE7dRx
         Isi38hPehAjwFODPiE1n/OPnniQ9QYD2PQcFyFKjV1XVNlB0u41YJ49uTMcT7hz7OYXc
         niNAKEMBP4byRhn76PkuY3y96RjYqeTqmndTvE0pka1uEs/9ppT1Leo2EGkDwVquvVUY
         K74A==
X-Gm-Message-State: AOAM533eejSzO0yecE7n0H45dkkhv8jmm1FOpDCvOYRYiF3N4RrlhIYm
	e2DaN/Q4jd8Ov2RFbAPaMfCRsaoB+3utzQ==
X-Google-Smtp-Source: 
 ABdhPJw3EHYNGsOoOXklRuouyH36YM0lm2RSglcnKmb+7HoOvM154agOriVtasJwIiTuS02YCDApqg==
X-Received: by 2002:a05:6000:257:b0:216:509c:2c4b with SMTP id
 m23-20020a056000025700b00216509c2c4bmr18147217wrz.196.1654611458217;
        Tue, 07 Jun 2022 07:17:38 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:e835:fc94:6c5b:fc12])
        by smtp.gmail.com with ESMTPSA id
 bd9-20020a05600c1f0900b0039c47767e23sm10483182wmb.33.2022.06.07.07.17.37
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 07:17:37 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/3] server/process: Remove daemonic thread usage
Date: Tue,  7 Jun 2022 15:17:35 +0100
Message-Id: <20220607141735.341158-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220607141735.341158-1-richard.purdie@linuxfoundation.org>
References: <20220607141735.341158-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Jun 2022 14:17:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13738

We're seeing UI deadlocks occasionally and this is possibly due to the
use of a daemonic thread in the UI event queue processing. This thread
could terminate holding a threading Lock() which would cause issues
for the process when exitting.

Change the shutdown process to handle this more cleanly.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 74b74dc39b..b330520a98 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -437,6 +437,7 @@ class BitBakeProcessServerConnection(object):
         self.socket_connection = sock
 
     def terminate(self):
+        self.events.close()
         self.socket_connection.close()
         self.connection.connection.close()
         self.connection.recv.close()
@@ -662,7 +663,6 @@ class BBUIEventQueue:
         self.reader = ConnectionReader(readfd)
 
         self.t = threading.Thread()
-        self.t.daemon = True
         self.t.run = self.startCallbackHandler
         self.t.start()
 
@@ -693,13 +693,16 @@ class BBUIEventQueue:
         bb.utils.set_process_name("UIEventQueue")
         while True:
             try:
-                self.reader.wait()
+                self.reader.wait(0.25)
                 event = self.reader.get()
                 self.queue_event(event)
-            except EOFError:
+            except (EOFError, OSError):
                 # Easiest way to exit is to close the file descriptor to cause an exit
                 break
+
+    def close(self):
         self.reader.close()
+        self.t.join()
 
 class ConnectionReader(object):
 
-- 
2.34.1


