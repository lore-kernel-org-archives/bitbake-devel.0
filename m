Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCDFC001DB
	for <webhook@archiver.kernel.org>; Wed,  1 Nov 2023 15:42:58 +0000 (UTC)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
 by mx.groups.io with SMTP id smtpd.web10.10816.1698853372928409173
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Nov 2023 08:42:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=I0l0g5Wn;
 spf=pass (domain: gmail.com, ip: 209.85.167.172, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3b3f6dd612cso4333536b6e.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 01 Nov 2023 08:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698853371; x=1699458171; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncOBBQVOKSJI4oIEZXme+bBgONZifXz6NgsuiVg1fgg=;
        b=I0l0g5WnoP9y5230ymi516fob3vR6LDO1+WZ8TIPoa4YBCOZ3thrlD9Cb7bYsl4hfo
         epIRYOhbbm45xDxl1I54AvHs9cUEzO9ic2O8uO1YthkvconR1GjdHJ0SLwKY5VXyPVV0
         7uCrCBYMavrf9jQd5LU2uk3RuLE8Am1CShaOkutspeIJsauF41IDT1TRaM+zVcVt5pr3
         gfV2XsiodVNbYaXbtrk28luWgxK3smJ1h2yA6cagm4YWld1DO8YyqtH73Gz48rLdv5J9
         Hj79zWErnfpX6NJcdba12fLuum8vauIcP6oCicaCZ7b6U/tyKZp3VL55fBoIS1ZpyucW
         2dtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698853371; x=1699458171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ncOBBQVOKSJI4oIEZXme+bBgONZifXz6NgsuiVg1fgg=;
        b=vtfIRA2AhKwyb/0CmaoG/09omcoFcWp5yPzpxBxI+rOZE5cyuBBtRBHFTMP+nYdveP
         0sC7kX3ONXQV01dtkkUze3reCmSw2BYgbHC8hbnX/u78B1fwOSRvT4s2Wdcox6ZyCVEJ
         RqnG65viwn8XAFvDSQW1uQ62DLVhPJG9rTfALYbVzn582F3I888CoWKBmeKdZhEOunlq
         74QRUU4CBMFcut4xzYe3cWpR4J04TK0kT7h9FtRjfwfOYtRmue3FY02FukCCT5VzCqTv
         3G5/0OAhZtEvNJdfWl3WoAtdqqcDYWw0TuW9/KLUXYKwBkJ9L2JyG1yqevYwRSJiDTJ1
         OcCQ==
X-Gm-Message-State: AOJu0YxVRtAGFuVNCUzV+jW04Xgd/xWOjztZ/38XVJyJRxiPnku96oRT
	H3TB7C2rsgKzNR9wTXZUczj6OGjmbAE=
X-Google-Smtp-Source: AGHT+IHY4wcCatQgkEYA++n6OUH66q7MWg+d+r9lBjYhnuzohGs4QCZZW+8rtbta7cVewjoyseT6kg==
X-Received: by 2002:a05:6808:210d:b0:3ac:aae1:6d64 with SMTP id r13-20020a056808210d00b003acaae16d64mr18889859oiw.2.1698853371642;
        Wed, 01 Nov 2023 08:42:51 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6aa6])
        by smtp.gmail.com with ESMTPSA id l9-20020aca1909000000b003ae36d664a9sm249651oii.39.2023.11.01.08.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 08:42:50 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v5 19/22] bitbake-hashserver: Allow anonymous permissions to be space separated
Date: Wed,  1 Nov 2023 09:42:13 -0600
Message-Id: <20231101154216.2758185-20-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101154216.2758185-1-JPEWhacker@gmail.com>
References: <20231031172138.3577199-1-JPEWhacker@gmail.com>
 <20231101154216.2758185-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 01 Nov 2023 15:42:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15401

Space separation is more natural when setting the value from an
environment variable, so allow that here for convenience.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bin/bitbake-hashserv | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-hashserv b/bin/bitbake-hashserv
index 1085d058..c560b3e5 100755
--- a/bin/bitbake-hashserv
+++ b/bin/bitbake-hashserv
@@ -127,7 +127,10 @@ websocket, as in "wss://SERVER:PORT"
     logger.addHandler(console)
 
     read_only = (os.environ.get("HASHSERVER_READ_ONLY", "0") == "1") or args.read_only
-    anon_perms = args.anon_perms.split(",")
+    if "," in args.anon_perms:
+        anon_perms = args.anon_perms.split(",")
+    else:
+        anon_perms = args.anon_perms.split()
 
     server = hashserv.create_server(
         args.bind,
-- 
2.34.1


