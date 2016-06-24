Return-Path: <michael.g.wood@intel.com>
Received: from mail-pf0-f171.google.com (mail-pf0-f171.google.com
	[209.85.192.171])
	by mail.openembedded.org (Postfix) with ESMTP id DA52A6FFCE
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Jun 2016 15:26:04 +0000 (UTC)
Received: by mail-pf0-f171.google.com with SMTP id t190so40251051pfb.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Jun 2016 08:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=GtXmIufj2DaxuWND7I4we6r7zzL0wgSct+skbN+7PiM=;
	b=RUUpQtFfOq2an1JAzdflyxIDo5vEu0tkChbfjvPPyk/pH2MyRAUBayDGVkYSulJfuS
	As5Yqn2Dj9GZM7IobLUeiRfvtLXd5glOY0Ktvj7hiBDCi9XyjH+li24x3fkwoSzhYnL3
	uGnieVe38pVyNSer71O70TISdYHJO0YpUNB5drpNHNIb52Nc/a8nBemghST336Dv7qKn
	32+iFXLS2KFyVcpXBnpzrWnv+mMsaQynMRrqQkBgW+L09hpRyr2102ScY5JbqLcovU2g
	Rnyk+5/KKHnGRLrc8n2y3jBGhwwaJn+e87pzh0vTJKXWAKVu9jeYfehJVN84qTfIiu9f
	xmLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=GtXmIufj2DaxuWND7I4we6r7zzL0wgSct+skbN+7PiM=;
	b=H5HxN3GTiEEAa/tAqejj/X5Xdo/vgKr8CXHY7mJ0/VP4pBiGuRfe4R4oZZ3R28E4M9
	8XyzbZ6EKbh0+pgQc+PIsegsPjkmQP3y3/mo0FO9uiGMWREDpBCtw3iLjYUbdbLJADR0
	ebtvuAgURn6G5xgyu2Vq7t66vGiSw0+jC8V5GfZip+2BEfx53GY9yDR4KUdg/mVpqokk
	WsOOsktvL2DXQvLPv8p7yRHwFYBvKmQQLIwQsKdjr8IB58PWbN11Be8MgRukr9FwnX8/
	5xOFEtYbekt4GNIGu33yYnqMeDtNltmoFVE2Ztq/3S9EvEKLj2hq+CzK3FfXZ6TZAAMF
	oZEg==
X-Gm-Message-State: ALyK8tLNhX4B+4o687qIWcjQzADt56xGPfbEGEPE1U2QrUYfBF1ng4MdFyiEPj1ShkwIYLs5
X-Received: by 10.98.25.66 with SMTP id 63mr8392430pfz.94.1466781964865;
	Fri, 24 Jun 2016 08:26:04 -0700 (PDT)
Received: from orion.ger.corp.intel.com ([192.55.54.45])
	by smtp.gmail.com with ESMTPSA id w67sm939643pfw.41.2016.06.24.08.26.02
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 24 Jun 2016 08:26:04 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 24 Jun 2016 16:25:54 +0100
Message-Id: <1466781954-16044-2-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1466781954-16044-1-git-send-email-michael.g.wood@intel.com>
References: <1466781954-16044-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 2/2] toaster: remove SSTATE_MIRRORS from projectconf
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
X-List-Received-Date: Fri, 24 Jun 2016 15:26:07 -0000

From: Sujith H <sujith.h@gmail.com>

Remove SSTATE_MIRRORS from getting blacklisted. Hence the SSTATE_MIRRORS
should be removed from projectconf.html file so that users can know that
this variable is no more blacklisted.

[YOCTO #9598]

Signed-off-by: Sujith H <sujith.h@gmail.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/templates/projectconf.html | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/toaster/toastergui/templates/projectconf.html b/lib/toaster/toastergui/templates/projectconf.html
index bfa386d..9a8b841 100644
--- a/lib/toaster/toastergui/templates/projectconf.html
+++ b/lib/toaster/toastergui/templates/projectconf.html
@@ -203,7 +203,6 @@
           <code>CVS_PROXY_HOST</code>
           <code>CVS_PROXY_PORT</code>
           <code><a href="http://www.yoctoproject.org/docs/1.6.1/ref-manual/ref-manual.html#var-PARALLEL_MAKE" target="_blank">PARALLEL_MAKE</a></code>
-          <code><a href="http://www.yoctoproject.org/docs/1.6.1/ref-manual/ref-manual.html#var-SSTATE_MIRRORS" target="_blank">SSTATE_MIRRORS</a></code>
           <code><a href="http://www.yoctoproject.org/docs/1.6.1/ref-manual/ref-manual.html#var-TMPDIR" target="_blank">TMPDIR</a></code></p>
           <p>Plus the following standard shell environment variables:</p>
           <p><code>http_proxy</code> <code>ftp_proxy</code> <code>https_proxy</code> <code>all_proxy</code></p>
-- 
2.7.4


