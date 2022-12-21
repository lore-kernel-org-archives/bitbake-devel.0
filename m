Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C13AC41535
	for <webhook@archiver.kernel.org>; Wed, 21 Dec 2022 14:15:54 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web10.19681.1671632148567937802
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 21 Dec 2022 06:15:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=LnGzkqeL;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f42.google.com with SMTP id a17so13913352wrt.11
        for <bitbake-devel@lists.openembedded.org>; Wed, 21 Dec 2022 06:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=poTDGlrbkqrHd+BGneklbkqOdwueYFkr4t0JdGPki4E=;
        b=LnGzkqeL0FRL3bc02n1L5pX+ayBHyg3HOPQy9JC4rorK4Zl6CpQt7i//tqG55W/iQO
         fC0IPTFt3XClTpYGToO0jgtVLP4hqJEtt0yKF5UidN3dzoIM5N9tAKRfFj6KvpCn6z4e
         bFtCQHGq0pYQhEjdYl1GEf1IxjKqfkIitw8fM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=poTDGlrbkqrHd+BGneklbkqOdwueYFkr4t0JdGPki4E=;
        b=gnBbhf2OiRAsBH89a1lTx4dQI6O5KQhf23eQ9PUtp349Ncw1ugDR4N/HAKm/Ji0cgI
         y71vXUXBTkHxQiMcgRvLyain0Hq1cD+d4ifNB1BUnxE+1ZgkmaqlWMGggcQDMKyG4cPl
         IK9bc9wgORns7PSVvdTlQ7yvpc7m9szkZunJhC6MpqWd8qimIMrJNRiN9ZSW7UfgJxr6
         eVpB+Ana3LGCv8IFxovFA0uVBRfxrCmkzeqjNNkgCJeo1wpKyWGAbvYdxEBSl3yCIqLA
         LhDNI+kVszWIfFfjB6AtDPbyQLY9MYSy8GFE/5CJZv+fhvZK9XJkpuI/RwSO5n5wl3hk
         Qa7Q==
X-Gm-Message-State: AFqh2kpQIALx4WBT+rkx6WiPelCoEXK5yQNHIkrW+D36520BbeLubEEs
	NB4QRxkeH7LZTYEUbVW9zlvPq5nIKvPAvLZe
X-Google-Smtp-Source: AMrXdXvE9vimjMp6v473+sG1w9euDzHOGYo7QjYfkBVFtJBLlS1n/EZ0PGt348/esuc5L47/LCpzpQ==
X-Received: by 2002:a5d:5a85:0:b0:264:ae8b:7dcd with SMTP id bp5-20020a5d5a85000000b00264ae8b7dcdmr1318105wrb.24.1671632146844;
        Wed, 21 Dec 2022 06:15:46 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:e749:b020:2cdb:af31])
        by smtp.gmail.com with ESMTPSA id k12-20020adff28c000000b0022e57e66824sm17839412wro.99.2022.12.21.06.15.46
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 06:15:46 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 5/7] server/process: Avoid dangling async commands
Date: Wed, 21 Dec 2022 14:15:41 +0000
Message-Id: <20221221141543.497904-5-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221221141543.497904-1-richard.purdie@linuxfoundation.org>
References: <20221221141543.497904-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 21 Dec 2022 14:15:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14222

There is a race where the client can have disconnected but the async
command hasn't finished running and isn't cleared up by the idle handler.
If a client connects and finds this state, it will fail as the server
appears busy and no new async command can execute. The old idle handler
code makes this unlikely but could explain some race issues. The new
code with idle handling in a separate thread makes it much more likely.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/command.py        | 3 +++
 lib/bb/server/process.py | 1 +
 2 files changed, 4 insertions(+)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 20a8b86653..1224eee413 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -152,6 +152,9 @@ class Command:
             bb.event.fire(CommandExit(code), self.cooker.data)
         else:
             bb.event.fire(CommandCompleted(), self.cooker.data)
+        self.finishAsyncDisconnect()
+
+    def finishAsyncDisconnect(self):
         self.currentAsyncCommand = None
         self.cooker.finishcommand()
 
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 6f43330fae..c9984539e8 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -177,6 +177,7 @@ class ProcessServer():
                 self.command_channel = False
                 del self.event_writer
                 self.lastui = time.time()
+                self.cooker.command.finishAsyncDisconnect()
                 self.cooker.clientComplete()
                 self.haveui = False
             ready = select.select(fds,[],[],0)[0]
-- 
2.37.2


