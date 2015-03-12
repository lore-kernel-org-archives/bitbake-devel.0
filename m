Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f181.google.com (mail-we0-f181.google.com
	[74.125.82.181])
	by mail.openembedded.org (Postfix) with ESMTP id 9D12773B45
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Mar 2015 10:46:52 +0000 (UTC)
Received: by wesq59 with SMTP id q59so15378652wes.9
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Mar 2015 03:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=yZ5Nk0zodt5PzPX1NeCLq9zZw3Li50xsUuZqFga587s=;
	b=XVTGu8vTd/iMrZM/FKyTN6F2TFN0XBAcVdDR50VHZu7vm316Lbkst2PSAoB7xpCkv5
	sAhHFZ6bu+CwshfRaFUcgpMMopPyDcA/HjUaTg3dOXFWHjJb2AuNQNr0nVozkshq/t94
	MFhhaHl4bF4sWyZk1GCzZ514UpSqZRCDxYZ+34U2lAfyAFTtdIkkFwAmnJ6kCQlptpJt
	lMtBuEVNID4Pi9mhviLdOHOPUkPY4RlsHpcbrmwQuAz9i/azjdXqdgh1hBn57nBcRun2
	GUAkEDI7ZRHYwtT8LZa/czMvU4QXCshdLl3lBeO6jZtiG+kqTAFd91L4Zu4HK8c5PUtv
	UgeA==
X-Gm-Message-State: ALoCoQlwQkFR/rtFeUDpbqAybIlSZjgrAxI3MwjeocChvAED7rGhCp26hUgAFLsgwBF9k4YVdCnE
X-Received: by 10.180.87.33 with SMTP id u1mr85704106wiz.20.1426157214056;
	Thu, 12 Mar 2015 03:46:54 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id 17sm9393791wjt.45.2015.03.12.03.46.51
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 12 Mar 2015 03:46:52 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 747AB56269A; Thu, 12 Mar 2015 10:46:51 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 12 Mar 2015 10:46:46 +0000
Message-Id: <ba71b6d80f84d000b330db1103e059a2bef339c6.1426156963.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <7f2019767b07ed0e1e4b831d2ec10f0708ef1f2f.1426156963.git.alexandru.damian@intel.com>
References: <7f2019767b07ed0e1e4b831d2ec10f0708ef1f2f.1426156963.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1426156963.git.alexandru.damian@intel.com>
References: <cover.1426156963.git.alexandru.damian@intel.com>
Subject: [PATCH 13/17] toaster: localhost build increase timeout
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
X-List-Received-Date: Thu, 12 Mar 2015 10:46:57 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We increase the timeout for waiting bitbake to start
for localhost builds.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/bldcontrol/localhostbecontroller.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index aef9b60..374991b 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -136,7 +136,7 @@ class LocalhostBEController(BuildEnvironmentController):
 
         retries = 0
         started = False
-        while not started and retries < 10:
+        while not started and retries < 30:
             started = _toaster_ui_started(toaster_ui_log_filepath, toaster_ui_log_filelength)
             import time
             logger.debug("localhostbecontroller: Waiting bitbake server to start")
@@ -144,7 +144,7 @@ class LocalhostBEController(BuildEnvironmentController):
             retries += 1
 
         if not started:
-            raise BuildSetupException("localhostbecontroller: Bitbake server did not start in 5 seconds, aborting (Error: '%s')" % (cmdoutput))
+            raise BuildSetupException("localhostbecontroller: Bitbake server did not start in 15 seconds, aborting (Error: '%s')" % (cmdoutput))
 
         logger.debug("localhostbecontroller: Started bitbake server")
 
-- 
1.9.1


