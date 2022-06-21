Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA99CCA480
	for <webhook@archiver.kernel.org>; Tue, 21 Jun 2022 18:21:26 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web11.36530.1655835678330381253
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Jun 2022 11:21:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=Kr6x0+Tb;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.48,
 mailfrom: steve@sakoman.com)
Received: by mail-pj1-f48.google.com with SMTP id
 t3-20020a17090a510300b001ea87ef9a3dso14271787pjh.4
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Jun 2022 11:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3m6+pa1arYVW3goM/30xOx1bZq6FNi7sU+pqa6YgwLY=;
        b=Kr6x0+TbEsyFix5GgJIJOsEeN3e7ZSyeKat7K30tnBaJXxYeLfHhnW8afr8bWmbALh
         SQGo+U2gNDmss5Ro/iVB1kDMe9Ew3fzAk1JFd9uLMEFdDv8DsNRGStNM+iERlVWw2AfZ
         dbIQf01q52r11auqK3fi8DxPhTqyIVyZ9u+yIJR2xRqQQmQVTeEN+dB15L6lIfCxG6Ry
         38LiYuRwRvtvw2Fbg47xk4lmdkVI47SdrOGe4bntvTw2hNOINTLrqXuhm0d0YAWzbirr
         4REO46xHuEKk8lcxS8Q3oBvwPC7cIpebyCPcM6m2XOU3lisOCXx7zcqltV3pz2n5veLj
         TXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3m6+pa1arYVW3goM/30xOx1bZq6FNi7sU+pqa6YgwLY=;
        b=FAV1UbgFqeEdngDadc44/W679n/2QoL6vOcRQiRbfaDv66NfBwBBovZpxYbMnvYHV2
         rNDmTlkK6qvtb92MqVEz42WSc1xMmohsvc8r334kvdRCcDPu5XlexTPUELYUGLsueKGd
         JemsXDIBsd6snnwqtiq/4t9zi/DiKQ8uvByJG7sRWq8cFMnYyXCbTJ0oy7als5aXl/bv
         65i076LZdsIq58C846Qi6rFUl05srdnsJjNrNZoG7dI7eYqV+3jb9pslclMlNt+1UIag
         C6Z3yMKhRKC6ujUCFkSXcO5Ox0btayYzTWPcoXcWR2FXzal8AEiAWxmBliEC2eG+9cVH
         flKQ==
X-Gm-Message-State: AJIora9KlR0eEpeYG8znfxqv9ok3w+IKbAc+nUU5T9kTGq2vIlmotyPQ
	vQGlgtF8UJE8Buv0q3rF8a3i+P2DsQcV9ly2
X-Google-Smtp-Source: 
 AGRyM1vbH/RuC3rDyM5vxgUN7WqnVcU2EmML823N6eSSNsuE0njwJehUz72qP4/4ROJCyfUum1o1IQ==
X-Received: by 2002:a17:90b:38c2:b0:1e8:7ad1:bec5 with SMTP id
 nn2-20020a17090b38c200b001e87ad1bec5mr44547123pjb.51.1655835677351;
        Tue, 21 Jun 2022 11:21:17 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 t13-20020a1709027fcd00b0016392bd5060sm9755503plb.142.2022.06.21.11.21.16
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 11:21:16 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 2/5] tinfoil/data_smart: Allow
 variable history emit() to function remotely
Date: Tue, 21 Jun 2022 08:20:58 -1000
Message-Id: 
 <144a1cfe8b60c677bb6ec66c242e064c7ba3ed88.1655835530.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1655835530.git.steve@sakoman.com>
References: <cover.1655835530.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Jun 2022 18:21:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13780

From: Richard Purdie <richard.purdie@linuxfoundation.org>

We can't access the emit() function of varhistory currently as the datastore parameter
isn't handled correctly, nor is the output stream. Add a custom wrapper for this
function which handles the two details correctly.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit ba0fa084ccd2b1ade96425d158fd31e49e42f286)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/command.py | 12 ++++++++++++
 lib/bb/tinfoil.py |  4 ++++
 2 files changed, 16 insertions(+)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 98c945ed..b8429b27 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -20,6 +20,7 @@ Commands are queued in a CommandQueue
 
 from collections import OrderedDict, defaultdict
 
+import io
 import bb.event
 import bb.cooker
 import bb.remotedata
@@ -478,6 +479,17 @@ class CommandsSync:
         d = command.remotedatastores[dsindex].varhistory
         return getattr(d, method)(*args, **kwargs)
 
+    def dataStoreConnectorVarHistCmdEmit(self, command, params):
+        dsindex = params[0]
+        var = params[1]
+        oval = params[2]
+        val = params[3]
+        d = command.remotedatastores[params[4]]
+
+        o = io.StringIO()
+        command.remotedatastores[dsindex].varhistory.emit(var, oval, val, o, d)
+        return o.getvalue()
+
     def dataStoreConnectorIncHistCmd(self, command, params):
         dsindex = params[0]
         method = params[1]
diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index 28f1e562..8bec8cba 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -53,6 +53,10 @@ class TinfoilDataStoreConnectorVarHistory:
     def remoteCommand(self, cmd, *args, **kwargs):
         return self.tinfoil.run_command('dataStoreConnectorVarHistCmd', self.dsindex, cmd, args, kwargs)
 
+    def emit(self, var, oval, val, o, d):
+        ret = self.tinfoil.run_command('dataStoreConnectorVarHistCmdEmit', self.dsindex, var, oval, val, d.dsindex)
+        o.write(ret)
+
     def __getattr__(self, name):
         if not hasattr(bb.data_smart.VariableHistory, name):
             raise AttributeError("VariableHistory has no such method %s" % name)
-- 
2.25.1


