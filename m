Return-Path: <yann.dirson@vates.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172FEEBFD2F
	for <webhook@archiver.kernel.org>; Mon, 13 Apr 2026 09:59:38 +0000 (UTC)
Received: from mail187-1.suw11.mandrillapp.com (mail187-1.suw11.mandrillapp.com [198.2.187.1])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.268918.1776074372649433262
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 13 Apr 2026 02:59:32 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: signature did not verify: crypto/rsa: verification error" header.i=@mandrillapp.com header.s=mte1 header.b=OAIHBHCb;
 dkim=fail reason="dkim: signature did not verify: crypto/rsa: verification error" header.i=yann.dirson@vates.tech header.s=mte1 header.b=pVJR/dxq;
 spf=pass (domain: bounce.vates.tech, ip: 198.2.187.1, mailfrom: bounce-md_30504962.69dcbe83.v1-ee302bc02eac441b884f69a4693c9262@bounce.vates.tech)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
	s=mte1; t=1776074371; x=1776344371;
	bh=M3RH0gI8jxTntjmZhDm9okkroS6lGh6elJlRfav6Xuk=;
	h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Feedback-ID:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
	 Subject:From;
	b=OAIHBHCb5O+icRIRmr6WQodk+oFkzoctWcmpWpJ1VA8bPkBPGc464cubJ3oO1pbXY
	 PqlW78F0T+/AebxS7efIZ9O4TYNHHEz2QdmeybojG5fGUiGQoqpLbQqaTPMdjgoQ/z
	 UVDzzYVU/PquQFDaLBzMUqkKcBLf/RnIKmIfTEFEhLE0xEnJEhmg4qz8MYfoe7orkl
	 vjCdPRmiiQ4Hct7/EYbRoYBVVgiN9eDwN+RVD7v0O8HCV1Luqt5XvAUvfqnlBMDikw
	 OiQb8OD2Q2okV2Q17SyNwl0b4B5sMGsjD25y2+XjWveBIf0nGufX3OA18hU+ehv/zx
	 s6eWcv6O40yYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
	t=1776074371; x=1776334871; i=yann.dirson@vates.tech;
	bh=M3RH0gI8jxTntjmZhDm9okkroS6lGh6elJlRfav6Xuk=;
	h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Feedback-ID:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
	 Subject:From;
	b=pVJR/dxqduhbMXB5IzuD4wLnCCWksdpnigdw9p75RQLQECadELr76LFEcL2/G0vFR
	 GtQfDKfrMM0w+ZrZ6QuIAAgcFjkF0yhuV9B+h3IBlyCqZjA6asHw36ewe9qngZ1jqn
	 X+q4Pl1KewrafkVz2VcfjyCEl5MkuTnvUjek6iOePcaHVm5CqZ/svqAN9q6HeSXQ4G
	 2jyil3ufYKTT0GM51bPtF4lb4kNgSzP7MQIoaLHiilbG36E5vwuk4FNINcVLCOddgk
	 q+ucHV8ufQUR/93zkzab5QbFutoKuTXSnBqOSTYCreIYv8M73E8wBuKmbQ2XJViBGP
	 IK35RpQ59JKbw==
Received: from pmta09.mandrill.prod.suw01.rsglab.com (localhost [127.0.0.1])
	by mail187-1.suw11.mandrillapp.com (Mailchimp) with ESMTP id 4fvNDM6BwBzBsTtBk
	for <bitbake-devel@lists.openembedded.org>; Mon, 13 Apr 2026 09:59:31 +0000 (GMT)
From: "Yann Dirson" <yann.dirson@vates.tech>
Subject: =?utf-8?Q?[PATCH=202/3]=20RunQueueData.prepare:=20fix=20comment=20typos?=
Received: from [37.26.189.201] by mandrillapp.com id ee302bc02eac441b884f69a4693c9262; Mon, 13 Apr 2026 09:59:31 +0000
X-Mailer: git-send-email 2.47.3
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1776074371308
To: bitbake-devel@lists.openembedded.org
Cc: "Yann Dirson" <yann.dirson@vates.tech>
Message-Id: <20260413095918.20804-2-yann.dirson@vates.tech>
In-Reply-To: <20260413095918.20804-1-yann.dirson@vates.tech>
References: <20260413095918.20804-1-yann.dirson@vates.tech>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,=20including=20all=20headers,=20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.ee302bc02eac441b884f69a4693c9262?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20260413:md
Date: Mon, 13 Apr 2026 09:59:31 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 13 Apr 2026 09:59:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19361

Signed-off-by: Yann Dirson <yann.dirson@vates.tech>
---
 lib/bb/runqueue.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index a880a0d54..8aae4e290 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -693,7 +693,7 @@ class RunQueueData:
         # To create the actual list of tasks to execute we fix the list of
         # providers and then resolve the dependencies into task IDs. This
         # process is repeated for each type of dependency (tdepends, deptask,
-        # rdeptast, recrdeptask, idepends).
+        # rdeptask, recrdeptask, idepends).
 
         def add_build_dependencies(depids, tasknames, depends, mc):
             for depname in depids:
@@ -841,7 +841,7 @@ class RunQueueData:
         # (makes sure sometask runs after someothertask of all DEPENDS, RDEPENDS and intertask dependencies, recursively)
         # We need to do this separately since we need all of runtaskentries[*].depends to be complete before this is processed
 
-        # Generating/interating recursive lists of dependencies is painful and potentially slow
+        # Generating/iterating recursive lists of dependencies is painful and potentially slow
         # Precompute recursive task dependencies here by:
         #     a) create a temp list of reverse dependencies (revdeps)
         #     b) walk up the ends of the chains (when a given task no longer has dependencies i.e. len(deps) == 0)
-- 
2.47.3



--
Yann Dirson | Vates Platform Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech


