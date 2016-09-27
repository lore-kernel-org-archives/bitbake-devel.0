Return-Path: <michael.g.wood@intel.com>
Received: from mail-pf0-f171.google.com (mail-pf0-f171.google.com
	[209.85.192.171])
	by mail.openembedded.org (Postfix) with ESMTP id A4D566078E
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Sep 2016 15:17:07 +0000 (UTC)
Received: by mail-pf0-f171.google.com with SMTP id s13so6837921pfd.2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Sep 2016 08:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=30TRsrSjnXRMtuKah3A34nbKHvmts2FRWLLu0aFSq+k=;
	b=RWoJ/nVT623/Ws7xKS3bskAqn4PxDAkZZYnG4xkDIPM5DcIdO9ijQb+G0sZNukjCbz
	qqOkELJb7H2G99Jl7is1ah6BMYGoLl7WD5uwba4aUVCU1nrdutsE1chlVM1pgkZGoT+0
	Xuau9u0FC0dm7BPNAm3XDMglD+uEY4y8OeWfyuEoRXLqtToXOwTEqoklu0/qzlkW3MFS
	z5y39dLXOHdPiJ84IT+orOpAwWV4rleqog4wUj1BkMDLwR/mrOOO8F25/FZWt+/VitR5
	RMm5XwH4XK4YId00BSUIeP2fHQPt9V4pHXJv0GQDJlLx2PS78l6kbJlUALly+QBCumvZ
	Xs5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=30TRsrSjnXRMtuKah3A34nbKHvmts2FRWLLu0aFSq+k=;
	b=ml0fwad5aiRyruRuxdzGmn7vmLuMx9SpvWZvaZIrcIl43JK1m0Qv1BmDQ91jMfgq07
	aju/YwqQp231BKcP0u2TjEkdzsWXQOLT5gPEiLSsbgdS2WVxpVBxKq+Guyyzg0eo7TGR
	xTmDv/soWibD6soQuRarw0dWi16CikYZ4fGYH/62+wUTbe/Eho3k+6+ydBbHNasoIZok
	NZ63DuZb5HbMCWGoTrlhvNJMFPRWx3CykWkoPFl0eRtcH+5m2poJ6051wxiGg6l1R5HA
	bdaDGy4T+W2NklHQXLVIJCtn9IQC5RzP4Aj1KfOOMqAkw9tYnxSvno+NvQLNHoTM32O6
	GBQw==
X-Gm-Message-State: AE9vXwOcf1ICx+UDKJZuGwb1NmcZZf7rlAQSidPjnGa9YYActYDtWr7Rz9TFyfO3HbYYV0fA
X-Received: by 10.98.35.84 with SMTP id j81mr49414663pfj.166.1474989428785;
	Tue, 27 Sep 2016 08:17:08 -0700 (PDT)
Received: from orion.ld.intel.com (fmdmzpr01-ext.fm.intel.com. [192.55.54.36])
	by smtp.gmail.com with ESMTPSA id
	p1sm5784876pae.12.2016.09.27.08.17.07
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 27 Sep 2016 08:17:08 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 27 Sep 2016 16:16:54 +0100
Message-Id: <1474989416-10454-4-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1474989416-10454-1-git-send-email-michael.g.wood@intel.com>
References: <1474989416-10454-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 3/5] toaster: fix handling of EnvironmentError
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
X-List-Received-Date: Tue, 27 Sep 2016 15:17:08 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Due to the bug in processing EnvironmentError exception,
toasterui ignores it. As EnvironmentError is a base for OSError
and IOError this means that all OSError and IOError exceptions
were silently ignored.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/bb/ui/toasterui.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index b5422cf..569957a 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -450,9 +450,12 @@ def main(server, eventHandler, params):
             return_value += 1
 
         except EnvironmentError as ioerror:
-            # ignore interrupted io
-            if ioerror.args[0] == 4:
-                pass
+            logger.warning("EnvironmentError: %s" % ioerror)
+            # ignore interrupted io system calls
+            if ioerror.args[0] == 4: # errno 4 is EINTR
+                logger.warning("Skipped EINTR: %s" % ioerror)
+            else:
+                raise
         except KeyboardInterrupt:
             if params.observe_only:
                 print("\nKeyboard Interrupt, exiting observer...")
-- 
2.7.4


