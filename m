Return-Path: <marciohenriques84@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE244FF885A
	for <webhook@archiver.kernel.org>; Tue,  5 May 2026 12:48:35 +0000 (UTC)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.38316.1777985312290743380
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 May 2026 05:48:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=UalbFc/G;
 spf=pass (domain: gmail.com, ip: 209.85.208.179, mailfrom: marciohenriques84@gmail.com)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-39389398838so25952131fa.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 05 May 2026 05:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777985310; x=1778590110; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U65UzTelbIaeo+R2AIZJyi7GyYPDWekPTdxCdXlQIcw=;
        b=UalbFc/GEzDBJUVHTLU+bZq4B1qdpcIlHSclPhDrmh4RatAbKxBp1OdradpBPqgnZI
         DJKOZaNSHKGPq3M/UeoBw54jvDvgf0OSJgtF702tmd6SpZaUpshtDwAo/ImT7Y2ih48j
         CS2A7o9+no9Bqe+K927ejqtyGyK8RXp2zcDkpPRhgwnebIBUizYstIZMc57gTfSZomja
         Lzf80pY1AEbaz2pxvoG3C7Bxe5geeLfpQpJYgTSdJHzjSjx5iAQPze/WqPE5Qukce/za
         RLeU1ZyKSSybvQhy2EnohmKlRlIeAQl1tyWMCHID/mK3PaUKZ9FU05EwCO0OgsCSNnm9
         vgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777985310; x=1778590110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U65UzTelbIaeo+R2AIZJyi7GyYPDWekPTdxCdXlQIcw=;
        b=BdAIXWuJ5LZl9zXnEpyD++cLNczeAUahaRohvexudu9TpkvWn3ee6eH5gLMUpWWHn/
         2zqr8O2X62IGCDZjGvrowx2ufA2Ga6Z9YB6qx1ivwgGd1T+IN9GftCCX9SQeZCa6mSGC
         rD3IWQDDTkqwwy5QqMQz7zVO8ZdPzdkZGw9Yy9TYyjHETW190MRVhDuZZggpZ6pc6f9r
         aw69ppdy7FD+1dnb4RXyketaMifXNBhI+gXfnk28KsaE8mx2NE7/w0DNxr/qiGfluiIe
         GL1tuBUmBVJXGDOUK8CiIghZ237EhrEeW2+W4O3fiIJlQkQIXZpH7wiGLhjzYNmjYq3i
         XoWg==
X-Gm-Message-State: AOJu0Yx9npQLTAgUF0ql/8R5NDD1//x50nWjQFiCfeyXFnvvn3+7l+ou
	n9oEkes7B0tEWe8X2+cHrL9UGFNG8CpYsYPKATO8+DcYrzDLA3sQv8iWqSDBCdTW
X-Gm-Gg: AeBDievLLIDfo29nmG34jO/aWvZvHQrdYyplPpo7EdnNBq21FuTVt948r8S4as+Evkq
	RXJbF4KL0Pm55vIbszPHs0K0wlNtGuofEgvWUqBLQLv5iwDnfiBxOnUyAEPfAiRW0QejsMQqoCD
	efIfUmHcV9Vyizx9vjWUTnA7xPvUEZnhmBS+UUwn1uBjYkQF8bj0ZvxVlu+ng+cdHf0BHs00r3u
	ZZpbiSIR9vfsFET8Kbhmw/cb4SRC+W/935oMr+w72ppsF0ARkcCJrBs7YDsQcfBgJiv4f7mY4dd
	Qh70K/yu3OMcXpUMD6se8FOLsjQ+WfxK8WIf48cGMoj+RQVI60P5RIrdjk/Waf1YioZYkSAsiQv
	u3p7raLujrUKOVu6Exu/cEFIMcenxpyux3niu5ZqYjM1aqLtnpbI3PNlXqQa005+vDS58IjCEv7
	YmAUAeoQrkM0RH/HdXECxcSyLbkUix5u1SOebRcEZH+pUATpC0K1HKtc+Zlite5ziKTE851fVY6
	JVfsk9jcL++WNI9C+hZ0Y/EIghQT9TzODtLnAzRK0HXJxQTLwbx5mQi
X-Received: by 2002:a2e:be26:0:b0:393:7a01:397d with SMTP id 38308e7fff4ca-3937a01518fmr51163281fa.26.1777985305153;
        Tue, 05 May 2026 05:48:25 -0700 (PDT)
Received: from PT-PF3LTRXS.critical.pt ([213.205.68.220])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4505558e213sm4490093f8f.25.2026.05.05.05.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 05:48:24 -0700 (PDT)
From: Marcio Henriques <marciohenriques84@gmail.com>
X-Google-Original-From: Marcio Henriques <marcio.henriques@ctw.bmwgroup.com>
To: bitbake-devel@lists.openembedded.org
Cc: Marcio Henriques <marcio.henriques@ctw.bmwgroup.com>
Subject: [PATCH] bitbake: fix issue with varflag exclusion
Date: Tue,  5 May 2026 13:48:01 +0100
Message-ID: <20260505124801.42920-1-marcio.henriques@ctw.bmwgroup.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 05 May 2026 12:48:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19436

This patch fixes an issue when checking if a varflag
can be safely excluded.

BB_SIGNATURE_EXCLUDE_FLAGS lists variable flags that
can be safely excluded from checksum and dependency
data for keys in the datastore.

When bitbake checks if a varflag must be excluded it
checks if the varflag name is part of the string stored
in BB_SIGNATURE_EXCLUDE_FLAGS.

As an example, if the varflag 'filename' is in
BB_SIGNATURE_EXCLUDE_FLAGS, the varflag 'name'
will also be excluded because the check will return 'True'
when checking if the varflag is part of the string with
the varflags to exclude.

To fix this issue the string from BB_SIGNATURE_EXCLUDE_FLAGS
is converted to a list before checking if a varflag is part of it.

Signed-off-by: Marcio Henriques <marcio.henriques@ctw.bmwgroup.com>
---
 lib/bb/data.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index 5fdcdb04..b12972c0 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -378,7 +378,7 @@ def generate_dependencies(d, ignored_vars):
     mod_funcs = set(bb.codeparser.modulecode_deps.keys())
     keys = set(key for key in d if not key.startswith("__")) | mod_funcs
     shelldeps = set(key for key in d.getVar("__exportlist", False) if bb.utils.to_boolean(d.getVarFlag(key, "export")) and not bb.utils.to_boolean(d.getVarFlag(key, "unexport")))
-    varflagsexcl = d.getVar('BB_SIGNATURE_EXCLUDE_FLAGS')
+    varflagsexcl = (d.getVar('BB_SIGNATURE_EXCLUDE_FLAGS') or "").split()
 
     codeparserd = d.createCopy()
     for forced in (d.getVar('BB_HASH_CODEPARSER_VALS') or "").split():

