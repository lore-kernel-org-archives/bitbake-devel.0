Return-Path: <rybczynska@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4780CC433F5
	for <webhook@archiver.kernel.org>; Mon, 21 Feb 2022 17:45:08 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web10.1925.1645465506927092816
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 21 Feb 2022 09:45:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=BctoIwL+;
 spf=pass (domain: gmail.com, ip: 209.85.221.53,
 mailfrom: rybczynska@gmail.com)
Received: by mail-wr1-f53.google.com with SMTP id d27so28436134wrb.5
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 21 Feb 2022 09:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TFjYNj/4MS9RJK9VgY8J4ktfGTyTWI/klpBCtczt9Eo=;
        b=BctoIwL+HUo2fMCMG5qsEP41BM9Od4ixz9kNDSma/OnrvOIY4CC4/Z1HvaCD4QNvC0
         ky+oP+/9mgQsSNAVVhsmIFQA6bOL83I0BPo8lzQt2etLGxI95NPDFnkZexUK+zLjs4PF
         2gZn42Ztn+faTh8GJf0FHWkp9BoR+HXvb/B9q6thFNQWHkd3220yYln6fTlfGJUuN6B4
         ZhMekuWz3pj3S1OwXEitqd9NoRf1s8PW04/x3Jn5XQ8J8zcxN9pRYfruHa0WRa4t/NBB
         NideehmuJd/Hs3/zQ7Kw/06kgWPIAKfpn1y6isuyTTWYQogMypqtcIMGI1xeV8bxcI2V
         hF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TFjYNj/4MS9RJK9VgY8J4ktfGTyTWI/klpBCtczt9Eo=;
        b=FQoho7yPSStVkZqsAaPwHbA/T1TLy5G82E4PxNqWtfWgxXRfecExgr6zft3kkvWWJk
         1nUv2mxX0c2L60LsvAbifpq/20wRNXy9oN3LoPAUEHiKPoSiq8d8gFtW+bh5VTNX4b00
         2QxBrnaaVYo1G2DzWmxofLx6QqGzw/UeO7/QX3pDRki13PWR9Li1qxIBxVne9j9Uf1Tc
         087GFMiB/dG5OHca+NAJApNL7ry6VrjxS7iPQz1fh9MSoFoCRjX+FFrbQaBq0LQfTgF0
         ovXVvU38PX9ULrP+l9zSdxvYU+Cjqw5BkFCEVq0f/TShFmaiUeDLRKMNr42vzFj63xVY
         BwCQ==
X-Gm-Message-State: AOAM533xGdBp8ZSbTtFKwUNh6RwBq0YLGVR+unHZifjTst+X8bRORHuG
	URm0Km1vvE+RlbnEz83/m5iVikwPdfA=
X-Google-Smtp-Source: 
 ABdhPJxQhHDcI1nTawjVfBHztUOch7Y1jqF+HS1aEpsoM5lLVJEi1TAi4v9sLM1lugmEbM7ch3o0/g==
X-Received: by 2002:adf:ec03:0:b0:1e4:98f6:2563 with SMTP id
 x3-20020adfec03000000b001e498f62563mr16518229wrn.168.1645465505341;
        Mon, 21 Feb 2022 09:45:05 -0800 (PST)
Received: from localhost.localdomain ([80.215.210.21])
        by smtp.gmail.com with ESMTPSA id
 n15sm22809901wri.33.2022.02.21.09.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 09:45:04 -0800 (PST)
From: Marta Rybczynska <rybczynska@gmail.com>
To: richard.purdie@linuxfoundation.org,
	bitbake-devel@lists.openembedded.org
Cc: Marta Rybczynska <rybczynska@gmail.com>,
	Marta Rybczynska <marta.rybczynska@huawei.com>
Subject: [PATCH v2][master-next] lib/bb: fix exit when found renamed variables
Date: Mon, 21 Feb 2022 18:44:59 +0100
Message-Id: <20220221174459.5474-1-rybczynska@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 21 Feb 2022 17:45:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13396

Until now, if a renamed variable was found, bitbake exited
immediately if it was in a class, but continued after an error
message if the variable was in a recipe. This was caused by
cookerdata.py CookerDataBuilder::parseBaseConfiguration checking
a different DataSmart instance than the variable was set in.
To solve the issue, add a special variable and set it when we
find a renamed variable. Check for it in ast.py and bail out
if needed.

Signed-off-by: Marta Rybczynska <marta.rybczynska@huawei.com>
---
 lib/bb/data_smart.py | 4 ++++
 lib/bb/parse/ast.py  | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 7b06d3a1..e7047d79 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -546,6 +546,8 @@ class DataSmart(MutableMapping):
         shortvar = var.split(":", 1)[0]
         if shortvar in self._var_renames:
             _print_rename_error(shortvar, loginfo, self._var_renames, fullvar=var)
+            # Mark that we have seen a renamed variable
+            self.setVar("_FAILPARSINGERRORHANDLED", True)
 
         self.expand_cache = {}
         parsing=False
@@ -737,6 +739,8 @@ class DataSmart(MutableMapping):
 
         if var in self._var_renames:
             _print_rename_error(var, loginfo, self._var_renames)
+            # Mark that we have seen a renamed variable
+            self.setVar("_FAILPARSINGERRORHANDLED", True)
 
         if 'op' not in loginfo:
             loginfo['op'] = "set"
diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index 31bcc8e7..4b1b44ce 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -333,6 +333,10 @@ def runAnonFuncs(d):
 def finalize(fn, d, variant = None):
     saved_handlers = bb.event.get_handlers().copy()
     try:
+        # Found renamed variables. Exit immediately
+        if d.getVar("_FAILPARSINGERRORHANDLED", False) == True:
+            raise bb.BBHandledException()
+
         for var in d.getVar('__BBHANDLERS', False) or []:
             # try to add the handler
             handlerfn = d.getVarFlag(var, "filename", False)
-- 
2.33.0


