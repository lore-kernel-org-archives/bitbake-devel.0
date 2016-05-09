Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f48.google.com (mail-wm0-f48.google.com [74.125.82.48])
	by mail.openembedded.org (Postfix) with ESMTP id 8AE5A731B9
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 May 2016 23:02:02 +0000 (UTC)
Received: by mail-wm0-f48.google.com with SMTP id g17so211543802wme.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 May 2016 16:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=HzwetoLFgmRIDksr2ztMSIYNbCQDlgvQvTKxCJnaQmA=;
	b=YJ/gD7M3DczHw/Jr687CFKzBbhcYoW8gz2PP5GPTFt6je2ClFALpL9mH8Tw/ESz4xZ
	QmK+LcbBRiog5TMArvA65IIvzvy9HdSNIhU9zTUvk9JNZ42dr2mAFiwTNTFtu5+uFs/3
	Yt82reYunHtYteBjAVGZURdHEVnqs8Sw55C/eMrSuFP/ZAOzJ4DDAv2ijEm1WOiVEEnp
	6hws/Ah4N2mJ+LIcggZj2/MNhr1u4FmlD3Obu1ECpnZzyvxIZNjm0cTfg3J+dLKWPZi0
	mTMtN+kSXbvx1m/nK/6Gaqstc9izowYHtT3usD7bN3dO98MghLwpNCKr5eO8Nku80goB
	TmVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=HzwetoLFgmRIDksr2ztMSIYNbCQDlgvQvTKxCJnaQmA=;
	b=HsCKxge0SnX6OTHs9eQrFMNmhu0IPYGbiDr3ecfho0uNF7q4x1Hvq7P1XgGsV3q7/V
	5N2zm3ueDdJenu/prhJystjvMwNuJUEpqHUO6nfGMYzoiQ10B3MUL1hUZXFd0E+HQcYg
	iM+A9Up3IwrqOKnJ1ikig1PO9cliRCbLC7TvxXMTXpr13akI5kLAuBUjmXJIbyYQV8AD
	zzYs2A0S+QoULr8ow4hz010a3mETSNcDo237mBHhQX09q5wKDOeHcn6N+43A088m9H6a
	c0CvRpd919HBnO8Ilxg3rwj77LFv4U5acS8cf3mCvo/Rb3FCXlUlLwbZdOvFDDLrq+eL
	HhNQ==
X-Gm-Message-State: AOPr4FVWafFUSpjlMHIxA3vUFfdUOXA02wOM2neTGlY9ZrDHd8ebOn/TiSrur4kbciERMuVN
X-Received: by 10.194.109.65 with SMTP id hq1mr2421770wjb.45.1462834922634;
	Mon, 09 May 2016 16:02:02 -0700 (PDT)
Received: from orion.home (host109-151-244-175.range109-151.btcentralplus.com.
	[109.151.244.175]) by smtp.gmail.com with ESMTPSA id
	b22sm27111436wmb.9.2016.05.09.16.02.02
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 09 May 2016 16:02:02 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 10 May 2016 00:01:51 +0100
Message-Id: <1462834912-23449-5-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1462834912-23449-1-git-send-email-michael.g.wood@intel.com>
References: <1462834912-23449-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 4/5] toaster: models Add missing import sys
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
X-List-Received-Date: Mon, 09 May 2016 23:02:02 -0000

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/orm/models.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 6716ddf..2669606 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -32,6 +32,7 @@ from django.core import validators
 from django.conf import settings
 import django.db.models.signals
 
+import sys
 import os.path
 import re
 import itertools
-- 
2.7.4


