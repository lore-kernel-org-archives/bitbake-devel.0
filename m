Return-Path: <xerofoify@gmail.com>
Received: from mail-io0-f181.google.com (mail-io0-f181.google.com
	[209.85.223.181])
	by mail.openembedded.org (Postfix) with ESMTP id DCA966014F;
	Tue, 21 Jun 2016 19:18:46 +0000 (UTC)
Received: by mail-io0-f181.google.com with SMTP id s63so21348510ioi.3;
	Tue, 21 Jun 2016 12:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=s9dRLI4gErtC8K5JMLrzVaw7/Y9qa+FRqiNk8G6tao8=;
	b=TSGLT8kW8x5INfpP1nZqLvZ9Dnsuewm/O54A2Ylxf1KstbIvqTYYePuiDFUjwDTn9Z
	Sq9rE935WVHbiQSnLas9zqLKUz8WeRHyAMob3iycm8xfqkxJfxlqFXctyz0xdEAV9Miq
	AqzoXcoRcGAOv2L+VYBzinlZKKcNs6QvLmGYFRfdxk0G6oJ7JETXZ9JC665JQozlWiHq
	+wRakM1pEwTsgB1nIaK2ZjITKeEBLmh8HwUkk/rW3NeaxKCARoGXinmMNt3GQaY3v2OV
	xu5q6L3WnEsAINCIIcJ4JDajyFGmORSQp8Rt5g8u/GdLNhStCdL7FThXQXOns5Xe8eNa
	uamw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:subject:to:references:cc:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding;
	bh=s9dRLI4gErtC8K5JMLrzVaw7/Y9qa+FRqiNk8G6tao8=;
	b=Z03yIC/NeQxdTCjje76T5jN4BStT8+bzmNNevPhkKSmFBndqTkVrXQN4m3vsq+87eT
	FUVWAMGnR18CIsPGZUhhU7Ia7QIMe7v2u2ABrPUDbuR3Sf2mnbdsDXykPI5QJb/fLLxY
	uNzb8RdknBn2xNy9ZYrRWdeSnidLPEjZLp6TWQWZR26tB0YGxkMVYyIY5otB4ng64TI+
	PLu48BeJWo22Oe07W9i2jFlR0+WJVuAPbR8XJ1SFD+Zb0IDua1NxBgeW+mnNy1uIKSMH
	4nnpCsQx9XiBKDvWSfix0eNbTReRTC+4QkXYIWNs3nNbIUWLotoJ4n5BVC0E6TTiCeKX
	k2Yg==
X-Gm-Message-State: ALyK8tLQ/p1+dQB++jbovoSi3Dx6qDKzLqvu/1EorX4krf8xj7MR5cHGpHf/zetfR5fmfw==
X-Received: by 10.107.14.71 with SMTP id 68mr36289591ioo.47.1466536726964;
	Tue, 21 Jun 2016 12:18:46 -0700 (PDT)
Received: from [192.168.0.10]
	(CPEbc4dfb2691f3-CMbc4dfb2691f0.cpe.net.cable.rogers.com.
	[99.250.193.223]) by smtp.googlemail.com with ESMTPSA id
	41sm15579240iod.43.2016.06.21.12.18.45
	(version=TLSv1/SSLv3 cipher=OTHER);
	Tue, 21 Jun 2016 12:18:45 -0700 (PDT)
To: Koen Kooi <koen@dominion.thruhere.net>
References: <1465572809.13979.185.camel@linuxfoundation.org>
	<20160610160710.GA18625@openSUSE-i7.site>
	<1465575223.13979.188.camel@linuxfoundation.org>
	<20160620024647.GA29701@openSUSE-i7.site> <57675F7C.9020909@gmail.com>
	<80947E15-FCD9-4A64-AE61-2B2381989371@dominion.thruhere.net>
	<57698986.2060808@gmail.com>
	<6F0BDB15-A440-48BF-9AB1-66F4E3324AE0@dominion.thruhere.net>
From: nick <xerofoify@gmail.com>
Message-ID: <57699314.8050002@gmail.com>
Date: Tue, 21 Jun 2016 15:18:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <6F0BDB15-A440-48BF-9AB1-66F4E3324AE0@dominion.thruhere.net>
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
X-List-Received-Date: Tue, 21 Jun 2016 19:18:48 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit



On 2016-06-21 02:48 PM, Koen Kooi wrote:
> 
> 
>> Op 21 jun. 2016 om 20:37 heeft nick <xerofoify@gmail.com> het volgende geschreven:
>>
>>
>>
>>> On 2016-06-21 09:26 AM, Koen Kooi wrote:
>>>
>>>> Op 20 jun. 2016, om 05:14 heeft nick <xerofoify@gmail.com> het volgende geschreven:
>>>>
>>>>
>>>>
>>>>> On 2016-06-19 10:46 PM, Trevor Woerner wrote:
>>>>>> On Fri 2016-06-10 @ 05:13:43 PM, Richard Purdie wrote:
>>>>>>> On Fri, 2016-06-10 at 12:07 -0400, Trevor Woerner wrote:
>>>>>>>> On Fri 2016-06-10 @ 04:33:29 PM, Richard Purdie wrote:
>>>>>>>> A few people have asked about multi-machine builds.
>>>>>>>
>>>>>>> Do you envision each config also pointing to individual bblayer
>>>>>>> configurations
>>>>>>> too? I.e. if I'm building for 3 different MACHINEs, with 3 different
>>>>>>> configs
>>>>>>> (local.conf?), then there would also be 3 different bblayers.conf's?
>>>>>>
>>>>>>
>>>>>> No, there is one local.conf and one bblayers.conf file and then three
>>>>>> different multiconfig files, each one of which sets a different
>>>>>> MACHINE.
>>>>>>
>>>>>> Would people really want to support different bblayer files? That would
>>>>>> complicate things quite a lot :/.
>>>>>
>>>>> Personally I have a common "Downloads" directory (this is probably quite normal).
>>>>>
>>>>> Then, I have a common "layers" directory in which I checkout every layer of
>>>>> which I'm aware. I also have a script that I run manually from time to time to
>>>>> keep each layer up to date (although it's capable of running any general git
>>>>> command on each git repository it finds one level beneath it):
>>>>>    https://github.com/twoerner/oe-misc/blob/master/scripts/gitcmd.sh
>>>>>
>>>>> I then create separate directories for each platform for which I'm interested
>>>>> in building (e.g. raspi2, raspi3, minnow, dragon, etc...). In each of those
>>>>> directories I have separate local.conf, bblayers.conf, sstate-cache, and tmp
>>>>> directories.
>>>>>
>>>>> I know most will disagree with this arrangement (especially the separate
>>>>> sstate-cache directories) but it's a system that has evolved over time, each
>>>>> decision was made based on experience, and it works great for me!
>>>>>
>>>>> It's been my experience that having too many layers in a build slows down the
>>>>> initial parsing stage noticeably and too often layers don't play well with
>>>>> each other. Also *many* build issues after an update can be fixed by blowing
>>>>> away tmp *and* sstate and starting over. Often, building for a particular
>>>>> board requires particular tweaks to local.conf (whether to enable a vendor
>>>>> license or to enable specific hardware/features) which don't apply to other
>>>>> boards and builds.
>>>>>
>>>>> I'm happy with the speed of my builds, and I have enough disk space to
>>>>> maintain the multiple sstates/tmps/etc. *Most* of my builds are
>>>>> core-image-full-cmdline-type builds and I can crank one of those out from
>>>>> scratch in 20 minutes (assuming the majority of sources have already been
>>>>> downloaded). Although I do sometimes need chromium (which takes an hour on its
>>>>> own) and I used to do qt (which is also quite painful). So I can understand
>>>>> how sstate might be more useful to others, but for me, not so much.
>>>> I second Trevor on this unless your building gui or media based packages sstate
>>>> is not very useful if you have a modern system with a 4 to 8 core CPU with 8 to
>>>> 16GB of ram. However if your trying to just do small tweaks to the same board and
>>>> test it may be of use as I use something similar for building the kernel called
>>>> ccache. Again as Trevor stated you may want to benchmark the results and see if
>>>> sstate actually decreases your build time by a significant margin i.e probably
>>>> more then half decreases your build speed. Otherwise I would agree with Trevor
>>>> and just not worry about sstate.
>>>
>>> My CI run that builds a basic image for about 30 machines drops from ~16 hours to about 1 hour after the first build with most of the remaining time spent in:
>>>
>>> 1) xz’ing the images
>>> 2) importing prserv-export.conf
>>> 3) parsing
>>>
>>> That’s with WORKDIR in tmpfs or nvme ssd, SSTATEDIR and DL_DIR on spinning rust RAID5, metadata on a regular ssd.
>>>
>>> regards,
>>>
>>> Koen
>> Koen,
>> I don't known the bitbake commands that well but to my knowledge there is a profile option that can tell you where you 
>> build is taking the most time. However why not try moving your whole project setup to the NVME ssd if there is enough
>> space on it, this may help improve the speed of your builds even further.
> 
> Nothing will be faster than tmpfs and the raid array is faster than pigz/Xz/bzip can process.
> 
That's true, so it seems fine to me but are you actually happy with or just curious is it's normal.
Seems pretty normal to be but then again I haven't tested on a nvme/tmpfs setup with a raid. You
can always update the CPU to more cores but it probably won't build much faster, maybe twice as 
fast depending on the processor you update to.
Nick
>> Hope this helps,
>> Nick

