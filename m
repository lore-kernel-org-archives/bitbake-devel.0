Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E144C433F5
	for <webhook@archiver.kernel.org>; Sat, 16 Oct 2021 12:55:15 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web10.10145.1634388913984064925
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 16 Oct 2021 05:55:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=YdssUVe0;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.50,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f50.google.com with SMTP id e12so31335504wra.4
        for <bitbake-devel@lists.openembedded.org>;
 Sat, 16 Oct 2021 05:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=itmqody4daqCCgIzMeGtuI3p98NRIBkM63g1/bQdsWk=;
        b=YdssUVe0x6OZhyYCPp8O2TN+bs/4V8WiNHJfNflPlXLBkLt6zExeK6GQpLXUwfgCzv
         zkOQy8wxogxhUVWpk0gBMilvmGdzQt7gtDuQDeBOmcfxaGyZVO3vT945M2NRLJmdCWYU
         S8TGKUMfwM3/6US1aTkehl7l+WmrWaiOe2xQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=itmqody4daqCCgIzMeGtuI3p98NRIBkM63g1/bQdsWk=;
        b=RT6LRxUvGF+mL1I/xrLWxK5cm1MPSNtL9b3rZFTLOg70+HXsNKwwTzyzaVPaO0yjJ4
         /pKBqQdYzSE+bHQl59nAPRPG9vHUJtravUxxY514d17Yr0tW/9kueZ8L18H1QmQeq7hb
         2rFMHC6OJ1xnlFzGkSBcuTKXJUYJBMpJdRWRtzm5kGknv1y/7Ky1XCiRJU9w5p6zWDxN
         EgbAYg14Q+KAIrpcOdcZXkHZ7mqmZmyd0zvPZ4n9zOEtRwOO2u0zGT/0EfHYYE1+jA+5
         loOMpwKx8iuNN8Pk3fF32XeAA6oH8IN9P+2O2kNk7URqWLytC5Lm5VSYomDb7t9FTyJc
         DcIQ==
X-Gm-Message-State: AOAM531bgcY5cXrQbi7NKI9CP7oX4aYDB+1fG2+sqrKOnRJ3X2bUXXqz
	MQVaXIHSbfq4XSC6Di2mDI5tyS+GeXEYnA==
X-Google-Smtp-Source: 
 ABdhPJwIR1gUVIpgmgXZco9DXoFnL13QOhHzgDxIi8n1RMzvu9qzL943c4k43dvTRAhyARLtTnzQhg==
X-Received: by 2002:adf:a31d:: with SMTP id
 c29mr21129113wrb.381.1634388912078;
        Sat, 16 Oct 2021 05:55:12 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:ac10:8c11:13d1:3cb9])
        by smtp.gmail.com with ESMTPSA id 3sm8014506wms.5.2021.10.16.05.55.11
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 05:55:11 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] siggen: Fix type conversion issues
Date: Sat, 16 Oct 2021 13:55:11 +0100
Message-Id: <20211016125511.3032540-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 16 Oct 2021 12:55:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12787

The switch to using json has messed up the type handling as the code
does assume that set()s are present. Add a decoder to reconstruct
the set() objects. Also fix the change of tuples to lists for the
file checksums and fix an existing type bug where dicts insteads of
lists was used.

Drop some old siginfo format handling code which is now long since
obsolete.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/siggen.py | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 323430270c..730e0f9a14 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -24,9 +24,14 @@ hashequiv_logger = logging.getLogger('BitBake.SigGen.HashEquiv')
 class SetEncoder(json.JSONEncoder):
     def default(self, obj):
         if isinstance(obj, set):
-            return list(sorted(obj))
+            return dict(_set_object=list(sorted(obj)))
         return json.JSONEncoder.default(self, obj)
 
+def SetDecoder(dct):
+    if '_set_object' in dct:
+        return set(dct['_set_object'])
+    return dct
+
 def init(d):
     siggens = [obj for obj in globals().values()
                       if type(obj) is type and issubclass(obj, SignatureGenerator)]
@@ -810,9 +815,9 @@ def compare_sigfiles(a, b, recursecb=None, color=False, collapsed=False):
         return formatstr.format(**formatparams)
 
     with bb.compress.zstd.open(a, "rt", encoding="utf-8", num_threads=1) as f:
-        a_data = json.load(f)
+        a_data = json.load(f, object_hook=SetDecoder)
     with bb.compress.zstd.open(b, "rt", encoding="utf-8", num_threads=1) as f:
-        b_data = json.load(f)
+        b_data = json.load(f, object_hook=SetDecoder)
 
     def dict_diff(a, b, whitelist=set()):
         sa = set(a.keys())
@@ -828,11 +833,11 @@ def compare_sigfiles(a, b, recursecb=None, color=False, collapsed=False):
 
     def file_checksums_diff(a, b):
         from collections import Counter
-        # Handle old siginfo format
-        if isinstance(a, dict):
-            a = [(os.path.basename(f), cs) for f, cs in a.items()]
-        if isinstance(b, dict):
-            b = [(os.path.basename(f), cs) for f, cs in b.items()]
+
+        # Convert lists back to tuples
+        a = [(f[0], f[1]) for f in a]
+        b = [(f[0], f[1]) for f in b]
+
         # Compare lists, ensuring we can handle duplicate filenames if they exist
         removedcount = Counter(a)
         removedcount.subtract(b)
@@ -915,9 +920,9 @@ def compare_sigfiles(a, b, recursecb=None, color=False, collapsed=False):
                 output.append(color_format("{color_title}Variable {var} value changed from '{color_default}{oldval}{color_title}' to '{color_default}{newval}{color_title}'{color_default}", var=dep, oldval=oldval, newval=newval))
 
     if not 'file_checksum_values' in a_data:
-         a_data['file_checksum_values'] = {}
+         a_data['file_checksum_values'] = []
     if not 'file_checksum_values' in b_data:
-         b_data['file_checksum_values'] = {}
+         b_data['file_checksum_values'] = []
 
     changed, added, removed = file_checksums_diff(a_data['file_checksum_values'], b_data['file_checksum_values'])
     if changed:
@@ -1047,7 +1052,7 @@ def dump_sigfile(a):
     output = []
 
     with bb.compress.zstd.open(a, "rt", encoding="utf-8", num_threads=1) as f:
-        a_data = json.load(f)
+        a_data = json.load(f, object_hook=SetDecoder)
 
     output.append("basewhitelist: %s" % (a_data['basewhitelist']))
 
-- 
2.32.0


