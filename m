Return-Path: <alex.kanavin@gmail.com>
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com
	[209.85.218.67])
	by mail.openembedded.org (Postfix) with ESMTP id 5A55A79163
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Aug 2018 12:43:36 +0000 (UTC)
Received: by mail-oi0-f67.google.com with SMTP id d189-v6so1662382oib.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Aug 2018 05:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=c/RnXXYFu4F7Emq+M1rBJ8MBjduHgYfF/0DaSKPBcR0=;
	b=dO3vhEcCGLO7JT3ceOhRmclI7vYCpWOQMtoOXgcQ9yzHaw74Zk4N8qsCo1GUevSQ04
	FdNwGhycAPXad11I9PkFiw0QeMVCMeQ50Yefpy6LlP18sHLoSqXmj3X7K1D7rWPXUNEH
	8rIB6vR3Bpx0IV2qUK/SUEtqN3IjKyXESABdFxq8NTKGr74yQPqcUpJIfELwktVbiEq1
	boDDnG+ReY9ewKYTh3gOIISd/7xmwqcdcfenM8uRH6ZIz9fVAZxiRcXZeiXVXYJLU7WO
	2Darfv+KdytJfAhOSFv6wY6XLp8faRmlkWC4VCY2mYb3GcMl/JPyIJiLe8QRNNi9fJ2q
	nFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=c/RnXXYFu4F7Emq+M1rBJ8MBjduHgYfF/0DaSKPBcR0=;
	b=k5dYLmOncnJRbP0Bwg8MRBH9D4DYcw5txgiagCllg79g3YLRuyvf9JFji5Mkv9GL4F
	qJfknqpx6gYvFfkSkYjF0sQ4DoZOn8H71qoqBqCtFw21sOpQgRdSr+T3zvBzMzsapOUg
	jijZvivWSxGNIy8wyEd2o+00QcrAgHn7qAiTXehnpEt8w3kBz8txI+JnCyCvfYxKl8eT
	6EjVvGnOvz6SoJMpYIfd5lmYwLeU+TK1VMQuTiCdL0JH+wPfMcH3ASLgT7oVoZD80Jrn
	K+SXBjq/1KOTTdho9IskEx6mRfugN13RGl7up5IVoXJgr+MScfiTmNc0+BIrIhHAid+m
	o4PQ==
X-Gm-Message-State: AOUpUlGRIC2RWZmkI60RIru/vBrC1pF74GKnh4s9QB4VBOksGpUh1m0z
	iwQ4hn8Fp7Ov0oniiSKB2BI/lFt9+z1LIHbhZxw=
X-Google-Smtp-Source: AA+uWPx6ppvGXttQyJ+IvjfmxQKS+G2Kpi5cUTOR/hsCvCric/gr296n3Ry4GWObwS97v1RCunKPIkxkWLvHZSTk8HQ=
X-Received: by 2002:aca:5754:: with SMTP id
	l81-v6mr28700119oib.100.1534337017320; 
	Wed, 15 Aug 2018 05:43:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:90c5:0:0:0:0:0 with HTTP; Wed, 15 Aug 2018 05:43:36
	-0700 (PDT)
In-Reply-To: <CANNYZj-WM349ZX_j99upQ6JbopcMs_pA0G_6N7hHRbo-Yo2xoA@mail.gmail.com>
References: <20180813210445.32496-1-schnitzeltony@gmail.com>
	<20180813210445.32496-3-schnitzeltony@gmail.com>
	<CANNYZj-3OQ7gPEop3OcDL5bnv3x9Q=DmEFCYi4-K7B3Xqp5v0Q@mail.gmail.com>
	<20180814011119.GA1391@jama> <20180814063203.GJ8291@hiutale>
	<CANNYZj-b4D5FOc-S2_EbLYvpzdM4u4H8DeJP3JUbmeJJAsAcWA@mail.gmail.com>
	<98d2737cbf96633abe4ff3bdacd40582f6e83262.camel@linuxfoundation.org>
	<CANNYZj-WM349ZX_j99upQ6JbopcMs_pA0G_6N7hHRbo-Yo2xoA@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 15 Aug 2018 14:43:36 +0200
Message-ID: <CANNYZj9usAVLe7guhH7h3XjXsvRjL+M8VnjM0cgFx3q-H0sqEA@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
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
X-List-Received-Date: Wed, 15 Aug 2018 12:43:36 -0000
Content-Type: text/plain; charset="UTF-8"

2018-08-14 13:03 GMT+02:00 Alexander Kanavin <alex.kanavin@gmail.com>:
> Both make and ninja have -l option:
>
>       -l [load], --load-average[=load]
>             Specifies  that  no  new  jobs (commands) should be
> started if there are others jobs running and the load average is at
> least load (a floating-point number).  With no argument, removes a
>             previous load limit.
>
>        -l N   do not start new jobs if the load average is greater than N
>
> Maybe that could be appended to PARALLEL_MAKE, which is far less
> invasive than any other approach?

I've done some tests, and yes -l does help. We currently have a nasty
quadratic growth rate with cpu cores as input, which hits especially
badly when the amount of cores is high, and a lot of long, heavy (e.g.
c++) do_compile tasks run at once. This potentially means n*n compiler
instances, where n is how many cpu cores are available. '-l' option
does neatly limit that to a constant amount of compilers per core.

However, this does not solve the other resource problem: running out
of available RAM and going into swap thrashing. Neither make nor ninja
can currently watch the RAM, even though it is not complicated:
>>> import psutil
>>> psutil.virtual_memory()
svmem(total=16536903680, available=7968600064, percent=51.8,
used=16347615232, free=189288448, active=11750494208,
inactive=2882383872, buffers=3158528000, cached=4620783616)

I think we should teach both to do that, and then replace a static
'number of jobs' limit in PARALLEL_MAKE with limits on CPU load and
RAM usage.

Alex

