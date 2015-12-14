Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
	by mail.openembedded.org (Postfix) with ESMTP id 275D060796
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 14 Dec 2015 22:51:03 +0000 (UTC)
Received: by mail-wm0-f52.google.com with SMTP id p66so85027638wmp.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 14 Dec 2015 14:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=jgBgHKFwJgOLrRm3QkL+JPWFbFCqjqvi58oEgryTYPE=;
	b=Q62sINBWC0+ymlJ9WFY7/vkN+SKNSXdJAOMWcd1emHPiaJP2owaWlD2MVtYsCRIpqc
	q7NBBq8ltDvgEyFCz5uhfryWjimgJXQhEKHb5qcuVPej7Jdnw3IlxJFi8nnED0Spux15
	o6xUNlw3plD8e8NatSgjiVSzUuj1JQKeOSB2MYPUpNsUhsGF9WEZm/OZwpOyNW4YgCFb
	aWhvK+ERNRghsuYKCExEarwFgq1x3SO+++G0zHA7z0gi3oKSkD6aIhzxWWq28yOg/ypo
	lJg9O/qAeTXN2Cl6uQB8YA1yrneKPIrTFtL7C97iBED8FbFYN06SDMTigyOuUMjL2xVB
	Q+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=jgBgHKFwJgOLrRm3QkL+JPWFbFCqjqvi58oEgryTYPE=;
	b=eYdRTtnC5mj2tJCCJFgYhbdg8ej0Ll2zB5qe4g1eoV3sXpV7n6kmBqJJ25dmamXh+3
	2FQd/tdfd2jnYeTqbzMTX9r58CLTYSE0fBqNztqJCNEQ4SSPel3elqGZRPhX7Av/u0Y0
	qYlWSE99WnYEJy5/qMWVqbBYXYnVCoqjDVXwuClkKRxZ9z/zON4jixhTkYck3Nhn3CrU
	PuhkYbpPDRPm3RbcM0WdqsVWlrLGDjx4wLCAITs0y2CZiz7LhpdpB2KiaEDnwzuzKPge
	lTE78RzY3X9WYXyFurkph5pQ0jZvknoaqgoY68ovaZENMvYH77SJR72f3Ro4MYWs2Ybw
	Mm2A==
X-Gm-Message-State: ALoCoQlrmNJfQdlixkv+a+Wsftg0F2tx+NxYnby5HZW3FUyn+WB5pnLkf9lnRGbBOrrYk486GX5w0/hELXBtfH9li24uII5Kog==
X-Received: by 10.195.18.6 with SMTP id gi6mr43719260wjd.83.1450133464340;
	Mon, 14 Dec 2015 14:51:04 -0800 (PST)
Received: from localhost.localdomain ([90.217.53.67])
	by smtp.gmail.com with ESMTPSA id x125sm46697wmg.1.2015.12.14.14.51.02
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 14 Dec 2015 14:51:03 -0800 (PST)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 14 Dec 2015 22:50:47 +0000
Message-Id: <1450133447-9946-1-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.5.0
Subject: [PATCH] toaster: tables Set a default order for the software recipes table
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
X-List-Received-Date: Mon, 14 Dec 2015 22:51:05 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

Add default order by recipe name, so that the table content is sorted
when the page loads.

[YOCTO #8791]

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/tables.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/toaster/toastergui/tables.py b/lib/toaster/toastergui/tables.py
index 74af507..3808820 100644
--- a/lib/toaster/toastergui/tables.py
+++ b/lib/toaster/toastergui/tables.py
@@ -561,6 +561,7 @@ class SoftwareRecipesTable(RecipesTable):
     def __init__(self, *args, **kwargs):
         super(SoftwareRecipesTable, self).__init__(*args, **kwargs)
         self.title = "Compatible software recipes"
+        self.default_orderby = "name"
 
     def setup_queryset(self, *args, **kwargs):
         super(SoftwareRecipesTable, self).setup_queryset(*args, **kwargs)
-- 
2.5.0


