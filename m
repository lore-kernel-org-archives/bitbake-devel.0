Return-Path: <xerofoify@gmail.com>
Received: from mail-io0-f170.google.com (mail-io0-f170.google.com
	[209.85.223.170])
	by mail.openembedded.org (Postfix) with ESMTP id 9F798601B8;
	Tue, 21 Jun 2016 18:37:59 +0000 (UTC)
Received: by mail-io0-f170.google.com with SMTP id f30so24165418ioj.2;
	Tue, 21 Jun 2016 11:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=xod5gAJg7kac3sbFNVa3R6hTZ17t21+PJgQmqGfesuQ=;
	b=TxQ+UvtNkxiBpAdHnty4lSV7sVu3XIRNjo5lXyv5nZ3nqvnsnaFp74g/Gn5wD/r2oQ
	VkBj1BG/XW6rt+zggdo054M3lyCn3dJk9PtSioyTzAxHfQhD4nJkqbS5cFazlxuM4ygr
	6/fcqDOM7EAP/bgeK1de5/LdwJEszjekAE1n5BE780bBhzyGvcqn+zqAfxl/Pkt6+ix6
	eq/H9VxkDL8/7Ly7KPuqArV40Czo4a+EQSwU0KH6GqOh0ee/m5K9+7E9sNKet0iTwyCE
	0a14pPcJhF11Jn6ATxX0rUIPpZpju+/u5q23UcYPubhgMO6l+jrTtP2DbVRoUHN6G6C5
	x0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:subject:to:references:cc:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding;
	bh=xod5gAJg7kac3sbFNVa3R6hTZ17t21+PJgQmqGfesuQ=;
	b=hkk8m4VwMRBGj8wLPf87Fhak6Vy7qX/1gPTQM4LkuZBRR11evTERWFsSKiMc3lS3Ky
	dxfHYoympZWNJF+9lL/+mwnSqE+QPDlRkKmwlDunDmrdjj2zez74oDCXkNWi3oDpUYUV
	1NNlEA4Ce4IbT5L3n/syPRrdZdnn29v9tx8l1tl4/7aqoml7V1sjicsQrBBJuNmvAJrw
	d7KV9W0DiAC/iQBKN4fASV7rUUtMLX2DKdRpaWOK/rHvjUyFPeQX2IERCwYDJ6wm/L8M
	YCfolZHVSxdFCOgPA3Z4TsNXvZBsOCV0LSLDR6o5LqnEPeULBUi4v52l2mUA16RM46xc
	N/ng==
X-Gm-Message-State: ALyK8tKq/ILCoKeeUj09Sq+3jc62cjnpSngXdwdQUka+XmP2Kx/FxWk2Utkch/lUrGAfDg==
X-Received: by 10.107.7.228 with SMTP id g97mr33191993ioi.64.1466534279735;
	Tue, 21 Jun 2016 11:37:59 -0700 (PDT)
Received: from [192.168.0.10]
	(CPEbc4dfb2691f3-CMbc4dfb2691f0.cpe.net.cable.rogers.com.
	[99.250.193.223]) by smtp.googlemail.com with ESMTPSA id
	w63sm1949487itf.6.2016.06.21.11.37.58
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 Jun 2016 11:37:59 -0700 (PDT)
To: Koen Kooi <koen@dominion.thruhere.net>
References: <1465572809.13979.185.camel@linuxfoundation.org>
	<20160610160710.GA18625@openSUSE-i7.site>
	<1465575223.13979.188.camel@linuxfoundation.org>
	<20160620024647.GA29701@openSUSE-i7.site> <57675F7C.9020909@gmail.com>
	<80947E15-FCD9-4A64-AE61-2B2381989371@dominion.thruhere.net>
From: nick <xerofoify@gmail.com>
Message-ID: <57698986.2060808@gmail.com>
Date: Tue, 21 Jun 2016 14:37:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <80947E15-FCD9-4A64-AE61-2B2381989371@dominion.thruhere.net>
Cc: openembedded-architecture
	<openembedded-architecture@lists.openembedded.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [Openembedded-architecture] Multi-configuration builds
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
X-List-Received-Date: Tue, 21 Jun 2016 18:38:01 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit



On 2016-06-21 09:26 AM, Koen Kooi wrote:
> 
>> Op 20 jun. 2016, om 05:14 heeft nick <xerofoify@gmail.com> het volgende geschreven:
>>
>>
>>
>> On 2016-06-19 10:46 PM, Trevor Woerner wrote:
>>> On Fri 2016-06-10 @ 05:13:43 PM, Richard Purdie wrote:
>>>> On Fri, 2016-06-10 at 12:07 -0400, Trevor Woerner wrote:
>>>>> On Fri 2016-06-10 @ 04:33:29 PM, Richard Purdie wrote:
>>>>>> A few people have asked about multi-machine builds.
>>>>>
>>>>> Do you envision each config also pointing to individual bblayer
>>>>> configurations
>>>>> too? I.e. if I'm building for 3 different MACHINEs, with 3 different
>>>>> configs
>>>>> (local.conf?), then there would also be 3 different bblayers.conf's?
>>>>
>>>>
>>>> No, there is one local.conf and one bblayers.conf file and then three
>>>> different multiconfig files, each one of which sets a different
>>>> MACHINE.
>>>>
>>>> Would people really want to support different bblayer files? That would
>>>> complicate things quite a lot :/.
>>>
>>> Personally I have a common "Downloads" directory (this is probably quite normal).
>>>
>>> Then, I have a common "layers" directory in which I checkout every layer of
>>> which I'm aware. I also have a script that I run manually from time to time to
>>> keep each layer up to date (although it's capable of running any general git
>>> command on each git repository it finds one level beneath it):
>>> 	https://github.com/twoerner/oe-misc/blob/master/scripts/gitcmd.sh
>>>
>>> I then create separate directories for each platform for which I'm interested
>>> in building (e.g. raspi2, raspi3, minnow, dragon, etc...). In each of those
>>> directories I have separate local.conf, bblayers.conf, sstate-cache, and tmp
>>> directories.
>>>
>>> I know most will disagree with this arrangement (especially the separate
>>> sstate-cache directories) but it's a system that has evolved over time, each
>>> decision was made based on experience, and it works great for me!
>>>
>>> It's been my experience that having too many layers in a build slows down the
>>> initial parsing stage noticeably and too often layers don't play well with
>>> each other. Also *many* build issues after an update can be fixed by blowing
>>> away tmp *and* sstate and starting over. Often, building for a particular
>>> board requires particular tweaks to local.conf (whether to enable a vendor
>>> license or to enable specific hardware/features) which don't apply to other
>>> boards and builds.
>>>
>>> I'm happy with the speed of my builds, and I have enough disk space to
>>> maintain the multiple sstates/tmps/etc. *Most* of my builds are
>>> core-image-full-cmdline-type builds and I can crank one of those out from
>>> scratch in 20 minutes (assuming the majority of sources have already been
>>> downloaded). Although I do sometimes need chromium (which takes an hour on its
>>> own) and I used to do qt (which is also quite painful). So I can understand
>>> how sstate might be more useful to others, but for me, not so much.
>> I second Trevor on this unless your building gui or media based packages sstate
>> is not very useful if you have a modern system with a 4 to 8 core CPU with 8 to
>> 16GB of ram. However if your trying to just do small tweaks to the same board and
>> test it may be of use as I use something similar for building the kernel called
>> ccache. Again as Trevor stated you may want to benchmark the results and see if
>> sstate actually decreases your build time by a significant margin i.e probably
>> more then half decreases your build speed. Otherwise I would agree with Trevor
>> and just not worry about sstate.
> 
> My CI run that builds a basic image for about 30 machines drops from ~16 hours to about 1 hour after the first build with most of the remaining time spent in:
> 
> 1) xz’ing the images
> 2) importing prserv-export.conf
> 3) parsing
> 
> That’s with WORKDIR in tmpfs or nvme ssd, SSTATEDIR and DL_DIR on spinning rust RAID5, metadata on a regular ssd.
> 
> regards,
> 
> Koen
> 
Koen,
I don't known the bitbake commands that well but to my knowledge there is a profile option that can tell you where you 
build is taking the most time. However why not try moving your whole project setup to the NVME ssd if there is enough
space on it, this may help improve the speed of your builds even further.
Hope this helps,
Nick

