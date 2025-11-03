Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F789CCF9F8
	for <webhook@archiver.kernel.org>; Mon,  3 Nov 2025 20:21:47 +0000 (UTC)
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1402.1762201298338025874
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 03 Nov 2025 12:21:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm1 header.b=zH7b/4/2;
 dkim=pass header.i=@messagingengine.com header.s=fm3 header.b=UxfVdo5F;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.151, mailfrom: paul@pbarker.dev)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 8FC0D1D003B7;
	Mon,  3 Nov 2025 15:21:37 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 03 Nov 2025 15:21:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1762201297; x=1762287697; bh=RJ
	/IvjOewJB+efZlDNtCeDXlrU1WSYT4tX/uPCvDpYg=; b=zH7b/4/2oLQucV2FuV
	/yOscXBX+esBGAHtCZBvtb2lUuYoazrvZv3IUka2yv/6aoZD7tDAoIW2kcEEyZAw
	wT7Pxel8tEic7pbdUGIeGsoHBOaqkbolqiJ4chH7TQjKWlUlpMr2QiGhH2Jpo/mN
	0sbGpK7+7FFQMA8eC+VUWki4IDNiaqbGVXPosXb4NaPkZBmbq9I0Ilqzr1h2wFiT
	wuzAKjIk237++EVM51TbSAXdjX4QkyEsVdzSR6zBuYlmuRVP8+/VNPoA7HlcE2mk
	EwxJ088NAU/O6f3dDyDw2tA/EbO/roP45Xi/s0dZUwDwEBffLOwgRlTxEC7IHR3b
	GuHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762201297; x=1762287697; bh=RJ/IvjOewJB+efZlDNtCeDXlrU1W
	SYT4tX/uPCvDpYg=; b=UxfVdo5FJ7ngA9EAY5pJUrf+YD5z99hzOjOCJtE0fbqC
	SIS5MeFY4ep7ZCYORO25aryfcu3As32n8+7Dzt6aYp8LixRF0/MVQq3S4kWNUdIh
	21lr5naSE9qVqf656iRbuoMtTHMq3iy+BlYXwdfFPZPCkrOBzgHjB5OI7HLwFYXe
	/rvMzpbkyhEdB04iH3N+s4GR8aQI6FVIRLzQ1RqHOILMIURlCYacGs11v4C5pdNX
	5/RPY3hi1sRPRNr3ef0rvo2AHeUkLJXSS2MGgNFgOS7emVe/IveXLfJk1jiLmIVt
	fNyaJJHBBAyIk9jPmMo2w1T8mhIDxBqspfdNX/53pQ==
X-ME-Sender: <xms:0A4JaRaW131wGCeGWuhKysBcf9RghPFc1cZ4GaaXOxVeHn9U1hY1fA>
    <xme:0A4Jaf2ivGeOOBcFJDgkr1vUEpEqzNhPjosgrQBgGHX9IISYeS0bsEYzpEQJJ6EcX
    hhS2U3Kh0LdS_W0zO6-A2XCH4fKbFhIf5WBZ0fUkgi83ychMRSN0wc>
X-ME-Received: <xmr:0A4JaRW8eoFFuYgo9mi9F28cWOBndev52GbBQCMCB1HRmaj3PTTcRvtr0i2BwbHHNOzWdbI1nRi6a3f1Dg16D6k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeeltdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpefrrghulhcuuegr
    rhhkvghruceophgruhhlsehpsggrrhhkvghrrdguvghvqeenucggtffrrghtthgvrhhnpe
    ffudeifeffffelhfetieekteetvedtheeuffdtleehuefhtdelueeggfdvteehteenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphgruhhlsehpsggrrhhkvghrrdguvghvpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrihgthhgrrhgurd
    hpuhhrughivgeslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegs
    ihhtsggrkhgvqdguvghvvghlsehlihhsthhsrdhophgvnhgvmhgsvgguuggvugdrohhrgh
    dprhgtphhtthhopehprghulhesphgsrghrkhgvrhdruggvvh
X-ME-Proxy: <xmx:0Q4JaZV2Y-hDwcGyQCYeFHRQ6w2ECEP3MPC-r5wg0KDycRjjnjK9Xw>
    <xmx:0Q4JaQfXoECKxmFLYDQgZrZXDcN-8VmDLBN_MrD4n3sIEphH_CbNZA>
    <xmx:0Q4JaSVZsVwctEXwKLjdePb8bj_Wt_Bn_cpSN9RBS80GIQznjMkeKw>
    <xmx:0Q4JaZc8iX9cKjBIrj_HjxgMq8jvICOaiYnnwHLKgKbk0IFVzr0wYQ>
    <xmx:0Q4JaUzAIBjNEcnoxWaW1lrAVUnhbgxKJcizngZiIhPGTfunns_HRi5D>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 15:21:36 -0500 (EST)
From: Paul Barker <paul@pbarker.dev>
Date: Mon, 03 Nov 2025 20:21:24 +0000
Subject: [PATCH v2] siggen: Fix dump of non-runtime sigdata
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-fix-dumpsig-v2-1-2b5eaf94df49@pbarker.dev>
X-B4-Tracking: v=1; b=H4sIAMQOCWkC/22MwQ7CIBAFf6XZs5hCKVhP/ofpAWFpN8aWgBJNw
 7+LPXuc9zKzQcJImODcbBAxU6J1qSAODdjZLBMycpVBtKLnrdDM05u51yMkmhgOsledNu40eKh
 GiFjvvXYdK8+Unmv87PHMf+v/TuaMM6l6paWV3tjuEm4m3jEeHWYYSylfrXukcKgAAAA=
X-Change-ID: 20251027-fix-dumpsig-e945637ad89f
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
 Paul Barker <paul@pbarker.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2183; i=paul@pbarker.dev;
 h=from:subject:message-id; bh=3V6SDWKr2RiZ0Lc+RdYz5kwXkzQTlrTHrIOBcVv4/rQ=;
 b=owGbwMvMwCW2OjnkzdxdX/IYT6slMWRy8l1Ydepj17rlz9sF7nIrvL15Yr7upJfGyjyiPVnn3
 /78rrZtSUcpC4MYF4OsmCLL5p6v95/2OvJmhNxSgJnDygQyhIGLUwAmsv4SI8Nsy4eGqufPeGmm
 SH7/vyXTNlDI2u5l9dIFM//83HjEpzSckeGB2/4w/0u7Z9+qDZvLpnB0xfm2kw/Oe/3l3J0YwlL
 Ans0EAA==
X-Developer-Key: i=paul@pbarker.dev; a=openpgp;
 fpr=98B2AAC100AC3F82BB5D546774975C81B7E66BAC
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 03 Nov 2025 20:21:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18244

If the debug code is uncommented in SignatureGeneratorBasic.finalise(),
sigtask stamp file are created without runtime data such as
'runtaskdeps' and 'file_checksum_values'. If we then try to run
bitbake-dumpsig on one of these files, we will see a traceback as the
expected keys are not present in the sigdata dictionary:

    Traceback (most recent call last):
      File ".../bitbake/bin/bitbake-dumpsig", line 195, in <module>
        output = bb.siggen.dump_sigfile(options.sigdatafile1)
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
      File ".../bitbake/lib/bb/siggen.py", line 1266, in dump_sigfile
        computed_taskhash = calc_taskhash(a_data)
                            ^^^^^^^^^^^^^^^^^^^^^
      File ".../bitbake/lib/bb/siggen.py", line 1199, in calc_taskhash
        for dep in sigdata['runtaskdeps']:
                   ~~~~~~~^^^^^^^^^^^^^^^
    KeyError: 'runtaskdeps'

To fix this, do not try to compute a task hash if the required data is
not present. We can key off 'runtaskdeps' as this will likely always be
needed to calculate a valid task hash.

Signed-off-by: Paul Barker <paul@pbarker.dev>
---
Changes in v2:
- Skip tash hash calculation if 'runtaskdeps' is missing.
- Link to v1: https://lore.kernel.org/r/20251027-fix-dumpsig-v1-1-465674c4fac3@pbarker.dev
---
 lib/bb/siggen.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 41eb6430122f..985fa7e4ca1d 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -1263,7 +1263,10 @@ def dump_sigfile(a):
     else:
         output.append("Unable to compute base hash")
 
-    computed_taskhash = calc_taskhash(a_data)
-    output.append("Computed task hash is %s" % computed_taskhash)
+    if 'runtaskdeps' in a_data:
+        computed_taskhash = calc_taskhash(a_data)
+        output.append("Computed task hash is %s" % computed_taskhash)
+    else:
+        output.append("Unable to compute task hash")
 
     return output

---
base-commit: acf5b02c5aaae1116d33b4e08b2ad7c27d9b94ab
change-id: 20251027-fix-dumpsig-e945637ad89f

Best regards,
-- 
Paul Barker


