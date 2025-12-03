Return-Path: <michael.opdenacker@rootcommit.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D93D12D41
	for <webhook@archiver.kernel.org>; Wed,  3 Dec 2025 10:51:46 +0000 (UTC)
Received: from zebra.cherry.relay.mailchannels.net (zebra.cherry.relay.mailchannels.net [23.83.223.195])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12351.1764759099453969758
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Dec 2025 02:51:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@rootcommit.com header.s=hostingermail-a header.b=gn5hd+Lr;
 spf=pass (domain: rootcommit.com, ip: 23.83.223.195, mailfrom: michael.opdenacker@rootcommit.com)
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id A984D82128F;
	Wed, 03 Dec 2025 10:51:38 +0000 (UTC)
Received: from fr-int-smtpout14.hostinger.io (trex-green-9.trex.outbound.svc.cluster.local [100.102.148.76])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 8735B821343;
	Wed, 03 Dec 2025 10:51:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1764759098;
	b=LPN76+wCpveHbqdMEGmH27xhrtLDTG1ihx01j/0goAA6mI44FZHK9+evpCj2rcx+u+2Ci8
	9j8Q/vW/Bs41+YTmTs3FnFd4u56qR2h+ndVl8jK3bk3T1Vq7mtoTzUb50v57OBWAMAMJXw
	pNhJUbNXcQh7WIkLezyDmsn+EjLjYdYi6m++w8/9waASc9zYyLj7TmeYT9CnNTIqqSAKDn
	6Th4hPS6rC6gpsiyg9Xpq42oMs2OehBbsleXz0kHK4AjkY9ACTMpwkmC7YyKOCrgjdDHxR
	FsNbXDhOFREWPmL9/GnS70spF8VXLBLhny55NSUFzsX8AZJP/l3Dd3m2amRp1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1764759098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=QaXG4wf2is8FLc1iPWiOw6+8wwT4yykSigS50p2Gy+Q=;
	b=J6e0h1z/ZDSi6eN0AybtsSm6CKOGFSNYhZjn8oIP+LICeMmJ4wUauQORfBWq+5ykMgnN+M
	jpKcIqPYryvtE87EEDBaJC3kKzeEcsNl5Mr+SLsyKLkiMw+W+NFpM3U2nUwl+ayRIdthPr
	QvgqaBfqrl2mOgQo3x40SzH8ZIGfI5FKjyhBAMKJd61WV3jBR4cGM6llP0kfjQew005Ico
	nJfgxmwk5THifcV5XrRASfW2wWNX4Ns1FNWBbqvDYp98AIaWxsj7JiyAk3af2alT4lJRav
	GFt/aGd493sEr8nvdMgkHXUSCtOdJkbuAFXk/YgHzmfV66vwR/c7l4Myy0xRUQ==
ARC-Authentication-Results: i=1;
	rspamd-57b9fc4dc5-gx4jn;
	auth=pass smtp.auth=hostingeremail
 smtp.mailfrom=michael.opdenacker@rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: 
 hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MailChannels-Auth-Id: hostingeremail
X-Trouble-Plucky: 3158e7565ef0c6f5_1764759098424_379119169
X-MC-Loop-Signature: 1764759098424:2759221947
X-MC-Ingress-Time: 1764759098424
Received: from fr-int-smtpout14.hostinger.io (fr-int-smtpout14.hostinger.io
 [148.222.54.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.102.148.76 (trex/7.1.3);
	Wed, 03 Dec 2025 10:51:38 +0000
Received: from [IPV6:2001:861:4450:d360:cbc7:a3f4:aebd:6628] (unknown [IPv6:2001:861:4450:d360:cbc7:a3f4:aebd:6628])
	(Authenticated sender: michael.opdenacker@rootcommit.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4dLvZv2QBBz1y1j;
	Wed,  3 Dec 2025 10:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rootcommit.com;
	s=hostingermail-a; t=1764759095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QaXG4wf2is8FLc1iPWiOw6+8wwT4yykSigS50p2Gy+Q=;
	b=gn5hd+LrHQxRJIleUtKLU7KzOzM8Ags+nZYZBtPpuIdudoPchDJZM7nH1Ug2ClitIu4GZk
	MOl71GRogRnuYyonS5FuKpjuZO9npss7Cv74Qj8Rp9ImkGQlJB5R5GIL8LZB3CK5OE/C34
	iVulNunAeXSbE55uCEVSbD1efXmj/Q6fSJG3ZekFeiaee7AshL/iUdUPdHZdnFp4CKcKpw
	VqOL2sg7nOZIwWTIvNAwJRpMl5zPQk3wjneAzIHBA4Z3zq3bO4iB/4NvYW/8rCf44B4gcg
	s23YVWsLma6skfBrzMMVNE+CdXMogka8fU8ldcZcno7QSynBwpWLDlM5Jki6Bw==
Message-ID: <e4ad3921-db47-4ac0-887c-6e3d485d8edb@rootcommit.com>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: michael.opdenacker@rootcommit.com, bitbake-devel@lists.openembedded.org,
 docs@lists.yoctoproject.org
Subject: Re: [PATCH v3] bitbake-user-manual: Documenting BB_CMDLINE
To: Swami <swami310@gmail.com>
References: <20251203085540.18826-1-swami310@gmail.com>
Content-Language: en-US, fr
From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
Organization: Root Commit
In-Reply-To: <20251203085540.18826-1-swami310@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed,  3 Dec 2025 10:51:35 +0000 (UTC)
X-CM-Envelope: MS4xfOSKnOVN/AwKlED6zwvIrHZ6l4Qorreb9hXUv+4ick43Zo/DKoev9I5AvVKtWcEDu/vf5OplknODnFiCSdCpzSn0n2cGmJBbUAGNkoM1TzM2eRNI7wBG ciZk8a1VVTH4h6747EpeTLAUiBtZDLqT0gyWE0lTBiXivicqUB4sbUAWvLBkTWxHvRVKPMGbWbJTSw+PabLjpxxfDbeVpADI9yXnhOTsqlJbm3r7KOfnfUpf 14IibDb1y1sE9Ef5YOu0MbsbizGkCua1jbtbKiZOrbMgHufFN5q9qQHW48NkAbp1iZeQCdLUK0CJSpcJr34yotqeqrD7Td++gD8QxIPaUxxRtDe1BdHD+4Ki gCdEsH/lUYqKF2JCGHzTK4Um+OcR2XVU/svM8lNZ1UaxBUwfv1IKnHZdNds5X3uWdkZc50r54+ZDnrfyOUH6JOvWmmtRFDFM6MuHZj4hlb9kuHvKhq4=
X-CM-Analysis: v=2.4 cv=NuiDcNdJ c=1 sm=1 tr=0 ts=69301637 a=OqpkdRz8NeyqghF3LjKiWg==:617 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=d70CFdQeAAAA:8 a=pGLkceISAAAA:8 a=yRnJVOifdGIRP--LNFEA:9 a=QEXdDO2ut3YA:10 a=NcxpMcIZDGm-g932nG_k:22
X-AuthUser: michael.opdenacker@rootcommit.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 03 Dec 2025 10:51:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18520

Hi Swami

Thanks for this update!

On 12/3/25 09:55, Swami wrote:
> Add documentation for the internal read-only variable :term:'BB_CMDLINE'.
> Fixes [YOCTO #15746]
> Signed-off-by: Swaminathan K <swami310@gmail.com>
> ---
>   doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index 734c7858a..f756c436d 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -116,6 +116,10 @@ overview of their function and contents.
>         Specifies if SSL certificates should be checked when fetching. The default
>         value is ``1`` and certificates are not checked if the value is set to ``0``.
>   
> +   :term:`BB_CMDLINE`
> +        :term:'BB_CMDLINE' is an internal variable and is read-only.It captures the exact
> +        command line used for the current invocation of BitBake.


Two more issues:

  * You need backquotes around the second instance of BB_CMDLINE, just
    like in the first line. Otherwise, the reference is not created.
  * There is a missing space between "read-only." and "It"

It's almost good!
Thanks
Michael.

-- 
Michael Opdenacker
Root Commit
Yocto Project and OpenEmbedded Training course - Learn by doing:
https://rootcommit.com/training/yocto/


