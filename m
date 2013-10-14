Return-Path: <chmorgan@gmail.com>
Received: from mail-ie0-f181.google.com (mail-ie0-f181.google.com
	[209.85.223.181])
	by mail.openembedded.org (Postfix) with ESMTP id 670256BF59
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 14 Oct 2013 13:28:56 +0000 (UTC)
Received: by mail-ie0-f181.google.com with SMTP id ar20so3062101iec.26
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 14 Oct 2013 06:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type;
	bh=75R7IRCGHY1l80Rw8myDwuLfQ2uqrR6rJ9/1k3UK9w4=;
	b=G7fL89Z9U1OXZ+3/H48vItdV+zWmitF6J7wuYtoABx5pIOa0Wo0JZTc7KL/LKQT4W8
	WuC5OvPNX3zTM/m/DD+TfwtE8p1zmxCXH+KrhQL23L9iI83VjSF4RewS5fiWwgZGU5US
	+BgGePrhWjFT9R7ZTETtkoFN6CDTalinJUIyQrq2e6LA1YfodCHPatEREpgirFeVvUzp
	qh5otw3bJT9VXTGt5Lp+ZFnZcoNlH5Jmow+h1RMrITLxkamM0NiLZ9M2yvOd3nMpJ5Hx
	TacBUD6mHL4YChzIdrXv/NZ+jdhRfiUKpLYeaNAaIfa0CGnj6TIr5qsTGI50cUp3BnF1
	foIw==
X-Received: by 10.50.13.104 with SMTP id g8mr13239879igc.30.1381757337796;
	Mon, 14 Oct 2013 06:28:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.143.195 with HTTP; Mon, 14 Oct 2013 06:28:37 -0700 (PDT)
In-Reply-To: <1381683215.29912.233.camel@ted>
References: <CAAPegz09fP8ppysRS_opbSxv6nLknfd4NUnyVmgqzMNcu7+zmg@mail.gmail.com>
	<1381683215.29912.233.camel@ted>
From: Chris Morgan <chmorgan@gmail.com>
Date: Mon, 14 Oct 2013 09:28:37 -0400
Message-ID: <CAAPegz12Mnrbipi0w4zMdcje1R4SUwhMiUKsOAOfKHpzukea2Q@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Bitbake for native x86 project?
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
X-List-Received-Date: Mon, 14 Oct 2013 13:28:56 -0000
Content-Type: text/plain; charset=ISO-8859-1

On Sun, Oct 13, 2013 at 12:53 PM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> On Fri, 2013-10-11 at 09:22 -0400, Chris Morgan wrote:
>> I'm working on a project that generates several libraries and
>> applications. Today we build and run exclusively on x86 Linux desktop
>> machines and use cmake for the build system. In the future we plan to
>> add cross-compiling of these same libraries and applications for an
>> embedded arm platform, Yocto based. We would like to maintain both
>> types of build, for x86 and for arm.
>>
>> I've seen guides on how to use Yocto (or other bitbake based
>> distributions) to generate x86 images but these appear to involve
>> building the entire x86 toolchain, kernel, all libraries, creating a
>> virtual root and building a root filesystem image that one would run
>> under an emulator.
>
> This isn't entirely accurate. You can choose just to build a given
> library for example (bitbake libfoo). All its default dependencies are
> also built though, which means in most cases, a cross toolchain would be
> triggered. There is no need to build a kernel or a complete rootfs.
>
>> In my case I'd like to use bitbake to build libraries and applications
>> and create a virtual root, but not create a kernel, toolchain and
>> other system provided libraries. Then, when we decide to transition
>> over to Yocto I'd like to leverage the recipes by plugging them into
>> the Yocto system somehow (I'm still starting to understand the
>> process).
>
> To try and clarify, we have roughly three types of target recipes:
>
> a) target system
>
> These are for the target system defined by MACHINE and are cross
> compiled by a cross toolchain against a cross compiled libc. target can
> be different to the build architecture. They are packaged and managed by
> a package manager.
>
> b) nativesdk
>
> These are standalone binaries designed to run on SDKMACHINE. They are
> cross compiled and link against their own libc which is designed to run
> in some location defined at install time. We use these to generate
> toolchain binaries and tools that can run on pretty much an Linux
> system, regardless of its kernel, libc or system layout. They are
> packaged and managed by a package manager.
>
> c) native
>
> These are compiled to run on the build system. They work very much like
> you describe except they are not packaged at all.
>
> (I'm ignoring -cross and -crosssdk since these are basically toolchain
> bootstrap details).
>
>> I haven't seen any guides or information on how to use bitbake for
>> native desktop applications. I feel like its certainly possible but it
>> appears to be quite a bit of work just to proof of concept things.
>>
>> Is there anything inherently wrong with what I'm proposing here with
>> bitbake? Does it make sense that it would save time to develop the
>> recipes once and use bitbake for the desktop like this?
>
> Its certainly possible, its just that nobody has done it. Your options
> would be to either reconfigure the native recipes to be packaged, or to
> add in a configuration which shortcircuits the cross compiler and adds
> in some native magic to specific machine targets.
>
> Whilst adding packaging to native sounds attractive, the reality is that
> its not easy and doesn't really make sense technically. Adding in those
> short-circuits I mention by comparison shouldn't be hard and if I were
> doing this, its the way I'd go.
>
> Cheers,
>
> Richard
>


Ahh interesting. I was thinking that this kind of a short-circuit
approach might make sense. Its good to hear that the concept isn't so
crazy although I've literally found no information about anyone doing
anything of the sort on the web.

I considered using the full blown x86/x86-64 targets but our build
time right now using cmake and native tools is ~30 seconds with only a
handful of MB of data to download.

Would using a sstate cache + a custom image target be able to get down
to that kind of time? Today each developer is building on their
desktop and from my own testing with angstrom it looks like the builds
take nearly an hour and generate 30+GB of data. This is almost
entirely why I've been hesitant to try to use the built-in x86/x86-64
support. I love the idea of ensuring that everything matches exactly
on each developer machine but the overhead is pretty crazy.

Chris

