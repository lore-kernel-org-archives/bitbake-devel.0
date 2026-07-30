Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B01C5516F
	for <webhook@archiver.kernel.org>; Thu, 30 Jul 2026 18:33:06 +0000 (UTC)
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18816.1785436378754527288
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Jul 2026 11:32:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Dp/RyNzj;
 spf=pass (domain: gmail.com, ip: 209.85.160.51, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-45171f2f608so135675fac.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 30 Jul 2026 11:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785436378; x=1786041178; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PI3rOpzqM993OnncotOYYrbT5CTP6U+3eCypg+8LKJM=;
        b=Dp/RyNzjADQZph9vSnG+/XlGWis3+6i32YPSxmf7havYs/5O6LEHMLmV1+SCFc2JgQ
         pE6Vglr1JhGDVBc82tz4CJtAb4FDpO7yQQE0w0mFnj8zJOaotC/cQHVc5F18BfaVUTjQ
         cbYJb6ZreHHnFzgr/9DCOukJy5paVByREfqpAyJ5pSfP0FUQkmsf8IXc1vgM1Q9h4hBU
         IRW+teFSPp/jqK53pCYK5A7XRWWwVsxBJcRBBXS+rArOcBFWgXDS3hPI75OnFLfKzo4c
         uwEhOKxTemqvnZ9Aws4gBpa2dOnOWlElSWzHzqZKjpef8qnK+GXWPHJpROs946114rxr
         dVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785436378; x=1786041178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PI3rOpzqM993OnncotOYYrbT5CTP6U+3eCypg+8LKJM=;
        b=ZNPxjGuww6ya0XhXGJhSTvdtyZDA5Cm+0Lzk7jjTzHxZRIDmHiZjmH+yyNGZYalngn
         XEwrEEd1MppifdZGB8C0wEKEJ5yEt69qyA6t56VosH5nXxNPXWBZvoUx/WBXVK9wYcQO
         CzNJPg39nYkMlMGD0465SHKFEoq+VDxvSdgDUI7yCiJV+RqGVvwUTu4mZo7e3ROY8bUn
         xjiGMPIqSxE96SgMUfV1tfPwLb9xNbERLzlEQvTVKi0K2dFCD/9H/i+scUczKaJBv56R
         W0H7p8YycEz7XtLyyPtP4v3GpnVtvtC15U7WpPNuqvi1M0RBpWx3O8GudiEs/wTeXh7h
         qDSA==
X-Gm-Message-State: AOJu0Yyec44y8EZhx9G1SeE9jPHhOD8l3a5EiyMEmeNX5tkSYOhV9Ax1
	4T9wrURbo/QImBl4/JWetQiEgrM+RsGQLHPIWH7C8VHX7rVLZn9HDXt6HsrjoA==
X-Gm-Gg: AR+sD13mMuSZxNgGerrR287GwTt/rDBCLv1GWqambHVqdm3PobF2N77e7b3sWXd4PN1
	v8XIxEKdib8v+svBV8dR5FMcQEpD0wDPYL3ayF55F3gbCQi8NbqA9Gkeunc23UdKeuu6mGd6rE6
	EfmSLldzGmgVUt0ye2uRgeckmnXyI/2vpt+YG0+BkCro0Oev7W+yTG108cnhJFMZLUdqD/Tc2zk
	8BX+/SQwPnjqnFjMaXzSSi2lyH8ZxtfKUq2qtKQBu3WIyFdwQ1Y1ONqIvj1hTQVVwQ0ivfvEjxF
	vjXWf4GxjRWfdjwKA9zsDN9ij4kaHUBUZPhY1sQO0f7LowMRlextIP8sneiJpQD7X/+TLZU74OE
	KfebbkCsTceGeDzrYh20eQ5HRu8jJv+Sfj5G7Nt8tJYSjDeZ+iY3Td9Asi2xRDODCeiWXF+VBqd
	iw1WuOoZNMFnEx879m64kZ590fI4olvMGkDHnK5cxeKJLljK/6iCLcGeifeQ==
X-Received: by 2002:a05:6808:179b:b0:4a4:934:b316 with SMTP id 5614622812f47-4ad878cae8cmr2587508b6e.21.1785436377790;
        Thu, 30 Jul 2026 11:32:57 -0700 (PDT)
Received: from localhost.localdomain ([2601:283:4b02:22d0::10c9])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ad6efc5c3fsm4593047b6e.13.2026.07.30.11.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 11:32:57 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v2 02/10] asyncrpc: serv: Use Task Group
Date: Thu, 30 Jul 2026 12:30:55 -0600
Message-ID: <20260730183254.793698-3-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730183254.793698-1-JPEWhacker@gmail.com>
References: <20260724212822.1165552-1-JPEWhacker@gmail.com>
 <20260730183254.793698-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 30 Jul 2026 18:33:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19882

Uses a task group instead of asyncio.gather(). The task group ensures
that all tasks are canceled if an exception occurs, which
asyncio.gather() does not.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 lib/bb/asyncrpc/serv.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/asyncrpc/serv.py b/lib/bb/asyncrpc/serv.py
index bd1aded8d..d3b1c6c35 100644
--- a/lib/bb/asyncrpc/serv.py
+++ b/lib/bb/asyncrpc/serv.py
@@ -334,7 +334,7 @@ class AsyncServer(object):
             self.loop.add_signal_handler(signal.SIGQUIT, self.signal_handler)
             signal.pthread_sigmask(signal.SIG_UNBLOCK, [signal.SIGTERM])
 
-            self.loop.run_until_complete(asyncio.gather(*tasks))
+            self.loop.run_until_complete(bb.asyncrpc.TaskGroup.run(*tasks))
 
             self.logger.debug("Server shutting down")
         finally:
-- 
2.54.0


