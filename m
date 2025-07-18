Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9B9C83F3E
	for <webhook@archiver.kernel.org>; Fri, 18 Jul 2025 09:07:11 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web11.16686.1752829630211978599
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 18 Jul 2025 02:07:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=VCo1jbbk;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D2EF041C7D;
	Fri, 18 Jul 2025 09:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752829627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rsgwItgFi7ZIIC3NVL4FYEo+FlpmG21ciES2PyHWoUk=;
	b=VCo1jbbk9yDn9wKV8P4nYOv0NDdrfNbR7ZeWVXqCgzkieUbH0N3Uwqvjw/7NxVNCWUjvJA
	3BWO8fDxBS3dOoCMQ0EJ/tV9INiXBpOiZ7xVcwNov428hOb+4Gjp8GnF6stFSKku0qON23
	zdHMB/BHp9QofOUB0RfU3Yq1G/WoG2OLC01iPp+3FNvq3bLPi3FK6ngXcn2U3oyaOXpG8b
	f8Lg6s2z6+VA7wbRPEErpRZv0xB4CQC4+dwZIXaBWi2hX9PITdZI/NniUjTHmiesCaKYWw
	8YldKNxv4IQcqtVtQ95lVl73XKobrEYjjhc42E5pjs60vGm7uJ1r+VPMytB9aA==
From: Antonin Godard <antonin.godard@bootlin.com>
Subject: [PATCH v2 0/2] Update the Git fetcher tag and rev descriptions
Date: Fri, 18 Jul 2025 11:06:56 +0200
Message-Id: <20250718-new-tag-git-fetcher-v2-0-11240d481a05@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALAOemgC/32NQQ6CMBBFr0Jm7Zh2UCquvIdhAXWASbQ1bYMa0
 rtbOYDL95L//gqRg3CEc7VC4EWieFeAdhXYuXcTo9wKAyk6KqMNOn5h6iecJOHIyc4csKGToZp
 GqwYNZfkMPMp7q167wrPE5MNnO1n0z/7vLRo1GsOHpqVWq3q4DN6nu7i99Q/ocs5fjhB/JbgAA
 AA=
X-Change-ID: 20250717-new-tag-git-fetcher-6287232fc0b1
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=785;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=I1bbePe0atKKpC8wT0LR6IVd0XD0j/a9v+1VWF4va40=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBoeg66YB9JAQ58pUTQHhjojKWdhyRiI83KqCjAS
 Y+KhefQL4GJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaHoOugAKCRDRgEFAKaOo
 Nu0aD/9yZ4uxU5442fVUkItKlw2Crb+wQ2MRj4PVR8PIgX5vHyMJdg8qfEbUcOfeSKRGlcDdr0K
 VozvE6KEd1TYfPg70McXu+hxRNwk+3U/Wij8s3aJ/PJvsicguMU7hpPnXrJ/4tRF966fr2Gzzf2
 i1nikTZVdp2utY3chMQ04XXdg0aYwWYL3uEf7mcUwqNUNtM9X4CbKj370k517n/v5Yt23DGONpl
 LaevrB90EaRPdepQ2qyq+YyouVPsD6XMNrml8avxYz28R+eqfjgANuoCUgWAZN10j3cJV+VLBFw
 dYwLXJG3Fc76t79DPrrM43NTGzHGelhZtXhXzk214XAHtpS0BkpUW6rIL/7SfUSBthiv6vCAQV5
 gUk25eY9/qNygOXt25fkkXy93gnTwZtTglrDViNgRZi/Ysh6eXuM/Rq3ME7nFqNPpcqzNbpvPie
 4I7ox2C2ZnhN8wYi/0RBobnsc1jKQdKXLJwsemb0roH05ctjr9j5Sm6OFXZqGc0L8FbDzVQB2Z6
 mLfaNIhs6iQg9c5K7WIhkv1wxUg2kco8ODJTB2gajqstPyaTL8IbIU43ZqFhUAtq7QiwHeXddSE
 p6BO1BO97JY+NbGAAsZZYa1kyNE4GVBkLl2ui44FXWdKvDB5HQB75DnC/qpfVtUGkGnH5WJy5vu
 gLk9BYwhfiXg1Vg==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeifedtiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpeetnhhtohhnihhnucfiohgurghrugcuoegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheptdduuefhleevheeuvedufeegvddtffefveelfeeutdejueetleegleevffdtjeetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeftgekudemvggsrgejmedusgeksgemrgehtgelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeftgekudemvggsrgejmedusgeksgemrgehtgelpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohephedprhgtphhtthhopegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdprhgtphhtthhopegsihhtsggrkhgvqdguvghvvghlsehlihhsthhsrdhophgvnhgvmhgsvgguuggvugdrohhrghdpr
 hgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopeguohgtsheslhhishhtshdrhihotghtohhprhhojhgvtghtrdhorhhgpdhrtghpthhtohepqhhuvghnthhinhdrshgthhhulhiisegthhgvrhhrhidruggv
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 18 Jul 2025 09:07:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17791

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Changes in v2:
- Suggestions by Quentin (thanks!):
  - not mandatory to -> optional
  - correct the rev parameter description
- Link to v1: https://lore.kernel.org/r/20250717-new-tag-git-fetcher-v1-1-77e46929103b@bootlin.com

---
Antonin Godard (2):
      doc/bitbake-user-manual-fetching: update the Git fetcher tag description
      doc/bitbake-user-manual-fetching: remove 'rev' default value

 doc/bitbake-user-manual/bitbake-user-manual-fetching.rst | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)
---
base-commit: 09f29a4968841ee5070f70277ba8c253bb14f017
change-id: 20250717-new-tag-git-fetcher-6287232fc0b1

Best regards,
--  
Antonin Godard <antonin.godard@bootlin.com>


