Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF99FC433F5
	for <webhook@archiver.kernel.org>; Wed,  8 Dec 2021 20:23:42 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web09.1811.1638995021733552807
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Dec 2021 12:23:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=TPnv5z+W;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id d24so6224024wra.0
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Dec 2021 12:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2OTTO4zUg4dcRUTWdtmWHhQkIxgreXQ+QA1bFqXZwbQ=;
        b=TPnv5z+W2rYc++iYabbG9puHiB1t0Ko9zN7H+BtDVk+6QKY22uRyBsp3V4+KjAD/E2
         HUsbJTtjR65RJIlhbDgGpdvmj+30Den5ML7UpM79VBTyE+2r955iSJqe7jS4yUAOflZm
         z+YFR0AxcoSGmHlADZkwbVJ6TPhWzeVmXU+Vo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2OTTO4zUg4dcRUTWdtmWHhQkIxgreXQ+QA1bFqXZwbQ=;
        b=vdKRRVMrRTxmmZzNSBrnP4XuWBNLFLa3WoAn4I9T5NktYFKSd1asSR3Fgrj4HSq5us
         uWgwTQHuNFwf4azcgQZW4FmktwsF/bEmGH9Ky1tWMpyKfcasbtKXDfyLWD+vq5Zhv0Lf
         hpGsipu0ZBHoLxKqEKUK5gBgYn91qHbS2DXHK/9aTkRL3zAbnw2coWk40PwI7A4AJ8jt
         ReZTeu1ddRqS5x9VwLF5KDh/qcvJJ5QLu8F3FG+YFKkq6Bi5Jxwvsyykze6wEnh0o94R
         NpTi1wg9AZrho/rDqNKDjuC52wrFcI3fCO9wfqnh7OHNWTLnD0LIZGdzlrEQDc7FCB8/
         Xfxw==
X-Gm-Message-State: AOAM533kNZLZlbxRZuItHnU5AoxdiLWrosHxYGj9V9gjvSVhhh7kICxn
	rzzfEjFSGImFzeY4pYdkkw3GPgLajS94yg==
X-Google-Smtp-Source: 
 ABdhPJyKF5Ch0CH+SUiHVF5yuRizTakQQhC8HrszRPlrEVa4yAW4PJSsUXr9aX6WIRvp5SHZSU8mDg==
X-Received: by 2002:a5d:6886:: with SMTP id h6mr1063489wru.287.1638995019726;
        Wed, 08 Dec 2021 12:23:39 -0800 (PST)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:7bcf:b0b3:a8aa:29ed])
        by smtp.gmail.com with ESMTPSA id
 m34sm7107668wms.25.2021.12.08.12.23.39
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 12:23:39 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] siggen: Ensure dumpsig output is deterministic
Date: Wed,  8 Dec 2021 20:23:38 +0000
Message-Id: <20211208202338.590553-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 08 Dec 2021 20:23:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13144

Currently the console output for signature dumps e.g. with bitbake-dumpsig
isn't deterministic. Add some sorting to improve that.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/siggen.py | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 44965c8cca..e0ec736dff 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -1054,28 +1054,28 @@ def dump_sigfile(a):
     with bb.compress.zstd.open(a, "rt", encoding="utf-8", num_threads=1) as f:
         a_data = json.load(f, object_hook=SetDecoder)
 
-    output.append("basewhitelist: %s" % (a_data['basewhitelist']))
+    output.append("basewhitelist: %s" % (sorted(a_data['basewhitelist'])))
 
-    output.append("taskwhitelist: %s" % (a_data['taskwhitelist']))
+    output.append("taskwhitelist: %s" % (sorted(a_data['taskwhitelist'] or [])))
 
     output.append("Task dependencies: %s" % (sorted(a_data['taskdeps'])))
 
     output.append("basehash: %s" % (a_data['basehash']))
 
-    for dep in a_data['gendeps']:
-        output.append("List of dependencies for variable %s is %s" % (dep, a_data['gendeps'][dep]))
+    for dep in sorted(a_data['gendeps']):
+        output.append("List of dependencies for variable %s is %s" % (dep, sorted(a_data['gendeps'][dep])))
 
-    for dep in a_data['varvals']:
+    for dep in sorted(a_data['varvals']):
         output.append("Variable %s value is %s" % (dep, a_data['varvals'][dep]))
 
     if 'runtaskdeps' in a_data:
-        output.append("Tasks this task depends on: %s" % (a_data['runtaskdeps']))
+        output.append("Tasks this task depends on: %s" % (sorted(a_data['runtaskdeps'])))
 
     if 'file_checksum_values' in a_data:
-        output.append("This task depends on the checksums of files: %s" % (a_data['file_checksum_values']))
+        output.append("This task depends on the checksums of files: %s" % (sorted(a_data['file_checksum_values'])))
 
     if 'runtaskhashes' in a_data:
-        for dep in a_data['runtaskhashes']:
+        for dep in sorted(a_data['runtaskhashes']):
             output.append("Hash for dependent task %s is %s" % (dep, a_data['runtaskhashes'][dep]))
 
     if 'taint' in a_data:
-- 
2.32.0


