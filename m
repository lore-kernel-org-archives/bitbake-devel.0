Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F972C36014
	for <webhook@archiver.kernel.org>; Fri,  4 Apr 2025 15:18:04 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web10.14116.1743779883609191812
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 04 Apr 2025 08:18:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=YoAA0Sjt;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DF9E04433D;
	Fri,  4 Apr 2025 15:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1743779881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4l3CI32ArpiLz/OYHSSuhs7A7eEYv9CoiV8htl/CL88=;
	b=YoAA0Sjtynr7/32mMbiSyogf309cShLY0lvCoRYvzVijaR/BaafzfKl982vapwvWLKJvao
	Q9YxDa18fMxTCNAza8ZUlAs82+f0jLNs8GOqFPFTIeIwLpKkdhPT1V3XCqADbGKFkfGyUh
	77RAPGfbkdtgDU15/5P7b0U1skDf/d+xq4noYRKLHKmlwZrPnQPFqKiaQVf7nkGM6DkU7Y
	8fEWkkZFSxecJEBiobS2ySuVoXdOqhVkVSNZXENNFThZbCEw/TN10l7PJTgtLyQKF96V0y
	KWAepev4qUrGxE8Tfv946HWWt3gI11FSC62UgrhWA+BUqERKbvLZ6WG8Bms1hA==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 04 Apr 2025 17:17:56 +0200
Subject: [PATCH] doc/bitbake-user-manual-metadata.rst: fix python task
 example
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250404-fix-python-task-example-v1-1-65f831cda2cd@bootlin.com>
X-B4-Tracking: v=1; b=H4sIACP472cC/x2MQQqAIBAAvxJ7bsFMIfpKdJDacqlMNMII/550H
 JiZFyIFpgh99UKgmyOfrkBTVzBZ41ZCnguDFFILJRQunNA/lz0dXiZuSMkcfiecqdWi01pNUkK
 pfaCi/udhzPkDr3qMUWkAAAA=
X-Change-ID: 20250404-fix-python-task-example-de3508554c22
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, 
 Robert Berger <pokylinux@reliableembeddedsystems.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1283;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=OVt9Zq6KWrdycRLY+jJiWpofy1Lk0jSfIZPiV9iAkPs=;
 b=owEBbQKS/ZANAwAIAdGAQUApo6g2AcsmYgBn7/goieWGO+uc4tAEAcSfQPlv2U0/4MLkRyKuM
 9DRNNidFjOJAjMEAAEIAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCZ+/4KAAKCRDRgEFAKaOo
 NkhWEAC+OXtthkbMZKzgytADcvO+SL+3kBVxCnYiLcKkQnqYkQLRI4lbq4zclE1cdUDcgvBD2rM
 lGERla4saFxB+VANvHzUQIogG2sjbLke9bB0g+iFe0FnXMROUUybcEIMWN0ugfXIDpyR2hcsMHh
 VBw1ZFDim++2R6HDpEXBiXXCzTFAZV84uayixB8iFh44/S1C+jrYr+zI24V4cavn+0FNyZ0eq3K
 5FbeggR5J9T5rfWLytIdxwo/2ZmPlxQLD6g9nCSKIHTTK3HXQvYkBkfACkmaxoiEZBPnwQDSA5e
 H4PPFJFCS1c2Tnmz3pKo4yU+cbDiHjKB8b6jZFCksBm9F/0+ZZmWJm52ld7e5jFdPi+e1si+PFp
 NlqNxYH7e9wlPJem6YtmKlvIV8djqXz1fiV8R336dEY9HUnNp2SL3Opq8PkL+uUrMlvZm0bqGiY
 ERll9SlatxbFhBuONOEA0ji83/8X36dqMWzUjD3OX878DOqcw+Dvlyy+bt+4dqjbNAilTD8r/lP
 QudeBvRRoeoPdB+lJzXMRlze1RNJUGJHXpnz7hObh340JvFjdf+TecjN8TBxJnowKs+yor3xtg0
 aZo9B3o/cIRdMEJAH7RnzsF0f0/4LqhS4+TvnnxVRkV1G6mBNo9e/mpf88hhCj1Ul32QodTkc7s
 HMekhbIOYG/yqaA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduledujeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkvfevofesthejredtredtjeenucfhrhhomheptehnthhonhhinhcuifhouggrrhguuceorghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeduieejledtieeuteffveetleeuffeivdffjefgteehgfehleeiteehieeuieekueenucfkphepvdgrtddvmeekgedvleemkedujegrmeegtddtudemtgdtsggvmeguheekrgemgedvledtmeelvggrjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemkeegvdelmeekudejrgemgedttddumegttdgsvgemugehkegrmeegvdeltdemlegvrgejpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohephedprhgtphhtthhopeguohgtsheslhhishhtshdrhihotghtohhprhhojhgvtghtrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepphhokhihlhhinhhugiesrhgvlhhirggsl
 hgvvghmsggvugguvggushihshhtvghmshdrtghomhdprhgtphhtthhopegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdprhgtphhtthhopegsihhtsggrkhgvqdguvghvvghlsehlihhsthhsrdhophgvnhgvmhgsvgguuggvugdrohhrgh
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 04 Apr 2025 15:18:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17517

Fix the old Python 2 print statement, replace it by a bb.plain() call
instead. Also replace time by datetime for a slightly simpler example.

[YOCTO #14670]

Reported-by: Robert Berger <pokylinux@reliableembeddedsystems.com>
Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 415fbf6d6..db1749178 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -1405,8 +1405,8 @@ the task and other tasks. Here is an example that shows how to define a
 task and declare some dependencies::
 
    python do_printdate () {
-       import time
-       print time.strftime('%Y%m%d', time.gmtime())
+       import datetime
+       bb.plain('Date: %s' % (datetime.date.today()))
    }
    addtask printdate after do_fetch before do_build
 

---
base-commit: 136c06e251de68ed64355ec6b47a522ff3a372e3
change-id: 20250404-fix-python-task-example-de3508554c22

Best regards,
-- 
Antonin Godard <antonin.godard@bootlin.com>


