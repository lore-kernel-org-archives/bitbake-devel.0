Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB66DC3DA6E
	for <webhook@archiver.kernel.org>; Fri,  5 Jan 2024 11:53:25 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web11.21829.1704455599678664498
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Jan 2024 03:53:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=WBjtrIVe;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-336755f1688so1255437f8f.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 05 Jan 2024 03:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1704455598; x=1705060398; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UcN4T/H4Z4G3nXWBm3o13QS+AcPqSBU3kniYiRg8co4=;
        b=WBjtrIVeiJejBVNtTXoNtna53pFgggFU5HGzsZeaDPLxUUJ2v0yTsN8oKD4YIg5Dlq
         MctdDAjZ288vmwv1nDIWrBS2gspX9CFNvEaiG2iWsBoOkNkqNd1yRvK0mjRdsqa4TWdJ
         +m8thW22uCO6lg84BmQj0O6zb9rN5+HizDb2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704455598; x=1705060398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UcN4T/H4Z4G3nXWBm3o13QS+AcPqSBU3kniYiRg8co4=;
        b=CRZe6xAwlUizdeJWvnJhOAUP5MKizQUS16lGePMVKNNZJT7xrr2u3HS08YJEdRE8XT
         FoqOiCOIaqug+xOKwaUXdWFxeL7nJbY/SHHL173lU1dOBWF/18Z9puHaZtZfgKeyt9lL
         eTXg22+wmHpexU8YQ0nB4V1jXU4JdAad98eeVuDgNewPHhhynSj60xzqLNPipkt2vMe1
         5gdBAVlPlFbv4bWIgEx0xsHI9APFV9KQZbO0rcSd4vaQ09/LcCwHR+J2+SejcMUYhM2s
         9FzxIYcL/GhpMwDr4HBqaMBsB+2cnzkLqv4JHaeFoo/tMpie3bVk5hXiLEznUw0+OhTD
         a3QA==
X-Gm-Message-State: AOJu0YwSIN3qQPN46eYgqRiY2/2t05xFdNmEbBJYoYwTtELm5mFv2Vfl
	3YpPPn9fb28yNZn25v85ERqSIDFH53C4jtwATvFRYjuyRIo=
X-Google-Smtp-Source: AGHT+IHqoufydtlbHfB2wLA4rVYy6jAlAVyQlIKkMYqWmzUGzG5fvn0qSRDaYzJEIt9zs8O2Fk8uJg==
X-Received: by 2002:a5d:4a92:0:b0:336:768f:f840 with SMTP id o18-20020a5d4a92000000b00336768ff840mr987646wrq.83.1704455597763;
        Fri, 05 Jan 2024 03:53:17 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:8000:8a34:98ad:54c2])
        by smtp.gmail.com with ESMTPSA id l3-20020a5d4bc3000000b00336843ae919sm1253546wrt.49.2024.01.05.03.53.17
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 03:53:17 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] siggen: Ensure version of siggen is verified
Date: Fri,  5 Jan 2024 11:53:16 +0000
Message-Id: <20240105115316.2430989-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Jan 2024 11:53:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15742

Since we need to change the form of the siggen function, we need to add versioning
and some verison checks. This means if a newer bitbake is used with older metadata
we can detect it.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/command.py  |  1 +
 lib/bb/runqueue.py |  1 +
 lib/bb/siggen.py   | 10 ++++++++++
 3 files changed, 12 insertions(+)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 79b6c0738f..1fcb9bf14c 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -777,6 +777,7 @@ class CommandsAsync:
         (mc, pn) = bb.runqueue.split_mc(params[0])
         taskname = params[1]
         sigs = params[2]
+        bb.siggen.check_siggen_version(bb.siggen)
         res = bb.siggen.find_siginfo(pn, taskname, sigs, command.cooker.databuilder.mcdata[mc])
         bb.event.fire(bb.event.FindSigInfoResult(res), command.cooker.databuilder.mcdata[mc])
         command.finishAsyncCommand()
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 51959231b7..9e3a87c0e8 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1760,6 +1760,7 @@ class RunQueue:
         return invalidtasks
 
     def write_diffscenetasks(self, invalidtasks):
+        bb.siggen.check_siggen_version(bb.siggen)
 
         # Define recursion callback
         def recursecb(key, hash1, hash2):
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index b023b79eca..5a584cadf9 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -24,6 +24,16 @@ import hashserv.client
 logger = logging.getLogger('BitBake.SigGen')
 hashequiv_logger = logging.getLogger('BitBake.SigGen.HashEquiv')
 
+#find_siginfo and find_siginfo_version are set by the metadata siggen
+# The minimum version of the find_siginfo function we need
+find_siginfo_minversion = 2
+
+def check_siggen_version(siggen):
+    if not hasattr(siggen, "find_siginfo_version"):
+        bb.fatal("Siggen from metadata (OE-Core?) is too old, please update it (no version found)")
+    if siggen.find_siginfo_version < siggen.find_siginfo_minversion:
+        bb.fatal("Siggen from metadata (OE-Core?) is too old, please update it (%s vs %s)" % (siggen.find_siginfo_version, siggen.find_siginfo_minversion))
+
 class SetEncoder(json.JSONEncoder):
     def default(self, obj):
         if isinstance(obj, set) or isinstance(obj, frozenset):
-- 
2.39.2


