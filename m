Return-Path: <michael.g.wood@intel.com>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
	[209.85.220.41])
	by mail.openembedded.org (Postfix) with ESMTP id 151F0736B6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 16:22:44 +0000 (UTC)
Received: by mail-pa0-f41.google.com with SMTP id oz2so22896101pac.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 09:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=AWEK8gnxhapfjoKzU4GbidNPMT/MigUFXFEo145oEpA=;
	b=djabPNlwgE3bjvuMhe+KRMzRLxmV//B6QEP+gc0LCh9XQ7DwkhFKxDhWxHCRgpGAcA
	aDqEqnWZoQX9qGWwXOpns3BbCNQCW0hDE4sv/nRbuKB73EOVexntc0CWi3a+lyebRVy1
	3XnfE5yc3s0FNicJvueaSrKHv3aCE1t0EpKP3X2COWSl00j/QC0IvPeIOZ4DmjFEVkjx
	91LUzewa9yDfTFOmVG82kfeJbt8QOhhUZGdt1VcauLKJr5XPJCBIbq2lSiIhJl2sGgcv
	PU9xMrMNoRb40L4v8JWw2X3N5jy2mgADl94l3ckXttOlp9EEt7zwbymImuLyqCa1dukH
	PglQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=AWEK8gnxhapfjoKzU4GbidNPMT/MigUFXFEo145oEpA=;
	b=NnJ0MSgv+fIR1WS9dDnQVovNP+f4l2EAFsbCgjzPn+8qyD8PkSNXOf+j1hWWvVg+Vn
	xpHm/BUTFmZZoSyJyHOMtELCBFTNTV8/JDLUdFKEqYFIe/y45nQ645d6NRXSDOG8tPO6
	DiBy5SIZvtRHF2pWowCQ72JIOC82TtCpqAfZwIuQsQ/9R8eOHhpwQv3fon2c144QUk7T
	Hq1H02Q0OtgHoY9Sa7qaXpaB2+/drT3mz4AKRWaKT+++osM4OXMAKZ10bDFgKUlxa+yw
	BL36bT3olVPWK/Fnrh2I2+k5M0BNH5yF0u82PRY1/xfpSBxFrK7ugusoM21HNP0wVN1e
	ODww==
X-Gm-Message-State: AE9vXwMKKJVqy3oc9VDH0ygWbA4V8jnq1EExvcd28w3smwsqkqW4qen0vaxixrtcY4qr856c
X-Received: by 10.66.100.225 with SMTP id fb1mr24389594pab.4.1474042965357;
	Fri, 16 Sep 2016 09:22:45 -0700 (PDT)
Received: from orion.ger.corp.intel.com (fmdmzpr04-ext.fm.intel.com.
	[192.55.55.39]) by smtp.gmail.com with ESMTPSA id
	bm8sm13336146pac.16.2016.09.16.09.22.43
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 16 Sep 2016 09:22:44 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Sep 2016 17:22:28 +0100
Message-Id: <1474042955-12618-2-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1474042955-12618-1-git-send-email-michael.g.wood@intel.com>
References: <1474042955-12618-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 1/8] toaster: fix checking of repository url
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
X-List-Received-Date: Fri, 16 Sep 2016 16:22:45 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Toaster checks gir repository url is the same as locally cloned before
checking it out to existing local clone. This check can be skipped if
commit is 'HEAD' as in this case repository is not hard reset to
commit, so the local clone won't be changed.

[YOCTO #10163]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/bldcontrol/localhostbecontroller.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 39de6dd..a64e89b 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -156,7 +156,7 @@ class LocalhostBEController(BuildEnvironmentController):
                 try:
                     localremotes = self._shellcmd("git remote -v",
                                                   localdirname)
-                    if not giturl in localremotes:
+                    if not giturl in localremotes and commit != 'HEAD':
                         raise BuildSetupException("Existing git repository at %s, but with different remotes ('%s', expected '%s'). Toaster will not continue out of fear of damaging something." % (localdirname, ", ".join(localremotes.split("\n")), giturl))
                 except ShellCmdException:
                     # our localdirname might not be a git repository
-- 
2.7.4


