Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93663C02199
	for <webhook@archiver.kernel.org>; Fri,  7 Feb 2025 15:28:33 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
 by mx.groups.io with SMTP id smtpd.web10.72002.1738942111826659646
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Feb 2025 07:28:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=jrQLSEaY;
 spf=pass (domain: bootlin.com, ip: 217.70.183.195, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0586C204CC;
	Fri,  7 Feb 2025 15:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738942110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=j1/qlujQTXJ4PqKdzOkRa7Hv0qmS7rAJ9LpidVcxYDY=;
	b=jrQLSEaYbiEdESvJrIRQdljH4xQ6YzkD9uVLx2/g4aWzPXpD3/G7tWmlEzylaHLZjocOt5
	iipKNFByvW9bsIcv6oRm9IvIxbk5dgzVQe+3hiVoBPC8Dw5FtmrWuh/iN+sWsxIba8CmYD
	cTxtUCrhNM4hpFwR3B6ejYgNEFcwQd7DR4rEq05KYqMFwh1QipEghXNysPSmKx+M7Kjl1/
	nBk2v7BLT1tp6g3UWj6RwycTFKInEHbw/+qzMjSZrFibO5o8tquLan4CKaenJyNDtgSOcP
	EbuPzzQDdKc0fhktjtMrHrazPLy3ahdLV+ImY48tUdn80/MV8iLza72Gq5fK4Q==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 07 Feb 2025 16:28:26 +0100
Subject: [PATCH] doc: bitbake-user-manual-ref-variables: document
 BB_CURRENT_MC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-doc-bbcurrentmc-v1-1-a95c50bf350a@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAJkmpmcC/x3MQQqAIBBG4avErBNUCqGrRIvSv5pFGmNFEN09a
 fkt3nsoQxiZuuohwcWZUywwdUV+HeMCxaGYrLatttqpkLyaJn+KIB6bV4BzBk1rXdBUql0w8/0
 f++F9P8vSL99hAAAA
X-Change-ID: 20250207-doc-bbcurrentmc-ee771e4527d0
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1398;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=Z7sVlstnjlMLLQ2hFzW5JawLg8NrZm2xBOMKHIyeCmA=;
 b=owEBbQKS/ZANAwAIAdGAQUApo6g2AcsmYgBnpiadVz7+WauEwEzTOOlMjxvd6NGMX/hN/d/7t
 lDjruZ6ZEeJAjMEAAEIAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCZ6YmnQAKCRDRgEFAKaOo
 NlMtD/9A06b+BPTfMFkdOf7tp5dFo29VqzZ7MNjLjweQSXJVMIOtLiEVUn7PNyiCudurwUwbJb1
 8w2dNwHZRHrY6+rObrmcIRg/7hWvFGz+1ejTg8V5W8Q0m44oZ5emT9oEbO+5kCNDkCPY1ood1FU
 7gjeU4JmLQAysEhQ43kYZFxLQE07t0J0HAG5B7MlAZG1YfMD8/CqiYd/tyKeIJZ/ihIkppTalKW
 O1eEF++M9bANLPWeyqVXgFffs12D9py07/MYVON+cinmaFC2/qrKsAXFV4G99VOc/tdKYonmjTP
 LChywKdgguVRmWYygwjtRP1GWjop+96Xd/sopQcBYX1jbvXpUEPEz21/fbtWPXPIh8bkiupXSPF
 cwOBFMQpDZBelyjswUZmu5pJhbJbRlnSPR4oxMzYqiRXtGQV5H7tQNA0CB3bCryRUHf22/3P4HD
 qs9DvnaP+wl6ydq0vqTOm3DffiU/bwOIfeHiyqrB4/R5LfIYXlCQaV7774WpijyCGO4wVF0Rdf9
 pfXiIf55pTLMTQS014b61CbEPCBLvD5pEn/W55wcr0VwZm1biUfAbu2DRlXpzjrBTzpiV9VsqYi
 nr5SUt4/sgGkpaRJq1/xdfzlNeVTfn/kRT0xEhRE6g61vCeGd1Z0i9iHDESC0OxNUfKfPwOnke2
 8xRyUdsgxjl6jHg==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleeigecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpeetnhhtohhnihhnucfiohgurghrugcuoegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepudeijeeltdeiueetffevteelueffiedvffejgfethefgheelieetheeiueeikeeunecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemjegthegtmeeirgguvgemjeelgeekmeegtdehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemjegthegtmeeirgguvgemjeelgeekmeegtdehledphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomheprghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeegpdhrtghpthhtohepsghithgsrghkvgdquggvvhgvlheslhhishhtshdrohhpvghnvghmsggvugguvggurdhorhhgpdhrtghpthhtohepughotghssehlihhsthhsrdihohgtthhophhrohhjvggtthdrohhrghdprhgtphhtthhopegrnhhtohhnihhnrdhgohgur
 ghrugessghoohhtlhhinhdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomh
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Feb 2025 15:28:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17185

Document the BB_CURRENT_MC variable, which holds the name of the current
multiconfig build a task is being run under.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index ad219b531..858de6347 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -127,6 +127,11 @@ overview of their function and contents.
       Contains the name of the currently running task. The name does not
       include the ``do_`` prefix.
 
+   :term:`BB_CURRENT_MC`
+      Contains the name of the current multiconfig a task is being run under.
+      The name is taken from the multiconfig configuration file (a file
+      ``mc1.conf`` would make this variable equal to ``mc1``).
+
    :term:`BB_DEFAULT_TASK`
       The default task to use when none is specified (e.g. with the ``-c``
       command line option). The task name specified should not include the

---
base-commit: 8843860010c97cc10ff69205d209634639b6c5cd
change-id: 20250207-doc-bbcurrentmc-ee771e4527d0

Best regards,
-- 
Antonin Godard <antonin.godard@bootlin.com>


