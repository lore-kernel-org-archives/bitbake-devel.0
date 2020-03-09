Return-Path: <jpewhacker@gmail.com>
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com
	[209.85.166.172])
	by mail.openembedded.org (Postfix) with ESMTP id DB3AC61B61
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Mar 2020 16:34:00 +0000 (UTC)
Received: by mail-il1-f172.google.com with SMTP id p1so5244123ils.12
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Mar 2020 09:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=IUQaYnM7cZ5ZotvAiDXpdTlR0FVB7RzAZvDyS1M6mUU=;
	b=roTZoxZ9AJaXdnoexwuZtNBAE4OiRSrKQTh+5lFjT8unp1DYSQeQSE4aZ+2doT8PuX
	TzWd607g8rjgG3oz7+vhgwchSPdhtQqZv6HegGG/I5m4qBekHv64vkoj71X3Ate1ZhTN
	JiGOSaK/iGoU2FEdr3byjiMcBuohQG51KPTkFIV2RS/Y/YgpR0HK83BTUoqdMrbfOkgJ
	tcY5oRK1f8yYwU81ZXlVn/2bFEj00/VszsSX/CxPPr5koKFnyhoTJWYZshJWPQpyJfmj
	6y7Xj1HSaqL2WYzlyxx8huC7Lv2F8mtmKxmuO5tlZvWf78lLrBU6AslU+ANykl78W3wX
	4feQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=IUQaYnM7cZ5ZotvAiDXpdTlR0FVB7RzAZvDyS1M6mUU=;
	b=MVGzhAzFVJNbAulNr3V6Lm4WJhLQ5r6m1xATY3feSl3tT7CP+L29StZ6yZlg3kebRt
	Uj+9VPoMx+K+trpxG2Tpi17gN+wxQn9pSkk5hwLUseTKD/qqQojTZSQHHJEGH0st2lfb
	Vv+D+/zZj0Ix5LU4Qtmt0Px7po+36Wk6Wz6hQ4NoEygNH3/3brAXnGklseYLYAW1iOyy
	6dHRgyr0+RyDBxuzq0cVSGke0EptLomyBVshdix4CU/2+aLuNtaVwzesTcenlKwXUGwQ
	XaYzvf4s+sgtUrzDpJ/hBVzvKpSU/D6wiqvZWOCgJ23v42reKXSfwxuh3YMr0vdN4Mcj
	PulQ==
X-Gm-Message-State: ANhLgQ0hPecL3yEnvFN4cGIRaOFfqJaidfvuJyfMMcDD1rzaTgSTONgK
	n/08UBJlwDDfgBcnCWfR409tvzKHjsU=
X-Google-Smtp-Source: ADFU+vsDmo1MBWn3Lmf/iO3hw7Ke2VF3nlCe4JrM95JWBy9SkROCbeU/hTUhHGfwmeAEJI1I9suj5A==
X-Received: by 2002:a92:8151:: with SMTP id e78mr10137402ild.227.1583771641811;
	Mon, 09 Mar 2020 09:34:01 -0700 (PDT)
Received: from OLA-8C37N23.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	q1sm15049593ile.71.2020.03.09.09.34.00
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 09 Mar 2020 09:34:01 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Mar 2020 11:33:43 -0500
Message-Id: <20200309163353.15362-6-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309163353.15362-1-JPEWhacker@gmail.com>
References: <20200309163353.15362-1-JPEWhacker@gmail.com>
Cc: docs@lists.yoctoproject.org
Subject: [PATCH 05/15] bitbake: knotty: Add commented logging_tree code
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
X-List-Received-Date: Mon, 09 Mar 2020 16:34:02 -0000

Adds a comment section that can be easily uncommented to enable dumping
the logging tree. This module is extremely useful for debugging issued
with logging configuration

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/ui/knotty.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index a6a92b920f..aac12cd479 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -430,6 +430,11 @@ def main(server, eventHandler, params, tf = TerminalFilter):
     llevel, debug_domains = bb.msg.constructLogOptions()
     server.runCommand(["setEventMask", server.getEventHandle(), llevel, debug_domains, _evt_list])
 
+    # The logging_tree module is *extremely* helpful in debugging logging
+    # domains. Uncomment here to dump the logging tree when bitbake starts
+    #import logging_tree
+    #logging_tree.printout()
+
     universe = False
     if not params.observe_only:
         params.updateFromServer(server)
-- 
2.17.1


