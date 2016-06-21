Return-Path: <koen@dominion.thruhere.net>
Received: from mail-lf0-f54.google.com (mail-lf0-f54.google.com
	[209.85.215.54])
	by mail.openembedded.org (Postfix) with ESMTP id 83B43608B7
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Jun 2016 18:48:12 +0000 (UTC)
Received: by mail-lf0-f54.google.com with SMTP id h129so37819185lfh.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Jun 2016 11:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=dominion-thruhere-net.20150623.gappssmtp.com; s=20150623;
	h=mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=kAMc4xXDFpYjK3t14s9pgh2sRXw5Nwz2hHBgRUb0X5o=;
	b=cQW/E3G27IthwgS8M9ebxnBr2jo8G4Dwt6ircb+a3tQ7vIO6ZCrjAuTZcrJYLuWCcR
	dDZCwGyf04EkS3T6u7wqaFgkHTifGIA0FKZ5Q+JgHOB6BNRFXk9envlPUVwePHQL+GEn
	iYLpXtqlzmnveyzGLZFzQQB59tqvN2sDPLK/33dsQ5w3XMi4XQCDqgqbAN3RnmrFZxqf
	bStntDbTz5L4rfRZjEd6c/qfOj7wR5s30lJ+wmLFTfb/HUItK8I7ml/iN73LOHfuZPe8
	bsegNdZ3/p+Y63d4RQ1BdfLbelcdh92j//Hw0CF++MAv4Nknkco+SjQjcmsNZKd0M5JX
	Idkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=kAMc4xXDFpYjK3t14s9pgh2sRXw5Nwz2hHBgRUb0X5o=;
	b=SF+F5dYGrJTfObYCTHKsKBdNCs5AWxzOj8TboIFplRwIdL6/l7d929H6hyIPIJ9Bqf
	8fIDuoSa05x5X5bMTUg70D6kg0LNpnuJRtb+d7/5Yu56HQq5QJVCA+dV47YMsvdDNJIN
	YuMQPaMR5D63YgRlEm9JDVuEcZYGFQup1D8ISg++7j1ixzCGrEk0halGnYXcKxXTF0/4
	crgKY4reZtg9ql/Ki2liDoIWWpzdKvc/Kb/RLNBPGHeBWWl6n8HDPCqDeuuMAWYtK4QL
	Q0Qoiewul9FGJo8YFxqVpJKhvS+aAWT5DeOwdFQSFCnBEkx/w+b7x0IDyGVWzS70QYyL
	lJFA==
X-Gm-Message-State: ALyK8tLR4+pj66LDLduhav7rOH+svbQdraGAK7anmVtpFiDzmM6TEejuyOjM1Wgs11B0zQ==
X-Received: by 10.194.82.36 with SMTP id f4mr21330860wjy.104.1466534892734;
	Tue, 21 Jun 2016 11:48:12 -0700 (PDT)
Received: from [10.29.114.94] ([84.241.198.133])
	by smtp.gmail.com with ESMTPSA id
	li10sm25469143wjb.5.2016.06.21.11.48.11
	(version=TLSv1/SSLv3 cipher=OTHER);
	Tue, 21 Jun 2016 11:48:12 -0700 (PDT)
Mime-Version: 1.0 (1.0)
From: Koen Kooi <koen@dominion.thruhere.net>
X-Mailer: iPhone Mail (13F69)
In-Reply-To: <57698986.2060808@gmail.com>
Date: Tue, 21 Jun 2016 20:48:10 +0200
Message-Id: <6F0BDB15-A440-48BF-9AB1-66F4E3324AE0@dominion.thruhere.net>
References: <1465572809.13979.185.camel@linuxfoundation.org>
	<20160610160710.GA18625@openSUSE-i7.site>
	<1465575223.13979.188.camel@linuxfoundation.org>
	<20160620024647.GA29701@openSUSE-i7.site>
	<57675F7C.9020909@gmail.com>
	<80947E15-FCD9-4A64-AE61-2B2381989371@dominion.thruhere.net>
	<57698986.2060808@gmail.com>
To: nick <xerofoify@gmail.com>
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
X-List-Received-Date: Tue, 21 Jun 2016 18:48:14 -0000
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable



> Op 21 jun. 2016 om 20:37 heeft nick <xerofoify@gmail.com> het volgende ges=
chreven:
>=20
>=20
>=20
>> On 2016-06-21 09:26 AM, Koen Kooi wrote:
>>=20
>>> Op 20 jun. 2016, om 05:14 heeft nick <xerofoify@gmail.com> het volgende g=
eschreven:
>>>=20
>>>=20
>>>=20
>>>> On 2016-06-19 10:46 PM, Trevor Woerner wrote:
>>>>> On Fri 2016-06-10 @ 05:13:43 PM, Richard Purdie wrote:
>>>>>> On Fri, 2016-06-10 at 12:07 -0400, Trevor Woerner wrote:
>>>>>>> On Fri 2016-06-10 @ 04:33:29 PM, Richard Purdie wrote:
>>>>>>> A few people have asked about multi-machine builds.
>>>>>>=20
>>>>>> Do you envision each config also pointing to individual bblayer
>>>>>> configurations
>>>>>> too? I.e. if I'm building for 3 different MACHINEs, with 3 different
>>>>>> configs
>>>>>> (local.conf?), then there would also be 3 different bblayers.conf's?
>>>>>=20
>>>>>=20
>>>>> No, there is one local.conf and one bblayers.conf file and then three
>>>>> different multiconfig files, each one of which sets a different
>>>>> MACHINE.
>>>>>=20
>>>>> Would people really want to support different bblayer files? That woul=
d
>>>>> complicate things quite a lot :/.
>>>>=20
>>>> Personally I have a common "Downloads" directory (this is probably quit=
e normal).
>>>>=20
>>>> Then, I have a common "layers" directory in which I checkout every laye=
r of
>>>> which I'm aware. I also have a script that I run manually from time to t=
ime to
>>>> keep each layer up to date (although it's capable of running any genera=
l git
>>>> command on each git repository it finds one level beneath it):
>>>>    https://github.com/twoerner/oe-misc/blob/master/scripts/gitcmd.sh
>>>>=20
>>>> I then create separate directories for each platform for which I'm inte=
rested
>>>> in building (e.g. raspi2, raspi3, minnow, dragon, etc...). In each of t=
hose
>>>> directories I have separate local.conf, bblayers.conf, sstate-cache, an=
d tmp
>>>> directories.
>>>>=20
>>>> I know most will disagree with this arrangement (especially the separat=
e
>>>> sstate-cache directories) but it's a system that has evolved over time,=
 each
>>>> decision was made based on experience, and it works great for me!
>>>>=20
>>>> It's been my experience that having too many layers in a build slows do=
wn the
>>>> initial parsing stage noticeably and too often layers don't play well w=
ith
>>>> each other. Also *many* build issues after an update can be fixed by bl=
owing
>>>> away tmp *and* sstate and starting over. Often, building for a particul=
ar
>>>> board requires particular tweaks to local.conf (whether to enable a ven=
dor
>>>> license or to enable specific hardware/features) which don't apply to o=
ther
>>>> boards and builds.
>>>>=20
>>>> I'm happy with the speed of my builds, and I have enough disk space to
>>>> maintain the multiple sstates/tmps/etc. *Most* of my builds are
>>>> core-image-full-cmdline-type builds and I can crank one of those out fr=
om
>>>> scratch in 20 minutes (assuming the majority of sources have already be=
en
>>>> downloaded). Although I do sometimes need chromium (which takes an hour=
 on its
>>>> own) and I used to do qt (which is also quite painful). So I can unders=
tand
>>>> how sstate might be more useful to others, but for me, not so much.
>>> I second Trevor on this unless your building gui or media based packages=
 sstate
>>> is not very useful if you have a modern system with a 4 to 8 core CPU wi=
th 8 to
>>> 16GB of ram. However if your trying to just do small tweaks to the same b=
oard and
>>> test it may be of use as I use something similar for building the kernel=
 called
>>> ccache. Again as Trevor stated you may want to benchmark the results and=
 see if
>>> sstate actually decreases your build time by a significant margin i.e pr=
obably
>>> more then half decreases your build speed. Otherwise I would agree with T=
revor
>>> and just not worry about sstate.
>>=20
>> My CI run that builds a basic image for about 30 machines drops from ~16 h=
ours to about 1 hour after the first build with most of the remaining time s=
pent in:
>>=20
>> 1) xz=E2=80=99ing the images
>> 2) importing prserv-export.conf
>> 3) parsing
>>=20
>> That=E2=80=99s with WORKDIR in tmpfs or nvme ssd, SSTATEDIR and DL_DIR on=
 spinning rust RAID5, metadata on a regular ssd.
>>=20
>> regards,
>>=20
>> Koen
> Koen,
> I don't known the bitbake commands that well but to my knowledge there is a=
 profile option that can tell you where you=20
> build is taking the most time. However why not try moving your whole proje=
ct setup to the NVME ssd if there is enough
> space on it, this may help improve the speed of your builds even further.

Nothing will be faster than tmpfs and the raid array is faster than pigz/Xz/=
bzip can process.

> Hope this helps,
> Nick

