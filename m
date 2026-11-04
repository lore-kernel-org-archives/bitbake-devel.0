Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6701.1793789812400294904
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Nov 2026 02:56:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=cym43JBo;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 286A11A1454
	for <bitbake-devel@lists.openembedded.org>; Wed,  4 Nov 2026 10:56:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EB3B560770;
	Wed,  4 Nov 2026 10:56:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 93359103291F6;
	Wed,  4 Nov 2026 11:56:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793789809; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=OUWpfmck+vUp6cTyQ28jp2qc1C+FUMonsIsuoY5I730=;
	b=cym43JBo+E4+KpZ3+G0m51sksQM/G16Hx5vgwLge5gx+K5PsX17Fv9u6VXS5iNfpgJIAC+
	HluK2Lfm2w/ucaE+Pr5lX5K7jaU64EEpExm5edQTRncP3ZuHu9i9SErZVluSwNGths3s57
	9KpseXlb/pYJ66VvHdibEQy7CSb8pdUXoNsrEE4Jhz/bTKMAA1cb0bfcZXOQJhZEXPrltN
	+rZFkZQVmWkJlolQsGmK3/D8TVh4hJTsxcMG1I3jLOxXF5XPipF1lgZdEcXpEwRFEjr4Ve
	Di1BDkIyI4ypOo0M3JoVn7O0x6RIGXxJMeRN/sbhhyyvwXChB5tpU1IjIz9wtA==
From: Antonin Godard <antonin.godard@bootlin.com>
Subject: [PATCH 0/2] Add a terms glossary and define "datastore"
Date: Wed, 04 Nov 2026 11:56:37 +0100
Message-Id: <20261104-terms-doc-v1-0-0ded0b9e1623@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM3QpAQBBA4VfRXNuyG8KryAWzg1F+2llS8u4Wl
 1+dzgVCjkmgii5wdLDwugToOAIc22UgxTYYTGJyrZNUeXKzKLuiKmyGpiypQMwg9Jujns/vVTe
 /Ze8mQv8O4L4f0j9S5G0AAAA=
X-Change-ID: 20261104-terms-doc-8d5c299e8cc5
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=778;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=3BHGzegjXM3hp/mTFVvzAifZX4bwf7CED99ADQseUHs=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBq6w9m+7mlisZkgo5hPj34e8hwO9SOBaoOVJdIf
 uS/ZjqFYCGJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCausPZgAKCRDRgEFAKaOo
 NswFD/9rbCQUbhpdOn0FGbCD3HkhrDF/aoVlJv7KnMqFnRWiZf/L8DNg1JUKWvYn0uul5byCZ5B
 1vgRuGB7Mh0MMaemeEUJt5EnHc1uHfWKQVmr8eGrnmAPNQUfuiidUTrdxw/DW4gZaIiaqvTOtcR
 ovrn+bVdrTuLy+WfhdxvEtSLv8ibe8Ck/st3R69VSJxLxiH2fX7tczaGZWwKZp8/oTKeXz4zj2N
 JO10ZEbfzAiy2rjuKyKamQpAR0ymkEQynKOQD24C+624wOj880pv6eB6TFqwEF14Azsm1Wfx+2W
 Q4tNg/ZhrorepK7YvYFb9j0hT8iC+f1Zaw3BKL/BoDj+38uht1FOQJr1jKaQXKA2yZgQfsF2MnM
 BEHS0aCwWs2nzlosXMgmYVIv6JDhJ2Zq85z980Vs1ghs5eCvPFpLIGlgTnufd9rrAftqakXFlIB
 1ZZgDCMG/cyfFnmz3Rb0DMAZlD+q3+bw0RETrYYGcHJeCGbc2msmcyQ3rKVXcRV58RcKcV3Jm1G
 UQT1oL4aa/ITz8HdXJqYnOMAZREWKxDX7EODWuwEL1v9AtA16iZdVDl85HlHTqe/QY64ykgRFo9
 KFJYuDH1fvxtsxn+enGaWpPtJrUI9ngnxls5d5De3GRMjX/eyVnFop8UDv7PLDgGYErWIuKRRU6
 ++8szHyTiZ8kBWQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Wed, 04 Nov 2026 10:56:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20391

This glossary can be later update to add additional terms common to BitBake.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Antonin Godard (2):
      doc: add a terms glossary and define "datastore"
      doc: xref occurrences of datastore to the new term

 .../bitbake-user-manual-execution.rst              |  2 +-
 .../bitbake-user-manual-metadata.rst               | 50 +++++++++++-----------
 .../bitbake-user-manual-ref-variables.rst          | 18 ++++----
 .../bitbake-user-manual-terms.rst                  | 25 +++++++++++
 doc/index.rst                                      |  1 +
 5 files changed, 61 insertions(+), 35 deletions(-)
---
base-commit: 0f33b68cbabab26c9ed1585e3ee109689d206812
change-id: 20261104-terms-doc-8d5c299e8cc5

