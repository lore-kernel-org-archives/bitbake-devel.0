Return-Path: <michael.g.wood@intel.com>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
	[209.85.220.41])
	by mail.openembedded.org (Postfix) with ESMTP id CA4666FFC8
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Dec 2015 14:26:05 +0000 (UTC)
Received: by pacwq6 with SMTP id wq6so30479494pac.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Dec 2015 06:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=GEo9UD02m0LK4trLHryCLJVqnK75UWLCNZU0P8nhDQ8=;
	b=ISO++jGTmuKAdUFEatMSSSKf/oj4/l6DcRrdo1l7+9soM6RtpJ8mpdsF+vuuju7lzM
	pqnB+5rrTigNIwTqyqh+KM0COEpxoWFaO2bTn9ULRKlPtsSimmIgHvuTFzklMQdp9k+X
	A94PVcdnnWCZBzN60UqO2l4+T0EVIDXF3GKaGjxYfjAyzdN16Mth7RHcio9BgDG9nbM6
	I/o5CuPflqactmCiVnAaCC1Ihy7ykkWJqWMtp9JA5YOGgc5G2yumNTQoMQvZ6g5+IC7v
	rQHWxCKOBlG/tWQ+p7z6UyZfv1Ste58cv+tdybFFucISnfontDMoC+WIt+PNmPiOwadQ
	u0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=GEo9UD02m0LK4trLHryCLJVqnK75UWLCNZU0P8nhDQ8=;
	b=Mjf49/0M5mvL5nlRFz9U1RYgmsTUTqfCPbDbzn6onXBjrdCsi+0H90ZFGPViErbSYZ
	ZS8HY9ZEJe44OgiDvDzEYSrCJF54JcP9+m4Poa9aWkAmBX0o4TlZP+Ui+5lNKMFeEW9N
	jPHIlaajBM+RZoSOZtSHqA0wXI7wF6V1nhjli2aHs9l7K62/mLmwVTKF2pgTjerVKbhG
	XDUhwkTrJuGIjRDsCjrBh+NQXp4XQoELl6zYOe/mZ1H1bKH/BcSafsHXZQvncMfofGgP
	QUpQ7KFkb/aEMS8d1ZPZwDXd6N7xUu+AePYdlC43pvHJSQVw3aEUlEFbg1x0tLiEDRR7
	CLoQ==
X-Gm-Message-State: ALoCoQlUtoaeaV2ZJwJZ1RYdV6K6PvzMzptJx3q0v4bn0F4xjWNE+OXp2Ofqo756bIqWZqdOcRTO5qDTQ5JWKIrfKO1sTNYM5A==
X-Received: by 10.66.122.105 with SMTP id lr9mr8445181pab.8.1449671165263;
	Wed, 09 Dec 2015 06:26:05 -0800 (PST)
Received: from draco.icx.intel.com (fmdmzpr01-ext.fm.intel.com. [192.55.54.36])
	by smtp.gmail.com with ESMTPSA id
	k2sm12095175pfj.25.2015.12.09.06.26.02
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 09 Dec 2015 06:26:04 -0800 (PST)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Dec 2015 14:25:48 +0000
Message-Id: <1449671149-9455-3-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1449671149-9455-1-git-send-email-michael.g.wood@intel.com>
References: <1449671149-9455-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 2/3] toaster: trigger SetBRBE event
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
X-List-Received-Date: Wed, 09 Dec 2015 14:26:05 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Triggered MetadataEvent "SetBRBE" when TOASTER_BRBE variable
is set on bitbake server. This should make buildinfohelper
aware of the build request id, which is used to properly
report build status and failures back to Toaster.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/bldcontrol/localhostbecontroller.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 92d9ac5..00228e9 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -287,6 +287,9 @@ class LocalhostBEController(BuildEnvironmentController):
         # set variables
         for var in variables:
             bbctrl.setVariable(var.name, var.value)
+            if var.name == 'TOASTER_BRBE':
+                bbctrl.triggerEvent('bb.event.MetadataEvent("SetBRBE", "%s")' \
+                                     % var.value)
 
         # Add 'toaster' and 'buildhistory' to INHERIT variable
         inherit = {item.strip() for item in bbctrl.getVariable('INHERIT').split()}
-- 
2.1.4


