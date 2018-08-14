Return-Path: <armccurdy@gmail.com>
Received: from mail-ua1-f67.google.com (mail-ua1-f67.google.com
	[209.85.222.67])
	by mail.openembedded.org (Postfix) with ESMTP id AABEA7453A
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Aug 2018 01:01:14 +0000 (UTC)
Received: by mail-ua1-f67.google.com with SMTP id m13-v6so11363353uaq.7
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Aug 2018 18:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=WUOBg/gpm7maXEMYtz5evd8S2rDdE72T72AFykcf/gE=;
	b=DvyGx5sa6f7hOuzvzUaYQGVbK3mUTjD6Yt48iCd+HsHzZs8/uXL/6vZ4A7G7WqL7xx
	qVevbSD3CBkZWDLulG3OWboOs96hNWuNY4gtrSdS4o15bU3neQrJlLWr05Lp44oSWwGH
	kYabL6fxV9ncsO6m2lsSP9qq2mjVpALdPLa+/V/x18EudOhvkTZQJMhagtyv9ur7QYbn
	nLR4sOZhRdepmhxLegxXFxbF3V0Bs71TVpYkjCEiFnH743CtomQ6E/FIRneccIPfQLHz
	5aWfjVpzhLKKvA27Na7JRcsFoq4hapUgyxDW9v6mplkXy6JrhZ1bJFuLHSWZdvpZHwP/
	IwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=WUOBg/gpm7maXEMYtz5evd8S2rDdE72T72AFykcf/gE=;
	b=tdTqbaVj0xK6lygHu8j+8/Xa3o4BoM/ntLA+L9dXPd7jSdsaeEmi916eTlT2jV1EbO
	YWjWapTwvNplFk+YyHGMnzGM3Iy0X50Cfr5wV+twh6AR2o4xQ/kSUyHQCmKK59SaCbl5
	9ppX/VDM021NE6T8StqJ9GcCIDXrhWXZLhvdsQsF9vfwA3yDqApwQncekWb0NBBA/5LT
	NKgaT/zaqg+Go3x76Rv8A+buoPFWmadytYOhTaLa15HjVJzp/y4U3fNQHyfThgPXHz71
	73MCu6JfDPKTnUouVw3AGxtVH8+KVO+gFVuGxHPSOLwQgyYFPkasGo29lKzN/JYktN3l
	0vFQ==
X-Gm-Message-State: AOUpUlGzppd/460bgU3LcS3B2EDAHBuNw5V9/OWGm6efJz2PPPfwZ57+
	ko4viG5BSXViF70bSHwKfCff8f7YJuOJzKCWGD0=
X-Google-Smtp-Source: AA+uWPyZASotn8lGs1ntzv3pZMXIUq4M2wYOntjlYTSyCSePIZLBr416HP/h2jasJJ53dUpYtBI2g14VfovTboAedJ0=
X-Received: by 2002:a1f:b3d5:: with SMTP id
	c204-v6mr12391610vkf.37.1534208475395; 
	Mon, 13 Aug 2018 18:01:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2a5:0:0:0:0:0 with HTTP;
	Mon, 13 Aug 2018 18:01:14 -0700 (PDT)
In-Reply-To: <CALbNGRRmWZGwi0NTeX3Gw3kzk4SP_6twLSZn=Bdfy0K4X5nZ2Q@mail.gmail.com>
References: <20180813210445.32496-1-schnitzeltony@gmail.com>
	<20180813210445.32496-3-schnitzeltony@gmail.com>
	<CANNYZj-3OQ7gPEop3OcDL5bnv3x9Q=DmEFCYi4-K7B3Xqp5v0Q@mail.gmail.com>
	<CALbNGRSUXV_HGSLNb4Uc=w_nZSLA_zL-da5+q-1jGgqqGdJKbw@mail.gmail.com>
	<CAJ86T=WJgaefsob77U57fQMkH=fZ+DK4srKN+PESUyYmSfKKmw@mail.gmail.com>
	<CALbNGRRmWZGwi0NTeX3Gw3kzk4SP_6twLSZn=Bdfy0K4X5nZ2Q@mail.gmail.com>
From: Andre McCurdy <armccurdy@gmail.com>
Date: Mon, 13 Aug 2018 18:01:14 -0700
Message-ID: <CAJ86T=XyN2NpH_ucbg-WL8A1EV5aabHLGKs7Lh7TSuNEhjAtBA@mail.gmail.com>
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
X-List-Received-Date: Tue, 14 Aug 2018 01:01:14 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 13, 2018 at 5:11 PM, Andreas M=C3=BCller <schnitzeltony@gmail.c=
om> wrote:
> On Tue, Aug 14, 2018 at 12:37 AM, Andre McCurdy <armccurdy@gmail.com> wro=
te:
>> On Mon, Aug 13, 2018 at 2:30 PM, Andreas M=C3=BCller <schnitzeltony@gmai=
l.com> wrote:
>>> On Mon, Aug 13, 2018 at 11:20 PM, Alexander Kanavin
>>> <alex.kanavin@gmail.com> wrote:
>>>> 2018-08-13 23:04 GMT+02:00 Andreas M=C3=BCller <schnitzeltony@gmail.co=
m>:
>>>>> To get most out of build host, bitbake now detects if the CPU workloa=
d is low.
>>>>> If so, additional tasks are spawned. Maximum 'dynamic' tasks are set =
by
>>>>> BB_NUMBER_THREADS_LOW_CPU.
>>>>
>>>> So the best improvement is going from 114.5 minutes to 113.5 minutes?
>>>> I don't think it's worth the trouble. Maybe it's time to invest in 16
>>>> (or even 32!) core amd threadripper? :)
>>>>
>>> Indeed - but I have to wait till next holiday to assemble such kind of =
machine.
>>>
>>> I still can't believe the results are that disappointing...
>>
>> I wonder if you've experimented with the opposite approach, ie
>> spawning fewer tasks when CPU load is very high? If a single
>> do_compile task can fully load all CPUs, not running other tasks in
>> parallel with it (especially another do_compile) might give some
>> benefit?
> How shall this work? 100% should be target.

Aim should be to limit the chance that the CPUs are completely
overloaded, e.g. with 4 CPUs, try to avoid running 4 x do_compile in
parallel.

If you define a single do_compile task which is able to load all CPUs
as "100%" then the limit (not target) should perhaps be 200%?

Some experimentation would be needed to fine tune.

>> Dynamically boosting and dynamically lowering BB_NUMBER_THREADS based
>> on overall CPU load both seem like logical things to do.
> Meanwhile I tested this on another machine (yeah should have done
> before sending out): Quite good processor / poor harddisk. As soon as
> harddisk is the bottleneck (or when swapping) -> workload goes down ->
> task explosion. Not exactly a good idea.

What does task explosion mean? Hitting the BB_NUMBER_THREADS_LOW_CPU limit?

If BB_NUMBER_THREADS_LOW_CPU is set to something fairly safe (1.5 x
BB_NUMBER_THREADS ?) hitting that limit doesn't seem like a big issue.

Or does "task explosion" mean your implementation was buggy and
BB_NUMBER_THREADS_LOW_CPU was exceeded?

