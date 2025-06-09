Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECAEC677C4
	for <webhook@archiver.kernel.org>; Mon,  9 Jun 2025 09:56:35 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web11.55632.1749462984485000124
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Jun 2025 02:56:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=M8OgYlh+;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a531fcaa05so1434423f8f.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 09 Jun 2025 02:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1749462982; x=1750067782; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pzTACMX/iZ1OQhYoyItMxq0mbZStFqW9BD/w/MCWMCk=;
        b=M8OgYlh+8QzRlMqYN6per9SLwhjl0qj+nBSWAy+pTk47yBRNsc30WnZrI6KnnaH9/l
         HJaHu1AQBXs8YWh2JRcj9OpQAZx3+hhfNmT5fLUFDeI1FZ74qyHWZzIfrlM60DD5D2I0
         64JoGAyIEhYb6PK2np90M+ICupsqzg4u8vfQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749462982; x=1750067782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pzTACMX/iZ1OQhYoyItMxq0mbZStFqW9BD/w/MCWMCk=;
        b=Hpg4EgdnZYgj4hT6BC2wD+pbKaPleA7ttRouo9XzKImz/5fxzmssh+ebny1av0uUMj
         2QJb0xFLZubMtdd1QSmgSSKuUOPAZWzKo3ADkIH55+giesaA+5R1CzvmXimu+JBvkv20
         d993Cf2Hy6yIvtdXnxamthBMJEZQl2zJIDr8tNcj5CLBcafRkWvWP/Mg7XNjhpmym66r
         ay0zunUz6LkcXUEJqhdqQTdfh96GKR+lhsm4BcM6z/Cvk7i1ge6hwV6Ouyp4nk7gvqHX
         jOvt+kUlVaTOzaKmNxk/L+igiqM0/VE7qz1bD23qO+42h1HxIi+Q0s6og+ef72U/AUn8
         dkmQ==
X-Gm-Message-State: AOJu0YxYgOA9uVQV8iLU5NTVnaQfgGKCG/VhLkCO2q++1sfp6ZBbTiwt
	gVRYcdvI+hZzpE0Q0KqDTx3vRBNie93A8In0dn+abNKgiXKtQI46gY36saREEbvc6tc3mEa2QId
	WeJGeovg=
X-Gm-Gg: ASbGncv/TZlx7LuMMiZk/XPGmfrQeMS3GaWRd/6fbOR3Ydnnr0Fwacmeft+/ZkiMSRI
	0Eyu6e5oVvdHGLv4bdGRufVV+qy2BQvPbwJQBNNRkSflY09BlybzHsO62WfXbvp3nOHPGGkBFEV
	tpWZ4QUJfsDFXKTCR1mIPWXZWnW+/mkLsdtTVKXb4E+QxT7BWAgB2N1XxsBC5Wl4JXR7HtBHXnR
	sczPDf81fcmDupMn309tVNl3gSy03OWNefYvczlaZlubr8NrUTVpi4jXMy0j0ucn3IUcetcwT6S
	KIioKcPKZ1GEohnhVcE4/UlyA5sPKWp1hLwjG6GoafVB8FkwnQaVx5yXspEwEfMfM3P3I9bEfEK
	6sFMQtdvVbjn1W2E=
X-Google-Smtp-Source: AGHT+IGE9bXN0W8+NbzEDqm2eaEInH5XXKt7k5z4jQ3jdLzGHp+BdB02LNRtHZ2DZD356y5VtyaZAA==
X-Received: by 2002:a05:6000:1acc:b0:3a5:27ba:47a8 with SMTP id ffacd0b85a97d-3a531ceb9a9mr10792039f8f.52.1749462982453;
        Mon, 09 Jun 2025 02:56:22 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:fa9f:168d:c475:ba8f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a532435fbfsm9229759f8f.64.2025.06.09.02.56.21
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 02:56:21 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/3] ast: Change deferred inherits to happen per recipe
Date: Mon,  9 Jun 2025 10:56:19 +0100
Message-ID: <20250609095621.937299-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Jun 2025 09:56:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17689

Currently deferred inherits get processed once for all class extensions
as a minor speed optimisation. Unfortunately this limits our options for
being able to report deferred classes to our code.

There are two challenges with using our deferred classes in OE at present.
One is that PACKAGECONFIG values don't work well with class overrides like
class-native if there are deferred classes based on PACKAGECONFIG, such
as python support. The second is that toolchain selection is proving
problematic to implement due to interactions between the toolchain deferred
inherit, the class extensions and class overrides being very late.

By changing deferred inherits to be recipe extension specific, we open
the way to generate events and "peek" at where things will end up,
allowing the class overrides to be set earlier.

The class extension code is updated to use a deferred inherit for the
class extension inheriting so that it is still inherited last.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/parse/ast.py | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index 290ed45048..f9998798d8 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -471,6 +471,14 @@ def finalize(fn, d, variant = None):
         if d.getVar("_FAILPARSINGERRORHANDLED", False) == True:
             raise bb.BBHandledException()
 
+        while True:
+            inherits = d.getVar('__BBDEFINHERITS', False) or []
+            if not inherits:
+                break
+            inherit, filename, lineno = inherits.pop(0)
+            d.setVar('__BBDEFINHERITS', inherits)
+            bb.parse.BBHandler.inherit(inherit, filename, lineno, d, deferred=True)
+
         for var in d.getVar('__BBHANDLERS', False) or []:
             # try to add the handler
             handlerfn = d.getVarFlag(var, "filename", False)
@@ -525,14 +533,6 @@ def multi_finalize(fn, d):
         logger.debug("Appending .bbappend file %s to %s", append, fn)
         bb.parse.BBHandler.handle(append, d, True)
 
-    while True:
-        inherits = d.getVar('__BBDEFINHERITS', False) or []
-        if not inherits:
-            break
-        inherit, filename, lineno = inherits.pop(0)
-        d.setVar('__BBDEFINHERITS', inherits)
-        bb.parse.BBHandler.inherit(inherit, filename, lineno, d, deferred=True)
-
     onlyfinalise = d.getVar("__ONLYFINALISE", False)
 
     safe_d = d
@@ -568,7 +568,9 @@ def multi_finalize(fn, d):
                 d.setVar("BBEXTENDVARIANT", variantmap[name])
             else:
                 d.setVar("PN", "%s-%s" % (pn, name))
-            bb.parse.BBHandler.inherit(extendedmap[name], fn, 0, d)
+            inherits = d.getVar('__BBDEFINHERITS', False) or []
+            inherits.append((extendedmap[name], fn, 0))
+            d.setVar('__BBDEFINHERITS', inherits)
 
         safe_d.setVar("BBCLASSEXTEND", extended)
         _create_variants(datastores, extendedmap.keys(), extendfunc, onlyfinalise)

