Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD7BC9833E
	for <webhook@archiver.kernel.org>; Mon, 28 Sep 2026 09:31:07 +0000 (UTC)
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.53768.1790587859457357800
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Sep 2026 02:30:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=T8HHt+Eo;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=ocHm+XXn;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.144, mailfrom: paul@pbarker.dev)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 8A9B21D000B1;
	Mon, 28 Sep 2026 05:30:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 28 Sep 2026 05:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790587858;
	 x=1790674258; bh=V44APMmaq6/GTDBWTbGJgwOr8wov27Z+G2UhZL4tWNI=; b=
	T8HHt+Eovq7jO/bcT5N3Passa61o2Dm9E2KBfOV6OiMEWHqoxPjKAEp2CFIvdRwO
	RjdXIs6cHKXPXYqyifgy4zrNrPzDVSi/Jx0kYkofrrQu3qo55w4FVnhh4adnaTme
	KfCR2aMaPeGjh5t21SrHdh+vsMYjsLhtpBUCU9jmuVONfGWzCyYqLcMt3WfFudJO
	qoj1JoUTIwMBg7Lr91Ur+c2oSJYStCDsPkkRkZL5oJ67iQbbE2uLY0JKqHP9+/a5
	SRTYnFsC70PyG/NJvzrYXrlL5J93xW5y0GjDJ0MaWIyaChLk57nPpSEreQwK6yBq
	CJP+577yLCNSKxP7yfoMFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790587858; x=
	1790674258; bh=V44APMmaq6/GTDBWTbGJgwOr8wov27Z+G2UhZL4tWNI=; b=o
	cHm+XXnp7rTfYA2zywd+oVyroZSxu/9Z7y93GO6o/O7CwceBMHN4XC3khXGbPCw0
	KUOOwexh1lklVWL6y3HtW68RDpSFjDqHtCCHfdFi0NDMJJVMgmqR7HPzFVCcWO3R
	NXPn9s6krYFoRoKdkzSSP7ns4l1x9Q7Rd7MVJtzPka0bVByZWQ50Qd1iyJnzvUpc
	Yah2EPNsj7pjlBN7i2p1+rZ7ENPDWCbofM/dFLEgFEt6fFN9aTMkPQbRL4REBVfB
	SY5/+D5ThoiElgAumKHqfb09Hfa7YqVYvd9cFgejr7kjlR7xxhYUqwRwgujPedPG
	m6cPckrfBNRCst7tyU1VQ==
X-ME-Sender: <xms:0jO6akvqu4-Sk7JQ7fywqBV5p5AsNXrTbxFVKjp4S1ToGWDEZLxj9w>
    <xme:0jO6ao4beMDVVfGcehajvzydM4BzenjVGuxbpQAmc7ETXWKM51twp3DD3hSHPpvNe
    CB5xjeu-BHzotIaxiOx_DSNHDmyv2rqz1vDxFt01EivYDD3hCPdV5tf>
X-ME-Received: <xmr:0jO6atJXS5ugcFeMdDzdB4iFmms9yUe7NTUCVvXx8CpZCivI51gV63w9JP9xDCgvnL7MNPQtx-we7uwe3AVn9saAXe9Qfm4oB0adKMg>
X-ME-Proxy-Cause: dmFkZTE9vOc2H1ehRq+BcpqJmRBpLbXR16pLFAH8zztI9PdvkiYXrA5N3NhRVYxgUxeX4i
    3raZd0/Q+hodhrm8HOUT0j/5ydPwvLFWgA0sNj1RoaTlIfn9dZYkMYF58LeAllCiTiB9gc
    xRqrRlukfXsJ7xVUlf9jATCV10E4ZxdRiiTWPK357qrmn1Oje5aBVY8g8OVsTI32+qqg0H
    jB7cTwnxwbneKjz61QNGoJKRU5vxigtIya8vAmaqeuyqWXVcjTMXugAxWL6ohJasvQMM6d
    C890uWPNZy3mTAKzmCke6tLMMwQ+nyF2/j9mfH1LvnWhV9rIHWzeiiWS+HjGaGrHQINKLt
    OrRChgkq/rvaT7+bNxnJRZAFCMtvqozi0fGSirXWgcP8Jcy8ftt3fKqeAyPKemHaDrsQXz
    ovC5/aSd82JiZI6bZbe0PqfsG2bSTutJH0CeMN931HMIi0BOk+FUsRRwUgjPOnpuKbje2m
    eBQCSiIhDts9kFPRApZfAZvenclOcmBhtYd+BZl/CcK8YL62AgvKQ3LfQUOWQ6ekpmVd3t
    2/ZZEz7TF7BbiNqK7inrDMzS7G8ToU7fMIzliH9FlqGEGioUyZYREgX9Y5eiHf7E+vuoME
    0fByuhdJLPXhN3WIn1pS1oV9TMGyj6mTfpKpLQ1NK/c4yoLF6eF9OeVWxE3Q
X-ME-Proxy: <xmx:0jO6ag6UXcoV67POpe6EuCa1qMIK1OqFuoc2qjo5Fb3F9mI5sqMh-g>
    <xmx:0jO6aowZJkgtar_tQ-vJAgz65J0aSME21cy0Tdl7SuO64WWsSEicgA>
    <xmx:0jO6asYpzvIT_8C15mEHFZjQP9RMMw5w0RI93a_MRCT497HCMUeSdw>
    <xmx:0jO6aiS3qj-CFdnaemNHM6dXb9pH7Pzht4dyZu2zpGTSRJpaocdCog>
    <xmx:0jO6aunh_Fm4OuNzdRZH_Pk5a6GGkhtPw2r5c8eb84_pMm641CNgFFzj>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 05:30:57 -0400 (EDT)
Message-ID: <2b5b8d1a56b5db173667efa839208df83188a7ca.camel@pbarker.dev>
Subject: Re: [PATCH v4] fetch/local: verify checksums for file:// urls
From: Paul Barker <paul@pbarker.dev>
To: Savvas Etairidis <setairidis@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Cc: jhonata.poma@gmail.com
Date: Mon, 28 Sep 2026 10:30:56 +0100
In-Reply-To: <20260924204518.19931-1-setairidis@gmail.com>
References: <DLNC7K9T9IRB.3TSABE8ZFLIZF@bootlin.com>
	 <20260924204518.19931-1-setairidis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 28 Sep 2026 09:31:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20266

On Thu, 2026-09-24 at 22:45 +0200, Savvas Etairidis wrote:
> [YOCTO #9993]
>=20
> Local.urldata_init() always cleared needdonestamp, so a checksum given
> in a file:// url (e.g. UNINATIVE_CHECKSUM when UNINATIVE_URL points at
> a local file://) was never verified. Keep the donestamp when the url
> carries a checksum so verify_checksum runs, and make
> rename_bad_checksum() a FetchMethod method that Local overrides as a
> no-op, so a mismatch doesn't rename the user's source file.
>=20
> Based on a patch by Jhonata Poma-Hansen.
>=20
> Signed-off-by: Savvas Etairidis <setairidis@gmail.com>

Hi,

Please include a list of changes since the previous version of the patch
after the '---' separator. For an example see 'Changes from v2' in [1].

[1]: https://lore.kernel.org/all/20260607-license-update-v2-1-877d92a588e0@=
pbarker.dev/

Have you spoken to Jhonata about these patches? It's good practice to
ask some questions and engage in discussion before taking over a patch
series someone else was working on.

Also, please ensure that you're following our policy on AI-assisted
contributions [2] if these patches were generated with AI.

[2]: https://docs.yoctoproject.org/contributor-guide/submit-changes.html#ac=
ceptance-of-ai-generated-code

Best regards,

--=20
Paul Barker


