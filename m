Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f181.google.com (mail-wi0-f181.google.com
	[209.85.212.181])
	by mail.openembedded.org (Postfix) with ESMTP id B1D2376312
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Jul 2015 14:24:38 +0000 (UTC)
Received: by wibud3 with SMTP id ud3so162068297wib.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Jul 2015 07:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=hnBMv2W7kAsBVGRwvnCqXprKpeun800NESG6YtLOfiA=;
	b=mZZt+v7aD96lj7LQ2z1ilEOzKFIU0rxBBGesD+a6c7+BjG/Qpld2EZFCFlFRq+ajrT
	SBfOD1So3Y3pQy9l0VfIsz7Cq3Eq+OOjenMpNxE5e9OPbMmvj6/2QSgFNsnLISOSpd+j
	612iPZJojA7AHG1uqw+P5PRLn7ELpg6g5efbhxKx4W+jWcTPVCu2kZxVdaoEP12I6iLh
	Uog6ZquACYGXAPXVCwqIvNzIBCeGXzDDMPMuBWd3VG9ybpzgHYGRoWC7VSrSRvrFAkwY
	MfYvQLaaA0cOU7fiY502txn+XpjMfW8shaWZF6T2LXNTYQSQP85j87FcApwVLl+K8nVb
	JnrQ==
X-Gm-Message-State: ALoCoQmDTr6vUle4lvDO4yJqoO1iqdtmek1WfMMHZ4unlhEYtKJffj98LTBjrkPbXipHCxPI7VNc
X-Received: by 10.180.87.105 with SMTP id w9mr35667490wiz.32.1438093478109;
	Tue, 28 Jul 2015 07:24:38 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id
	i6sm33510838wje.33.2015.07.28.07.24.36
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 28 Jul 2015 07:24:36 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 60455561C91; Tue, 28 Jul 2015 15:24:46 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 28 Jul 2015 15:24:41 +0100
Message-Id: <5e436591122f85dcc60a7c53766daef71c02eeec.1438093379.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <964caf5c2f9ce47f17d85d9bcfa2321f8e9ab6fb.1438093379.git.alexandru.damian@intel.com>
References: <964caf5c2f9ce47f17d85d9bcfa2321f8e9ab6fb.1438093379.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1438093379.git.alexandru.damian@intel.com>
References: <cover.1438093379.git.alexandru.damian@intel.com>
Subject: [PATCH 2/6] bitbake: toaster: Wait for toaster gui to come
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
X-List-Received-Date: Tue, 28 Jul 2015 14:24:40 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Set logging level for the Toaster logger to get messages
to toaster_ui.log

Reverted previous workaround.

[YOCTO: #7965]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/ui/toasterui.py                          | 1 +
 lib/toaster/bldcontrol/localhostbecontroller.py | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index 376ac59..f30f89e 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -74,6 +74,7 @@ def main(server, eventHandler, params ):
     bb.msg.addDefaultlogFilter(console)
     console.setFormatter(format)
     logger.addHandler(console)
+    logger.setLevel(logging.INFO)
 
     includelogs, loglines, consolelogfile = _log_settings_from_server(server)
 
diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 1d3d1ce..3e16837 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -139,7 +139,7 @@ class LocalhostBEController(BuildEnvironmentController):
             with open(filepath, "r") as f:
                 f.seek(filepos)
                 for line in f:
-                    if line.startswith("Bitbake server started on demand"):
+                    if line.startswith("NOTE: ToasterUI waiting for events"):
                         return True
             return False
 
-- 
1.9.1


