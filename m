Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com [74.125.82.54])
	by mail.openembedded.org (Postfix) with ESMTP id 5106277180
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Apr 2016 16:47:25 +0000 (UTC)
Received: by mail-wm0-f54.google.com with SMTP id v188so29618811wme.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Apr 2016 09:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; bh=KeYEZJDQj0MejlQd56dPckGYBf3W8UAoJ5cOitEEoj8=;
	b=DvJf1RoJyal2ouseXaRlv4T0Cu3cx1qFWyRzE5zkcoYaMqnb98padP/nZxjmh3G3Vr
	YcpTmfjSgKADjkzmzkViFLsrsPT4O4DXnzwm4ip82+SYZ6BCMQqwxVIBjbN47uIvS/q8
	qvOuzYpTYTWMgqFvrZwfXtTE/0ofnKSaPY/qyqJCtFkcuQTRMK7WeYLMHYxHAs+MG6qx
	pPlIu4h+l1VIW+bTVUWxfVtSfl1hwKFqpRe7z8fcalib/UCcMy1w0yCZSPe/ydzePpAg
	QQLShAk5eqTgHRukvPvGew+gh9874yqSeskfyE7RqANZshyEuF4gWryH7+bg5VLpCejt
	BRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=KeYEZJDQj0MejlQd56dPckGYBf3W8UAoJ5cOitEEoj8=;
	b=mmV9tk8YgrcIZY0KYeD3cUdxC9AZWoIlqa4pl2kx8gvftUaz8xe/u3Y9mDWQgqIRDG
	WRHSTFWaAbZPlJ2MTYlotR8Fjfsxbn9bHvm86+WmAWDdXzyRlaqTdfqDC5Fpp46AmrOC
	aOtl0gxQm45dYUjaETddsPGTORwv07xc0YV93jo30u0E+8HRqV/X4ZaZItVdmIKhtmBB
	kjTUjv6eJcxk26TG9Nu2FRxuizJsS7VrW/VbEyZPHIF6/yBoRiNUCF3c5PL8I4WacD3C
	Uomw5RkfQbZ2A9w/jKdY6R6txIUYCzpLo3Jyi0lac1kCQQjvdI/RpvyXpvowBdxfTw8t
	99Yg==
X-Gm-Message-State: AD7BkJLCo6LJ1qKqW4w4cD82MyP1rGalnvdLobL4EvfLiKBlnosAv+xUmrSt4HW+CCCY+lao
X-Received: by 10.28.184.194 with SMTP id i185mr25319591wmf.90.1459961245833; 
	Wed, 06 Apr 2016 09:47:25 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id gt7sm4145345wjc.1.2016.04.06.09.47.24
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 06 Apr 2016 09:47:25 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Apr 2016 17:46:29 +0100
Message-Id: <efafbf633386d3d0fc97af0e442c9d4e326956ee.1459960764.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
References: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1459960764.git.michael.g.wood@intel.com>
References: <cover.1459960764.git.michael.g.wood@intel.com>
Subject: [PATCH 19/38] toaster: bldcontrol Add forceShutDown function to BitbakeController
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
X-List-Received-Date: Wed, 06 Apr 2016 16:47:25 -0000

From: Sujith H <sujith.h@gmail.com>

Add forceShutDown function to BitbakeController class. This function
provides a mechanism to cancel the build from toaster. An API which
can be used safely to cancel build and hence shutdown running bitbake
server.

[YOCTO #6787]

Signed-off-by: Sujith H <sujith.h@gmail.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/bldcontrol/bbcontroller.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/toaster/bldcontrol/bbcontroller.py b/lib/toaster/bldcontrol/bbcontroller.py
index 058e490..0f7b66d 100644
--- a/lib/toaster/bldcontrol/bbcontroller.py
+++ b/lib/toaster/bldcontrol/bbcontroller.py
@@ -63,6 +63,9 @@ class BitbakeController(object):
             task = "build"
         return self._runCommand(["buildTargets", targets, task])
 
+    def forceShutDown(self):
+        return self._runCommand(["stateForceShutdown"])
+
 
 
 def getBuildEnvironmentController(**kwargs):
-- 
2.1.4


