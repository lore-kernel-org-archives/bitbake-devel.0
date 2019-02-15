Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
	[209.85.128.49])
	by mail.openembedded.org (Postfix) with ESMTP id 97DEC7C40C
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Feb 2019 08:02:46 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id x7so8887663wmj.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Feb 2019 00:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=p+X8ukUdwJ8IMCNPrMXLeND286kKzbdYdChZYN6eNAs=;
	b=DWo2X3cLyDj8tDX/Xx4D74Q3W1VcfvU3sD4db48V4MQ4EAqEH5VHBD1Va2aV6SSZPd
	otzdo9t8QUsKS2noJ/1K4PmDT34f2b2obr7G52rnWD704tck3eBFGBsp4iFpGT5ESQSy
	SXq3pd3F6S8zold3XrXTR4epDtiS6do178KI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=p+X8ukUdwJ8IMCNPrMXLeND286kKzbdYdChZYN6eNAs=;
	b=myO5j++SCpKt+nu4HCN8VvAvJDXkQ4Bvb+ev6xIBVExbqpsPgHVV2b0TRGRGE/u4RU
	VzIPMZNaGMIHNpV9eei0RjtMMDFZeqD2YmxFuf7U8eNcKD3SgUwHE3vMp7T0FYRKU/BN
	k/anXYLKm7Za9sv6YWs95QQw+QkE2xPMvLSH3XuMInzhljR4s6GHQpBH1ahNYGvSWJ1f
	/zucwZ2Q3n7/M0DliLznZPntQsoEWBTpuhghU5/8fi3+dcQ1AfpTCIDAMg5mPMPb6X9r
	pJB5UqCtfGEFJq99AZLfq/SB1P00pV5sOUVjqEnHvxqBptf8/dE30Sor+UvgD09YUHdC
	kIiw==
X-Gm-Message-State: AHQUAuYW84SAHiiFLPsSmJXXiJx0jQxPsagquf4ZL6bGCJKYeiXaE2V3
	RDw+ZlZUB0WJu+LpfA8bxfHNPsGAFG8=
X-Google-Smtp-Source: AHgI3Iao/e3EwFHHkluxqSbYMkrTKNW2ysCYH/xyzlxeDfXcwj5YzJuXri1g1NIRpWCHUg2uMcz+Hg==
X-Received: by 2002:a1c:e913:: with SMTP id q19mr5541196wmc.55.1550217765424; 
	Fri, 15 Feb 2019 00:02:45 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	u12sm2101143wrt.2.2019.02.15.00.02.43
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 15 Feb 2019 00:02:43 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 15 Feb 2019 08:02:42 +0000
Message-Id: <20190215080242.22675-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH] wic/engine: Fix missing parted autobuilder failures
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
X-List-Received-Date: Fri, 15 Feb 2019 08:02:47 -0000
Content-Transfer-Encoding: 8bit

OE-Core rev: a88bcbae850a2e6d182291d3f8e167aabdbe4842 broke the ability
to find parted as it may be in sbin which is not in PATH for some users
on some distros.

Iterate on the original patch to fix this and also fix the original problem.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 scripts/lib/wic/engine.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/scripts/lib/wic/engine.py b/scripts/lib/wic/engine.py
index 880e4640367..ea600d2854e 100644
--- a/scripts/lib/wic/engine.py
+++ b/scripts/lib/wic/engine.py
@@ -244,15 +244,17 @@ class Disk:
         self._psector_size = None
         self._ptable_format = None
 
+        # find parted
         # read paths from $PATH environment variable
         # if it fails, use hardcoded paths
+        pathlist = "/bin:/usr/bin:/usr/sbin:/sbin/"
         try:
-            self.paths = os.environ['PATH']
+            self.paths = os.environ['PATH'] + ":" + pathlist
         except KeyError:
-            self.paths = "/bin:/usr/bin:/usr/sbin:/sbin/"
+            self.paths = pathlist
 
         if native_sysroot:
-            for path in self.paths.split(':'):
+            for path in pathlist.split(':'):
                 self.paths = "%s%s:%s" % (native_sysroot, path, self.paths)
 
         self.parted = find_executable("parted", self.paths)
-- 
2.20.1


