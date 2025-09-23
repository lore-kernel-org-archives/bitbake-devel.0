Return-Path: <jeroen@myspectrum.nl>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2541CAC5B0
	for <webhook@archiver.kernel.org>; Tue, 23 Sep 2025 10:31:20 +0000 (UTC)
Received: from outbound10.mail.transip.nl (outbound10.mail.transip.nl [136.144.136.17])
 by mx.groups.io with SMTP id smtpd.web10.13527.1758623471783639064
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 23 Sep 2025 03:31:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@myspectrum.nl header.s=transip-a header.b=iBeNXkkU;
 spf=pass (domain: myspectrum.nl, ip: 136.144.136.17, mailfrom: jeroen@myspectrum.nl)
Received: from submission15.mail.transip.nl (unknown [10.103.8.166])
	by outbound10.mail.transip.nl (Postfix) with ESMTP id 4cWGV554ZczTPNWj;
	Tue, 23 Sep 2025 12:31:09 +0200 (CEST)
Received: from yellow.myspectrum.nl (unknown [IPv6:2a01:7c8:bb0c:45:5054:ff:fe01:854])
	by submission15.mail.transip.nl (Postfix) with ESMTPSA id 4cWGV320hdz2mZN1X;
	Tue, 23 Sep 2025 12:31:07 +0200 (CEST)
Received: from [192.168.178.17] (82-75-103-118.cable.dynamic.v4.ziggo.nl [82.75.103.118])
	(Authenticated sender: jeroen@myspectrum.nl)
	by yellow.myspectrum.nl (Postfix) with ESMTPSA id 302B42001F;
	Tue, 23 Sep 2025 10:31:06 +0000 (UTC)
Authentication-Results: yellow.myspectrum.nl;
	auth=pass smtp.auth=jeroen@myspectrum.nl smtp.mailfrom=jeroen@myspectrum.nl
Message-ID: <d4c9b66f-9e3d-48f7-b9fa-0744f3548c8a@myspectrum.nl>
Date: Tue, 23 Sep 2025 12:31:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [RFC] fetch2: npm: do keep the sha256sum
To: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>,
 bitbake-devel@lists.openembedded.org
Cc: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
References: <20250922195059.1052515-1-jeroen@myspectrum.nl>
 <c136f020-69dd-427e-89ed-d9a487ff4477@myspectrum.nl>
 <e4bd126f-ddbb-4632-a871-078e1a9ac383@weidmueller.com>
Content-Language: en-US
From: Jeroen Hofstee <jeroen@myspectrum.nl>
In-Reply-To: <e4bd126f-ddbb-4632-a871-078e1a9ac383@weidmueller.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: ClueGetter at submission15.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=myspectrum.nl; t=1758623467; h=from:subject:to:cc:
 references:in-reply-to:date:mime-version:content-type;
 bh=qTJUyRZznTlGjA3Jc3P4gtp5eVcnVKY/F8tmgUVV0Y4=;
 b=iBeNXkkUzQGv1412WAjOwA8tfuVllakvisEc2muNN/VouPqLItv+SfMF39c5Bb9x5gKMN9
 GNbdkWyK/GCvXFNsrNCw7RRFqprcJh97/cGiGFt2ug1OpIj7UYboLHyM0YtMmu03uk4AZQ
 MN3Qy7kcsRkCU7qNrLYIGNeowhKYpqJExOrTBJQNSnzGj8rciH9tmBOwZZcLHxDVZm+DKh
 DWtdyICN64+DvfrkjAWGCUxQfWGiKYpj/qp1TREvBuEbqPAmPriJiKixOojdesBG1Za9MZ
 NQDZkvrh/iosCy8D0Rcxo3Sjefzt1tkweruvKZ+QksEciXuzjuDQs4cNL2Kmlw==
X-Report-Abuse-To: abuse@transip.nl
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 23 Sep 2025 10:31:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18081

Hello Stefan,

On 9/23/25 12:25, Stefan Herbrechtsmeier wrote:
> Am 22.09.2025 um 22:05 schrieb Jeroen Hofstee via lists.openembedded.org:
>> cc-ing Stefan Herbrechtsmeier who is the author of mentioned
>> patch.
>
> Please revert the mention patch. The npm fetcher inject the checksum 
> on the fly from the remote source. The mention patch was part of a 
> proposed rework of the npm fetcher to use local checksum and remove 
> the dependency to the npm binary.
>

I would say what you did actually a good thing. Afaiac we should
get rid of "The npm fetcher inject the checksum on the fly from the
remote source"

Regards,

Jeroen


