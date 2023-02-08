Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A70EC636D7
	for <webhook@archiver.kernel.org>; Wed,  8 Feb 2023 14:34:17 +0000 (UTC)
Received: from mail.kapsi.fi (mail.kapsi.fi [91.232.154.25])
 by mx.groups.io with SMTP id smtpd.web10.7705.1675861195003403027
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Feb 2023 04:59:55 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=none, err=permanent DNS error (domain: lakka.kapsi.fi, ip: 91.232.154.25, mailfrom: mcfrisk@lakka.kapsi.fi)
Received: from kapsi.fi ([2001:67c:1be8::11] helo=lakka.kapsi.fi)
	by mail.kapsi.fi with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mcfrisk@lakka.kapsi.fi>)
	id 1pPk39-007OLe-Dx; Wed, 08 Feb 2023 14:59:47 +0200
Received: from mcfrisk by lakka.kapsi.fi with local (Exim 4.94.2)
	(envelope-from <mcfrisk@lakka.kapsi.fi>)
	id 1pPk39-00GXt9-5W; Wed, 08 Feb 2023 14:59:47 +0200
From: "Mikko Rapeli" <mikko.rapeli@linaro.org>
To: bitbake-devel@lists.openembedded.org
Cc: "Schmidt, Adriaan" <adriaan.schmidt@siemens.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [PATCH v2][kirkstone 2/2] bitbake-diffsigs: break on first dependent task difference
Date: Wed,  8 Feb 2023 14:59:38 +0200
Message-Id: <20230208125938.3943013-2-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230208125938.3943013-1-mikko.rapeli@linaro.org>
References: <20230208125938.3943013-1-mikko.rapeli@linaro.org>
MIME-Version: 1.0
X-Rspam-Score: -1.2 (-)
X-Rspam-Report: Action: no action
 Symbol: RCVD_TLS_LAST(0.00)
 Symbol: ARC_NA(0.00)
 Symbol: DMARC_POLICY_SOFTFAIL(0.10)
 Symbol: FROM_HAS_DN(0.00)
 Symbol: RCPT_COUNT_THREE(0.00)
 Symbol: R_MISSING_CHARSET(0.50)
 Symbol: TO_MATCH_ENVRCPT_ALL(0.00)
 Symbol: MIME_GOOD(-0.10)
 Symbol: TO_DN_SOME(0.00)
 Symbol: MID_CONTAINS_FROM(1.00)
 Symbol: R_SPF_NA(0.00)
 Symbol: FORGED_SENDER(0.30)
 Symbol: R_DKIM_NA(0.00)
 Symbol: MIME_TRACE(0.00)
 Symbol: ASN(0.00)
 Symbol: FROM_NEQ_ENVFROM(0.00)
 Symbol: BAYES_HAM(-3.00)
 Symbol: RCVD_COUNT_TWO(0.00)
 Message-ID: 20230208125938.3943013-2-mikko.rapeli@linaro.org
X-SA-Exim-Connect-IP: 2001:67c:1be8::11
X-SA-Exim-Mail-From: mcfrisk@lakka.kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 08 Feb 2023 14:34:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14387

From: "Schmidt, Adriaan" <adriaan.schmidt@siemens.com>

compare_sigfiles() recursively calculates differences on all dependent
tasks with changed hashes. This is done in arbitrary/alphabetical order, and
only the last of those results is returned, while everything else is discarded.

This changes the behavior to instead return the first difference and not calculate
any more, which significantly speeds up diffs of tasks with many dependencies.

(Bitbake rev: ea6a676c9aa2864c2eff40eea41ba09ce903a651)

Signed-off-by: Adriaan Schmidt <adriaan.schmidt@siemens.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 bitbake/lib/bb/siggen.py | 1 +
 1 file changed, 1 insertion(+)

v2: correct list, removed "bitbake:" subject prefix

v1: sent to openembedded-core list

diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index 9a20fc8e5f..fa2915d164 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -1028,6 +1028,7 @@ def compare_sigfiles(a, b, recursecb=None, color=False, collapsed=False):
                             # If a dependent hash changed, might as well print the line above and then defer to the changes in
                             # that hash since in all likelyhood, they're the same changes this task also saw.
                             output = [output[-1]] + recout
+                            break
 
     a_taint = a_data.get('taint', None)
     b_taint = b_data.get('taint', None)
-- 
2.34.1


