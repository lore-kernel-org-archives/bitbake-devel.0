Return-Path: <michael.opdenacker@rootcommit.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E93ED1F9B6
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 10:54:55 +0000 (UTC)
Received: from siberian.tulip.relay.mailchannels.net (siberian.tulip.relay.mailchannels.net [23.83.218.246])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.40825.1764845694020320127
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Dec 2025 02:54:54 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@rootcommit.com header.s=hostingermail-a header.b=MfJLjZSS;
 spf=pass (domain: rootcommit.com, ip: 23.83.218.246, mailfrom: michael.opdenacker@rootcommit.com)
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 706778C24FE;
	Thu, 04 Dec 2025 10:54:53 +0000 (UTC)
Received: from fr-int-smtpout28.hostinger.io (trex-green-4.trex.outbound.svc.cluster.local [100.99.173.173])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 50C7F8C1B55;
	Thu, 04 Dec 2025 10:54:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1764845692;
	b=U354wEduC2FyhRYg159LJ+H9sPXmWeIgAB822MBKQxP78dhVxw/tLQk1SJw3JcNqa/VImd
	kpVJokHFhvfvxp+dUkYZkcyUK0DMDsvzi0X+2PpcFVhgD7AOvsnwidporfmii5OFfiVJFV
	RjJ35YEIz39aEoRwweNjrwO2iZ+3cIXcGTzABsxJnbgso9dhk+gd0qCb8qR1+gVn0qiLBw
	ZFfODKBI1NNxD3uKMNwP1XC0Z9PFtphriTXbHCmS7SpO9dHH3K9UipWjuCOcp3CrQHuG1V
	r6warYTqJnobLsyhYp1Ebz29UuRPECy2GTPVYLMH6xUC439OmPJnRKD15C32oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1764845692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=6VmxV+MR2UxEwZgpT9rXaVFyyu77KWVxNuX3L5j/XlY=;
	b=Aq3PoVoiK350tGThm17fpDqtIkNECSLe2e3neGpGyaw2/Lx2E0qdu0wxPedqvsNRZDcAbO
	V6ssKQ8pqX9o4/tsPtu4XMh1vUNdkkwdw2FqkGq6QkpH9wzX/SapBke8zsz3x3z6bDx7kp
	hGbd/tKvGF581PPlOr70KKgWrNDQN6hoDkF4vkItLPYzA5KyyVPoVUMxARzIXPhJN55evg
	YkZIsOMWSJXeeA8qnlvXca472eALI9Tu20vvn/jhWncqCKGxR7FI73cz4h5uN8136gD9zT
	hvGLFCyA3yQQSCgFUJmNzAMCfcroFxVx3E5UXpaPDWPA8i92gEWiHw2SWxFjoA==
ARC-Authentication-Results: i=1;
	rspamd-858948c46c-tdh6c;
	auth=pass smtp.auth=hostingeremail
 smtp.mailfrom=michael.opdenacker@rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: 
 hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MailChannels-Auth-Id: hostingeremail
X-Spicy-Coil: 66bc559a7a3779a6_1764845693184_2673531325
X-MC-Loop-Signature: 1764845693184:1935148176
X-MC-Ingress-Time: 1764845693183
Received: from fr-int-smtpout28.hostinger.io (fr-int-smtpout28.hostinger.io
 [148.222.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.173.173 (trex/7.1.3);
	Thu, 04 Dec 2025 10:54:53 +0000
Received: from [IPV6:2001:861:4450:d360:93ee:beb7:5173:8b2] (unknown [IPv6:2001:861:4450:d360:93ee:beb7:5173:8b2])
	(Authenticated sender: michael.opdenacker@rootcommit.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4dMWcB0dymz2y9T;
	Thu,  4 Dec 2025 10:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rootcommit.com;
	s=hostingermail-a; t=1764845690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6VmxV+MR2UxEwZgpT9rXaVFyyu77KWVxNuX3L5j/XlY=;
	b=MfJLjZSSYIeR5qduer+pSL7l/0H5ZIraxqAJKGTt5nPXXXWX22CVSDJQ7TVWDHSSbQeNgB
	ppWLPLzqWdC1TGOUqJvWUHlHpsqQ4kXNfgqFA7YF5KgiCyx+dzGfZ4oRExsQOtSo0hmr9t
	LDewBhd0jXicmP76Y4vcB9wH+1DRElzVuWLUqh03SyteNSFeGCgx8P2A1NSllMhkUQuclQ
	VoDK5zZiSMjM9iyJmwEPOH4YDBNQLdEefiWphyppEG0r9Gw+eFwfg0ddj+vzAbmGWS2gPr
	ydgaQmpPwpBLlxwopA4ZxiiYZ0ychu6XfmkaXub9ivQlGyWhqobr/QAcyz2jOg==
Message-ID: <af10c84c-1bda-42f4-ace0-74e7d3306cfb@rootcommit.com>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: michael.opdenacker@rootcommit.com, bitbake-devel@lists.openembedded.org,
 docs@lists.yoctoproject.org
Subject: Re: [PATCH v5] bitbake-user-manual: Documenting BB_CMDLINE
To: Swami <swami310@gmail.com>
References: <20251204002531.7660-1-swami310@gmail.com>
Content-Language: en-US, fr
From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
Organization: Root Commit
In-Reply-To: <20251204002531.7660-1-swami310@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Date: Thu,  4 Dec 2025 10:54:50 +0000 (UTC)
X-CM-Analysis: v=2.4 cv=GbNFnhXL c=1 sm=1 tr=0 ts=6931687a a=I9xiqIjMKFJQXI9lKSYqCg==:617 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=d70CFdQeAAAA:8 a=pGLkceISAAAA:8 a=B_sTQ91uS8caXt9xnAoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NcxpMcIZDGm-g932nG_k:22
X-CM-Envelope: MS4xfBP2aQ749JvKe4xWEfb9NbCxWP5Je4v8WwuHzmUDJ48KZtphZ0qTCqsLOB2RWPNuNb1pfiC2lkr/vQGC7WNM/I/NCMjt4096EaL022TXrDdu75BokJ5X XeeJBZnSNBearqG+yODw3T+nkt3vXCwJY7LJZtjpUIgJuCsGrAJwhkR8rz9gHHKF7HstJPFXIDReZDoQtTVoXDb04mcwWSUVlaj+zq4PXyZm7dYHl5H4v+GL KHSZ4wC5V8t3b3FBciha3COjcNp5+9lbw/yT1EyNPB+jOV7SGWZoqSFRZkH4SY/xHuMeyEMFPFM2jODHcViOKZ8QOnF/dvDdL/qpgxb00zLrLIlNtGN3cr8y fCDlyK/xuvjOQnqhvZxTfxzzSVYo+iwZhSkMZqOugke2QebD1pk9kxrzuXjx1RJBX5CUbEvddgqlmEhE6rvyQY+o0r5dDb2j5Q/Hftfs8wCAKv1PB7I=
X-AuthUser: michael.opdenacker@rootcommit.com
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 04 Dec 2025 10:54:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18537

Hi Swani

Thanks for the update!

On 12/4/25 01:25, Swami wrote:
> Add documentation for the internal read-only variable :term:`BB_CMDLINE=
`.
> Fixes [YOCTO #15746]
> Signed-off-by: Swaminathan K <swami310@gmail.com>
> ---
>   doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 4 +++=
+
>   1 file changed, 4 insertions(+)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.=
rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index 734c7858a..00b28519a 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -116,6 +116,10 @@ overview of their function and contents.
>         Specifies if SSL certificates should be checked when fetching. =
The default
>         value is ``1`` and certificates are not checked if the value is=
 set to ``0``.
>  =20
> +   :term:`BB_CMDLINE`
> +      :term:`BB_CMDLINE` is an internal variable and is read-only. It =
captures the exact
> +      command line used for the current invocation of BitBake.
> +


Oops, you have unnecessary spaces in your last line. Please remove them.=20
My editor flags those and this is distracting for a reviewer.
Unless Antonin prefers to fix this by himself.

If you send a V6, you can also move "the exact" to the next line.=20
Otherwise, your line is longer than 80
characters and it also stands out a little bit.

Sorry, documentation patches are the most difficult ones =F0=9F=98=85
Thanks for your patience!
Cheers
Michael.

--=20
Michael Opdenacker
Root Commit
Yocto Project and OpenEmbedded Training course - Learn by doing:
https://rootcommit.com/training/yocto/


