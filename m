Return-Path: <chmorgan@gmail.com>
Received: from mail-ie0-f181.google.com (mail-ie0-f181.google.com
	[209.85.223.181])
	by mail.openembedded.org (Postfix) with ESMTP id 935B560FAA
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 14 Oct 2013 15:02:24 +0000 (UTC)
Received: by mail-ie0-f181.google.com with SMTP id ar20so3390556iec.12
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 14 Oct 2013 08:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type;
	bh=EYtKsIZ30bakyXGDoEcDmRZmUzMLnOlZL/dvciy7iho=;
	b=ltsru+Dxv5LAfzdN2PkA5LF+w8H1p8MCOg1h1T/ywEsBDvdbzSR4mn2MpLQA5p2+6w
	WN0fgW3w+6UzPR6ASCCI27YsVWOvoaI0Gfq7DxZSfZXRnQute2GcexTiBliNs3hKkFJA
	/+cjWYulWkjypjIuB60X44ThCJl9Vbszf6CY0q0rtXLKwiatj+wdeJsWJLaJhFNrDPEY
	zp926nqEFlBPTxy2LDwMgyPf+iE9UMrtgg3ujjAKXDtk5NbfGqZWPcWv1KT5H9zTu8cu
	PnTJVO8nubbdPglHNA+ERdzdm/aYTPq7R+Skfq28ymbRYdoSVpi0EKWMz70KguySBF6d
	+ssA==
X-Received: by 10.50.111.48 with SMTP id if16mr13375842igb.23.1381762945517;
	Mon, 14 Oct 2013 08:02:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.143.195 with HTTP; Mon, 14 Oct 2013 08:02:05 -0700 (PDT)
In-Reply-To: <1381761637.29912.326.camel@ted>
References: <CAAPegz09fP8ppysRS_opbSxv6nLknfd4NUnyVmgqzMNcu7+zmg@mail.gmail.com>
	<1381683215.29912.233.camel@ted>
	<CAAPegz12Mnrbipi0w4zMdcje1R4SUwhMiUKsOAOfKHpzukea2Q@mail.gmail.com>
	<1381761637.29912.326.camel@ted>
From: Chris Morgan <chmorgan@gmail.com>
Date: Mon, 14 Oct 2013 11:02:05 -0400
Message-ID: <CAAPegz04fh+NP+ZEduiPo+Cbvh-bbzyqGNEsMaWJoOH0t_v23w@mail.gmail.com>
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
X-List-Received-Date: Mon, 14 Oct 2013 15:02:25 -0000
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Oct 14, 2013 at 10:40 AM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> On Mon, 2013-10-14 at 09:28 -0400, Chris Morgan wrote:
>> Ahh interesting. I was thinking that this kind of a short-circuit
>> approach might make sense. Its good to hear that the concept isn't so
>> crazy although I've literally found no information about anyone doing
>> anything of the sort on the web.
>
> I just sent out my notes/patch attempt at just short circuiting in gcc.
> Its a bit messy and I found some issues I didn't expect. It would be
> possible to do it with both gcc/libc I'd guess but its not something I'm
> going to have any more time to try any time soon...
>
>> I considered using the full blown x86/x86-64 targets but our build
>> time right now using cmake and native tools is ~30 seconds with only a
>> handful of MB of data to download.
>>
>> Would using a sstate cache + a custom image target be able to get down
>> to that kind of time? Today each developer is building on their
>> desktop and from my own testing with angstrom it looks like the builds
>> take nearly an hour and generate 30+GB of data. This is almost
>> entirely why I've been hesitant to try to use the built-in x86/x86-64
>> support. I love the idea of ensuring that everything matches exactly
>> on each developer machine but the overhead is pretty crazy.
>
> You can build a complete rootfs from sstate in about 4 minutes so I'd
> suggest trying it and see. If you've just building a cmake app, it will
> need to download and install a toolchain but it will just do that once
> for any given build directory and I suspect you could make it work.
>
> Cheers,
>
> Richard
>
>

Ahh. I see.

Thank you for those examples, I'll take a look at it in more detail
and see what I can learn. I appreciate the help.

Today I'm going to try to setup a sstate on a remote machine that has
a few hundred GB of free space, do a build and then try locally to do
the same. One question I had was whether developers, when using the
sstate, would receive tens of gigabytes of files downloaded to their
machines. I think that would be ok but not idea but oh well.


Would you be interested in doing some consulting/contracting around
the issue? or know if some one that might be? It would probably be 10x
faster than me doing it and we could avoid the various pitfalls that
we might hit during experimentation. If you or anyone is interested
you can contact me at chmorgan@gmail.com. We are in the Boston area
but telecommute works too.

Chris

