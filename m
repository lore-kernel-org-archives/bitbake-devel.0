Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19BEC001E0
	for <webhook@archiver.kernel.org>; Tue,  1 Aug 2023 14:38:20 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web10.14473.1690900699936748722
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 01 Aug 2023 07:38:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=FY+Bbyuj;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3178dd771ceso4251749f8f.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 01 Aug 2023 07:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690900698; x=1691505498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxYYj5ym56bdbxp81EuLmR9zectCa+Ak2JaUT5vcx7M=;
        b=FY+BbyujsDULpIGZu1gTFi0uolNps3h7han+VdYK79ifXbEDJugCx92ng6G0B36OaG
         LnvYyzYTTA1S18FkD0q8G5NweeIPLKTrRQdbJ8jUAMoep3HGgIsf8OY2m3TD4nho/Gs0
         NESZmUyAhn79G6l+23QnWqA9glgQmc1UNXUuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690900698; x=1691505498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fxYYj5ym56bdbxp81EuLmR9zectCa+Ak2JaUT5vcx7M=;
        b=Ewyw6AUeu+yCwfNbFuYdRNSK+HH78IpXwYfnDV6PGVk4hZ0RFFavuqNEOhMrAjBEe6
         WtaYANqAhXbpBXq4c72McvKjqLgy6T5dX74B2thaYPkqnh+m4X4XAxefiiSr0Q6tmRqx
         eKNdnfkzj6oy7AsUFA5dgDUxr9LqWcR/2KAY4Fs+N+sSG/pbe9RGzKs1TGubCxWss2WY
         oAFRnn8JYbhJFyXGZNZonIA2KIly/lKTGoGHSAiL38mYXLY3Z7eouEwYLDZB1XtNsMHv
         ZEidIJPVDyea+wF9hyqePSZzExtixw7HnH0eT4ZOINA4LhUEn4IaEw8UjlbBTFDekcs5
         mB8Q==
X-Gm-Message-State: ABy/qLZ38wSUKuGsCOkAV0WA+BetTHux1jHHd+WX/kXn+HByDvk+D8xr
	uoB8ls+/CXsZCQwhY/cUJIhCQ8g6hfgLZAtKVBs=
X-Google-Smtp-Source: APBJJlHMhxVstV/QsoN9PRtn2FQQ/0BB7RKiVb1Qp8s0w7qoqk7xyjoyUR6w/71b7FdA5XPeLKZpwA==
X-Received: by 2002:adf:e509:0:b0:314:3344:72f6 with SMTP id j9-20020adfe509000000b00314334472f6mr2585304wrm.32.1690900698284;
        Tue, 01 Aug 2023 07:38:18 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:e3b7:1714:595d:8417])
        by smtp.gmail.com with ESMTPSA id d14-20020adff2ce000000b003176053506fsm12572887wrp.99.2023.08.01.07.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 07:38:17 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Cc: Christopher Larson <kergoth@gmail.com>
Subject: [PATCH 5/6] data_smart: directly check for methodpool functions in context lookup
Date: Tue,  1 Aug 2023 15:38:12 +0100
Message-Id: <20230801143813.2206785-5-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230801143813.2206785-1-richard.purdie@linuxfoundation.org>
References: <20230801143813.2206785-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 01 Aug 2023 14:38:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14904

From: Christopher Larson <kergoth@gmail.com>

We previously checked for the existence of the 'func' flag to determine
if we should avoid looking up in the metadata. This was done to ensure
the user gets the function for 'def' python functions rather than their
string contents. We can sidestep the metadata lookup and check our
function context directly, instead.

Signed-off-by: Christopher Larson <kergoth@gmail.com>
---
 lib/bb/data_smart.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index fe0bacd13b..0128a5bb17 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -154,19 +154,20 @@ class VariableParse:
             return str(value)
 
 class DataContext(dict):
-    excluded = set([i for i in dir(builtins) if not i.startswith('_')] + ['bb', 'os', 'oe'])
+    excluded = set([i for i in dir(builtins) if not i.startswith('_')] + ['oe'])
 
     def __init__(self, metadata, **kwargs):
         self.metadata = metadata
         dict.__init__(self, **kwargs)
         self['d'] = metadata
+        self.context = set(bb.utils.get_context())
 
     def __missing__(self, key):
-        if key in self.excluded:
+        if key in self.excluded or key in self.context:
             raise KeyError(key)
 
         value = self.metadata.getVar(key)
-        if value is None or self.metadata.getVarFlag(key, 'func', False):
+        if value is None:
             raise KeyError(key)
         else:
             return value
-- 
2.39.2


