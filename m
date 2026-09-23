Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46015C98302
	for <webhook@archiver.kernel.org>; Wed, 23 Sep 2026 14:02:20 +0000 (UTC)
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7676.1790172138795369704
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Sep 2026 07:02:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=XDyiNgcC;
 spf=pass (domain: snapchat.com, ip: 74.125.225.140, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d3931so7120545e9.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Sep 2026 07:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1790172137; x=1790776937; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HiePUUEcZRDTg/MCw2mx3FpdojIrukbMXzxgMxios3s=;
        b=XDyiNgcCV6o5iHMGYPLlVaTyaZITxA/Nxc76Da6YFJ773vLh408mTRfz6Mprlx+njj
         wH4uWNqy41/1E2JsijbXbOaKwbTL3gYiN7gVb59Gw5ZRfH0vR/kY0wmHFo1pjL4O91YD
         flz4MwPPPOi938TJvnODFbvSB8Bb6uCauQ5nY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790172137; x=1790776937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HiePUUEcZRDTg/MCw2mx3FpdojIrukbMXzxgMxios3s=;
        b=BqTo5Zxp3hRAC5nHvxAPTRLTdpibOFcaaupP5DSBZg1tglCg9K/LJS0Ndkp7tj1Xgw
         76RglwudPik1Qdq08oqSR+TkESInNj1JnPIO2q46ybrTP+1cFzdbWKR0W0TEQG8O+gvM
         uLyy616CV5GsWRHHr6kOgaJ6Kbe0ULopZCfoHFF8EeQr7lP18hsc0bNl5UsFwLEp4mTq
         ucoPC8iDczKF70XBD9GjTWq3PASQNgnFqkU0o1jy7z1T3qR1jAfdSu4V4KCWi9WXj9VU
         ITeAvarpdgyYbWA18PgryUaYEgGgSxexL43NVIeZ2iDjOl/Z9ayJpdx2nyWr+nMSWfmZ
         hlug==
X-Gm-Message-State: AFuF++lI2yST7GgA7hgdNGJqOh7vaVNC+onZ4XpdjuzVhZ9MJXJx0pPj
	4eekgnWviFFs7rB9Jbcqva1CwDC9rAmV+Ar0JT8UbrLkG+gg3YIpBAeXuDSr4L5ic+nPoP4OUcw
	GnjklX9s=
X-Gm-Gg: AYBFou1NMqs+Jt8LIF3xtUXh7enKAdyLRBGlZYvUNeMNGB0qzvdX8s1NdUOkx8xQEiG
	2Ul5tDCd02l4YPxpMAU0kCnOlZmZmK+lPRofD9FB4in2A/TG1tZF+ghjztcn/AOxPUufpgKnYPd
	0/gjJOizkMEMz+paqAh8Xtz2b0Rh5IMfkL4Zhk4F+6xwhLIOw9WLvpufS1z6R1tD2BB65/Hm9vn
	0z5tk6+wugTdENycMEowOvFLSSB83sdrIUslCc2ejQ8PDXxchqQs4BLXOyeQGR6qk7Dw/WDFjkR
	J6ib/270ZScMf5FM1zCNHBngR3pA80OCf/bmOh6kr0zULPpQpSywzTtR4xgOazcolbXz1cCs9eK
	W4EtlWYptsHZZOWTRweDL6Kswt2XJrCnbDsCNVUMI3d5QPMcOoUco4F4vizWbN2Rs/ayafEGLLO
	WZ2sxWjaVrZR69dn95ixaZfets2PMvGjkymKr2o4WXeo30S59ndEDGNreIbE3Zvvy6G0k7+jE/v
	3yKXdgClbX+n0DbsIsDywk6NWgH7IerA3Jxwwgqqwcg
X-Received: by 2002:a05:600c:500d:b0:49d:28c4:b304 with SMTP id 5b1f17b1804b1-49fdf1485e3mr39480655e9.29.1790172136786;
        Wed, 23 Sep 2026 07:02:16 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([213.249.125.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde1acb91sm76977585e9.15.2026.09.23.07.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 07:02:16 -0700 (PDT)
From: ecordonnier@snap.com
To: bitbake-devel@lists.openembedded.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [PATCH] data_smart: Cache compiled inline Python expressions
Date: Wed, 23 Sep 2026 16:02:08 +0200
Message-ID: <20260923140208.1915740-1-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Sep 2026 14:02:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20242

From: Etienne Cordonnier <ecordonnier@snap.com>

VariableParse.python_sub() recompiles an inline Python expression on every
expansion, although parsing evaluates a small set of expressions many times.
Cache the compiled code objects keyed on the expression and synthetic
filename, so error reporting is unchanged, and bound the cache size so a
long-lived server cannot grow it indefinitely.

This reduces a cold parse of 2847 recipes (poky, meta-oe, meta-python) from
32.6s to 28.6s (-12%), averaged over four alternating runs.

AI-Generated: Uses OpenAI Codex
Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 lib/bb/data_smart.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 8aa7c1f99..cc87a665d 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -18,6 +18,7 @@ BitBake build tools.
 
 import builtins
 import copy
+import functools
 import re
 import sys
 from collections.abc import MutableMapping
@@ -30,6 +31,10 @@ from bb.COW  import COWDictBase
 
 logger = logging.getLogger("BitBake.Data")
 
+@functools.lru_cache(maxsize=8192)
+def compile_python_expression(code, varname):
+    return compile(code, varname, "eval")
+
 __setvar_keyword__ = [":append", ":prepend", ":remove"]
 __setvar_regexp__ = re.compile(r'(?P<base>.*?)(?P<keyword>:append|:prepend|:remove)(:(?P<add>[^A-Z]*))?$')
 __expand_var_regexp__ = re.compile(r"\${[a-zA-Z0-9\-_+./~:]+}")
@@ -133,7 +138,7 @@ class VariableParse:
             varname = 'Var <%s>' % self.varname
         else:
             varname = '<expansion>'
-        codeobj = compile(code.strip(), varname, "eval")
+        codeobj = compile_python_expression(code.strip(), varname)
 
         parser = bb.codeparser.PythonParser(self.varname, logger)
         parser.parse_python(code)
-- 
2.43.0


