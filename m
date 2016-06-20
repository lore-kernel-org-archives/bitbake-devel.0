Return-Path: <xerofoify@gmail.com>
Received: from mail-qk0-f169.google.com (mail-qk0-f169.google.com
	[209.85.220.169])
	by mail.openembedded.org (Postfix) with ESMTP id A450373175;
	Mon, 20 Jun 2016 03:14:05 +0000 (UTC)
Received: by mail-qk0-f169.google.com with SMTP id p10so146404805qke.3;
	Sun, 19 Jun 2016 20:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=V181hlVE8uVAkAEVIGIRcRYgasIFVEAJcpuOdgSqADA=;
	b=t90O7gVWsXuRQa9e8wv3wCJObLFUaL18UTjoKwhk31GimYzzsQ1hiz4EhZojBwZtIz
	JeyYTqyiCfEhmnMdsBR3/HcOoS5NkCyW6LE3I7LbTCDJVuk2hld3cKNVLH/9BYOa/5ov
	w93CZfVGqeZR1ClM/UBfeEJl8XQl2JfozEa+nmZcM8gS25ADEFfs3GoM56nj4N8CBN3L
	Jm7GDjI5g9fwBhaE6cAS3Is2yPW7fJa5RWRvtwIwEAlhLDC2rHkAMJFcaZLAaHY23om/
	WlR/FKmHyRat/Q8wgjWaDDBERAgXDxVinIdHPO+Tj2ACyyFuGwDUGmTkERNkBa/yk+En
	zJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:subject:to:references:cc:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding;
	bh=V181hlVE8uVAkAEVIGIRcRYgasIFVEAJcpuOdgSqADA=;
	b=GtmsXNECnIDVQOaT01w2uJUUh/cNgc7psz3h8aym0R00XYxNHCwWX9JBzns+rZt/tS
	SPXcU/8vJ9q3DizuePdASBiqLsRN41/ew1SeylRC7tahdHwyjp8YpDjt+lwr8mjZVPio
	7gUCfai0GyF85FfSjeSJH73pfYyPwK1KN4Or0czMoXajdbbB62yb6iTEa8AGW8OITNeP
	brB8rz42nu8ntOiRfkOleDTRLZdBV1cxJ2GjhJMYDA+SP3tMpfVo/gNWje/oOaIsbNlw
	fQxDK+L+RwsanVeqv/GI4yYfOExGxvSNnUih2956jl4186RoNtVQ4uug79jPU2BD+j/R
	vV9w==
X-Gm-Message-State: ALyK8tLdCEpwLUUDs/2xH2Ppx84vR7hvIzCixaP/Ur9mMxHedzmRI5V2cSbcUqYgcaSsiQ==
X-Received: by 10.237.50.199 with SMTP id z65mr18776919qtd.24.1466392446254;
	Sun, 19 Jun 2016 20:14:06 -0700 (PDT)
Received: from [192.168.0.10]
	(CPEbc4dfb2691f3-CMbc4dfb2691f0.cpe.net.cable.rogers.com.
	[99.250.193.223]) by smtp.googlemail.com with ESMTPSA id
	q19sm12561885qtc.33.2016.06.19.20.14.05
	(version=TLSv1/SSLv3 cipher=OTHER);
	Sun, 19 Jun 2016 20:14:05 -0700 (PDT)
To: Trevor Woerner <twoerner@gmail.com>, openembedded-architecture
	<openembedded-architecture@lists.openembedded.org>
References: <1465572809.13979.185.camel@linuxfoundation.org>
	<20160610160710.GA18625@openSUSE-i7.site>
	<1465575223.13979.188.camel@linuxfoundation.org>
	<20160620024647.GA29701@openSUSE-i7.site>
From: nick <xerofoify@gmail.com>
Message-ID: <57675F7C.9020909@gmail.com>
Date: Sun, 19 Jun 2016 23:14:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <20160620024647.GA29701@openSUSE-i7.site>
X-Mailman-Approved-At: Tue, 21 Jun 2016 10:00:41 +0000
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
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
X-List-Received-Date: Mon, 20 Jun 2016 03:14:11 -0000
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit



On 2016-06-19 10:46 PM, Trevor Woerner wrote:
> On Fri 2016-06-10 @ 05:13:43 PM, Richard Purdie wrote:
>> On Fri, 2016-06-10 at 12:07 -0400, Trevor Woerner wrote:
>>> On Fri 2016-06-10 @ 04:33:29 PM, Richard Purdie wrote:
>>>> A few people have asked about multi-machine builds.
>>>
>>> Do you envision each config also pointing to individual bblayer
>>> configurations
>>> too? I.e. if I'm building for 3 different MACHINEs, with 3 different
>>> configs
>>> (local.conf?), then there would also be 3 different bblayers.conf's?
>>
>>
>> No, there is one local.conf and one bblayers.conf file and then three
>> different multiconfig files, each one of which sets a different
>> MACHINE.
>>
>> Would people really want to support different bblayer files? That would
>> complicate things quite a lot :/.
> 
> Personally I have a common "Downloads" directory (this is probably quite normal).
> 
> Then, I have a common "layers" directory in which I checkout every layer of
> which I'm aware. I also have a script that I run manually from time to time to
> keep each layer up to date (although it's capable of running any general git
> command on each git repository it finds one level beneath it):
> 	https://github.com/twoerner/oe-misc/blob/master/scripts/gitcmd.sh
> 
> I then create separate directories for each platform for which I'm interested
> in building (e.g. raspi2, raspi3, minnow, dragon, etc...). In each of those
> directories I have separate local.conf, bblayers.conf, sstate-cache, and tmp
> directories.
> 
> I know most will disagree with this arrangement (especially the separate
> sstate-cache directories) but it's a system that has evolved over time, each
> decision was made based on experience, and it works great for me!
> 
> It's been my experience that having too many layers in a build slows down the
> initial parsing stage noticeably and too often layers don't play well with
> each other. Also *many* build issues after an update can be fixed by blowing
> away tmp *and* sstate and starting over. Often, building for a particular
> board requires particular tweaks to local.conf (whether to enable a vendor
> license or to enable specific hardware/features) which don't apply to other
> boards and builds.
> 
> I'm happy with the speed of my builds, and I have enough disk space to
> maintain the multiple sstates/tmps/etc. *Most* of my builds are
> core-image-full-cmdline-type builds and I can crank one of those out from
> scratch in 20 minutes (assuming the majority of sources have already been
> downloaded). Although I do sometimes need chromium (which takes an hour on its
> own) and I used to do qt (which is also quite painful). So I can understand
> how sstate might be more useful to others, but for me, not so much.
I second Trevor on this unless your building gui or media based packages sstate
is not very useful if you have a modern system with a 4 to 8 core CPU with 8 to
16GB of ram. However if your trying to just do small tweaks to the same board and
test it may be of use as I use something similar for building the kernel called
ccache. Again as Trevor stated you may want to benchmark the results and see if
sstate actually decreases your build time by a significant margin i.e probably
more then half decreases your build speed. Otherwise I would agree with Trevor
and just not worry about sstate.
Cheers,
Nick 
> _______________________________________________
> Openembedded-architecture mailing list
> Openembedded-architecture@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/openembedded-architecture
> 

