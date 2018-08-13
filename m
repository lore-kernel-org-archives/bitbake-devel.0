Return-Path: <armccurdy@gmail.com>
Received: from mail-ua1-f68.google.com (mail-ua1-f68.google.com
	[209.85.222.68])
	by mail.openembedded.org (Postfix) with ESMTP id 422046FFA1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Aug 2018 22:37:10 +0000 (UTC)
Received: by mail-ua1-f68.google.com with SMTP id y10-v6so11070759uao.4
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Aug 2018 15:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=bJG6VUMQG+CvTJLhMXSNafWkCHnbhB03c3lTgZZRYmo=;
	b=hH2RzhFozqjEnerHrjZfeDTtG0igWnc6r7U0SGw5kcjaeGeimyrlkv5ki48TAfMjOZ
	h6QGyjKAFPd6fqhCCzSVYh8JGi9uiHM+pAwBpgwGRPa28YLojhb48f5IApWnDER4sOEM
	qoom6nhDYAe7xQpDcgUX8uv3/ij1pQrEqkL8cPrag811VQQDn9TBOVF0TLsEo64E5tsJ
	istVU1k0JalqaDXRhfq1xPfGmVAKsr43/5S10e/wEqMMmx8B8qT0DXOtVDJtB4MqOuAD
	pSCzghYS4jsL2y89Qu0pNCZOPRc3vG71mpSx1Q6tRaSUH9Ka11NggyoOSRs/PtA96Thi
	Afkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=bJG6VUMQG+CvTJLhMXSNafWkCHnbhB03c3lTgZZRYmo=;
	b=EhylZKYlzcXkGZPh1cjIwPdlpkXcDsDnNNrSxOjMcDideoJCRuy2ZuU+HtizF+UvyV
	j2+tPoka+PGFRSA6e2PwtLYmGvU9fFBXu2DRHEnQzihaV0ayHI2bd9ZyDDVVW0hmNf0o
	InrxHwTzKTq1O7kNDwdavvlV/5MjnAKFtPLK8RJdmkofDIibw1rdeBgMiicIA6Z/s4iJ
	XEnS+mWyZYONzx7irbpsv2Bn1WZMIAmmZTuostm27vJs8inlDR1SfsK6cDfe5gO8eUNr
	mxmLCr/y/YD3j8NAJNS8wRcwCnAVS56Zp1SliwJXH88MJYYd52sUIGVsus33cnxnso79
	LwBQ==
X-Gm-Message-State: AOUpUlG5vDO1l4nDPa/MuPrOsIccUyLdC5MjZwpZheuvEB4pfhfM/aEJ
	hjPwI8RsztaFghUTNcwGkPDLaPridbRBFWm4cz4=
X-Google-Smtp-Source: AA+uWPwtI/HiWb0LgeHDX+IGM/fzhHagP0d+QVHns4rXhD3uwZgnYiT7cc5DDCOZFzbrHQ+qvhCqPfAUl6Bhe6KUxng=
X-Received: by 2002:a1f:b3d5:: with SMTP id
	c204-v6mr12175103vkf.37.1534199831029; 
	Mon, 13 Aug 2018 15:37:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9f:2523:0:0:0:0:0 with HTTP; Mon, 13 Aug 2018 15:37:10
	-0700 (PDT)
In-Reply-To: <CALbNGRSUXV_HGSLNb4Uc=w_nZSLA_zL-da5+q-1jGgqqGdJKbw@mail.gmail.com>
References: <20180813210445.32496-1-schnitzeltony@gmail.com>
	<20180813210445.32496-3-schnitzeltony@gmail.com>
	<CANNYZj-3OQ7gPEop3OcDL5bnv3x9Q=DmEFCYi4-K7B3Xqp5v0Q@mail.gmail.com>
	<CALbNGRSUXV_HGSLNb4Uc=w_nZSLA_zL-da5+q-1jGgqqGdJKbw@mail.gmail.com>
From: Andre McCurdy <armccurdy@gmail.com>
Date: Mon, 13 Aug 2018 15:37:10 -0700
Message-ID: <CAJ86T=WJgaefsob77U57fQMkH=fZ+DK4srKN+PESUyYmSfKKmw@mail.gmail.com>
To: =?UTF-8?Q?Andreas_M=C3=BCller?= <schnitzeltony@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 2/2] runqueue: Introduce load balanced task spawning
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
X-List-Received-Date: Mon, 13 Aug 2018 22:37:10 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 13, 2018 at 2:30 PM, Andreas M=C3=BCller <schnitzeltony@gmail.c=
om> wrote:
> On Mon, Aug 13, 2018 at 11:20 PM, Alexander Kanavin
> <alex.kanavin@gmail.com> wrote:
>> 2018-08-13 23:04 GMT+02:00 Andreas M=C3=BCller <schnitzeltony@gmail.com>=
:
>>> To get most out of build host, bitbake now detects if the CPU workload =
is low.
>>> If so, additional tasks are spawned. Maximum 'dynamic' tasks are set by
>>> BB_NUMBER_THREADS_LOW_CPU.
>>
>> So the best improvement is going from 114.5 minutes to 113.5 minutes?
>> I don't think it's worth the trouble. Maybe it's time to invest in 16
>> (or even 32!) core amd threadripper? :)
>>
> Indeed - but I have to wait till next holiday to assemble such kind of ma=
chine.
>
> I still can't believe the results are that disappointing...

I wonder if you've experimented with the opposite approach, ie
spawning fewer tasks when CPU load is very high? If a single
do_compile task can fully load all CPUs, not running other tasks in
parallel with it (especially another do_compile) might give some
benefit?

Dynamically boosting and dynamically lowering BB_NUMBER_THREADS based
on overall CPU load both seem like logical things to do.

