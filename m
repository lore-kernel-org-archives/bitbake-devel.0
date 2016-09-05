Return-Path: <michael.g.wood@intel.com>
Received: from mail-pf0-f172.google.com (mail-pf0-f172.google.com
	[209.85.192.172])
	by mail.openembedded.org (Postfix) with ESMTP id 8FB79773E1
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  5 Sep 2016 14:30:01 +0000 (UTC)
Received: by mail-pf0-f172.google.com with SMTP id h186so65154991pfg.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 05 Sep 2016 07:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=7MS+8X+WMQWMo1TCzSpdvzesqO9k6S7Z1ZF9WnoQlx4=;
	b=ZAaPSFxOTXtYtd2xS3JvbXBj/fLFQ19GKS0TH8PSLlIAASP+nJBSnhopkNFgqtU830
	kfQgdC4U86NKg8aayO/Ck5WakmV5D9sfzToe3qISCU/IQo4JzWscV+s8kt4govJblmLd
	GtAvMxuTRttFJhAyCT4n0ksxMaRzdOvePC1mJY2+Gllh+FRACNUXj6Ubv3aYgBt8i9hw
	+ZMS5apBMzLr61b8w7uk7mjs+MQ7pM68n/GZR4NToRI8r4byvjj3jfU0kzPaOsycDVOb
	4e9/nnpbX5wBE88DRulXQq1Ufe3h2Ls2aaPctCNCLEpG4DxjGvTmYUHHT+McWiFcDBkI
	jxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=7MS+8X+WMQWMo1TCzSpdvzesqO9k6S7Z1ZF9WnoQlx4=;
	b=mzlTqt6F7muh8E9xytg77k0dqNeH8ZFBWZ5ZzjHMX6l0epfiJlk4bSkzPt1QFBTbME
	Ne4OGVPIbNiDwZFV3p5CidpRy78hoQraxD2ssPG9u8HbGdjMgObK/Lbi3n99s1kVMG1G
	rQWSiLU0pX10cWczBBJl77kPrQ172UjZ8OiazOD1KMfFdioYki5mD9LPVKLJwfKXBH8c
	Bp1Ae6Dvfx/STc3ANBckySXR7pLUwg7CDVkBQy5bWLG+3tRaD4xOKphxDYQsRNXar8Az
	HtATdnyjPJWCyaI+vWJAbS3WAgoBZ3GS4oeMFC4J/a1MYLxnqQOIX6mjrH+9snYuStX3
	t5zg==
X-Gm-Message-State: AE9vXwMbNK5wxN8cQexbssv4sAbJrylX5R56CQiPjc4B5ENs5YrNPPRBNPdkOS68rQlFjC6B
X-Received: by 10.98.35.7 with SMTP id j7mr64249289pfj.39.1473085801992;
	Mon, 05 Sep 2016 07:30:01 -0700 (PDT)
Received: from orion.ger.corp.intel.com (fmdmzpr03-ext.fm.intel.com.
	[192.55.54.38]) by smtp.gmail.com with ESMTPSA id
	j21sm34058285pfj.75.2016.09.05.07.30.00
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 05 Sep 2016 07:30:01 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  5 Sep 2016 15:29:31 +0100
Message-Id: <1473085772-17878-11-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473085772-17878-1-git-send-email-michael.g.wood@intel.com>
References: <1473085772-17878-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 10/11] toaster: remove handling of .toasterui.pid
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
X-List-Received-Date: Mon, 05 Sep 2016 14:30:01 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

This file is not created anywhere, but handled in toaster
script code.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 bin/toaster | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index 5e01101..b14749a 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -95,10 +95,6 @@ stop_system()
     # prevent reentry
     if [ $INSTOPSYSTEM -eq 1 ]; then return; fi
     INSTOPSYSTEM=1
-    if [ -f ${BUILDDIR}/.toasterui.pid ]; then
-        kill `cat ${BUILDDIR}/.toasterui.pid` 2>/dev/null
-        rm ${BUILDDIR}/.toasterui.pid
-    fi
     webserverKillAll
     # unset exported variables
     unset TOASTER_DIR
-- 
2.7.4


