Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6765CC3DA7A
	for <webhook@archiver.kernel.org>; Mon,  2 Jan 2023 16:21:55 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.39112.1672676509539297615
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 02 Jan 2023 08:21:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=iElk7kJb;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id fm16-20020a05600c0c1000b003d96fb976efso18900737wmb.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 02 Jan 2023 08:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IdJTeG5QfUmn0gindh/NBX8TztHjeqk1ixWH0g8uBbs=;
        b=iElk7kJb2nbkb2hulEDLtgAOcyVGQxkBobXqYWnWy0eOkqgdUMdc9jP2SF3ky5FTeG
         crq/IbdqWGvDAFUZWdBUSzhot55bKABiFYwh1+nfL9KQt1Jr0ChyfYIVwlBlHqbC9Ocw
         O3sY7fKPtrAAbgIap1HQ4eBGWJTPM/I5hkmB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IdJTeG5QfUmn0gindh/NBX8TztHjeqk1ixWH0g8uBbs=;
        b=3axXSvEEbtjJqE1Yl3hSg1MCF7WgAJ1RSgsEFTqgrtujNEijX1wWczAfcOMkl+Q1Nf
         Vq2iZogBVcooXIBSYIr1YuhilFP661ZlnZPIDOBFSVpNtzOfH1CDJC8lf1owxfUcuVrX
         CGgwdjru8c6ZmS21NFQgDdFsmIs05P6R9af4BTypWNbxSP9RAs2RiiFjkeTxBcxFCXgI
         /WahxOkvRRGpKUKRNuXJutqIc58dw5AjNwTVH3aAApE1xEDeLXF0BjSJAIVEIWm52qFJ
         O5O0m7B1HvL/XqRt3Ac6ve9pYndBEshW2Ou03lu8H0tt+SKI/J5VCODF4Gtks0VxprNu
         Zeqw==
X-Gm-Message-State: AFqh2kp5mDpD0Ga2saxHb7faq1TjjOOo11nFRlQ7nqowd8B5pH8h9AKZ
	+dZny+srZ9gNsfCci6urpYmak4bhij6F2y32
X-Google-Smtp-Source: AMrXdXsAU8qezXlPA58PAFm4eMh/S6W8RHg7pVQ/7fWHE1hZo4vTFy66UB52ell/+n67qybmXGbNzw==
X-Received: by 2002:a7b:c3d6:0:b0:3d3:5ccc:4442 with SMTP id t22-20020a7bc3d6000000b003d35ccc4442mr29091320wmj.26.1672676507626;
        Mon, 02 Jan 2023 08:21:47 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:409d:216c:1a2:8d83])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600c199100b003d99da8d30asm17413259wmq.46.2023.01.02.08.21.47
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 08:21:47 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] command: Ensure that failure cases call finishAsyncComand
Date: Mon,  2 Jan 2023 16:21:46 +0000
Message-Id: <20230102162146.1066346-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 02 Jan 2023 16:21:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14280

There are a couple of failure cases that runCommands needs to better
handle, ensuring finishAsyncCommand is called. This doesn't matter if the
server is about to shut down but for memory resident bitbake and with
threading enabled, correctness is more important this could could in
theory lead to problems with the recent code changes.

By using the idleFinish class, it ensures the current async command
is terminated correctly and the various state pieces around commands
finishing are called. This also makes the code more uniform matching
the other exception handling code.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/command.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 2b25ce5385..5d321cf9fa 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -118,7 +118,7 @@ class Command:
                 # updateCache will trigger a shutdown of the parser
                 # and then raise BBHandledException triggering an exit
                 self.cooker.updateCache()
-                return False
+                return bb.server.process.idleFinish("Cooker in error state")
             if self.currentAsyncCommand is not None:
                 (command, options) = self.currentAsyncCommand
                 commandmethod = getattr(CommandsAsync, command)
@@ -130,7 +130,7 @@ class Command:
                     commandmethod(self.cmds_async, self, options)
                     return False
             else:
-                return False
+                return bb.server.process.idleFinish("Nothing to do, no async command?")
         except KeyboardInterrupt as exc:
             return bb.server.process.idleFinish("Interrupted")
         except SystemExit as exc:
-- 
2.37.2


