Return-Path: <schnitzeltony@gmail.com>
Received: from mail-oi0-f68.google.com (mail-oi0-f68.google.com
	[209.85.218.68])
	by mail.openembedded.org (Postfix) with ESMTP id 5A6F3791B8
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Aug 2018 15:01:32 +0000 (UTC)
Received: by mail-oi0-f68.google.com with SMTP id n21-v6so2440673oig.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Aug 2018 08:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=iomCFWmnnsfqhJ7VPdUXMelvyv6cPZ8VVtW1XhW2sX0=;
	b=PSaXreiFYbAGKdAkF1IjrV60xFuXdBmKynTLgF+PxkfOrTBXAGpMeEq6eDprlwKcPV
	XBDVmxyLUIVy/pPqOu0HWo/uHOMa9XnZ7a2pYJS/+50tFPqnqk4oMshanXWXd6gYD4Iv
	x6nn0QPABqiu5ecvC/WS1zHakYi8qwld4QHQIzgwZnQbGiJRZtivcAsLeA2kCKmO62z0
	0faXayzr2hOiaTWftFXZe0ca1wuuCRJoOimsyMzDr6At3bkOt6ec3gr3O1AOJnvuLFl2
	beersGCYMLxRBHQhQazyCrxv9AFGBS6vW4zbTFjYvno0vdfbh7Ibbtft4nSIClYAzEPW
	spKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=iomCFWmnnsfqhJ7VPdUXMelvyv6cPZ8VVtW1XhW2sX0=;
	b=dmXess5/AcOwY6nXqeBz7qHRPIu0FS1h48dLuqGwVSJh35AOFamFEaJPHsl5zNn8ZR
	ESA6LMhSH2G57zQoAPgzO7IqAxuxJpImBCToEniiD2ooFCBCDHW72tYc1jsmjn8lZq5u
	zvHBRPnwuHcPiFU56K2JleYiR1MDraztMO/iEPrx5UqoRnfGrranpPRbob+HVwVmsFXV
	7Vr4oT9SHJxOEPf5C7yikR3riFS7b0Upp6dgkTwdM2AZgF+Ynaephv1IYO3Apgu6hrx4
	Mwz6ZAJfn8STVE3So1vh71lgqqrBUlkUqrq/Bean18HIFOLOVjKvcLRvnxJSz/P2BU2x
	wtSw==
X-Gm-Message-State: AOUpUlE+Dj3198/7UgLZSAvbp8NwmY1+2KqHh2o+I2LmGY3IVlE/AuxY
	v4ZQLmsIAvQtrK7PDe5V6wFARz9ucsQcmdE/R/Q=
X-Google-Smtp-Source: AA+uWPzdGjX3+bwSC5W9Iep5HtEE/p0IJFZ+vjsJiMwJPqKxDD58CXq8PmmuITfxYkunEDFyRzDL9mUEae5EMX+58i0=
X-Received: by 2002:aca:4fd1:: with SMTP id
	d200-v6mr29003227oib.224.1534345288529; 
	Wed, 15 Aug 2018 08:01:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:590c:0:0:0:0:0 with HTTP; Wed, 15 Aug 2018 08:01:27
	-0700 (PDT)
In-Reply-To: <CANNYZj9usAVLe7guhH7h3XjXsvRjL+M8VnjM0cgFx3q-H0sqEA@mail.gmail.com>
References: <20180813210445.32496-1-schnitzeltony@gmail.com>
	<20180813210445.32496-3-schnitzeltony@gmail.com>
	<CANNYZj-3OQ7gPEop3OcDL5bnv3x9Q=DmEFCYi4-K7B3Xqp5v0Q@mail.gmail.com>
	<20180814011119.GA1391@jama> <20180814063203.GJ8291@hiutale>
	<CANNYZj-b4D5FOc-S2_EbLYvpzdM4u4H8DeJP3JUbmeJJAsAcWA@mail.gmail.com>
	<98d2737cbf96633abe4ff3bdacd40582f6e83262.camel@linuxfoundation.org>
	<CANNYZj-WM349ZX_j99upQ6JbopcMs_pA0G_6N7hHRbo-Yo2xoA@mail.gmail.com>
	<CANNYZj9usAVLe7guhH7h3XjXsvRjL+M8VnjM0cgFx3q-H0sqEA@mail.gmail.com>
From: =?UTF-8?Q?Andreas_M=C3=BCller?= <schnitzeltony@gmail.com>
Date: Wed, 15 Aug 2018 17:01:27 +0200
Message-ID: <CALbNGRS7aavRtSSpj-JMKo6mTnWL7OGp+_Tnsjk3BLb=ooDHCA@mail.gmail.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>
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
X-List-Received-Date: Wed, 15 Aug 2018 15:01:32 -0000
Content-Type: text/plain; charset="UTF-8"

On Wed, Aug 15, 2018 at 2:43 PM, Alexander Kanavin
<alex.kanavin@gmail.com> wrote:
> 2018-08-14 13:03 GMT+02:00 Alexander Kanavin <alex.kanavin@gmail.com>:
>> Both make and ninja have -l option:
>>
>>       -l [load], --load-average[=load]
>>             Specifies  that  no  new  jobs (commands) should be
>> started if there are others jobs running and the load average is at
>> least load (a floating-point number).  With no argument, removes a
>>             previous load limit.
>>
>>        -l N   do not start new jobs if the load average is greater than N
>>
>> Maybe that could be appended to PARALLEL_MAKE, which is far less
>> invasive than any other approach?
>
> I've done some tests, and yes -l does help. We currently have a nasty
> quadratic growth rate with cpu cores as input, which hits especially
> badly when the amount of cores is high, and a lot of long, heavy (e.g.
> c++) do_compile tasks run at once. This potentially means n*n compiler
> instances, where n is how many cpu cores are available. '-l' option
> does neatly limit that to a constant amount of compilers per core.
>
> However, this does not solve the other resource problem: running out
> of available RAM and going into swap thrashing. Neither make nor ninja
> can currently watch the RAM, even though it is not complicated:
>>>> import psutil
>>>> psutil.virtual_memory()
> svmem(total=16536903680, available=7968600064, percent=51.8,
> used=16347615232, free=189288448, active=11750494208,
> inactive=2882383872, buffers=3158528000, cached=4620783616)
>
> I think we should teach both to do that, and then replace a static
> 'number of jobs' limit in PARALLEL_MAKE with limits on CPU load and
> RAM usage.
>
> Alex
1. I like -l - have to try either!!
2. Quadratic explosion: I think it you should reduce number of
parallel bitbake threads. From what I have seen: When running heavy
compiles with -j = number-of-cores it takes only 2-3 do_compiles to
have CPU load at constant ~100%. I think this should be independent of
number of cores. Try 4-5 parallel bitbake threads - I bet that speeds
up your builds and reduces swap floods.

Andreas

