Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
	[209.85.221.51])
	by mail.openembedded.org (Postfix) with ESMTP id 2CC6C61506
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Feb 2020 16:23:08 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id w12so20466528wrt.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Feb 2020 08:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=o7MGq+j6iO5gmCMW7Y1oI/+SVmgqonec3luH1FIyY14=;
	b=CmJ5KhImy8ASYZAp2UM4P6bPRuLk4+cGdkKniHl4xvC9VgT2t0392IBZhFZPI8vzOt
	297OfYBFXzSEYiLLoeIAjV4ck4/J3ZSTDqS1VOlIa0VE6PdMrfWvA7d/D8vUoZSPdm/T
	BV5AVe79g+XnwdDvhDvB8HEIzeGlo7EvqJDZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=o7MGq+j6iO5gmCMW7Y1oI/+SVmgqonec3luH1FIyY14=;
	b=sV/nzolUC0HqZFE9VRBoFrHitYyJUtY2mgEto3+TrUs/mEUWhBrIRDDZwWUID4kyXp
	p636nexHEjOCtObn9mvDMCo3vpCbC4WGN59DxGtOmsuW/rsbzm2wwM7qpxtH3XO0gSLh
	6bA+JYCGly4LC7D+GO23vyh+DYy3HwGo7tYcdssD7KVR7WKK+J3sexNLqWuSgeD9e2Kh
	IRH1G7zqfTWAX8HdazkUwJnLhWQl4iRsm+5Cn+WFnMpkGakhSEv9gHHD+ZnXHu/5T0Mo
	T+Ke7+GM93fQ1gohTg5jz6DU/P3cuMdD1O1m75nVBIWQC2NC7ldrCOpcQ5ZCWuh9TN0v
	srZA==
X-Gm-Message-State: APjAAAVN198Ovuec2h4WxDhwyvpcQ5Ext6JS04ngceIXfsSQvfxo8stp
	z03jBnM0RKt6VPjAxZbzOI3B6NYfT2A=
X-Google-Smtp-Source: APXvYqxWBECPNH+tmprEY0waADT9YJNn1S3KFHpIKYOnSvLaww4ErpQuDlL2/x2XEnxH2DO2FdJL/Q==
X-Received: by 2002:a5d:4204:: with SMTP id n4mr22665576wrq.123.1581956588530; 
	Mon, 17 Feb 2020 08:23:08 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	a16sm1779725wrt.30.2020.02.17.08.23.07
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 17 Feb 2020 08:23:08 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 17 Feb 2020 16:23:07 +0000
Message-Id: <20200217162307.36082-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Subject: [PATCH] cooker/siggen: Empty siggen cache during parsing
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 17 Feb 2020 16:23:08 -0000
Content-Transfer-Encoding: 8bit

When parsing recipes its apparent the memory usage of bitbake rises linearly
with number of recipes parsed. It shouldn't.

Using tracemalloc (thanks for the tip Joshua Lock) it was clear that the
dependency information left behind in siggen was the culprit. Add a new
method to allow us to drop this information. We don't need it after the recipe
has been parsed and hashes calculated (at runtime its different but only the
currently executing task would be in memory).

This should give signficant memory usage improvements for bitbake and that
in turn should help speed on more constrained systems, as well as when used in
multiconfig environments.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py |  3 ++-
 lib/bb/siggen.py | 11 +++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 1124332186..a05630d52d 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1940,7 +1940,8 @@ class Parser(multiprocessing.Process):
                 except IndexError:
                     break
                 result = self.parse(*job)
-
+                # Clear the siggen cache after parsing to control memory usage, its huge
+                bb.parse.siggen.postparsing_clean_cache()
             try:
                 self.results.put(result, timeout=0.25)
             except queue.Full:
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index ffd8fcaf36..c2d0c736cf 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -51,6 +51,9 @@ class SignatureGenerator(object):
     def finalise(self, fn, d, varient):
         return
 
+    def postparsing_clean_cache(self):
+        return
+
     def get_unihash(self, tid):
         return self.taskhash[tid]
 
@@ -188,6 +191,14 @@ class SignatureGeneratorBasic(SignatureGenerator):
         for task in taskdeps:
             d.setVar("BB_BASEHASH_task-%s" % task, self.basehash[fn + ":" + task])
 
+    def postparsing_clean_cache(self):
+        #
+        # After parsing we can remove some things from memory to reduce our memory footprint
+        #
+        self.gendeps = {}
+        self.lookupcache = {}
+        self.taskdeps = {}
+
     def rundep_check(self, fn, recipename, task, dep, depname, dataCache):
         # Return True if we should keep the dependency, False to drop it
         # We only manipulate the dependencies for packages not in the whitelist
-- 
2.25.0


