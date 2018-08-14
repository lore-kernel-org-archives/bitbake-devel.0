Return-Path: <schnitzeltony@gmail.com>
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com
	[209.85.218.67])
	by mail.openembedded.org (Postfix) with ESMTP id 503536E5E9
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Aug 2018 00:11:25 +0000 (UTC)
Received: by mail-oi0-f67.google.com with SMTP id q11-v6so30465394oic.12
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Aug 2018 17:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=QnlTh2w/tuPzW0xh30pgSau3VFy1JIZpN6G0fXgSPyI=;
	b=BTUAXbNdWX42Lj2mI6Tkf1VOIzf2ROghenNMZ8fiRxYoAxsWyAnfVXUApgt9G7rbxH
	lPJgCxvRj7ZqZwdTEre4f6wXSDRbwPL3NhgGV57rqiqiiyPmeImLIIW4FUGJpVtqDXJk
	Sc+5Map/urNZs2fLjXL1PZODH+8hjOcg+V/r7zNbTxmgdazVGkZ8R675jfKAjOmCq4gz
	BppmW6h/5iM9Lwni5F1UZrhOLXQDnTyeDMowzzeBwmW1Eh781LKJYuFSumde4Ic6/u1x
	MXAtlNmOQvk0zmVUdvdX9XQPJDZ6BioT7GwDx7X6HL9P5JrWAn5VKqC9ssg4/k7qfDVy
	gmnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=QnlTh2w/tuPzW0xh30pgSau3VFy1JIZpN6G0fXgSPyI=;
	b=CMTGedRVU+cT5eadDKjjCrsTAPYzB60PthXbTo6yQuX7dLxkgvFQqolSSGspfSDrSu
	83EhBxHsL5koIqeCbNsPYh8DeY2n+iOWeyIxx2q+BSx7H2eSD4Rr8V8Q9pBuxc4vY56a
	higp6uHQureSDYPXRTaIYmRHcv0pMZWukECRCnj1TSfdtYZ987yGIXNI1Gixrndn0eAO
	YbpBsejL+2tOC00Ijw6RXCpsXzGDdNN1L9gC8d6n+FQCuRUokg1CSQ+PvRzDlM4KSxU2
	tcWXtWJtMmldeLqeExJuk9zPud7MG3spPgN8JiP6SBI4Yy6tShPJ0NmInRWTSMmNNAx0
	v53g==
X-Gm-Message-State: AOUpUlE9239ydHYqwIoRIwDyp3paXG1S2lrWrsbNvdB1Pfq46+KzHTlL
	rRywhHSoeRacmY+NwkdW/+lTauv3bLx/ey8AIKE=
X-Google-Smtp-Source: AA+uWPwuLY5SwX3tDE+EhU5WZAaf8hihPpX+5ln4/4MWZNOUm+HO9sdvWSen5CFowCkDfVvZBm8zeg54poNCbHfNe9Q=
X-Received: by 2002:aca:4fd1:: with SMTP id
	d200-v6mr21587489oib.224.1534205487022; 
	Mon, 13 Aug 2018 17:11:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:590c:0:0:0:0:0 with HTTP; Mon, 13 Aug 2018 17:11:26
	-0700 (PDT)
In-Reply-To: <CAJ86T=WJgaefsob77U57fQMkH=fZ+DK4srKN+PESUyYmSfKKmw@mail.gmail.com>
References: <20180813210445.32496-1-schnitzeltony@gmail.com>
	<20180813210445.32496-3-schnitzeltony@gmail.com>
	<CANNYZj-3OQ7gPEop3OcDL5bnv3x9Q=DmEFCYi4-K7B3Xqp5v0Q@mail.gmail.com>
	<CALbNGRSUXV_HGSLNb4Uc=w_nZSLA_zL-da5+q-1jGgqqGdJKbw@mail.gmail.com>
	<CAJ86T=WJgaefsob77U57fQMkH=fZ+DK4srKN+PESUyYmSfKKmw@mail.gmail.com>
From: =?UTF-8?Q?Andreas_M=C3=BCller?= <schnitzeltony@gmail.com>
Date: Tue, 14 Aug 2018 02:11:26 +0200
Message-ID: <CALbNGRRmWZGwi0NTeX3Gw3kzk4SP_6twLSZn=Bdfy0K4X5nZ2Q@mail.gmail.com>
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
X-List-Received-Date: Tue, 14 Aug 2018 00:11:26 -0000
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
How shall this work? 100% should be target.
>
> Dynamically boosting and dynamically lowering BB_NUMBER_THREADS based
> on overall CPU load both seem like logical things to do.
Meanwhile I tested this on another machine (yeah should have done
before sending out): Quite good processor / poor harddisk. As soon as
harddisk is the bottleneck (or when swapping) -> workload goes down ->
task explosion. Not exactly a good idea.

So better go Alex's suggestion :)

Andreas

