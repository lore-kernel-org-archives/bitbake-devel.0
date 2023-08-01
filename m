Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA64C04FDF
	for <webhook@archiver.kernel.org>; Tue,  1 Aug 2023 14:38:20 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web10.14471.1690900698233122147
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 01 Aug 2023 07:38:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=OgJPzBpv;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3177163aa97so5918226f8f.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 01 Aug 2023 07:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690900696; x=1691505496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xr6xKJOGFMNKRN/POjNx+b7Lcy2saM9y0FysfgZW34=;
        b=OgJPzBpv3ijzb/x7wLFotPRdhyE/XNNGXBS7lhvFtp+QuiOh5uSJdkKvSgoaBRgAXN
         UqPrlWjWsRMw1Vpu/9UkkiQwjqzk5/daXjkEbgkNvSZueKr8z2xvp7js4zBuK955dp7B
         VStwyOxL40Js55xXNV642cFJSPQh+p1n6FCzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690900696; x=1691505496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5xr6xKJOGFMNKRN/POjNx+b7Lcy2saM9y0FysfgZW34=;
        b=BhCwLq5g605zkg7lZrx9YOvXjYeV24TnCFIEHjWSFl22BOtHGa8qawyYuhS8av4sMX
         Iw/8apCeSJxO2XzgDQOaE4lyKjm8SqLVWSZZhnUFadJ4wN0H0JU3U4/K4HTRd5sO9HoG
         TnPnUY8jOicDsoTzDTPiYPpHgNUh7/w1tgqWLhH80w3CSnFtQbg9VTMW7PKYOupHa/xo
         RwyQ/fu1ot4ngRtDdAGe+1eg8MgHzb3EWjx/HIvio3AWiMUS+x9uhGHyGMZcn4UQVTOU
         R0A0IVNfAYL+luUadvBJvBv8nVPYf+u3CsD/o1JEc7GJokurOqVhAL1sg5jVh2x3HatK
         votA==
X-Gm-Message-State: ABy/qLYGWD4+ErJmVfnjXrHnNaLFiibiJZSDpGCuhOkHdfMghVbMeM6L
	b63wBkCHozvq/8qALK5vC0U52ru091C61Udyt8o=
X-Google-Smtp-Source: APBJJlEHPvR8/riw7NlYRCg5VtR1ri5kHL1yq3klSDeAHu2tAs9al14T2Py7MwoWwE9TQg1KxDUEeg==
X-Received: by 2002:adf:e60e:0:b0:317:58e4:e941 with SMTP id p14-20020adfe60e000000b0031758e4e941mr2488828wrm.33.1690900696406;
        Tue, 01 Aug 2023 07:38:16 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:e3b7:1714:595d:8417])
        by smtp.gmail.com with ESMTPSA id d14-20020adff2ce000000b003176053506fsm12572887wrp.99.2023.08.01.07.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 07:38:15 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Cc: Christopher Larson <kergoth@gmail.com>
Subject: [PATCH 3/6] data_smart: check for python builtins directly for context lookup
Date: Tue,  1 Aug 2023 15:38:10 +0100
Message-Id: <20230801143813.2206785-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230801143813.2206785-1-richard.purdie@linuxfoundation.org>
References: <20230801143813.2206785-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 01 Aug 2023 14:38:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14902

From: Christopher Larson <kergoth@gmail.com>

This avoids the need to hardcode a list of python builtins. This also slightly changes behavior, in a case like `${@eval("3")}`, this will ensure we always call the builtin, even if the metadata has an 'eval' variable defined.

Signed-off-by: Christopher Larson <kergoth@gmail.com>
---
 lib/bb/data_smart.py | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index c597dbade8..fe0bacd13b 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -16,7 +16,10 @@ BitBake build tools.
 #
 # Based on functions from the base bb module, Copyright 2003 Holger Schurig
 
-import copy, re, sys, traceback
+import builtins
+import copy
+import re
+import sys
 from collections.abc import MutableMapping
 import logging
 import hashlib
@@ -150,17 +153,18 @@ class VariableParse:
             value = utils.better_eval(codeobj, DataContext(self.d), {'d' : self.d})
             return str(value)
 
-
 class DataContext(dict):
+    excluded = set([i for i in dir(builtins) if not i.startswith('_')] + ['bb', 'os', 'oe'])
+
     def __init__(self, metadata, **kwargs):
         self.metadata = metadata
         dict.__init__(self, **kwargs)
         self['d'] = metadata
 
     def __missing__(self, key):
-        # Skip commonly accessed invalid variables
-        if key in ['bb', 'oe', 'int', 'bool', 'time', 'str', 'os']:
+        if key in self.excluded:
             raise KeyError(key)
+
         value = self.metadata.getVar(key)
         if value is None or self.metadata.getVarFlag(key, 'func', False):
             raise KeyError(key)
-- 
2.39.2


