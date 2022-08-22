Return-Path: <marex@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E55C28D13
	for <webhook@archiver.kernel.org>; Mon, 22 Aug 2022 08:41:33 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web08.15941.1661157685946544053
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Aug 2022 01:41:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=phobos-20191101 header.b=ZcIteFgx;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: marex@denx.de)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 12CC880755;
	Mon, 22 Aug 2022 10:41:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1661157684;
	bh=k6x1adt36XxYONuHEwGCjmUystJxyMOjBgm+mwTbghA=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=ZcIteFgxBhgd6YbZ5UZCScb4XilbITKkCL9Tyad2R7ay2iytMdedshh77lvIzE+Xw
	 jkPcdBYhIDpp7TmruzNFL2ZnenHp8PlBn1XD8VhtkxqYwa0KDzOXsgIW4QtzBmtbPK
	 YQm8j33fsYgdaGMe7QVB3De3P/Wg0HNp8KgNQaMt31/qVTlPFEGLNMf+UfO8npnsdZ
	 p60FEEHf15Gc4pj2TFGeoE15k+eWIoy1gXopdW3TdtaSAlaAMLcj1Aj6kYuqTt/Qi0
	 Si0YYsdGg+0wm9tw18JrJZIBj/6d2wu4Xc/J28nJGExqCEW+SLcdpmGtO84WMlUWp/
	 AEILk5vtmFhaA==
Message-ID: <0762e114-4233-8b43-b796-cab61e4881bc@denx.de>
Date: Mon, 22 Aug 2022 10:41:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [bitbake-devel] [PATCH] [RFC] fetch2/git: Prevent git fetcher
 from fetching gitlab repository metadata
From: Marek Vasut <marex@denx.de>
To: Mikko.Rapeli@bmw.de, alex.kanavin@gmail.com
Cc: Martin.Jansa@gmail.com, bitbake-devel@lists.openembedded.org,
 peter.kjellerstedt@axis.com, richard.purdie@linuxfoundation.org
References: <20220819165455.270130-1-marex@denx.de>
 <ab9e6c5562c44ac68e5d5e13e82dc8c0@axis.com> <YwMR+H8KWePvpJtn@korppu>
 <CANNYZj_Ag2Y8ZTXVgwagGv+26+HKPM31SRq8p3h4EL0PUEPefQ@mail.gmail.com>
 <YwMyXi/vfRh3S6bx@korppu> <7b3d167e-17c0-c236-d0a7-97c4b0fd8e27@denx.de>
 <c4c53113-49bd-ec7b-b5dd-f510c281f013@denx.de>
Content-Language: en-US
In-Reply-To: <c4c53113-49bd-ec7b-b5dd-f510c281f013@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Aug 2022 08:41:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13915

On 8/22/22 10:37, Marek Vasut wrote:
> On 8/22/22 10:29, Marek Vasut wrote:
>> On 8/22/22 09:38, Mikko.Rapeli@bmw.de wrote:
>>> On Mon, Aug 22, 2022 at 08:57:11AM +0200, Alexander Kanavin wrote:
>>>> Can be solved with a parameter to a fetcher perhaps?
>>>
>>> Frequently developers know to change the git URL in recipes from
>>> "branch=master" to "nobranch=1" for their test commits.
>>>
>>> This could be used for fetching the changes too, to limit the scope.
>>
>> So maybe the easy way out is, if nobranch=1 then fetch everything, 
>> else just heads and tags ?
> 
> No, this won't do, nobranch expects the commit to be in a tag.

But then, if gerrit works with nobranch=1, then gerrit must be 
generating tags which contain the commits you test ?

And since this patch fetches refs/tags/ , then this patch won't break 
the gerrit setup ?

