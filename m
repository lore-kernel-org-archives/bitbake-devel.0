Return-Path: <alex.kanavin@gmail.com>
Received: from mail-oi0-f68.google.com (mail-oi0-f68.google.com
	[209.85.218.68])
	by mail.openembedded.org (Postfix) with ESMTP id 96B1578E6F
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Aug 2018 09:18:35 +0000 (UTC)
Received: by mail-oi0-f68.google.com with SMTP id 13-v6so32379404ois.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Aug 2018 02:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=Bz4cBHKLgYYKakOFtPaZosH8H/ukHJoEF+O1XnU4CEo=;
	b=OwJt/6G/D6ey79+i6C9xOYNwGi6Xpaz5yOVG+bSUQBFken/EQ34H8bLt4GOqlnzMIF
	bhhrNFVZPXCsGeBrPCW4slzDHtxumkp0ydWn1jheP8N//ZexOEmv8hBEPv+2KI/9ZxcA
	Px2ZNxpj0nDKRzzJr4GEpKZ7FHpbhoinFHGS22msIXADiKQ3vl4YOli72bRA4Ot/Y9jJ
	aCb5m+W23JWtfpCe7XO6rZeGio0qnMLBXWU7XRoZemjISRfVdKE2DPFmozhsqQVi3+2o
	8Uh6AiEB6nDvXd4oM9Wr8um27mqAE5o/IOVowI4mkLkjWLpPDqBkGCHUa5eLhRfiRB45
	av8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=Bz4cBHKLgYYKakOFtPaZosH8H/ukHJoEF+O1XnU4CEo=;
	b=B0MwLMNsqwa5Xj/uPMW8L374qlbv2xNJmIE/yBMc8iur1ymBRKElQg5zdp71taDyIN
	Y/vsayOQMYToyEvTlz2d48zlchfzIjm61rsLbobPZHFeOVt9bLJg/GMiAUY9ZYRm5LN3
	i8/rRoC8c74Xtt/Q8QeLZmL627uaTUuq7a07Mi6MAEC4HBAAmw8Szx/r9zm8KJjUIZGJ
	YrjggH/BmYj2pL303eSXl/tfSSPu0oCIy9Nx9gVgFgzav3jCz4NwAYDwYthKPIGx76Ys
	GMc94+wjMr0HysP5TzijNMF0qhASlVjR4+V8tj0wcL6IgeeeHnOkCtrKJ73vyqEFZAhc
	ofYQ==
X-Gm-Message-State: AOUpUlEVTwpxWDmz3hYrgVg8DpCJxTs0KibWyv2SqPzzuH/ICzciIsqm
	Wtwk175L+M4ZUM4767NM4TSKNCvWFV5y6vJdz8c=
X-Google-Smtp-Source: AA+uWPxQ3MhB0+3aW74Md6JyhqwqsppUuzeL2FD9fqcZOatIk7gf1hjgUVpMdfMjp1C6zfRTpuh5VYDlhAsQH3aXfEg=
X-Received: by 2002:aca:3e03:: with SMTP id
	l3-v6mr19873862oia.54.1534238316634; 
	Tue, 14 Aug 2018 02:18:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:90c5:0:0:0:0:0 with HTTP; Tue, 14 Aug 2018 02:18:36
	-0700 (PDT)
In-Reply-To: <CALbNGRRQOX81rdKkqnJRyM8i3xFy9e10Twq-o7q+KevcUJHq4g@mail.gmail.com>
References: <20180813210445.32496-1-schnitzeltony@gmail.com>
	<20180813210445.32496-3-schnitzeltony@gmail.com>
	<CANNYZj-3OQ7gPEop3OcDL5bnv3x9Q=DmEFCYi4-K7B3Xqp5v0Q@mail.gmail.com>
	<CALbNGRSUXV_HGSLNb4Uc=w_nZSLA_zL-da5+q-1jGgqqGdJKbw@mail.gmail.com>
	<CAJ86T=WJgaefsob77U57fQMkH=fZ+DK4srKN+PESUyYmSfKKmw@mail.gmail.com>
	<CALbNGRRQOX81rdKkqnJRyM8i3xFy9e10Twq-o7q+KevcUJHq4g@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 14 Aug 2018 11:18:36 +0200
Message-ID: <CANNYZj9qV6DD=w-UCq5Ntq0U1CBKR9daLZvfg3aAyA91vsos8A@mail.gmail.com>
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
X-List-Received-Date: Tue, 14 Aug 2018 09:18:35 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2018-08-14 11:05 GMT+02:00 Andreas M=C3=BCller <schnitzeltony@gmail.com>:
>> I wonder if you've experimented with the opposite approach, ie
>> spawning fewer tasks when CPU load is very high? If a single
>> do_compile task can fully load all CPUs, not running other tasks in
>> parallel with it (especially another do_compile) might give some
>> benefit?
>>
>> Dynamically boosting and dynamically lowering BB_NUMBER_THREADS based
>> on overall CPU load both seem like logical things to do.
>
> I think the patch does this of you interpret parameters differently.
> So if you use BB_NUMBER_THREADS =3D 10 currently and want to go down to
> 2 in case heavy load set
>
> BB_NUMBER_THREADS =3D 2
> BB_NUMBER_THREADS_LOW_CPU =3D 10

Right, then that's quite useful! Is it also possible to detect the low
RAM situation?

Perhaps it's better to rename the parameters to BB_NUMBER_THREADS_MIN
and BB_NUMBER_THREADS_MAX? Then bitbake would run tasks within the
range, with the aim of keeping the CPU loaded, but not overloaded.
There could even be reasonable defaults: number of cores/threads for
MAX, and 2 for MIN.

Alex

