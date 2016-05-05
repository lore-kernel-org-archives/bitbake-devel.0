Return-Path: <akuster@mvista.com>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
	[209.85.220.49])
	by mail.openembedded.org (Postfix) with ESMTP id 5DB7D731D4
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  5 May 2016 17:50:28 +0000 (UTC)
Received: by mail-pa0-f49.google.com with SMTP id xk12so38536670pac.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 05 May 2016 10:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mvista-com.20150623.gappssmtp.com; s=20150623;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=VU+zXimfihXdCGYhCxpLFgrVLnwoABJ8AFlbjNoqog4=;
	b=N83rL5lisHnMEqu7W9U56ED/WTSh+D9cGunc5koJYS8EV73UM1dj5DIJCE30Aa/0+/
	Y7LY5kIZnyGA6cpAX+HzxGq3cer6B1agnBbVYHaPtfhct5OBp9sI/KL6PpTeI0ySdVac
	BN61ve3iRYiUGk+y06IZkvryxWzu224K3VdllofPOpGZ+uzYXndN18i5i5qAPry/HncA
	1X0etKqZuAMcpKVEF0o4JH+NEPH7PTocPJVqxP2aOIFLGp70Qu9LeuzwA/MsH+P8/jC/
	gyILYXb6Cx5u+x1UXtmYJ3ZiwnWMDRd8yr4jCFrafvMfYemzrmyEfAFxZry3EVZp8LTi
	N25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:subject:to:references:cc:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding;
	bh=VU+zXimfihXdCGYhCxpLFgrVLnwoABJ8AFlbjNoqog4=;
	b=AH7tbZhQcpV3pWYSXJSOttWkTVV1MtgFx3LwwhCz9jJZ+iAC6927EGspAitU/qG0oi
	cI7CSe+hpLhlZBaiaMSL5AyMlCUrYBCZlWpNF5/PQEJ6s+nOriTeG8wR+4FxiDalWZmk
	Bq9+ibjcgHAq2n5RtqnBuUOLGnOIDgUgRFHThOjYN2IxGn3f4maifJDc1DrOiWXQl44q
	dYRZV7F6664jaljf/4jE8lN2IAXj1nKY6nZgcfzvoo3aXaPkiOaY5RAqSeKm7vr/3hMK
	9TxXOATyHtgHkmxLAEq2hCQClX8NGpE7AH6VmtLJ5d50H8jA3kFycyopWG97eFl6SBVS
	Q7eA==
X-Gm-Message-State: AOPr4FV46fBB5E4Z4z9NVe9DsU+byR3cjfdsOfGr0zCAaskvs1BOUfv2q5R3mfvsbOlvqSN+
X-Received: by 10.66.153.209 with SMTP id vi17mr22480682pab.0.1462470629752;
	Thu, 05 May 2016 10:50:29 -0700 (PDT)
Received: from ?IPv6:2601:202:4000:1239:f10a:9ff0:2d1d:e70f?
	([2601:202:4000:1239:f10a:9ff0:2d1d:e70f])
	by smtp.googlemail.com with ESMTPSA id
	xn3sm15201318pab.32.2016.05.05.10.50.28
	(version=TLSv1/SSLv3 cipher=OTHER);
	Thu, 05 May 2016 10:50:28 -0700 (PDT)
To: =?UTF-8?Q?Jan-Simon_M=c3=b6ller?= <dl9pf@gmx.de>,
	openembedded-architecture@lists.openembedded.org
References: <1462352176.18407.11.camel@linuxfoundation.org>
	<cb3d3b05-4d43-dbdb-e905-c407ce6219ec@balister.org>
	<fce22d23-e66c-c692-f7d5-f1154081246a@windriver.com>
	<9084039.ulb8Qqh204@elrond>
From: akuster <akuster@mvista.com>
Message-ID: <572B87E3.9020105@mvista.com>
Date: Thu, 5 May 2016 10:50:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <9084039.ulb8Qqh204@elrond>
Cc: Philip Balister <philip@balister.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [Openembedded-architecture] Python 3 for Bitbake
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 05 May 2016 17:50:30 -0000
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit



On 05/05/2016 10:29 AM, Jan-Simon Möller wrote:
> Am Donnerstag, 5. Mai 2016, 10:13:21 schrieb Mark Hatle:
>>>> Question, do we need any type of identifier in layers to say they're
>>>> "python3" compatible or not?
>>>
>>> Layers that are python2 will need krogoth branches. I'd expect master
>>> branches to follow oe-core/master and jump to python3.
>>
>> I don't disagree, but my experience has been that branching is late or never
>> in a lot of layers.
>>
>> This might be a place where we need to plan to go through the layer index
>> and at least see if the layer parses -- and flag things that no longer
>> parse?  (I don't even know if this is something reasonable to attempt.)
>>
>> My fear is just we've already got a lot of "broken" (without defining that)
>> layers in the index, and I think it will be worse once the python3 change
>> happens.  I'd really like to make sure we don't confuse people with various
>> errors.
>>
> 
> As it is a hard cut anyway, call it YP 3.0 (!) and start with an empty 
> layerindex for 3.0 and only add layers that parse or are maintained.
> Legacy is 1.x/2.x and will be a separate page.

That would be the lest disruptive but I fear the Python3 switch over
wont happen for a very long time. The same people doing that work would
most likely be active on or maintaining 2.x

- armin
> 
> 
> --
> Jan-Simon Möller
> dl9pf@gmx.de
> 

