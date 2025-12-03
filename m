Return-Path: <michael.opdenacker@rootcommit.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4C8D12D71
	for <webhook@archiver.kernel.org>; Wed,  3 Dec 2025 14:36:47 +0000 (UTC)
Received: from elephant.ash.relay.mailchannels.net (elephant.ash.relay.mailchannels.net [23.83.222.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16707.1764772597293583299
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Dec 2025 06:36:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@rootcommit.com header.s=hostingermail-a header.b=ccB4F4/C;
 spf=pass (domain: rootcommit.com, ip: 23.83.222.57, mailfrom: michael.opdenacker@rootcommit.com)
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 5C46E460E29;
	Wed, 03 Dec 2025 14:36:36 +0000 (UTC)
Received: from de-fra-smtpout4.hostinger.io (100-99-13-166.trex-nlb.outbound.svc.cluster.local [100.99.13.166])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 1E57346277D;
	Wed, 03 Dec 2025 14:36:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1764772594;
	b=9AbTbGY6JdFwaUMpi6XXIfIbKQIJvY8Z3geKGgLG6CBZMKJqbAIuDPs9BFujtrrDGyz5Ij
	zMgpMK6U+ikcyal+iS1HGSdJaUbzGIxS2O2CBc3/h10TXh3B07+7J7yA1t5gVrmfWwMxuC
	YuRu70Zz3kMPNkEH/Vjj/5IBZI2W/vaCgBB7WGbwx95EbJZsU2M0GIYAa8OK36J84lX8ZG
	A094tifpZrktIZkdpP74VWZlaHsDMJ2dvdmLk1BnFdifQ55D3JALJCCtv+S771AYlruOob
	eOyvaIEcoZS40T7KVi8gf+1QFeXdJJd9DdhRzwLlNswpCy9A9UKbbNcShOHmJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1764772594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=P9J1iyBx+xyrh05fl9rDT9PM2SDskU5ujuRacrdN268=;
	b=M3Ah1eLLG1s1qrL/HH5HiLCz4hxIiPme0ge/0qagpamp2HBsj7YpxFhd+Ox8CF7B3AWodY
	PC+jCmhp1m9BW5JpewdC7846fFWRHOG02SVrtK6W5B0Ld+2OKbmkab2cGzkMSWXJienknu
	KaNHOkkehbrycrH35TkXfU0y83SVaVncOhZ/qF0agX6nmpz7hDgPoJlK9QcDXiVCOUZL3y
	ebym4k65oZ9D9L2gbEjiLXRkPV7x8MPd7G6LBSKdubCEeLPkk4wDGGZtVgmWphYYlw7PpW
	Pt7S8HMPbin4GqNWYmm+JE+rv03AsI4tdnOYZY5Cxf8ooAGcwcyuzC9AGYn7mw==
ARC-Authentication-Results: i=1;
	rspamd-858948c46c-sh6vr;
	auth=pass smtp.auth=hostingeremail
 smtp.mailfrom=michael.opdenacker@rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: 
 hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MailChannels-Auth-Id: hostingeremail
X-Harbor-Irritate: 5b42fb367b0510be_1764772594991_2528147085
X-MC-Loop-Signature: 1764772594990:930509760
X-MC-Ingress-Time: 1764772594990
Received: from de-fra-smtpout4.hostinger.io (de-fra-smtpout4.hostinger.io
 [148.222.55.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.13.166 (trex/7.1.3);
	Wed, 03 Dec 2025 14:36:34 +0000
Received: from [IPV6:2001:861:4450:d360:1ce0:330a:25fd:1fc3] (unknown [IPv6:2001:861:4450:d360:1ce0:330a:25fd:1fc3])
	(Authenticated sender: michael.opdenacker@rootcommit.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4dM0ZR4V6Jz44b9;
	Wed,  3 Dec 2025 14:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rootcommit.com;
	s=hostingermail-a; t=1764772592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P9J1iyBx+xyrh05fl9rDT9PM2SDskU5ujuRacrdN268=;
	b=ccB4F4/CAUOpoVfCH0My4dRugzrCW16HfaFmxmQbg232Lgqr3tF+vwbWJbW0p9EWY0VvsV
	xhGciQIrUcIoblfkFzbfVOCWZUeYHs3xWx6jJksABw3HLRipgW4lwrDISYoD91LIOUQnsr
	daJSo30QcBkKjRDiqCUUGoTgr8//2HymQRL3Qu0rL80UECBIacQ3sc4PjYPa69GFsggTDX
	6hWaIOWnEZK9r+WnGCOk6teLKYdalN70hePmKdIBWqs2NsCaAxVKvz9pjWHejcpylcHwWT
	BHa/hQHhs8dM7J66pf8+R+vG5RmQkHKOi9ffyyfstSLj8TF6sNaWonM5qesOUg==
Message-ID: <25d80654-678d-45e6-898e-bc79b7aeb75d@rootcommit.com>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: michael.opdenacker@rootcommit.com, bitbake-devel@lists.openembedded.org,
 docs@lists.yoctoproject.org
Subject: Re: [PATCH v4] bitbake-user-manual: Documenting BB_CMDLINE
To: Swami <swami310@gmail.com>
References: <20251203113900.31314-1-swami310@gmail.com>
Content-Language: en-US, fr
From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
Organization: Root Commit
In-Reply-To: <20251203113900.31314-1-swami310@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed,  3 Dec 2025 14:36:31 +0000 (UTC)
X-CM-Analysis: v=2.4 cv=etGNzZpX c=1 sm=1 tr=0 ts=69304af0 a=3r9wdrx9W0vQMltN5Nm6Cw==:617 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=d70CFdQeAAAA:8 a=pGLkceISAAAA:8 a=ZZoWuFA8VuO5aYj3eMsA:9 a=QEXdDO2ut3YA:10 a=NcxpMcIZDGm-g932nG_k:22
X-CM-Envelope: MS4xfCNW54lu0KHh1zn4ZAPvqq5L3JezQY2Eln8X9RJws1xuHnw3S5kOAnyPygvg2Pzf6TyQsWtZn3j+Xb+YZ4G41S0IFLJ5C4z8qM8UdPoV46ipXcw3y/zL ny4HXYzlWF+Y/a9miPVnjA3Z045IiB814vVLPj5mxZkS6md1bE7GO/wvivLXPY4b7aqtobrpHWkVNYTrPz7vV6bK4eCIcNrXPWgMDD4nArn170XxjASqC3KK 6HhhfoRZlR2AAot+pfH+p908HfNWBC1Pga4wSg8EyX9Y5dGprHkaNb2vaN4PR2EjiaztKfotC2pprjGnqru2IyNpEIzknsa1hyECTJzOyKaxdJiitHAN18/f EX4DubzOsEwb6MSGVbS8wnTh/ZBBrmqPJybahqPRS4vcA+tuY+rUMNU/ZqL/Dhepl/SdR+JVD3k+BI/Q2qRy5B175bUPoi1pSJZiW390ShJs2Mimuio=
X-AuthUser: michael.opdenacker@rootcommit.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 03 Dec 2025 14:36:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18529

Hi Swami

Thanks for the update and your patience :)

On 12/3/25 12:39, Swami wrote:
> Add documentation for the internal read-only variable :term:`BB_CMDLINE`.
> Fixes [YOCTO #15746]
> Signed-off-by: Swaminathan K <swami310@gmail.com>
> ---
>   doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index 734c7858a..f49ce0f9f 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -116,6 +116,10 @@ overview of their function and contents.
>         Specifies if SSL certificates should be checked when fetching. The default
>         value is ``1`` and certificates are not checked if the value is set to ``0``.
>   
> +   :term:`BB_CMDLINE`
> +        :term:`BB_CMDLINE` is an internal variable and is read-only. It captures the exact
> +        command line used for the current invocation of BitBake.
> +
>      :term:`BB_HASH_CODEPARSER_VALS`
>         Specifies values for variables to use when populating the codeparser cache.
>         This can be used selectively to set dummy values for variables to avoid


Looks all good to me.
Reviewed-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>

-- 
Michael Opdenacker
Root Commit
Yocto Project and OpenEmbedded Training course - Learn by doing:
https://rootcommit.com/training/yocto/


