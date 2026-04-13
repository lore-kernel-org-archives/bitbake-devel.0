Return-Path: <yann.dirson@vates.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2295BEBFD34
	for <webhook@archiver.kernel.org>; Mon, 13 Apr 2026 09:59:38 +0000 (UTC)
Received: from mail187-1.suw11.mandrillapp.com (mail187-1.suw11.mandrillapp.com [198.2.187.1])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.268916.1776074371553289987
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 13 Apr 2026 02:59:31 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: signature did not verify: crypto/rsa: verification error" header.i=@mandrillapp.com header.s=mte1 header.b=ZtqY8WWh;
 dkim=fail reason="dkim: signature did not verify: crypto/rsa: verification error" header.i=yann.dirson@vates.tech header.s=mte1 header.b=Z5W08k43;
 spf=pass (domain: bounce.vates.tech, ip: 198.2.187.1, mailfrom: bounce-md_30504962.69dcbe82.v1-3c701c003f224735bc6b3ed7e0b64fd9@bounce.vates.tech)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
	s=mte1; t=1776074370; x=1776344370;
	bh=WgT/8LtdsoczLYF6Vsk4gzocCeFjLKxByV4hqSjR+Jo=;
	h=From:Subject:To:Cc:Message-Id:Feedback-ID:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:CC:Date:Subject:From;
	b=ZtqY8WWh5sTv0leroMxfzDacRvB8Y1/w/oJFhGRCBaAKwLyLyF05VUuY3hJcLQHQy
	 2WwXrmZ0DXSLFoanvUkrA/L9nV8Ot2x9rQ5t0JML1Qk8JeSKLEm6rjepaGSOA+W3FZ
	 Utzb0QAo2pm/UzZ9pvN6ZDFJ2aEZlbJfc886MLyoDUyEEH4olQETolGI3xEKIDUsiU
	 ZqDY7LMNiykshLvysJv58cFsf2KRrS20urvsTs+IWl2GFSyr6XSIwL8Gnu7k1Hzctg
	 NFBPWa9a+AktP1ltGDBk2e4UniEV8bTiOn+kf7E3o706tq415dHeKcDXYCVADG2oGl
	 VCEFhZRxbm/Vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
	t=1776074370; x=1776334870; i=yann.dirson@vates.tech;
	bh=WgT/8LtdsoczLYF6Vsk4gzocCeFjLKxByV4hqSjR+Jo=;
	h=From:Subject:To:Cc:Message-Id:Feedback-ID:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:CC:Date:Subject:From;
	b=Z5W08k43kdrZN6AUfp9EvctA3Ib4yhKqXhctH3KnIHKRs/KlnD1ohndtiEWZkgKcw
	 wxHs4b5K6rXCHfhuZ0nGwDVea22goDtBtqhyYLrMqQy9n35yM5kkOzUGhmDeE+QOrT
	 KpA+RWxb+41nNDfuQlAWdKHQGK7hRpyqhZ2xSVxWL3O3WNUqLOtADhp40guFkMDY/+
	 Z2RKEaLThhCj2lAeGJfArbFiTTJpfbQ/hqDmz+rdT21/nEZ5zI4b0r7QuCQpXq8KLW
	 wjjjY8u27YYJB6rsYT2jozLSGHNf+VKNX6gJd2itkuIZ8dxWJUJ53C6C9P4iFchdV1
	 bvpr7cP+GZhPQ==
Received: from pmta09.mandrill.prod.suw01.rsglab.com (localhost [127.0.0.1])
	by mail187-1.suw11.mandrillapp.com (Mailchimp) with ESMTP id 4fvNDL1wZczBsTtBk
	for <bitbake-devel@lists.openembedded.org>; Mon, 13 Apr 2026 09:59:30 +0000 (GMT)
From: "Yann Dirson" <yann.dirson@vates.tech>
Subject: =?utf-8?Q?[PATCH=201/3]=20add=5Ftasks:=20use=20sets=20to=20dedup=20from=20debug=20output?=
Received: from [37.26.189.201] by mandrillapp.com id 3c701c003f224735bc6b3ed7e0b64fd9; Mon, 13 Apr 2026 09:59:30 +0000
X-Mailer: git-send-email 2.47.3
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1776074369653
To: bitbake-devel@lists.openembedded.org
Cc: "Yann Dirson" <yann.dirson@vates.tech>
Message-Id: <20260413095918.20804-1-yann.dirson@vates.tech>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,=20including=20all=20headers,=20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.3c701c003f224735bc6b3ed7e0b64fd9?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20260413:md
Date: Mon, 13 Apr 2026 09:59:30 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 13 Apr 2026 09:59:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19360

When packages appear multiple times it gets hard to make any sense of
the list display.  Using sets does the job for us.

Signed-off-by: Yann Dirson <yann.dirson@vates.tech>
---
 lib/bb/taskdata.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/bb/taskdata.py b/lib/bb/taskdata.py
index 66545a65a..b40afc02b 100644
--- a/lib/bb/taskdata.py
+++ b/lib/bb/taskdata.py
@@ -138,15 +138,15 @@ class TaskData:
             rdependids = set()
             rdepends = dataCache.rundeps[fn]
             rrecs = dataCache.runrecs[fn]
-            rdependlist = []
-            rreclist = []
+            rdependlist = set()
+            rreclist = set()
             for package in rdepends:
                 for rdepend in rdepends[package]:
-                    rdependlist.append(rdepend)
+                    rdependlist.add(rdepend)
                     rdependids.add(rdepend)
             for package in rrecs:
                 for rdepend in rrecs[package]:
-                    rreclist.append(rdepend)
+                    rreclist.add(rdepend)
                     rdependids.add(rdepend)
             if rdependlist:
                 logger.debug2("Added runtime dependencies %s for %s", str(rdependlist), fn)
-- 
2.47.3



--
 | Vates

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech


