Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465F0C433EF
	for <webhook@archiver.kernel.org>; Mon, 23 May 2022 14:40:25 +0000 (UTC)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by mx.groups.io with SMTP id smtpd.web08.28371.1653316823615447568
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 23 May 2022 07:40:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=oSs1oxnh;
 spf=softfail (domain: sakoman.com, ip: 209.85.215.169,
 mailfrom: steve@sakoman.com)
Received: by mail-pg1-f169.google.com with SMTP id a38so10994971pgl.9
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 23 May 2022 07:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=LosbZIoUSiLbaJOrMmsankthwkLeaud88Ahev/n0YhM=;
        b=oSs1oxnh1POZ4OPycWQSzInbIW+auaTLpdTab7352hX3ELKVD/2zKKzT7mK5FwHk59
         qmdn/fyBjTVwtGIqo2xdcThgcQDQR4cDzaQWSwlDGu/PCfkX3Vvv8Bd0yFf2GbLQaSWt
         E5dzZcf8P9hISw+JvTzLaAFzia2Gt+T8x+tWU+YhnBgXFm1x6u+eqLYxFgof2K02iXQD
         7X5MjOSdme0VZhkcnT/jgVtY3l7Ot2KEuBLJvswxnpAc0KOG2ZqqQkpwT+J+XU7DYErA
         rqCkPu+gUkniKXTPDyAULbutWE/3uWxVqZppLZctgn7QkECgDOKK/l5DMhUnNr46YHv6
         oV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LosbZIoUSiLbaJOrMmsankthwkLeaud88Ahev/n0YhM=;
        b=GEHsTynbegdImATREWBdlZgYSS/vFxFDrQx2meSPpXwUWo/KCiQwgFa7i7H8C2YcjL
         sPISi7AL82MegSQvFYwU95B4ifBoCbSPMU69smNjo8gf1rQ7GeyAfMTQfmscUifLFRpp
         Z8EOEM3e32TQU4Nr/F9xWYg11t75dSx9v0IacvKQ54z3nJuunOOS55a3DQ+WMWDyms1J
         XNge2NwJRwnwQrTPqTesoSpzlHUJAf89ZAfd3NMc9Ow7WJIkueM7eyGE5O5/Y7seao05
         JJJtv7Eq5R1GfDlH4e60tEVEGKm8KqrvLOdUpWHCjXQkYRv1C0fXnz4BgrJeT8a0avjK
         KZ4w==
X-Gm-Message-State: AOAM532WKqfY8zrFuA0+Xx0fSkO8GII/a61zioKkxl6rhIAPzAtj3+Tv
	cmR4QjjWbdLPZWYbFYXQqq1aLEzd2oebug50
X-Google-Smtp-Source: 
 ABdhPJwtR4i/JqhSSfW5jkU+jS1ZmaW37O42KQrkwZJsFZmq/4EzT32sk7CpxuauHf2BHY2V3+f0SQ==
X-Received: by 2002:a65:52cd:0:b0:3f5:f3fb:6780 with SMTP id
 z13-20020a6552cd000000b003f5f3fb6780mr21083298pgp.150.1653316822296;
        Mon, 23 May 2022 07:40:22 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 u4-20020a655c04000000b003c14af50623sm4865576pgr.59.2022.05.23.07.40.20
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 07:40:21 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 2/3] data: Do not depend on
 vardepvalueexclude flag
Date: Mon, 23 May 2022 04:40:04 -1000
Message-Id: 
 <b1957b3d814b72e42902fd858718d138504842ed.1653314792.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1653314792.git.steve@sakoman.com>
References: <cover.1653314792.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 23 May 2022 14:40:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13709

From: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>

If SRC_URI contains python function that extends vardepvalueexclude its
value is being tracked by sstate-cache, which can lead to rebuilds if
value is set dynamically (for example gerrit replicas).

Return empty string if vardepvalueexclude is checked to fix this
behaviour.

Signed-off-by: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit f5f9a7b89a7d8321f03184e61ad6d5ed8d0f840e)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/data.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index 62ec2147..c09d9b04 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -277,6 +277,8 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, ignored_vars, d):
     try:
         if key[-1] == ']':
             vf = key[:-1].split('[')
+            if vf[1] == "vardepvalueexclude":
+                return deps, ""
             value, parser = d.getVarFlag(vf[0], vf[1], False, retparser=True)
             deps |= parser.references
             deps = deps | (keys & parser.execs)
-- 
2.25.1


