Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFE2CCF9EB
	for <webhook@archiver.kernel.org>; Mon, 27 Oct 2025 08:25:52 +0000 (UTC)
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
 by mx.groups.io with SMTP id smtpd.web11.27189.1761553542720013590
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Oct 2025 01:25:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm1 header.b=M85oSYXd;
 dkim=pass header.i=@messagingengine.com header.s=fm3 header.b=q/hdwdqm;
 spf=pass (domain: pbarker.dev, ip: 103.168.172.146, mailfrom: paul@pbarker.dev)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 013EAEC0300;
	Mon, 27 Oct 2025 04:25:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 27 Oct 2025 04:25:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1761553541; x=1761639941; bh=sJ
	R2ZcmBS6B2QjxQKTe63LLcI+dwRRB12fYE2Imph7o=; b=M85oSYXdIguFx60gWI
	ji89A9SvrMxmAGcdwg+3FLL6hzUSPUlV5vFZc+4HR+F/FBlWQ4xPRnoz9PGLnSdl
	f6ynxYHyRcIiN9/X1OS+Dc7aSbOGyFDl2eE9E/huHBPHrxknna/qYLGwL9UbUnye
	IbK3wIY3OMK6j6vYH6HtEqRAbxhsIoZPRi1pqGz3KIgn8d149UCytvHqs4D6C+5d
	jfzTBCrys3YBv7Y1IarvdXqadtREnRrJlSnOKxn47xh79tocE23kwog76aERLaAo
	A09QEnN7JyR4C96aTkJbvNkmSs/Wimp96FqieRRz0fn1JKlgH7XJA5wEPKl6Xj4q
	Tvrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1761553541; x=1761639941; bh=sJR2ZcmBS6B2QjxQKTe63LLcI+dw
	RRB12fYE2Imph7o=; b=q/hdwdqmldHrb+qaXrT1VMQVTvHE6Pc8yeLcx+Qr9n7J
	pCbQwc1EWRKGuRD3HKWprcdTw2xrY90oK5pfJ+GYllXSxPBlL3JQ3y989ZZTOMYe
	Gq8PBPVg4MWpRekAsCgKxN/us514WShvBqpiTlOQOtXFHoroUN06xGAjDbYDLpqQ
	t1aurnNYvzN/FiAodiWgS84/hWAM668thewrx/kLaadxKP+r6XyxD3YHuXGJJnHt
	i8UgycN5pdNcHi/U3oK1N0OsZSF/bvpiRsmAuoekI712qt8mdpBuNLNkyBz+Trqj
	NR/wiO+SSJ/Dy8JS7Mkst7Mudr3ZEExQ+CvxydaPpw==
X-ME-Sender: <xms:hSz_aGwx3kT9OXxrdnWMBMbkvPbylqJg0HSIu2X-ieJHum-DD6UWgA>
    <xme:hSz_aJsKZNxiT4TjXGNaXvGFmxGVbfGL4-ObQu4WH_f84c9JGGiiyRDs9tnMzSic2
    9UxB2Xd541ILb4IzUvMXacgmivI-jIiTDLwWjRVoKZc8hmeDywGkaQ>
X-ME-Received: <xmr:hSz_aFvOgR3mLD-u4PoVg-8lFoO46BYphmZNOp0yVOKB6W_XO5ihfJbAJFDSuuE2ra8_rbfeo1jG_reWBueHNVo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheejgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpefrrghulhcuuegr
    rhhkvghruceophgruhhlsehpsggrrhhkvghrrdguvghvqeenucggtffrrghtthgvrhhnpe
    fhteeugfevveevvdevgeffgfffteehvdejfeelhfelhfdtvdejvdffgedtleduhfenucff
    ohhmrghinhephihotghtohhprhhojhgvtghtrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepphgruhhlsehpsggrrhhkvghrrdguvghv
    pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsih
    htsggrkhgvqdguvghvvghlsehlihhsthhsrdhophgvnhgvmhgsvgguuggvugdrohhrghdp
    rhgtphhtthhopehrihgthhgrrhgurdhpuhhrughivgeslhhinhhugihfohhunhgurghtih
    honhdrohhrghdprhgtphhtthhopehprghulhesphgsrghrkhgvrhdruggvvh
X-ME-Proxy: <xmx:hSz_aGMiWT4WvjxX0-FfRWxkn8MOxSD2qo3x9X88TJ8ZfLE5FMsKzA>
    <xmx:hSz_aL0RfpgoQ_Za8ks8jOSMINMPAbuC8i2ow5kdlC4RkoCXF3cBPQ>
    <xmx:hSz_aKPcany3H_pYgTTv9QjxI-AfbCF98IsEwo-89tzZ9AbTD3b3hA>
    <xmx:hSz_aD1t0SlDLk_sVzuvH0uMc2tbAmBdm_MSIoMVNv2CH2Rp-OJpyw>
    <xmx:hSz_aCoYeP6yT-DB7tVXZXACSSc35iFE3K0K3vn1tegFMCcRyQosSTcn>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 04:25:41 -0400 (EDT)
From: Paul Barker <paul@pbarker.dev>
Date: Mon, 27 Oct 2025 08:25:22 +0000
Subject: [PATCH] siggen: Fix dump of non-runtime sigdata
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-fix-dumpsig-v1-1-465674c4fac3@pbarker.dev>
X-B4-Tracking: v=1; b=H4sIAHEs/2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyNz3bTMCt2U0tyC4sx03VRLE1MzY/PEFAvLNCWgjoKiVKA02LTo2Np
 aAIQ6po1dAAAA
X-Change-ID: 20251027-fix-dumpsig-e945637ad89f
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
 Paul Barker <paul@pbarker.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2378; i=paul@pbarker.dev;
 h=from:subject:message-id; bh=9VNLZye0WlaqXyC27qEW/gYkaMZl7d0OPh4CvHqLbwc=;
 b=owGbwMvMwCW2OjnkzdxdX/IYT6slMWT812kpCfbZuP7FWtGlXZkSv//L7PAse7Dsu1V9wxOJw
 xxWfhdUO0pZGMS4GGTFFFk293y9/7TXkTcj5JYCzBxWJpAhDFycAjARu2cM/yy/TJG96s95QrO0
 6Zdu/QUf+xMzPKZOs95w9Phy4wsPfl9l+F8S46kolc5aUVT6/rqnDjtLhx7ro+Blvbs85N7HGy3
 JYQcA
X-Developer-Key: i=paul@pbarker.dev; a=openpgp;
 fpr=98B2AAC100AC3F82BB5D546774975C81B7E66BAC
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 Oct 2025 08:25:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18217

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

To fix this, treat these entries as empty lists if they are not present.

Signed-off-by: Paul Barker <paul@pbarker.dev>
---
Richard,

This patch attempts to fix an issue reported on IRC last week [1]. It
prevents the traceback, but I'll have to defer to you on whether the
taskhash calculated without 'runtimedeps' and 'file_checksum_values' is
meaningful.

I guess an alternative approach would be to call calc_taskhash in a try
block and not print out a task hash if the call fails.

Thanks!

[1]: https://irc.yoctoproject.org/irc/%23yocto.2025-10-24.log.html#yocto.2025-10-24.log.html#t2025-10-24T11:09:20
---
 lib/bb/siggen.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 41eb6430122f..5355f499074f 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -1196,10 +1196,10 @@ def calc_basehash(sigdata):
 def calc_taskhash(sigdata):
     data = sigdata['basehash']
 
-    for dep in sigdata['runtaskdeps']:
+    for dep in sigdata.get('runtaskdeps', []):
         data = data + sigdata['runtaskhashes'][dep]
 
-    for c in sigdata['file_checksum_values']:
+    for c in sigdata.get('file_checksum_values', []):
         if c[1]:
             if "./" in c[0]:
                 data = data + c[0]

---
base-commit: 35a421cdcafb3595b9de5489ffdc567825400d26
change-id: 20251027-fix-dumpsig-e945637ad89f

Best regards,
-- 
Paul Barker


