Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63D3C43334
	for <webhook@archiver.kernel.org>; Thu, 16 Jun 2022 13:49:13 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web09.18163.1655387346331806704
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Jun 2022 06:49:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=QPiVka1M;
 spf=pass (domain: gmail.com, ip: 209.85.221.43,
 mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f43.google.com with SMTP id c21so1983029wrb.1
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Jun 2022 06:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PfZZCRPZPD4SUOVAKZl6a30wIvMwQ+X32uJssyguZ7c=;
        b=QPiVka1MZKUJeRyQN78U4peWilK/aX4oyMNQzZUj+TUYTtc8pm6DkdJOkP0kUMA5Ky
         dojkSbl79IEcdgHlJLLCU3mch/3QaJjRi/1T3N5yFEmyjKxq5HLUfArfb/ySAt8i52kC
         eTFRTTxd5zRziSI5g4SkUjST21uYlChVESA+DFf2NoOrmU5cS0u7UyjWvJyH82kR9Hn8
         EIMkG9fj8LzLZp1k3YBMjiOP3Y5/8zdLtOglGZB5WHzmdJcsmvwMJEUNRxy69OUG0bgX
         6IpzCmvZzF+7h1ya93nREUa74i4WhmYRS4HSLxfnQLxtk2USZyi11jZBjGUCtQ8H9XWU
         FUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PfZZCRPZPD4SUOVAKZl6a30wIvMwQ+X32uJssyguZ7c=;
        b=NGcUQl4iZYUaxvopYs59jrdHUlr4LrVVWwWJ0YU7vUocn448wwSba8Cd6REDbswz26
         3WaNiW8+47l35y3W8Zye8RMKt29BcoxrqZs8OlrQqCxbWiUOy7nIG5KJUSY4rQ94TXQm
         XhDzuT8jZQbnIe/Ym3qpEk72JjOMC6GudowcR6hurQvkWfF+5DirxAfx+IESUlKekrq0
         682+F6VIJLMuvLR5+62gn4VI4JG5KrnBxtBUS1qUDodvpsUgdGiUDc6N9wtvpOmjrvPw
         Q1Nj1Hl3+1omzrA5jW/+J3a1qdBPTA2vxvsQ3PiO9RGJ28SeNhofxzD5HUvf4VzQj4e2
         48yg==
X-Gm-Message-State: AJIora95NABt89dFGA09vuf6r7ANnGL/r31SijTVphSsqNJQ0v+KLf0D
	AyzlNVNoheJn7OuxJ6/6P7M3Vi8cIWA=
X-Google-Smtp-Source: 
 AGRyM1tuvGnTnLL5ohR/x26WwAN95mIpf8Er0FrjP40zgXzR8LZQfO6kxRbjH40b5KZZRx7djiWCXQ==
X-Received: by 2002:a5d:6d8b:0:b0:218:4de1:25a0 with SMTP id
 l11-20020a5d6d8b000000b002184de125a0mr4970894wrs.8.1655387344678;
        Thu, 16 Jun 2022 06:49:04 -0700 (PDT)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id
 v184-20020a1cacc1000000b0039c454067ddsm2395679wme.15.2022.06.16.06.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 06:49:04 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [1.46][PATCH 1/4] tinfoil/data_smart: Allow variable history emit()
 to function remotely
Date: Thu, 16 Jun 2022 15:48:47 +0200
Message-Id: <20220616134850.3471187-1-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 16 Jun 2022 13:49:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13768

From: Richard Purdie <richard.purdie@linuxfoundation.org>

We can't access the emit() function of varhistory currently as the datastore parameter
isn't handled correctly, nor is the output stream. Add a custom wrapper for this
function which handles the two details correctly.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
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
2.35.1


