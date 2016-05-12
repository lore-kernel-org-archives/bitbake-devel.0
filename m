Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com [74.125.82.41])
	by mail.openembedded.org (Postfix) with ESMTP id 65AD46FF84
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 May 2016 14:10:46 +0000 (UTC)
Received: by mail-wm0-f41.google.com with SMTP id g17so138270767wme.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 May 2016 07:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=ZRf/QIgsbWkPuowfCo+j4h/Zwjm2CsAPo8ntQLDyBEM=;
	b=We3IntlgGxZJ2tenrxtV5aZMdKdx4FHwX1pfJo7bCJ8jelTT2XvLdS7xRY1L2ARQud
	sm6yuzDVOJarJmDA5GWXbkBwGJVDJf3DWDICkOuaEe9XYV+onyxPE+AL+cexTKs0caP6
	y4nHTG7ovLP+yB1A4gNXsmM5Oe5lyg19RRI67c2E4sMrQtMsZtmM2FrWwLQwum0XWS9G
	2CbkF0Sj7y/7t3X5xKWKHhoXN0MbyCijiUDvCDvh2pD1vYoF5dZ+LDKQGQC9k7g3dpXS
	4cph+dg6yEzMkH7XZTmovAoSTfE897I95nDgUEyGN3LoJP2DZCxbbRJJ7ANw7ozQzF49
	dozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=ZRf/QIgsbWkPuowfCo+j4h/Zwjm2CsAPo8ntQLDyBEM=;
	b=ADGCNHlrjQ+erULLHTgsZUUJJ2oNg33apYYltjGkp2epe+vGWBDiUgD8ZorSmXQ0Ob
	6DVwGGYeCy6bfRLrGpHUulX+PTbyTMu9srxTyUR1yOLogcN5vXDEdOFXocgWySiHTTrb
	bWrvCf6N6Xwlzie0053gKnOpMsRdW+l5uvDXg/GMULCo4QjsI7zl/wwBn2TotHCV99WP
	dQeLOCuWYYuB16X06EArvM3Ab9HCl5DVWmZCYjN90NC5REUfEp7OihQvphxXdu1DTIhy
	E8Aj2ZHrnxDhCr4DNgjMxjzV3efow9BgL4+c+IL7Pxg3bczuxkMj/PB6PBCX6buEdpHA
	foCg==
X-Gm-Message-State: AOPr4FVI3gVINFwN9X5X8t4wBjkMtMPVtmsLgEyea5k/um+yGq7X4Wplsb8YrDGB0PKUv9aD
X-Received: by 10.194.6.65 with SMTP id y1mr10141222wjy.12.1463062246502;
	Thu, 12 May 2016 07:10:46 -0700 (PDT)
Received: from orion.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id u4sm13653360wjz.4.2016.05.12.07.10.45
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 12 May 2016 07:10:46 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 12 May 2016 15:10:37 +0100
Message-Id: <1463062238-12007-3-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1463062238-12007-1-git-send-email-michael.g.wood@intel.com>
References: <1463062238-12007-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 2/3] toasterui: capture keyboard interrupts the same way as knotty
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
X-List-Received-Date: Thu, 12 May 2016 14:10:46 -0000

From: Elliot Smith <elliot.smith@intel.com>

knotty captures two levels of keyboard interrupt: a single interrupt
or two interrupts in a row. These then trigger stateShutdown
and stateForceShutdown respectively.

toasterui doesn't have an equivalent way of capturing interrupts and
using them to shut down bitbake. Now that we are no longer using
knotty + XMLRPCServer for our command line builds (since switching to
per-project build directories), we see some odd side effects of this,
such as builds continuing after they have been interrupted on the
command line.

Bring toasterui in line with knotty (copy-paste most of the code
in knotty.py which deals with interrupts) so that a keyboard
interrupt actually shuts down the bitbake server (if not in
observe only mode).

Additionally use the cancel_cli_build() method to set the Build
status to CANCELLED in Toaster's db when we get keyboard interrupts.
This means that builds interrupted on the command line show as
cancelled (same as if they'd been cancelled from the Toaster UI),
as specified in the UI designs.

[YOCTO #8515]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/bb/ui/toasterui.py | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index addd5cc..8e5af65 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -441,7 +441,22 @@ def main(server, eventHandler, params):
             if ioerror.args[0] == 4:
                 pass
         except KeyboardInterrupt:
-            main.shutdown = 1
+            if params.observe_only:
+                print("\nKeyboard Interrupt, exiting observer...")
+                main.shutdown = 2
+            if not params.observe_only and main.shutdown == 1:
+                print("\nSecond Keyboard Interrupt, stopping...\n")
+                _, error = server.runCommand(["stateForceShutdown"])
+                if error:
+                    logger.error("Unable to cleanly stop: %s" % error)
+            if not params.observe_only and main.shutdown == 0:
+                print("\nKeyboard Interrupt, closing down...\n")
+                interrupted = True
+                _, error = server.runCommand(["stateShutdown"])
+                if error:
+                    logger.error("Unable to cleanly shutdown: %s" % error)
+            buildinfohelper.cancel_cli_build()
+            main.shutdown = main.shutdown + 1
         except Exception as e:
             # print errors to log
             import traceback
-- 
2.7.4


