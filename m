Return-Path: <michael.g.wood@intel.com>
Received: from mail-wg0-f47.google.com (mail-wg0-f47.google.com [74.125.82.47])
	by mail.openembedded.org (Postfix) with ESMTP id 48CED75CC7
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  2 Jul 2015 16:58:31 +0000 (UTC)
Received: by wgqq4 with SMTP id q4so68476045wgq.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 02 Jul 2015 09:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=Bm/P69z8Cii6iec/u+khG6xvxjNefh9Qr7el1xihWZg=;
	b=NIgAoTP36UnFQB7Ge4cCfdWK5w3zdrgHekdwgzW6Q5lMT8ucJ+U2197ZEh/rmkYd34
	l/dwuByC+x2rGsRHSKAZfmdeTwZYJU1APOwOsUqGKz0J3RMJm8vTNhOFWemrFBe2O4M/
	4PEw4cJwXdJTmE+0sybxlOIGwwtXFhZ3Rai6HKQL8lBZen3/NI9D6hmFx1vYkbusTaGx
	vGBXb/fzPclOlTHpbTi0DEuhfprRV2873pj/8olY5G2ojHk9XGRUKhlHZBc191xzLMD0
	uYJibSvO7VUN6u4B8zktPuo1pEcBi5AIthL9yxA7TNoYnkE1UvM3X5XHPMDK9pTfO7QJ
	FeQg==
X-Gm-Message-State: ALoCoQnIx8gZvmqjxFis2d2l1ZqXNhMOGSA6gvTCuohaQlPEdrwuWkPUqnmfQzhByAf4VYVcjpRa
X-Received: by 10.194.97.196 with SMTP id ec4mr60811879wjb.3.1435856311884;
	Thu, 02 Jul 2015 09:58:31 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id ka7sm9007084wjc.36.2015.07.02.09.58.31
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 02 Jul 2015 09:58:31 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  2 Jul 2015 17:58:16 +0100
Message-Id: <1435856296-12531-6-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1435856296-12531-1-git-send-email-michael.g.wood@intel.com>
References: <1435856296-12531-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 5/5] bitbake: toaster: Fix build execution regression
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
X-List-Received-Date: Thu, 02 Jul 2015 16:58:32 -0000

Make sure the error value is initialised and update the string match
that we have to identify bitbake's current startup status.

Patch contribution from Eduard Bartosh

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 bitbake/lib/bb/ui/toasterui.py                          | 1 +
 bitbake/lib/toaster/bldcontrol/localhostbecontroller.py | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/toasterui.py b/bitbake/lib/bb/ui/toasterui.py
index 28fdd82..376ac59 100644
--- a/bitbake/lib/bb/ui/toasterui.py
+++ b/bitbake/lib/bb/ui/toasterui.py
@@ -239,6 +239,7 @@ def main(server, eventHandler, params ):
 
             if isinstance(event, (bb.event.BuildCompleted, bb.command.CommandFailed)):
 
+		errorcode = 0
                 if (isinstance(event, bb.command.CommandFailed)):
                     errors += 1
                     errorcode = 1
diff --git a/bitbake/lib/toaster/bldcontrol/localhostbecontroller.py b/bitbake/lib/toaster/bldcontrol/localhostbecontroller.py
index 3e16837..1d3d1ce 100644
--- a/bitbake/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/bitbake/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -139,7 +139,7 @@ class LocalhostBEController(BuildEnvironmentController):
             with open(filepath, "r") as f:
                 f.seek(filepos)
                 for line in f:
-                    if line.startswith("NOTE: ToasterUI waiting for events"):
+                    if line.startswith("Bitbake server started on demand"):
                         return True
             return False
 
-- 
2.1.4


