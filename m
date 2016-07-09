Return-Path: <avery.brian@gmail.com>
Received: from mail-pf0-f193.google.com (mail-pf0-f193.google.com
	[209.85.192.193])
	by mail.openembedded.org (Postfix) with ESMTP id E19946067C
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  9 Jul 2016 00:52:49 +0000 (UTC)
Received: by mail-pf0-f193.google.com with SMTP id t190so9408435pfb.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 08 Jul 2016 17:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=gZE3hCah4pn+Sq4+QUqSqp4e/v57BwmbrOZif2iqNO8=;
	b=VnUgbfSWp5fBeypdLpd00xI9EZxupep0Aw/FCSudU67XsSgsOt41BdPLwI9BWv3oqb
	HtUlXBGSsD6Q6RNkEmefstHWHPFT5td+kZb3B4suWFZbUQQt2rLxZ0dnXl6RavACgoFN
	UCBOcmM7PJHIsTRdiEdVeimLfyt9M8orVvAO5IHSXlwgspaujEmfeC2zz2yz+ERb+Weu
	k3bD81UWGQDrAooJeKnM4RZzYnhuiSrmNQ9u2L4c9oqTdLMm6ax0oR2781blQW4mw9CU
	HPnjlzmYSsjZZAUz/0nxZ+YYse54rWScrJhblhyhTMjPuuxbw1avpuckNUjHayhOoqOu
	ssdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=gZE3hCah4pn+Sq4+QUqSqp4e/v57BwmbrOZif2iqNO8=;
	b=iDC6gtTXYxED6mXMqphF+o/sEvnRaZJy5UBklVbTxQJrod2ezbUKPXe+fpg1Sy0bKL
	tuRHlEvR+p5C378J8uV8Fr1xE2aiD45eSbVjvZ6Ipnu4Z1ZtEqEVS3C1cRHpxAHBO2Y2
	pvIpCuH0fGAEMHGl3IHKrrCzZvQayozZGEodQ4HTW2ZN6/ZmNYEXYUmsAVDxGmu+nN+x
	XXDYzGO1FOLLwHLqpHUfF/X/WaVZKoVg1+LicLRwKQFTVawBpi6FGrHWO05rdsQLxc82
	+K1STIJinErEahg1o21oBqX2sJjNq9isJvvfjMIJRu3KxNHB5pvKGeSvVtq4Q1f/y3em
	Q4DA==
X-Gm-Message-State: ALyK8tKKFAy8BR+rsxk+SGdHdlg3bJ7BydMz1P/iIEYbeljcFH5JN7bYTLTAe3m0L7CZiw==
X-Received: by 10.98.222.130 with SMTP id h124mr14561789pfg.78.1468025570632; 
	Fri, 08 Jul 2016 17:52:50 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id bm8sm213836pad.10.2016.07.08.17.52.49
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 08 Jul 2016 17:52:50 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
X-Google-Original-From: brian avery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  8 Jul 2016 17:52:41 -0700
Message-Id: <fb5a436289d7cfd1c86e0308b996e1db36ae63bb.1468024992.git.brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1468024992.git.brian.avery@intel.com>
References: <cover.1468024992.git.brian.avery@intel.com>
Cc: brian avery <brian.avery@intel.com>
Subject: [PATCH 1/7] runqueue: improve exception logging
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
X-List-Received-Date: Sat, 09 Jul 2016 00:52:50 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Runqueue errors direct the user to view the "failure below",
but no additional error message is available.

Log the stacktrace so that the user can see what went wrong.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <brian.avery@intel.com>
---
 lib/bb/runqueue.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 57be15a..04f2f4c 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1219,8 +1219,10 @@ class RunQueue:
                 pass
             self.state = runQueueComplete
             raise
-        except:
-            logger.error("An uncaught exception occured in runqueue, please see the failure below:")
+        except Exception as err:
+            import traceback
+            logger.error("An uncaught exception occured in runqueue: '%s'" % err)
+            logger.error(traceback.format_exc())
             try:
                 self.teardown_workers()
             except:
--
1.9.1

