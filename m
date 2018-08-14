Return-Path: <schnitzeltony@gmail.com>
Received: from mail-oi0-f66.google.com (mail-oi0-f66.google.com
	[209.85.218.66])
	by mail.openembedded.org (Postfix) with ESMTP id 8AC6878FB9
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Aug 2018 10:43:29 +0000 (UTC)
Received: by mail-oi0-f66.google.com with SMTP id w126-v6so32666590oie.7
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Aug 2018 03:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=ES0EM9bjZtLRAvc9gS/zLF7kSnqAAinNs+h60/YSO2w=;
	b=RYONbusqbvQ+h8sBqAiX7zNk/+DtpWjSWNocFyK6i/+uQEziTtGu9pmPAVUoVzRG2z
	d9wp9WNOEWODeSHESUkqykd4aySFEo4YQTx/FMx5iDbP+PAPtR4PfqK4zaKzWmqSJf0S
	DRK8hBxg88vhdfn1wtR2LFTuU6ov9YHfiICGdnF/vjlR5JEt9fcrLjc2tW4GZzrBidi9
	NzDE09WIf7nB1GTPlabxwCF+ePYlTETjybTDPr0/8XzO9ga5VI1OrZkmlYQ55KIqR0FN
	97RNhIMB7PWkWjOHphtoTIthAwlO0gepWadZvI2O/x1EAAfh7RiSgxdrMUyDhhxDkTOo
	tytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=ES0EM9bjZtLRAvc9gS/zLF7kSnqAAinNs+h60/YSO2w=;
	b=Ajo65Ti2+87Rthd8EIncoZLtJG1WtxUJjklwSq0U7OgfVbDpisSK8eTc6W8mWU0hYx
	yUCbf0dq7DM3nfMwJ1hHyoSubN13XUCxwHLXUCEchBCC5jcuCTEXzFB+tt5F6ZtamzjM
	b+q5HhTSHx4LhcGjfAQevKd37PUk/HqqFEvtgmDAPLuTS2cS9Usp4aiMC1lliCU7UbM3
	r8Tjdxs/O885R2WaTnV64FNur0/TenVbeu5Z1z/FkV+u7YRY6nmDZ9pyu53LK+UCsGuH
	AtGEogFOgK5MZ1mNCBKboYUMQlEPkA2GqFdPMdJQbetdAbezjCisVDKyRsMuqWKxNbYR
	djlg==
X-Gm-Message-State: AOUpUlENI76sU6+LJkU+Qd27wavP+LY2oAu221o8SgqQsWHeous5CtY0
	CyabnCkjIwuCZ+7zNcluFRb1n1HpyI2WOL6hWhY=
X-Google-Smtp-Source: AA+uWPy2Yhn3G7TZ3VN24NPIvn5FCQwJjvuv68x1mkrZ7Swyorde7fi77WmQOUQcZzCdgaQh52ezsBFBmwr3EQ6o1uI=
X-Received: by 2002:aca:5841:: with SMTP id
	m62-v6mr23409192oib.346.1534243410627; 
	Tue, 14 Aug 2018 03:43:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:590c:0:0:0:0:0 with HTTP; Tue, 14 Aug 2018 03:43:29
	-0700 (PDT)
In-Reply-To: <75dc7178b6204b0d898f136ab9cceeb4@XBOX02.axis.com>
References: <20180813210445.32496-1-schnitzeltony@gmail.com>
	<20180813210445.32496-3-schnitzeltony@gmail.com>
	<CANNYZj-3OQ7gPEop3OcDL5bnv3x9Q=DmEFCYi4-K7B3Xqp5v0Q@mail.gmail.com>
	<20180814011119.GA1391@jama> <20180814063203.GJ8291@hiutale>
	<CANNYZj-b4D5FOc-S2_EbLYvpzdM4u4H8DeJP3JUbmeJJAsAcWA@mail.gmail.com>
	<98d2737cbf96633abe4ff3bdacd40582f6e83262.camel@linuxfoundation.org>
	<8ac13026f3f66ce8a652d760162bb4cf74e13ebd.camel@linuxfoundation.org>
	<75dc7178b6204b0d898f136ab9cceeb4@XBOX02.axis.com>
From: =?UTF-8?Q?Andreas_M=C3=BCller?= <schnitzeltony@gmail.com>
Date: Tue, 14 Aug 2018 12:43:29 +0200
Message-ID: <CALbNGRR0tEuAJaTFKNu_N9+v6D900vE8FFr25DtB9JjZGdTOiQ@mail.gmail.com>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
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
X-List-Received-Date: Tue, 14 Aug 2018 10:43:29 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 14, 2018 at 12:28 PM, Peter Kjellerstedt
<peter.kjellerstedt@axis.com> wrote:
>> -----Original Message-----
>> From: bitbake-devel-bounces@lists.openembedded.org <bitbake-devel-
>> bounces@lists.openembedded.org> On Behalf Of Richard Purdie
>> Sent: den 14 augusti 2018 11:45
>> To: Alexander Kanavin <alex.kanavin@gmail.com>; Mikko.Rapeli@bmw.de;
>> Andreas M=C3=BCller <schnitzeltony@gmail.com>; Martin Jansa
>> <martin.jansa@gmail.com>
>> Cc: bitbake-devel@lists.openembedded.org
>> Subject: Re: [bitbake-devel] [PATCH 2/2] runqueue: Introduce load
>> balanced task spawning
>>
>> On Tue, 2018-08-14 at 10:43 +0100, Richard Purdie wrote:
>> > On Tue, 2018-08-14 at 10:07 +0200, Alexander Kanavin wrote:
>> > > 2018-08-14 8:32 GMT+02:00  <Mikko.Rapeli@bmw.de>:
>> > > > Just my 2 =E2=82=AC cents to the discussion:
>> > > >
>> > > > we had to limit number of threads because heavy C++ projects
>> > > > were using all of RAM and causing heavy swapping. Single g++
>> > > > processes were eating up to 20 gigabytes of physical ram.
>> > > > It's not just the CPU which is the limiting factor to
>> > > > parallel task execution.
>> > >
>> > > I do believe some kind of clever dynamic limiter would be
>> > > useful here. Obviously it's an absurd situation when on a 32
>> > > core processor there are 32 do_compile c++ tasks, each running
>> > > 32 instances of g++ - which is the default configuration. On
>> > > the other hand running things like do_configure or do_install
>> > > should happen in parallel. I like Andre's idea, but it should
>> > > also watch the available RAM.
>> >
>> > If people want to play, I did experiment with "proper" thread
>> > pooling:
>> >
>> > http://git.yoctoproject.org/cgit.cgi/poky-contrib/commit/?h=3Drpurdie/=
wipqueue4&id=3Dd66a327fb6189db5de8bc489859235dcba306237
>>
>> More recent version of the patch:
>>
>> http://git.yoctoproject.org/cgit.cgi/poky-contrib/commit/?h=3Drpurdie/wi=
pqueue7&id=3D236ca8be128ba7a4edb9fb2c9e512d181679eee8
>>
>> Cheers,
>>
>> Richard
>
> Even though make is the prevalent tool used to build code, we have
> to consider others such as cmake and meson... Any idea if their
> parallelism can be controlled in some similar way?
>
BTW: do_package_ipk is also a CPU eater these days although these task
do not last as long as compile.

Andreas

