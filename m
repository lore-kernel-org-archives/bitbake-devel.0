Received: from vrout30.yaziba.net (vrout30.yaziba.net [185.56.204.33])
 by mx.groups.io with SMTP id smtpd.web10.192033.1598262079903656673
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Aug 2020 02:41:20 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: softathome.com, ip: 185.56.204.33, mailfrom: chris.minnoy_ext@softathome.com)
Received: from mtaout20.int.yaziba.net (mtaout20.int.yaziba.net [10.4.20.37])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by vrout30.yaziba.net (mx10.yaziba.net) with ESMTPS id 4F36351FCA;
	Mon, 24 Aug 2020 11:41:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mtaout20.int.yaziba.net (Postfix) with ESMTP id 7472F1605D6;
	Mon, 24 Aug 2020 11:41:16 +0200 (CEST)
Received: from mtaout20.int.yaziba.net ([127.0.0.1])
	by localhost (mtaout20.int.yaziba.net [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6xLidO7NFoaD; Mon, 24 Aug 2020 11:41:16 +0200 (CEST)
Received: from [192.168.1.77] (186.93-200-80.adsl-dyn.isp.belgacom.be [80.200.93.186])
	by mtaout20.int.yaziba.net (Postfix) with ESMTPSA id 50BBD160032;
	Mon, 24 Aug 2020 11:41:16 +0200 (CEST)
Subject: Re: [bitbake-devel] [PATCH] ipk ar/tar unpack
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
References: <436e18f3d9dd0fd0ae23547f4172f907fed50dc9.camel@linuxfoundation.org>
 <5687.1596801277895813527@lists.openembedded.org>
 <ebc1c0da5227e49deb6778b571a58adf56a4d79d.camel@linuxfoundation.org>
From: "Chris Minnoy" <chris.minnoy_ext@softathome.com>
Organization: Soft At Home
Message-ID: <8e66e77b-c292-fa9e-dfbd-dfb37eb63c5a@softathome.com>
Date: Mon, 24 Aug 2020 11:41:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ebc1c0da5227e49deb6778b571a58adf56a4d79d.camel@linuxfoundation.org>
X-CLAMAV-SCAN: ok
X-VRSPAM-SCORE: -51
X-VRSPAM-STATE: legit
X-VRSPAM-CAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedruddukedgtdegucetufdoteggodetrfcurfhrohhfihhlvgemucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpefuvfhfhfhokffffgggjggtgfesthejredttdefjeenucfhrhhomhepvehhrhhishcuofhinhhnohihuceotghhrhhishdrmhhinhhnohihpggvgihtsehsohhfthgrthhhohhmvgdrtghomheqnecuggftrfgrthhtvghrnhepleduvdejkeekudeggeeltdefhfdtgffgheevheehheehtedvudejgeefleevjeelnecuffhomhgrihhnpehtrghrrdgrrhenucfkphepkedtrddvtddtrdelfedrudekieenucfrrghrrghmpehmohguvgepshhmthhpohhuth
X-VRSPAM-EXTCAUSE: mhhouggvpehsmhhtphhouhht
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US

We sometimes import ipk packages from OpenWRT into Yocto.
Unfortunatly they use the other archiver; hence the patch.

Cheers,

Chris

On 07/08/2020 15:01, Richard Purdie wrote:
> On Fri, 2020-08-07 at 04:54 -0700, Chris Minnoy wrote:
>>  From d21155c4b55ac96d3c13a3cef1f020df67b62641 Mon Sep 17 00:00:00
>> 2001
>> From: Chris Minnoy <chris.minnoy_ext@softathome.com>
>> Date: Fri, 7 Aug 2020 11:35:27 +0000
>> Subject: [PATCH 1/1] bitbake fetch2: fetcher can now unpack .ipk
>> files from ar and tar format
>>
>> Ipk packages can be formed with ar or tar. ar/tar can't read each
>> others archives.
>> This fixes the unpack to call the correct archiver based on the
>> format.
> What is creating ipk files using tar instead of ar?
>
> I know they did once exist but I've not seen real world use of those
> for many years?
>
> Cheers,
>
> Richard
>
-- 
With kind regards,

Chris Minnoy

