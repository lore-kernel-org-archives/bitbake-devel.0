Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7266AC36010
	for <webhook@archiver.kernel.org>; Fri, 11 Apr 2025 14:46:31 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web10.28160.1744382786898855176
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 11 Apr 2025 07:46:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=OhD2x7CR;
 spf=pass (domain: bootlin.com, ip: 217.70.183.196, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3DAF943AD8;
	Fri, 11 Apr 2025 14:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744382785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7HgWkrwlh2QCUVhJmIOOKjK7AOyN1p3yrnV+FqgKpBw=;
	b=OhD2x7CR6xeNGFOcNwbEwjN1g+O0jSuK+N8hGDepNfqPo+g9zExeJokHGYJ7gZM8gtdSjd
	4SkcmZ9xjEb6jFxo23YmuOABgz2WrUQh3FULoSLW4wsdMMvkMDBmG4Ef4lhKrgGrlbp0uz
	zMlRAUjIer1+eeix0CVLNZpbspsSs7+/zEf/wzgjoCJvLGpQCPa8pTntO6ExX79Zai/dvC
	0vMUjmORp9rdrzqkYYMt/+38mLmF6DWz0plmHeiIbdMsIyDzHS7ZQBWtYMEVX1j0X6t/ec
	Kjpn1Z1wHShITF4dlPUDpFiIiUd4TUGyhGlkh7sXiBNxxsqJi5WplQM6r4V0aw==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 11 Apr 2025 16:46:09 +0200
Subject: [PATCH 1/2] runqueue: decrease the verbosity of pressure messages
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-bb-pressure-improvements-v1-1-7d9e3593167f@bootlin.com>
References: <20250411-bb-pressure-improvements-v1-0-7d9e3593167f@bootlin.com>
In-Reply-To: <20250411-bb-pressure-improvements-v1-0-7d9e3593167f@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1675;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=MbhiDgyrFjcyzeQUDmOpy7/oUOXQTxiteJW1UVjYNiU=;
 b=owEBbQKS/ZANAwAIAdGAQUApo6g2AcsmYgBn+StAN537DGPUPE1maH1Zth1dAaBbGypjj3JJN
 EQZDWlL+8eJAjMEAAEIAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCZ/krQAAKCRDRgEFAKaOo
 NmCsD/9j4nKYfkcrbZToZPjdBuxumSvq7Y6oFhBUPX/51p0LjyfRTLJ1sH1SV+wMjdkwu0KAzkH
 LwOLxRlfmp9OeekdRAdZIDXY6ddrrgSskIoZvWtTfJMyeLgKKOZAWce/AKkraAbmPvH03o2/8YQ
 kLmaNPi0v+RsEJOZglEiG9U/xmJnQ8GhqXog1dyMyUK4e+IoBqLyybLRQ+z6DdVJS/LDEhk/JCH
 lzXxLqITDblrcUOuuZTnxvgljXBtWkMww25kfaWsy9D4nso+wNVU4W4xFmfUJfx2dK8ANQRsxub
 XwVKFME3AhLRL92TKNjB7oPzVDeZUXDpN3fmrpbx1OP0Mk5/Arez7udbWBbjL4nV10wSjEitGOz
 5TJDsGZ3DYkkYufc+4wVmN8o8loEtS4r0SHKljGJodEAhiVmzSUVmTJKgzr7wnDpNLqHYdnpjks
 O0T00SuKAdyug9s9L4dNlOajtq7Mej0XOVV68oLYfTaZ2PwqXk6EPb2781QnVbmD4COQI/GCe7W
 S2LXgmKeNYOJITUVkhV+AzNKcSNWwvc1KUr34FR+LLfgrfBKiim5/gNcDFV1uL2oTfC82UkFfq2
 Mj8Q1rK0F/LF/+OL8/v9Mt/hQ/0472z+494XTd8u106zFdczQOcI8r3A0gtpiuUaM7GpivdopG6
 in3eA1vFzzcXO8w==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvuddvtdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheptehnthhonhhinhcuifhouggrrhguuceorghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehieeguefhfeegheffgfeuieetheeileefheejkeetgfekueehueeluddvlefghfenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeisgelleemvghfheegmedvtdgrfeemiehfgedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeisgelleemvghfheegmedvtdgrfeemiehfgedvpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepgedprhgtphhtthhopegsihhtsggrkhgvqdguvghvvghlsehlihhsthhsrdhophgvnhgvmhgsvgguuggvugdrohhrghdprhgtphhtthhopeguohgtsheslhhishhtshdrhihotghtohhprhhojhgvtghtrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpv
 ghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtoheprghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhm
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 11 Apr 2025 14:46:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17525

By default all the pressure changes are printed on the console and
generate a lot of spam to users using the BB_PRESSURE_* variables.
Decrease the default verbosity to bb.debug (level 1, so can be seen with
-D).

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 lib/bb/runqueue.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 8fadc8338..adfe3c7a1 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -219,7 +219,7 @@ class RunQueueScheduler(object):
             pressure_state = (exceeds_cpu_pressure, exceeds_io_pressure, exceeds_memory_pressure)
             pressure_values = (round(cpu_pressure,1), self.rq.max_cpu_pressure, round(io_pressure,1), self.rq.max_io_pressure, round(memory_pressure,1), self.rq.max_memory_pressure)
             if hasattr(self, "pressure_state") and pressure_state != self.pressure_state:
-                bb.note("Pressure status changed to CPU: %s, IO: %s, Mem: %s (CPU: %s/%s, IO: %s/%s, Mem: %s/%s) - using %s/%s bitbake threads" % (pressure_state + pressure_values + (len(self.rq.runq_running.difference(self.rq.runq_complete)), self.rq.number_tasks)))
+                bb.debug(1, "Pressure status changed to CPU: %s, IO: %s, Mem: %s (CPU: %s/%s, IO: %s/%s, Mem: %s/%s) - using %s/%s bitbake threads" % (pressure_state + pressure_values + (len(self.rq.runq_running.difference(self.rq.runq_complete)), self.rq.number_tasks)))
             self.pressure_state = pressure_state
             return (exceeds_cpu_pressure or exceeds_io_pressure or exceeds_memory_pressure)
         elif self.rq.max_loadfactor:

-- 
2.47.0


