Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f173.google.com (mail-we0-f173.google.com
	[74.125.82.173])
	by mail.openembedded.org (Postfix) with ESMTP id 574F27355F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Feb 2015 21:42:12 +0000 (UTC)
Received: by wevk48 with SMTP id k48so15061047wev.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Feb 2015 13:42:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=FRGwDG1QD50kUVs+vCw2iC5/gQAZl6aypx6szWcSfYI=;
	b=YUUJqt+Z3YREIAt2AQ6PVqcMiduVzCECpeslG+0mMQrhpEXLR67+U0RbWBlZJCqna4
	njYZptxpvmV5KZs+D/pBPKB9M2n+/UGWeTBz4QyitMkIx2IPNFIapkKk9YyxmFZPD3Tp
	+16cPtckxBrECcosChgbYDjseXvGJLiAVkiCisF4jvCG2h0PEDya3mxcFd+Zl/MWoOA3
	DR1vGkQ5pXD00buxrce6xYaFIQyzUzOQaKmEEo8WH0sSFh+XQqiJggLiUPw0JSqELza2
	ns+DPWoIpLTVygTwWuzUDbKc3lgO8MNIWHxhD1RkLlRJ2Ff/7b7oaPSqX85ju1A+fw5G
	mttA==
X-Gm-Message-State: ALoCoQnkGmSqVADKV6DLy6Hun9YG+1IgeNkxKPcaStpM1Bm4qgFmVnLCU/4tOD03FsAzxnT9CZbC
X-Received: by 10.181.9.107 with SMTP id dr11mr219631wid.40.1424986934013;
	Thu, 26 Feb 2015 13:42:14 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id ka1sm3202746wjc.2.2015.02.26.13.42.12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 26 Feb 2015 13:42:12 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id BD75B5613ED; Thu, 26 Feb 2015 21:42:02 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 26 Feb 2015 21:41:54 +0000
Message-Id: <21cb6ea0acdaec4a3aa133790a17c7055b9a1348.1424986746.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1424986746.git.alexandru.damian@intel.com>
References: <cover.1424986746.git.alexandru.damian@intel.com>
Subject: [PATCH 1/8] toaster: fix typo in models.py
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
X-List-Received-Date: Thu, 26 Feb 2015 21:42:15 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

The typo caused the tasks table to break when a task has no
help text.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/orm/models.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 9e6089b..d2b579f 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -366,7 +366,7 @@ class Task(models.Model):
             return self._helptext
         try:
             self._helptext = HelpText.objects.get(key=self.task_name, area=HelpText.VARIABLE, build=self.build).text
-        except HelpText.DoesNotExit:
+        except HelpText.DoesNotExist:
             self._helptext = None
 
         return self._helptext
-- 
1.9.1


