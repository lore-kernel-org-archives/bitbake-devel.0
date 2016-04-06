Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com [74.125.82.49])
	by mail.openembedded.org (Postfix) with ESMTP id 8828D77178
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Apr 2016 16:47:20 +0000 (UTC)
Received: by mail-wm0-f49.google.com with SMTP id n3so71345494wmn.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Apr 2016 09:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; bh=qL19uSqtLNi9vNr2HrUNbHYFEUkgGlmZBkXf6JkycNk=;
	b=JLl8a8MtdeKa8St5kqBCHXcq2K+5QrBdAehY8efWEsuXEkN5ErjFw0C5FeMi5yqHbY
	ugaukFSR8MrtsmLGrpy18k+/qkGvATT3Nc3geA6UPln9BUXdZjJ7gZKb/v2ykwLlKzLv
	nf8JlONvk1qJB7HOcEjD8xaY6kNwWS7Y5j5rOmsDLK8verUrQdOypQZ5DA314JGqps9h
	POhUagdk6Fsr/VhHiTaQbm3E4Wpj974IV7JPtC/f6mne6QE1srFjhYidETeAOfWPO8Pv
	FW9986aKPpHEXyJwspVvR85FGt4jd6jPu+GQOZHXBsNE9+qIsw617Voj9hpUOFo26Qda
	EJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=qL19uSqtLNi9vNr2HrUNbHYFEUkgGlmZBkXf6JkycNk=;
	b=cw5j6N8RyCyheRyW3XKD1YXgiFOazADc5UZy0IRV+1uQsqdQPpKDKJwJGBX5rKzcfq
	/gIde7bpeBhuMOMz5nFpZJRMSRuWy08BTGpM5USMATtAGEXUBpqpdvIFeLbYhK2yCclJ
	h7qDW1F44lg7Ih4FqMusWKP1k+1DGz2rFxqKsP5HsGP1BU7iIpTexs4XnQ2DraP2F2bR
	hC9QD0N1T6R4exoh28zptsvPsqTd+Kmpb2ccxS6kL4lnr4VYg+qZa1wqCQKD1IGC/Who
	7n1SVIhQj7O32ztd/0jc7nd0Ta7xOfvIMGmOYX/DtP0wBnEosZuBS/wIX8QmYmwubzlr
	u95A==
X-Gm-Message-State: AD7BkJKXPjsU+nS6dUqH2GVkDwbxKrMCws8Mf8qSmoOtBfnXiLhmpyNd2rK/uB9FoCB49nG8
X-Received: by 10.28.100.132 with SMTP id y126mr21269368wmb.91.1459961240811; 
	Wed, 06 Apr 2016 09:47:20 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id gt7sm4145345wjc.1.2016.04.06.09.47.19
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 06 Apr 2016 09:47:20 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Apr 2016 17:46:23 +0100
Message-Id: <8299a6a7c2c4de3e6b412118844b9b49ed8d6da4.1459960764.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
References: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1459960764.git.michael.g.wood@intel.com>
References: <cover.1459960764.git.michael.g.wood@intel.com>
Subject: [PATCH 13/38] toaster: add new parameter to _shellcmd
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
X-List-Received-Date: Wed, 06 Apr 2016 16:47:20 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Added 'nowait' parameter to _shellcmd method to support
running chain of commands in a subshell.

This is going to be used to stop bitbake server after
the build.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/bldcontrol/localhostbecontroller.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 2e3aa37..ed46636 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -51,12 +51,14 @@ class LocalhostBEController(BuildEnvironmentController):
         self.pokydirname = None
         self.islayerset = False
 
-    def _shellcmd(self, command, cwd = None):
+    def _shellcmd(self, command, cwd=None, nowait=False):
         if cwd is None:
             cwd = self.be.sourcedir
 
         logger.debug("lbc_shellcmmd: (%s) %s" % (cwd, command))
         p = subprocess.Popen(command, cwd = cwd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
+        if nowait:
+            return
         (out,err) = p.communicate()
         p.wait()
         if p.returncode:
-- 
2.1.4


