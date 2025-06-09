Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EABC5B552
	for <webhook@archiver.kernel.org>; Mon,  9 Jun 2025 09:56:35 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web10.56055.1749462985631372932
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Jun 2025 02:56:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=gY1x1hBJ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a4f72cba73so3506201f8f.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 09 Jun 2025 02:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1749462984; x=1750067784; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3YxWBXIM2ad/j3C75NGLbtQKhx9jBZAiUcVQ2JlWbTk=;
        b=gY1x1hBJnNDJue1Ee+9L28P31qdUaqXF+Az7W0JoK/eGXI8lRXR1ubpZqFFVn9V6SF
         EcUpR3VFp4YQhmhh5UDwbOMYLcMlOH+NiT3dGvw6YZJEobFKVmIOZdPFBOo6V1xJX5Vo
         nFTbfNZwmLzQMNlq7KMA6tdjpv23jctBAJURw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749462984; x=1750067784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3YxWBXIM2ad/j3C75NGLbtQKhx9jBZAiUcVQ2JlWbTk=;
        b=v6pm9ybZ4GpDw7j1GkZp6BgAKJ3Jk9xERNSpKqHWprqRRAo1Blr+l4huuSVviKLKi5
         x4gS/G4KedqNzJcyHt8wXQDDF+Y91CePlsPazdGNhVVTtCNY0PLVlpuCN1vwr97XUYrF
         tNM2VbNIZfqQULPjaAt3uoPHZneRLgOdBr8PgaoF8SCwEcpe7M+DNwlZ7ORp6bvpejHl
         jRfWEkK0M3455++LqRHy9JO87dB/ZZpNMeAlGth7j3Y0yCOERYSkDcTTKF0exPOgr7lX
         +ffpyWZDUZvQHD0xNpq5vwW3NzDO4ciQAEgX9Zmz6sCf2AbmKycdEWsysmU5ucpW8oVf
         /TJQ==
X-Gm-Message-State: AOJu0YxuxDDYhQscRaLgC+CYWBs31RAj7nO6hUyieW6eB2MttvXmLC8Y
	paf8VGm7GppwsQVCD3FkK09H4VAqvcYrDGc9oCQpw8mZGXPqo7ztviEy7wuVtmavCon6EKk4ADV
	E2E0KZ6M=
X-Gm-Gg: ASbGncs7wcg0hKZN9Q0CFMP/2WV67SGmZq5P+2fdh5TcIPBzF9doKalslgqAKHPaTKI
	kud7WXdBaFxeAK6GXWCBo4D9fzZT2AYYw2zBoUB5zXj72ZB9c3kbpUGjtDYLXmViH/IerCpvsw6
	ROciXXmJBlsAuHfW/9ZrSk8O2OMFWsiBNtMsT6I+dy/J8zWnXfe71yekUhu0N3bYl4Ru5N8EIOC
	JExjMDatP+pRPZaXWMMy/3UZYfvkxkUWcVSgc+Ij/vSQwDJLP+vPciFlh49WydGUTToqkkMw2Pr
	3mpGh8Uz+JRqIWctCb3fwY4SMwEqu+aFoFM7ah6Y2q4Tua/QFrf5pcff0+FxdBy711eqKslM9fM
	rk183ft6GYkRRMfA=
X-Google-Smtp-Source: AGHT+IHq/YxyXxCF3VdPEl1g3vCNaYIg0XvQkrnCOHu77T6CCsAZ98kK5lLhATxMQE+A7dD9ydo8Uw==
X-Received: by 2002:a05:6000:2285:b0:3a4:f7ae:77c9 with SMTP id ffacd0b85a97d-3a531315562mr10413045f8f.5.1749462983606;
        Mon, 09 Jun 2025 02:56:23 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:fa9f:168d:c475:ba8f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a532435fbfsm9229759f8f.64.2025.06.09.02.56.22
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 02:56:22 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/3] event: Add event for deferred inherits
Date: Mon,  9 Jun 2025 10:56:20 +0100
Message-ID: <20250609095621.937299-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250609095621.937299-1-richard.purdie@linuxfoundation.org>
References: <20250609095621.937299-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Jun 2025 09:56:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17690

Now that deferred inherits are extension specific, we can pass this
list to an event, which our metadata can use to set class overrides
earlier (as an example).

There are limitations to this, the list of classes is unexpanded and
recursive classes are not visible. There isn't much that can be done
about this, the ones we are interested in would usually be visible
at the top level (such as class extensions).

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/event.py     | 10 ++++++++++
 lib/bb/parse/ast.py |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index a12adbc937..b29f0a5568 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -431,6 +431,16 @@ class RecipeEvent(Event):
         self.fn = fn
         Event.__init__(self)
 
+class RecipePreDeferredInherits(RecipeEvent):
+    """
+    Called before deferred inherits are processed so code can snoop on class extensions for example
+    Limitations: It won't see inherits of inherited classes and the data is unexpanded
+    """
+    def __init__(self, fn, inherits):
+        self.fn = fn
+        self.inherits = inherits
+        Event.__init__(self)
+
 class RecipePreFinalise(RecipeEvent):
     """ Recipe Parsing Complete but not yet finalised"""
 
diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index f9998798d8..5a086b4e95 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -471,6 +471,9 @@ def finalize(fn, d, variant = None):
         if d.getVar("_FAILPARSINGERRORHANDLED", False) == True:
             raise bb.BBHandledException()
 
+        inherits = [x[0] for x in (d.getVar('__BBDEFINHERITS', False) or [('',)])]
+        bb.event.fire(bb.event.RecipePreDeferredInherits(fn, inherits), d)
+
         while True:
             inherits = d.getVar('__BBDEFINHERITS', False) or []
             if not inherits:

