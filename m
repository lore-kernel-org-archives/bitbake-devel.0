Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78075C4332F
	for <webhook@archiver.kernel.org>; Fri,  3 Nov 2023 14:27:26 +0000 (UTC)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
 by mx.groups.io with SMTP id smtpd.web11.52776.1699021645956533823
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Nov 2023 07:27:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=FzJu0Xyi;
 spf=pass (domain: gmail.com, ip: 209.85.210.53, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6ce532451c7so1148792a34.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 03 Nov 2023 07:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699021644; x=1699626444; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncOBBQVOKSJI4oIEZXme+bBgONZifXz6NgsuiVg1fgg=;
        b=FzJu0XyiKV9yjJRDHoUhgDzDuYErxwjIsHUrjYa3Ivp8L7G+D7B40vjt4qxppxGhCo
         82bqFcQMzIkiWAYkVbdYvfOrypIQvG4BLfFuNNiaO4sqkrUzFmnBhDBj7iob4iE5K+s1
         AcIg1GycUO9Dy1VO4wb08RRv/KTx30rPOSbveCws/iq2cPv+SFpNXHbbu7j1donY995f
         Vj12AilJ/qmNUxoSHUEmN6oRpyZyN4PnpE08q/IrYRJvLhio+mQzbEdgjut18Jm/hlnH
         lla95yVnNno9UrKjKfqQxHZ5j7g8D/KA54yg0UEToQScG0SW7Ql7WFJWdsF75JlkGKvr
         658Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699021644; x=1699626444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ncOBBQVOKSJI4oIEZXme+bBgONZifXz6NgsuiVg1fgg=;
        b=q8/mK0ErdSI45Ca1rC0I+zOERJ7A4DrZ8e1XuXgb8Tai3Eq4CYqnNX9pQ3bxCBCHFn
         yvNOJNRn3ZgWb0nCC0riYWdTL1v+mSn7fgTzeU0gca8uO+9bLtE3cOTLCBCKZriMYWif
         EbSXISK5X5GeBCzo4Zq22BCbaJGecKj5NlZMMh1v1YjYz/tyYhjjPqrQSnW2VGz5205J
         KqtHffvrM16HaXs7SzzVkUnpAUYf9UcmB5gWFSh32ToghWSKDrz49sCWRhlJPyB1XDEa
         4WKH+j+POrwoagtw82BD+dybbitD2Gbf6IvwxhgU4UrM3hQ8qms4w2n7RtVeuUeymTPn
         nClg==
X-Gm-Message-State: AOJu0Yyx0kS8Vmh8Bvi5J/d3BT+XKrAiQv7XXsMrQFVLlcFx4oVhZ54H
	+dbi0j+1xFdZgbyeS1Tk3WpJHIyejpE=
X-Google-Smtp-Source: AGHT+IEnPJR+JZaMZ4vH7aOw9xFTq5G9njKM41Bki5VhbEZHZAIDrhdul9S7o7TrCVW2YPnX/rtE1A==
X-Received: by 2002:a05:6870:d8c8:b0:1ea:ce71:dd13 with SMTP id of8-20020a056870d8c800b001eace71dd13mr22820257oac.28.1699021644057;
        Fri, 03 Nov 2023 07:27:24 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::2fe0])
        by smtp.gmail.com with ESMTPSA id bb29-20020a056871b21d00b001dcde628a6fsm308272oac.42.2023.11.03.07.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 07:27:22 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v6 19/22] bitbake-hashserver: Allow anonymous permissions to be space separated
Date: Fri,  3 Nov 2023 08:26:37 -0600
Message-Id: <20231103142640.1936827-20-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103142640.1936827-1-JPEWhacker@gmail.com>
References: <20231031172138.3577199-1-JPEWhacker@gmail.com>
 <20231103142640.1936827-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 03 Nov 2023 14:27:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15440

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


