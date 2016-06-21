Return-Path: <koen@dominion.thruhere.net>
Received: from mail-lf0-f46.google.com (mail-lf0-f46.google.com
	[209.85.215.46])
	by mail.openembedded.org (Postfix) with ESMTP id DB6C8605BB
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Jun 2016 13:26:32 +0000 (UTC)
Received: by mail-lf0-f46.google.com with SMTP id l188so23574785lfe.2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Jun 2016 06:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=dominion-thruhere-net.20150623.gappssmtp.com; s=20150623;
	h=mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=fWPJGhtohezewskcrFNSp8jRuu3BNxe6CVnhVV4lxTM=;
	b=Uvt7A+shKZ6IwEGMlnaaeqXWbDPiSRRLpIoNtahH5INzoO+rLDh7qJXesPspdGOZPj
	asxyNHZ8Z/TBrFDgbIQhml8zLr7HwozzPM4PoVRAFTO8RxiU/hTEsvk2GToOqVLPwQff
	hrBjaX1BQv541wThxL7wMmlkKiGxUKcrFV5c0TfWllTUsJvEi9/u+QNNbdPEIKxqPBu9
	w/LoxF71Ddf4miparpVtwmOb78KEYK55T8VFH/imjGYFTI+XSv2CR1D4Y7VhUZZbME01
	lP1hPeGysb3YDogLLxZUqZmSTeGGgfK33QLFpjQMt7lBXO66Hbg76nxjV+fXZHTToATP
	L82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=fWPJGhtohezewskcrFNSp8jRuu3BNxe6CVnhVV4lxTM=;
	b=CnA+X+0TqS0Ytk/WchbHE3+rVec9o5CvjZv1DpQXxL2c8RIvYGUm1TKUI37Bo4c497
	KO+07Ooa/Z622XCOP2QWGHHayFCOrBsToLf/1Km+YPjkBg4wbt4hNEO48qYDGigyWhkv
	9iJ1gg3UB59QsH55NbJiQ2Xm2oyT0gxCl0V69ej9E4KFMhSGxjpTbaYzbkUqC3Q7M+kr
	WCBlywPai/gykpEaPhARbbI5McsxcTBnxQ3roW1+J3QxmihJ28yGOjs+JPQIuh3BOefN
	rwkIpHhThSpabe7Jo98Ya7iIn3l3JBHheQMSOQli3ZzNsYN6mZIF8Rdhf6QgZZIBHU/k
	WF+Q==
X-Gm-Message-State: ALyK8tLbuGH5bV9+8HdECq+B5CUgUrhaU7yDJU6om0b5B5gjr1anuOWC/qnWRr268kH+Hw==
X-Received: by 10.28.154.214 with SMTP id c205mr3332445wme.9.1466515591971;
	Tue, 21 Jun 2016 06:26:31 -0700 (PDT)
Received: from [172.20.0.187] (ip4da2a5ae.direct-adsl.nl. [77.162.165.174])
	by smtp.gmail.com with ESMTPSA id
	v200sm3022901wmv.4.2016.06.21.06.26.30
	(version=TLSv1/SSLv3 cipher=OTHER);
	Tue, 21 Jun 2016 06:26:31 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Koen Kooi <koen@dominion.thruhere.net>
In-Reply-To: <57675F7C.9020909@gmail.com>
Date: Tue, 21 Jun 2016 15:26:29 +0200
Message-Id: <80947E15-FCD9-4A64-AE61-2B2381989371@dominion.thruhere.net>
References: <1465572809.13979.185.camel@linuxfoundation.org>
	<20160610160710.GA18625@openSUSE-i7.site>
	<1465575223.13979.188.camel@linuxfoundation.org>
	<20160620024647.GA29701@openSUSE-i7.site>
	<57675F7C.9020909@gmail.com>
To: nick <xerofoify@gmail.com>
X-Mailer: Apple Mail (2.3124)
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
X-List-Received-Date: Tue, 21 Jun 2016 13:26:35 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


> Op 20 jun. 2016, om 05:14 heeft nick <xerofoify@gmail.com> het =
volgende geschreven:
>=20
>=20
>=20
> On 2016-06-19 10:46 PM, Trevor Woerner wrote:
>> On Fri 2016-06-10 @ 05:13:43 PM, Richard Purdie wrote:
>>> On Fri, 2016-06-10 at 12:07 -0400, Trevor Woerner wrote:
>>>> On Fri 2016-06-10 @ 04:33:29 PM, Richard Purdie wrote:
>>>>> A few people have asked about multi-machine builds.
>>>>=20
>>>> Do you envision each config also pointing to individual bblayer
>>>> configurations
>>>> too? I.e. if I'm building for 3 different MACHINEs, with 3 =
different
>>>> configs
>>>> (local.conf?), then there would also be 3 different =
bblayers.conf's?
>>>=20
>>>=20
>>> No, there is one local.conf and one bblayers.conf file and then =
three
>>> different multiconfig files, each one of which sets a different
>>> MACHINE.
>>>=20
>>> Would people really want to support different bblayer files? That =
would
>>> complicate things quite a lot :/.
>>=20
>> Personally I have a common "Downloads" directory (this is probably =
quite normal).
>>=20
>> Then, I have a common "layers" directory in which I checkout every =
layer of
>> which I'm aware. I also have a script that I run manually from time =
to time to
>> keep each layer up to date (although it's capable of running any =
general git
>> command on each git repository it finds one level beneath it):
>> 	=
https://github.com/twoerner/oe-misc/blob/master/scripts/gitcmd.sh
>>=20
>> I then create separate directories for each platform for which I'm =
interested
>> in building (e.g. raspi2, raspi3, minnow, dragon, etc...). In each of =
those
>> directories I have separate local.conf, bblayers.conf, sstate-cache, =
and tmp
>> directories.
>>=20
>> I know most will disagree with this arrangement (especially the =
separate
>> sstate-cache directories) but it's a system that has evolved over =
time, each
>> decision was made based on experience, and it works great for me!
>>=20
>> It's been my experience that having too many layers in a build slows =
down the
>> initial parsing stage noticeably and too often layers don't play well =
with
>> each other. Also *many* build issues after an update can be fixed by =
blowing
>> away tmp *and* sstate and starting over. Often, building for a =
particular
>> board requires particular tweaks to local.conf (whether to enable a =
vendor
>> license or to enable specific hardware/features) which don't apply to =
other
>> boards and builds.
>>=20
>> I'm happy with the speed of my builds, and I have enough disk space =
to
>> maintain the multiple sstates/tmps/etc. *Most* of my builds are
>> core-image-full-cmdline-type builds and I can crank one of those out =
from
>> scratch in 20 minutes (assuming the majority of sources have already =
been
>> downloaded). Although I do sometimes need chromium (which takes an =
hour on its
>> own) and I used to do qt (which is also quite painful). So I can =
understand
>> how sstate might be more useful to others, but for me, not so much.
> I second Trevor on this unless your building gui or media based =
packages sstate
> is not very useful if you have a modern system with a 4 to 8 core CPU =
with 8 to
> 16GB of ram. However if your trying to just do small tweaks to the =
same board and
> test it may be of use as I use something similar for building the =
kernel called
> ccache. Again as Trevor stated you may want to benchmark the results =
and see if
> sstate actually decreases your build time by a significant margin i.e =
probably
> more then half decreases your build speed. Otherwise I would agree =
with Trevor
> and just not worry about sstate.

My CI run that builds a basic image for about 30 machines drops from ~16 =
hours to about 1 hour after the first build with most of the remaining =
time spent in:

1) xz=E2=80=99ing the images
2) importing prserv-export.conf
3) parsing

That=E2=80=99s with WORKDIR in tmpfs or nvme ssd, SSTATEDIR and DL_DIR =
on spinning rust RAID5, metadata on a regular ssd.

regards,

Koen


