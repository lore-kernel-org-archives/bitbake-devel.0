Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web11.15916.1599302680017453851
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 05 Sep 2020 03:44:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ZwqE3AzX;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id t10so9925602wrv.1
        for <bitbake-devel@lists.openembedded.org>; Sat, 05 Sep 2020 03:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QoJe7PlH39j0zs2kuHiHOo6Q8MUEInOZAZKIln0BHpA=;
        b=ZwqE3AzXdaa3wZXUl15e/XLoNNcAHFvjnR5wniP1c1OBqzpot/zCLOaVLmnnqib7S4
         C3qBFH0mJX7tmZYLWnK3vbEDMQP4mAzFaVwttMbOArEBt+8U90mqvvyF6RnMtbJubXPL
         uS06AqoDNXMt2H9oYsZnSbarRpd9xEOIGjHeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QoJe7PlH39j0zs2kuHiHOo6Q8MUEInOZAZKIln0BHpA=;
        b=Eme1eXk/C5JeaAtPr2sXLvNyaTKIF9gh2soaZbYB0Rb0sgeNHIhOFFtevwQGgpuJcn
         ypW4l4eoBHbp6cgfplN2Anqq622sS9lq/OFG1kfB+FBeX6q2ITP7eNFFGRv1bXQLhj9b
         WOROkW8UML+r5vzSCdXy5nYlMw1Kye2yLBs5QCNNbIt6j/0NJxU264wI0NpvYigq4Soa
         pV8Tuowxr+QNrtKv9D4pTMRKTP5nxVcZ+oFODWxMlj9sVsjTVqBp63o8ATWlh3yh99MG
         RQFgOBRIeg9CwYJhHnhB10FnS86z2C4NKQc6DbukOHhSwAf8TpkD2abBHCbz9f7Q28G+
         reUw==
X-Gm-Message-State: AOAM530At4I06W/Pqvb7IUpaRLg6YirGuxt6q3Z/kyxPMPRKg6N0sfxE
	aw9jvjYzYogtg4Y6SLtd4FPv+A2OdbJj7g==
X-Google-Smtp-Source: ABdhPJyMwSIhOHRSvodey4ZEKNqOn+wPuxVK7QbzlKC31zM/pXeHj84UO28hv7FyofhUSR5hiqUJAg==
X-Received: by 2002:a5d:4a4b:: with SMTP id v11mr11548879wrs.36.1599302677930;
        Sat, 05 Sep 2020 03:44:37 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (d.f.d.f.5.0.6.0.0.2.6.1.6.b.c.7.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:7cb6:1620:605:fdfd])
        by smtp.gmail.com with ESMTPSA id k24sm16425084wmj.19.2020.09.05.03.44.37
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 03:44:37 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] server/process: Note when commands complete in logs
Date: Sat,  5 Sep 2020 11:44:36 +0100
Message-Id: <20200905104436.1847814-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Its hard to tell from the server logs whether commands complete or not
(or how long they take). Add extra info to allow more debugging of
server timeouts.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 21f95cb61e..c7cb34f0cc 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -215,6 +215,7 @@ class ProcessServer():
                 try:
                     serverlog("Running command %s" % command)
                     self.command_channel_reply.send(self.cooker.command.runCommand(command))
+                    serverlog("Command Completed")
                 except Exception as e:
                    logger.exception('Exception in server main event loop running command %s (%s)' % (command, str(e)))
 
-- 
2.25.1

