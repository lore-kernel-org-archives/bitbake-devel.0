Return-Path: <avery.brian@gmail.com>
Received: from mail-pf0-f174.google.com (mail-pf0-f174.google.com
	[209.85.192.174])
	by mail.openembedded.org (Postfix) with ESMTP id 3F0BE77041
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 19 Feb 2016 05:16:01 +0000 (UTC)
Received: by mail-pf0-f174.google.com with SMTP id q63so44646706pfb.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Feb 2016 21:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=FRNimqih5crDcWfOXaEV2VxXcN501wnf5pDRBEXDT0w=;
	b=ko1KGUHr3rlbW0CpaZB1kBFVnK8EhH5o86Hj8jA7P6CE/p85HhRwwka0hyu4vYMymW
	fYhjmzdWyaFDW29IJ03xcXYOuycjZbP2QVY5aG9BGlxDV01wX+plK3w0/YQV1cU+ne67
	URl+4rUFk287WOPdLLQmjQEqh/hL5rtTEB4vfOjVeOEMbDex0v2OaVhuQAFTMgGxHRrA
	v4igaPE7Uj+Xyy/fF1xtqW2i6hi70GAx9f89Yv2fFDe1wetKB5oh1G6lbLnRKXB0NAEs
	/EsA8o6Ifoci3OsXDQ0J2g+71drZYzQYrwWL9UGKILDH5C1GCUUpYpepMGn0RKYfIPr3
	LCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=FRNimqih5crDcWfOXaEV2VxXcN501wnf5pDRBEXDT0w=;
	b=cIS7P2z1wMkNvUmfwGzwbTdBLuW3KO3oqjgDQ/p3RmDEkhPkJof9EUBigNblHhfnnn
	ByY13BeuBi9d/DOKT3b+nto41BfGDSB6mcY7NH2vaWQXzVY4dJyb4BF8jDHpn0cR3Oul
	Qc1nun7oh+WyGeSqyTgSqmzdo8H0VJur0UVYh8aZ+opUw3tpuPtmuaZOTffSmi1+VkMs
	JRl45u2QHjdQ9dshTxeR933zdLbAw4mXMFVgCQmoht7HZEq3H0/7ZWDp6uyrCItN05Gz
	nQcyJF8vcEOCxqJPKyJHuqr2O4yMpXbhIzQUMwef5bKsviCyGZ0HjbQ+L2Syi7kUkLKC
	CC/g==
X-Gm-Message-State: AG10YORR5EGaMXaysdtBPOIhKGbpSo6YXkHmgmpbQHWDcYHN5AL9yKJGskzAvGE617nEyA==
X-Received: by 10.98.18.201 with SMTP id 70mr15652933pfs.104.1455858962741;
	Thu, 18 Feb 2016 21:16:02 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	ml5sm13317073pab.2.2016.02.18.21.16.01
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 18 Feb 2016 21:16:02 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 18 Feb 2016 21:21:49 -0800
Message-Id: <b0d93d028f7f03333e939cfc93884a0694401109.1455859137.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1074d09d9af22d962880d1ba7791b85eecfeac08.1455859137.git.avery.brian@gmail.com>
References: <1074d09d9af22d962880d1ba7791b85eecfeac08.1455859137.git.avery.brian@gmail.com>
In-Reply-To: <cover.1455859137.git.avery.brian@gmail.com>
References: <cover.1455859137.git.avery.brian@gmail.com>
Subject: [PATCH 2/5] toaster: SoftwareRecipesTable apply default order_by
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
X-List-Received-Date: Fri, 19 Feb 2016 05:16:02 -0000

From: Michael Wood <michael.g.wood@intel.com>

Make sure the default orderby for the SoftwareRecipesTable is applied

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/toastergui/tables.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/toaster/toastergui/tables.py b/lib/toaster/toastergui/tables.py
index 86d111d..5a589d3 100644
--- a/lib/toaster/toastergui/tables.py
+++ b/lib/toaster/toastergui/tables.py
@@ -617,6 +617,7 @@ class SoftwareRecipesTable(RecipesTable):
         super(SoftwareRecipesTable, self).setup_queryset(*args, **kwargs)
 
         self.queryset = self.queryset.filter(is_image=False)
+        self.queryset = self.queryset.order_by(self.default_orderby)
 
 
     def setup_columns(self, *args, **kwargs):
-- 
1.9.1


