Return-Path: <adrian.freihofer@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BABC48BC4
	for <webhook@archiver.kernel.org>; Thu, 15 Feb 2024 20:45:44 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
 by mx.groups.io with SMTP id smtpd.web11.1544.1708029938729874733
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Feb 2024 12:45:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=VXNcdeiD;
 spf=pass (domain: gmail.com, ip: 209.85.167.45, mailfrom: adrian.freihofer@gmail.com)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51182f8590bso1691396e87.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 15 Feb 2024 12:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708029936; x=1708634736; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NCiPJBnrAMvNK29JR2dnufUJjCsfWjqptDxD74y8Rk=;
        b=VXNcdeiDgi2s/+qdSWOuRQHk5hataY3C76tUJhYQAf7xMlIQzFJQrhHJ3h9SVq+L3y
         sIckdxOsfwsF2S5ZTKecFXwlt1bSWxaf9f1U3D9d7S6iUdptZGn7BBQHK8lk2jf8A23v
         1sCP4Fp31y/xjAabJc30wll3tTBAjsCDS2jfk5BqvlGOg1h8k0OnIv1o+vIOSejTSHzM
         KrLPrA+eMTQjuPkgwHaeK3iXjwtY0l/4LeKzWq0vBa7Qu9WEoQcrvbIDIgPgGY0/3rxs
         9cDmNJHXbfLoGQ4yhZQaMoFtsfHF7U+YzH3l3He49E49YtZZwSi0l0IGsseaFMjz2vK+
         wFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708029936; x=1708634736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8NCiPJBnrAMvNK29JR2dnufUJjCsfWjqptDxD74y8Rk=;
        b=bt+h+KA6mES/xGE2kOeu31Vcu2SJwZg2p2pxkOtmKsaa4mc+YjBhyZspbvu8v9y9ow
         M56aV/6YbYbwhd5XA4D8Jbua1FMvHDplOdhPsrIGfo2bczeTxej1NJ1Soq/LuWFNflJg
         +qUPpBQkoFnzA/qq6nU7gfROkNtCmVEoPR777Vu7RozB65piHfkYKpBd4PfzKX44px2D
         CGhzGtQ1GnLt0WF405ioejZJkHxt8Ak9SPPdyWwsPcdDYSz+iSYMz794A/harqHpxx8o
         qynx8Mc6GfcDWJEM3vgkRDqyCwl6AfdNHmmTKw6otxirX6Z3dwRPieWLiI8X/8IpN+pq
         wv2w==
X-Gm-Message-State: AOJu0Yzahhqhc2JWALTGwGVUF/s6Bv5KhLay39Yo3gNiRdZOtP4JT9UP
	ZRetC9M9yfczkofVm/be/fKAxMCgnjQTNeBk2NI6DQzllEFQxapnOS3IxHod
X-Google-Smtp-Source: AGHT+IFwK0/wWSIDlcoK1j8PLPpylT3ta+VoHb8NHat6XqrljtW1sfIS438DW8D9tP4xz0uvtzHeHw==
X-Received: by 2002:a19:e04c:0:b0:511:8691:62d4 with SMTP id g12-20020a19e04c000000b00511869162d4mr2110940lfj.41.1708029936264;
        Thu, 15 Feb 2024 12:45:36 -0800 (PST)
Received: from wsadrian16.fritz.box ([2a02:169:59a6:0:55c4:f628:91f3:4287])
        by smtp.gmail.com with ESMTPSA id er17-20020a056402449100b0056058f2603asm883058edb.3.2024.02.15.12.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 12:45:35 -0800 (PST)
From: Adrian Freihofer <adrian.freihofer@gmail.com>
X-Google-Original-From: Adrian Freihofer <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Chris Laplante <chris.laplante@agilent.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [2.0][kirkstone][PATCH 1/3] codeparser: replace deprecated ast.Str and 's'
Date: Thu, 15 Feb 2024 21:44:50 +0100
Message-ID: <20240215204524.320874-2-adrian.freihofer@siemens.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240215204524.320874-1-adrian.freihofer@siemens.com>
References: <20240215204524.320874-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 Feb 2024 20:45:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15901

From: Chris Laplante <chris.laplante@agilent.com>

These have been deprecated since 3.8

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/codeparser.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index 9d66d3ae..bb890ddd 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -225,8 +225,8 @@ class PythonParser():
     def visit_Call(self, node):
         name = self.called_node_name(node.func)
         if name and (name.endswith(self.getvars) or name.endswith(self.getvarflags) or name in self.containsfuncs or name in self.containsanyfuncs):
-            if isinstance(node.args[0], ast.Str):
-                varname = node.args[0].s
+            if isinstance(node.args[0], ast.Constant) and isinstance(node.args[0].value, str):
+                varname = node.args[0].value
                 if name in self.containsfuncs and isinstance(node.args[1], ast.Str):
                     if varname not in self.contains:
                         self.contains[varname] = set()
-- 
2.43.1


