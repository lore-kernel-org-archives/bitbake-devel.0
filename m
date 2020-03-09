Return-Path: <jpewhacker@gmail.com>
Received: from mail-il1-f195.google.com (mail-il1-f195.google.com
	[209.85.166.195])
	by mail.openembedded.org (Postfix) with ESMTP id 34B0461B57
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Mar 2020 16:33:57 +0000 (UTC)
Received: by mail-il1-f195.google.com with SMTP id a14so6130993ilk.6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Mar 2020 09:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=qX0SoE7oLyxviYRLg/FYJszxmE4e5oEJF9Fyzs1pyoE=;
	b=Xs0/61LILJVZAzLDYTnbxbINyLtrrDxH2f9SqzptjTWNywfiB7Gqnu5ZJ7ipLwp+mD
	QyIVleEG4B2XZjQufurlJe/rsvSLQLg2EHA5PRkZc/ajxnfmEEIkG9+0dgdCyQ8IWIZn
	2v76zFdP8Ab3wUVGNvyKI4Li2UDnFOh5yBtv6fjnI8xLKml2cnatVraLU2Oc57x5GtYI
	9QM/56USeYgRMWfKsGLJ9KG0cHIPdog1Q2LskuikIkhvW2ou6Jw7kEPfCVVZ3a5mgMbW
	M1nCw+Mi1zePSZus633T9VXb1BEd6dI3bowUFNFnXW5gHY6VpGO0tenmvZqbjC7HciEs
	BDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=qX0SoE7oLyxviYRLg/FYJszxmE4e5oEJF9Fyzs1pyoE=;
	b=MeXVOvhNm60j1wD20K8mureB7/e6WoCZ3wgtah7BiLufYGH4g++uF1U5Z7gaPcszVS
	iaQEx2CGVP12S5IlDI3Rc1+RXG1Pti30sP4LKFB3YPvcO5BU4mkiOHNnavr36RygatYf
	YKs8gy95FNBMygjCWBFyRQlZY8BQdarTJBSRi3FlnHMzHks+B7m1AzTasTScZRBtNLdz
	l1JwhwOfDej5m/VqnfMNK3F2IL7WWhiEC3IfpszoUnOlcao1cC107w+cdFbw7xwM68v/
	+GC6h6ub3/Agd/UYS1UHj2zYUi5TWLXpoCe2qwJHiL0XXAEgFaUfJhWfKVzoVwE7fmvq
	WPJg==
X-Gm-Message-State: ANhLgQ0OZpPFVi+TcVD4fTgjcdhXV9ousq5u8/kMavs7AsPC7TsG+Vhb
	BXFP+rks7IfgvjfrhKzEbPmqiliZOaY=
X-Google-Smtp-Source: ADFU+vuv1Hw10fQRA8Li3lHsHc/q3ySxA6wQByobJhwq0NCAPXczpINrjygKzZIG+AAlewCe7pKXwA==
X-Received: by 2002:a92:7742:: with SMTP id s63mr15674002ilc.184.1583771638902;
	Mon, 09 Mar 2020 09:33:58 -0700 (PDT)
Received: from OLA-8C37N23.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	q1sm15049593ile.71.2020.03.09.09.33.58
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 09 Mar 2020 09:33:58 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Mar 2020 11:33:40 -0500
Message-Id: <20200309163353.15362-3-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309163353.15362-1-JPEWhacker@gmail.com>
References: <20200309163353.15362-1-JPEWhacker@gmail.com>
Cc: docs@lists.yoctoproject.org
Subject: [PATCH 02/15] bitbake: knotty: Handle logging messages with specific logger
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
X-List-Received-Date: Mon, 09 Mar 2020 16:33:58 -0000

Handles the log messages from the bitbake server with the specific
logger that the event originated from. This allows hierarchical logging
configurations to work as expected.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/ui/knotty.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index cbb289b05f..a6a92b920f 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -522,7 +522,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                         event.msg = taskinfo['title'] + ': ' + event.msg
                 if hasattr(event, 'fn'):
                     event.msg = event.fn + ': ' + event.msg
-                logger.handle(event)
+                logging.getLogger(event.name).handle(event)
                 continue
 
             if isinstance(event, bb.build.TaskFailedSilent):
-- 
2.17.1


