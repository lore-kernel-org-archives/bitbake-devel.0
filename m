Return-Path: <schnitzeltony@gmail.com>
Received: from mail-oi0-f65.google.com (mail-oi0-f65.google.com
	[209.85.218.65])
	by mail.openembedded.org (Postfix) with ESMTP id 86FE578F5D
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Aug 2018 09:05:44 +0000 (UTC)
Received: by mail-oi0-f65.google.com with SMTP id w126-v6so32254468oie.7
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Aug 2018 02:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=rTlYwsdoyu/ZWmYKDWEVr9A6ezmmnfELXu+6d+m+TiQ=;
	b=tQhsCdOxjxW1mUoHy5RjihwGscI/GTG8/vWXe25e1eAdDqLAND+FsKku9lMleYri39
	fb57QuG/A5DVrKuaLui+eYvOMAenBkCd/PZSgp5VC6Wg57FG9FE4YaZ29JJ+91i/AUXe
	zOo474ErarLaatQ05IlD6c7sZYeZP7e4jk8K830hk9kB/gX7+9q3SEpXu+T4esMIphFN
	j3OM6kpDTy4S2tTGUug1cH9dK2wEnvaj7cq9B8u7wJ54HoGt/ioIyH4cnHQpdek3ZzHL
	0tuYOLNyrZYBEUuicbsiIzqP5K4ESeWCd4BULZp5s3/tkodBBsRiMC9SuOYyFL+8Eu75
	3xCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=rTlYwsdoyu/ZWmYKDWEVr9A6ezmmnfELXu+6d+m+TiQ=;
	b=euTcuEuEuidw5X5dRSYC7Q/xpkLvME1dTQ/04TaazxXJL0FL1EKqwvprt4KoHXrX6S
	6/kThfsK+vXFDROMPKLoKFaoOUZI14mpDnLrYabWdl282YeqST+lcOWhsrT9xS1nmc16
	qj+Yvoho3WXpNgBXgx99HmhZiToZclMXm0E9m/Bs4zFbu2ZErFPm4N0S8Orrn5sOzio0
	8BJPr0POnBAz7pFzkh3htC9Gsy5X2D2L3UmNZM2MzprnS2l0rzArieQVant0kGsZeSo9
	WKtDPIeiAj3q4CjwjYcXUeEfjJu5hbEtOPSy95grGsYNIdhu9/RtcjCwRVqg4//HGqCH
	Jizg==
X-Gm-Message-State: AOUpUlGO9h7k27cxRESbKcxUt1832AgIUZ1oL2VseHeRcCwh0Pxr+GUa
	PdCwRG99+b/s/FCS9nrSkTJ1n0XsvoCr22ZYWCQ=
X-Google-Smtp-Source: AA+uWPxwFwWJIHeLgcaPh6YEyNYM6b3ODVegYDC/QLE3XWMs+KBUzy9CGAs/y+CQY3e9RC0hgYoiSYT8VGvTK8QF0/c=
X-Received: by 2002:aca:ab11:: with SMTP id
	u17-v6mr19998546oie.53.1534237545490; 
	Tue, 14 Aug 2018 02:05:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:590c:0:0:0:0:0 with HTTP; Tue, 14 Aug 2018 02:05:44
	-0700 (PDT)
In-Reply-To: <CAJ86T=WJgaefsob77U57fQMkH=fZ+DK4srKN+PESUyYmSfKKmw@mail.gmail.com>
References: <20180813210445.32496-1-schnitzeltony@gmail.com>
	<20180813210445.32496-3-schnitzeltony@gmail.com>
	<CANNYZj-3OQ7gPEop3OcDL5bnv3x9Q=DmEFCYi4-K7B3Xqp5v0Q@mail.gmail.com>
	<CALbNGRSUXV_HGSLNb4Uc=w_nZSLA_zL-da5+q-1jGgqqGdJKbw@mail.gmail.com>
	<CAJ86T=WJgaefsob77U57fQMkH=fZ+DK4srKN+PESUyYmSfKKmw@mail.gmail.com>
From: =?UTF-8?Q?Andreas_M=C3=BCller?= <schnitzeltony@gmail.com>
Date: Tue, 14 Aug 2018 11:05:44 +0200
Message-ID: <CALbNGRRQOX81rdKkqnJRyM8i3xFy9e10Twq-o7q+KevcUJHq4g@mail.gmail.com>
To: Andre McCurdy <armccurdy@gmail.com>
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
X-List-Received-Date: Tue, 14 Aug 2018 09:05:44 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 14, 2018 at 12:37 AM, Andre McCurdy <armccurdy@gmail.com> wrote=
:
> On Mon, Aug 13, 2018 at 2:30 PM, Andreas M=C3=BCller <schnitzeltony@gmail=
.com> wrote:
>> On Mon, Aug 13, 2018 at 11:20 PM, Alexander Kanavin
>> <alex.kanavin@gmail.com> wrote:
>>> 2018-08-13 23:04 GMT+02:00 Andreas M=C3=BCller <schnitzeltony@gmail.com=
>:
>>>> To get most out of build host, bitbake now detects if the CPU workload=
 is low.
>>>> If so, additional tasks are spawned. Maximum 'dynamic' tasks are set b=
y
>>>> BB_NUMBER_THREADS_LOW_CPU.
>>>
>>> So the best improvement is going from 114.5 minutes to 113.5 minutes?
>>> I don't think it's worth the trouble. Maybe it's time to invest in 16
>>> (or even 32!) core amd threadripper? :)
>>>
>> Indeed - but I have to wait till next holiday to assemble such kind of m=
achine.
>>
>> I still can't believe the results are that disappointing...
>
> I wonder if you've experimented with the opposite approach, ie
> spawning fewer tasks when CPU load is very high? If a single
> do_compile task can fully load all CPUs, not running other tasks in
> parallel with it (especially another do_compile) might give some
> benefit?
>
> Dynamically boosting and dynamically lowering BB_NUMBER_THREADS based
> on overall CPU load both seem like logical things to do.

I think the patch does this of you interpret parameters differently.
So if you use BB_NUMBER_THREADS =3D 10 currently and want to go down to
2 in case heavy load set

BB_NUMBER_THREADS =3D 2
BB_NUMBER_THREADS_LOW_CPU =3D 10

Andreas

