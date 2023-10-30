Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5272EC4708E
	for <webhook@archiver.kernel.org>; Mon, 30 Oct 2023 19:18:24 +0000 (UTC)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
 by mx.groups.io with SMTP id smtpd.web11.158501.1698693499927064155
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 Oct 2023 12:18:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=iW97Zj5x;
 spf=pass (domain: gmail.com, ip: 209.85.210.48, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6ce37683cf6so3333448a34.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 30 Oct 2023 12:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698693498; x=1699298298; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncOBBQVOKSJI4oIEZXme+bBgONZifXz6NgsuiVg1fgg=;
        b=iW97Zj5xy03Vd9hTtansQ6c619msSsDcBB77HBKkTGL7lSrSFLxXPk+R1Xxx+pjbz6
         nRlC0QlnP+gnE89tK1LarrmJ4tUr/zmBv2UbbQWdVUbCdrvY3YinX11eXlchPZQ1KqEw
         2kHtP9Q16MAxaFr4QYEhnmfSbxDDUsP7mkVQR6H8nImBEUSs+GHKUTlb0jkrMgf1t/7u
         s4kAOmH4comCL4y3v3PT4MB10vzmuszkbogOHt/R4+3R8oAt0qpIf4AEmW2TCxWjdlKn
         ERSApy35wzWavCi+1shvP3/v4JWs3fVKSgZF3hdUAeQrRaAH0BBLn6Unkuejzusc6i0M
         LEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698693498; x=1699298298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ncOBBQVOKSJI4oIEZXme+bBgONZifXz6NgsuiVg1fgg=;
        b=lDfUU3lbEPgNMZ093S19JHKM8C13oyPVtONVMdv51lHXFJWq1NrPCqfHqb/t92r9rf
         alwBio/PA0CRAWUfLH1fMHWS/+z9SfyL/r1xkdeGhHmN9Sp3o5nHr7L22BQAZDvblySa
         a5XenrlMAntKXgo+LrXgXcN8iLFF4EYzBZQShKUj8wM+t9te04y/DuV+X+GkofNKHT52
         runHbdLW6QvkFrLOzRSIw7XvCQr3UKmbj4TGQ8HwoWpFCyHi//7+l95Tm5N9GrAGMMxl
         0YsvZh2xDU+gP0HQtxABFZU2ejoHVtsYKuEN7tEX7wxEVLlveJopN7/iJ7xDJmAQiWoJ
         0udw==
X-Gm-Message-State: AOJu0YyXR19Ai+4QFdK6xMAVrNCq7KResoBt9v1zrekXSVCoJOiO/xaW
	0qaluwbOhZTulkCb9U3xPy1Zkq782Ws=
X-Google-Smtp-Source: AGHT+IFmtUe5DK57oOh9OG5FL3lw+2jCRQrDtgSjNS9TWc8fx9BHpwMetrN3m9jVjjRtavVms/6LMg==
X-Received: by 2002:a05:6830:348f:b0:6d3:940:82fa with SMTP id c15-20020a056830348f00b006d3094082famr393105otu.12.1698693498693;
        Mon, 30 Oct 2023 12:18:18 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6aa6])
        by smtp.gmail.com with ESMTPSA id l38-20020a0568302b2600b006cd099bb052sm1510500otv.1.2023.10.30.12.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 12:18:17 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v3 19/22] bitbake-hashserver: Allow anonymous permissions to be space separated
Date: Mon, 30 Oct 2023 13:17:25 -0600
Message-Id: <20231030191728.1276805-20-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030191728.1276805-1-JPEWhacker@gmail.com>
References: <20231012221655.632637-1-JPEWhacker@gmail.com>
 <20231030191728.1276805-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 30 Oct 2023 19:18:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15321

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


