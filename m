Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EBAC433F5
	for <webhook@archiver.kernel.org>; Thu, 10 Feb 2022 17:54:30 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web09.13621.1644515669871638708
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 10 Feb 2022 09:54:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=RjCrY/4o;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id k1so10956047wrd.8
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 10 Feb 2022 09:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t4ADXE109HoSiXFYAOWGZcZeriQcLqN/n4OycBm0sQc=;
        b=RjCrY/4ok5VTc77/CFc3fq8I+fZzDAegc3YTmMqCWsRCYFtVddS89qQCCPGIeeLl+w
         /517OONyWRxsT2fNf8d+6QodCM3P5OY4BAg1LXMAWqaYJyHD6VGhuWcN3NfAzeVxTawU
         PX1xQyAP32n5YCwI+C89N8tEtKTLdW4TEm9AM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t4ADXE109HoSiXFYAOWGZcZeriQcLqN/n4OycBm0sQc=;
        b=GFEo9XJpG9inuhSGLzu/752mewPFIvBy3lW1dvuJjE+azWiSUwS1qXFTtyGhzxlMFz
         RkWuSZ/Bjn0pbYP0De/5G/pTWgtrKzmqcpDgShX9t84S/QqzoQt7FslR86myz6qnSTIB
         5zGLIqP9YhaLvGNSEfK+SnJdETowff8EIFBzEtbHEsY3WYkLaY9/+d7V29uoRNKzMiqM
         xf8x4MBxZF6V0u/RCHQXjezHZiBugwUfuinMlOixaEmdK2hw+eQz9GEZGP4L+d9pucIE
         mBVL5PQIXWH8SFTptgjXyQEl+kFTLKspOlufeR1x6xX+tIuSwM3V9kTNSMNufDtLcq1t
         NqVw==
X-Gm-Message-State: AOAM530+Zj9+6nVuwJexrkO1z08LMoLtpQTMhP2jr7gLQjYaDF96leKd
	kH1TZZ/IIKOtkPhMZBHhQy5ctgg6mk1eqw==
X-Google-Smtp-Source: 
 ABdhPJyXOy4jmYqiMQylrS6rCioH/xyCCRyTaoNNzOWFF/eynwXSqH0x1Bd4EiWBIJrzLDnYUxoLSg==
X-Received: by 2002:adf:d1c5:: with SMTP id b5mr7167754wrd.465.1644515668094;
        Thu, 10 Feb 2022 09:54:28 -0800 (PST)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:7dcb:9837:5409:449e])
        by smtp.gmail.com with ESMTPSA id
 o10sm7352115wrc.98.2022.02.10.09.54.27
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 09:54:27 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch2/cooker: Fix source revision handling with floating
 upstreams
Date: Thu, 10 Feb 2022 17:54:26 +0000
Message-Id: <20220210175426.2695614-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 10 Feb 2022 17:54:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13338

Where a git url uses a tag instead of a full source revision, breakage
can currently occur in builds. Issues include:

* the revision being looked up in multiple tasks (fetch and unpack)
* the risk a different revision may be obtained in those tasks
* that some tasks may not be allowed to access the network
* that a revision may not be consistent throughout a given build
* rerunning a specific task may given inconsistent results

To fix this, stop the workers from cleaning out the source revision store. This
should only be done in the cooker itself (based on current policy).

Also, where the code "sees" an upstream access, mark the recipe as not to be
cached. The reparse re-triggers the upstream lookup by the server.

Add a test to ensure that if get_srcrev isn't called, the user is told they're
using a configuration that is known to break.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-worker        | 2 +-
 lib/bb/cookerdata.py      | 4 ++--
 lib/bb/fetch2/__init__.py | 1 +
 lib/bb/fetch2/git.py      | 6 ++++++
 4 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 063cf37926..9d850ec77c 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -440,7 +440,7 @@ class BitbakeWorker(object):
     def handle_cookercfg(self, data):
         self.cookercfg = pickle.loads(data)
         self.databuilder = bb.cookerdata.CookerDataBuilder(self.cookercfg, worker=True)
-        self.databuilder.parseBaseConfiguration()
+        self.databuilder.parseBaseConfiguration(worker=True)
         self.data = self.databuilder.data
 
     def handle_extraconfigdata(self, data):
diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 397b43dfa7..a961f36574 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -258,12 +258,12 @@ class CookerDataBuilder(object):
         self.data = self.basedata
         self.mcdata = {}
 
-    def parseBaseConfiguration(self):
+    def parseBaseConfiguration(self, worker=False):
         data_hash = hashlib.sha256()
         try:
             self.data = self.parseConfigurationFiles(self.prefiles, self.postfiles)
 
-            if self.data.getVar("BB_WORKERCONTEXT", False) is None:
+            if self.data.getVar("BB_WORKERCONTEXT", False) is None and not worker:
                 bb.fetch.fetcher_init(self.data)
             bb.parse.init_parser(self.data)
             bb.codeparser.parser_cache_init(self.data)
diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 28a3e54c7f..d099cd1092 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -765,6 +765,7 @@ def get_srcrev(d, method_name='sortable_revision'):
     that fetcher provides a method with the given name and the same signature as sortable_revision.
     """
 
+    d.setVar("__BBSEENSRCREV", "1")
     recursion = d.getVar("__BBINSRCREV")
     if recursion:
         raise FetchError("There are recursive references in fetcher variables, likely through SRC_URI")
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 30da8e95b7..836ef1c49a 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -727,6 +727,12 @@ class Git(FetchMethod):
         """
         Compute the HEAD revision for the url
         """
+        if not d.getVar("__BBSEENSRCREV"):
+            raise bb.fetch2.FetchError("Recipe uses a floating tag/branch without a fixed SRCREV yet doesn't call bb.fetch2.get_srcrev() (use SRCPV in PV for OE).")
+
+        # Ensure we mark as not cached
+        bb.fetch2.get_autorev(d)
+
         output = self._lsremote(ud, d, "")
         # Tags of the form ^{} may not work, need to fallback to other form
         if ud.unresolvedrev[name][:5] == "refs/" or ud.usehead:
-- 
2.32.0


