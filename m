Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE15105F7B4
	for <webhook@archiver.kernel.org>; Fri, 13 Mar 2026 15:12:45 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18142.1773414758114954124
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 13 Mar 2026 08:12:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=iyXLeXef;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id DA39DC4270D
	for <bitbake-devel@lists.openembedded.org>; Fri, 13 Mar 2026 15:12:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8E3FC60027;
	Fri, 13 Mar 2026 15:12:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EBBAC10369F34;
	Fri, 13 Mar 2026 16:12:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773414755; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=HynfMeDCyNu7etmsZAGBg//F5kb1JSGQyZ92ZmsBhoo=;
	b=iyXLeXef379H6L4uZamcFDzy5PdX0Y6GDV130xfjdrnyWuMEiLYMPzB5S0TmEHTN/FwgXU
	z3ZkxF/2iEx1QVg1UYGbG/vkZUIxJPP4z8OJMEWzFOJA2DpHaogZvucCoC3aXLT6Fn7A+Z
	DNVkrxFak8V8P5bnYdl+3tcDVqWQjOb75yU9jtCd15T/90H4x2JfhsCFKixbBXGav7TZPF
	L0Y3HhvPk2ZC+SSTiGjjqoW4tVJJPthZ08I1S0IjCNY9s/RB4s/fG65gnAa++Q9tqZG1pm
	Q5TJ+23RA9H4yr3zZJrkJoF16f01QHiBaYJHDK0G9plsnUDfByyTpb6tHKRa7A==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Fri, 13 Mar 2026 16:12:12 +0100
Subject: [PATCH] taskexp_ncurses: update tests for new spdx tasks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-mathieu-taskexp-spdx-fix-v1-1-9b149e680330@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAEsptGkC/x2MwQqDMBAFf0X23IUYtVB/RXoI5tkspTZkVQLBf
 zd4nIGZQookUBqbQgmHqPzXCu2joTm49QMWX5mssU/TtR3/3BYEO29Ov8iRNfrMi2QGBgfjX+j
 tQDWPCVXf6+l9nhf1QvNSagAAAA==
X-Change-ID: 20260313-mathieu-taskexp-spdx-fix-ee5ae0d9e425
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <jpewhacker@gmail.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773414753; l=1430;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=Bksie+8Bp0QKHWOVXHXEHAO4MzX/EI5RDMlxkiDOPlE=;
 b=7JuSi5Urfy/70JiDhwxqLCAE/d3Y3HPihueeFR3ia2wqTuWW1HXFhEpszRPY07yesnOjPt52o
 zHyJtx9ABbVDo0Q/6q4xkC8NBOpPNN3SKFfDGP9qSyVNswolLWfjGYx
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 13 Mar 2026 15:12:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19155

Some new tasks have been added to handled SPDX 3.0 [1], changing a bit
the test output: some small changes are needed to account for these
changes.

[1]: https://lore.kernel.org/all/20260220154123.376880-1-JPEWhacker@gmail.com/

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
Fix the extra bitbake tests, such as [1]. We need to wait until the
Joshua SPDX series is merged before merging this.

[1]: https://autobuilder.yoctoproject.org/valkyrie/#/builders/35/builds/3388/steps/22/logs/stdio
---
 lib/bb/ui/taskexp_ncurses.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/ui/taskexp_ncurses.py b/lib/bb/ui/taskexp_ncurses.py
index ea94a4987f97..551ad142a2a7 100755
--- a/lib/bb/ui/taskexp_ncurses.py
+++ b/lib/bb/ui/taskexp_ncurses.py
@@ -146,6 +146,9 @@ def debug_frame(nbox_ojb):
 unit_test = os.environ.get('TASK_EXP_UNIT_TEST')
 unit_test_cmnds=[
     '# Default selected task in primary box',
+    'tst_selected=<TASK>.do_create_recipe_spdx',
+    '# Move to next entry, more predictable',
+    'tst_entry=<DOWN>',  # optional injected error
     'tst_selected=<TASK>.do_recipe_qa',
     '# Default selected task in deps',
     'tst_entry=<TAB>',

---
base-commit: b59bdcf8134e6f5935e8f7b0ed8033cbb745e0ff
change-id: 20260313-mathieu-taskexp-spdx-fix-ee5ae0d9e425

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


