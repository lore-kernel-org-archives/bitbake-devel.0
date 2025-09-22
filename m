Return-Path: <jeroen@myspectrum.nl>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A83CA100F
	for <webhook@archiver.kernel.org>; Mon, 22 Sep 2025 20:05:51 +0000 (UTC)
Received: from outbound8.mail.transip.nl (outbound8.mail.transip.nl [136.144.136.8])
 by mx.groups.io with SMTP id smtpd.web11.579.1758571544647792353
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Sep 2025 13:05:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@myspectrum.nl header.s=transip-a header.b=SF1w0Sw9;
 spf=pass (domain: myspectrum.nl, ip: 136.144.136.8, mailfrom: jeroen@myspectrum.nl)
Received: from submission15.mail.transip.nl (unknown [10.103.8.166])
	by outbound8.mail.transip.nl (Postfix) with ESMTP id 4cVvHV572xzY76WM;
	Mon, 22 Sep 2025 22:05:42 +0200 (CEST)
Received: from yellow.myspectrum.nl (unknown [IPv6:2a01:7c8:bb0c:45:5054:ff:fe01:854])
	by submission15.mail.transip.nl (Postfix) with ESMTPSA id 4cVvHV0WYJz2mZN0T;
	Mon, 22 Sep 2025 22:05:42 +0200 (CEST)
Received: from [192.168.178.17] (82-75-103-118.cable.dynamic.v4.ziggo.nl [82.75.103.118])
	(Authenticated sender: jeroen@myspectrum.nl)
	by yellow.myspectrum.nl (Postfix) with ESMTPSA id 7BAB82012A;
	Mon, 22 Sep 2025 20:05:41 +0000 (UTC)
Authentication-Results: yellow.myspectrum.nl;
	auth=pass smtp.auth=jeroen@myspectrum.nl smtp.mailfrom=jeroen@myspectrum.nl
Message-ID: <c136f020-69dd-427e-89ed-d9a487ff4477@myspectrum.nl>
Date: Mon, 22 Sep 2025 22:05:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] fetch2: npm: do keep the sha256sum
To: bitbake-devel@lists.openembedded.org
References: <20250922195059.1052515-1-jeroen@myspectrum.nl>
Content-Language: en-US
Cc: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
From: Jeroen Hofstee <jeroen@myspectrum.nl>
In-Reply-To: <20250922195059.1052515-1-jeroen@myspectrum.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: ClueGetter at submission15.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=myspectrum.nl; t=1758571542; h=from:subject:to:cc:
 references:in-reply-to:date:mime-version:content-type;
 bh=Z39Ia0F1WmKSj82nBbav+x4vYSk/LghYOqmwgehoixw=;
 b=SF1w0Sw9rikKtzHxA4+Ilp6uax6WHKeVcukuRoiRm8Ui6riouSAaryUxRP6+NQ6cz1D7lF
 LjRLWHRmmDkLAiASmihjWR5oLSn4TcmFG1RlrV2Uxdmgt719vfIkouwz3cLfIyIPKul85Z
 yW5sbf4WvN/QLWALctUx2SE0LCp24H+SJ5fQ/z8aMPsyzDtlIFErom5mDD3wpTi7HSC/mf
 1s3/wuisr1AokkL0t0hW74oRSj6ZbNb7sVrjhG139RUJ3l+FFdfFvAzwrz6BpmtRIGnEJR
 c61/ZBenvD+trGzySCWLMqNf3LVeDBbhazCciMKBLbYvSiMXCumFt5/A9rZYzw==
X-Report-Abuse-To: abuse@transip.nl
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Sep 2025 20:05:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18075

cc-ing Stefan Herbrechtsmeier who is the author of mentioned
patch.

On 9/22/25 21:50, jeroen@myspectrum.nl wrote:
> From: Jeroen Hofstee <jhofstee@victronenergy.com>
>
> commit 8d3232152e ("fetch2: read checksum from SRC_URI flag for npm")
> added npm to require a checksum. The checksum is also added with the
> `npm view` command which relies on downloaded data. Furthermore in
> _setup_proxy all the SRC_URI variables are removed, so an explicit
> local SRC_URI[sha256sum] is removed and it only checks the online
> checksum from npm view.
>
> This removes the data.delVarFlags("SRC_URI"), so the check works again,
> but given the comment "Avoid conflicts between the environment data and
> the proxy url checksum", there might be reason for that, but I wouldn't
> expect tarballs to differ when served directly or via a proxy.
>
> We might consider getting rid of npm_integrity completely and force
> having a local checksum and not depend on the npm infrastructure.
> ---
>   lib/bb/fetch2/npm.py | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
> index e469d6676..ad740f832 100644
> --- a/lib/bb/fetch2/npm.py
> +++ b/lib/bb/fetch2/npm.py
> @@ -269,7 +269,8 @@ class Npm(FetchMethod):
>               # Avoid conflicts between the environment data and:
>               # - the proxy url checksum
>               data = bb.data.createCopy(d)
> -            data.delVarFlags("SRC_URI")
> +            # XXX: What is the purpose of removing SRC_URI, it also removes the checksum...
> +            #data.delVarFlags("SRC_URI")
>               ud.proxy = Fetch([url], data)
>   
>       def _get_proxy_method(self, ud, d):

