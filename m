Return-Path: <armccurdy@gmail.com>
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com
	[209.85.221.173])
	by mail.openembedded.org (Postfix) with ESMTP id 023CA6092C
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Feb 2020 01:32:03 +0000 (UTC)
Received: by mail-vk1-f173.google.com with SMTP id t129so330137vkg.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Feb 2020 17:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=9/F6WdW1vZLH759Fnf5XyOEHrsj6fUzG1ZPk0wc6qQY=;
	b=PC0NlHLX16NRDjSum08y3ttodsOWQpaHOTrEMFdzjSG5zinCY39aCwPnXv0C5ydqAk
	9o8xf+t+6vdhWhbDxxBmYXIhrtVn6zjKDNFJI6LK/imoNP76ThBMSrM8vKbZI6NrczwP
	UWO07VZ1ETtdAb5VS4cgvkF5QNNTcSY0TjuIw1v69l87KmYOXr9Yvsitz5pWAW3+HOuz
	mW8uS2oy9fAUhhvxq0/ynX9KazHfbw0mjvPxrINJEhIR9S9OWkfWGjd2cT+12Jg2jQp9
	20BATLeRy/hnjO+lF/yoHSk5jwEEqqLa4E1D9UdjbzUw4FDOXqH+avK4yBvvH1ho553V
	gxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=9/F6WdW1vZLH759Fnf5XyOEHrsj6fUzG1ZPk0wc6qQY=;
	b=Re8WdzpN602qNwfEIYlamQqtyivSr/mlgc6uZYPg/eeOM/BnX6VT8xRJZZxv0Mcr8F
	UvtwyglyggzxUc435IrPrPE6VQBUWSZHkS10sZpCZfhC9Z5XryXQ3fApR9UOqBF05Nzm
	rzYQJjwtZxCFwjsNh38BZTUeG4wsMZaUv6kJihT7oJCleKNWPj5cw+HqFI1zsxzqmlq6
	DbDLKaIdkYXTmRXQ7LR7fCkMGDDxbfN+QEGgGrNwP3TRAXnhxhHDL/X/rgy9Xyq3FBQb
	i8AyvLV9+21EBSXop7W2pDNUxKCNQUvtqOJ2fk2l/ryI19uwXG6Z+wds7IScgc5NP0vn
	/qPQ==
X-Gm-Message-State: APjAAAXZFc0lvnipwc/0fXPofquNdAYXGPZPrOOsgQYXKdXUdgJuZiaA
	Gn3SRTluGOmsPSFiUhfFWJ60H8BEW1vrcWOby02GUQ==
X-Google-Smtp-Source: APXvYqwGkqOveeN5r7AaUPPGzrxNGRjlcigJmb717BnnOAjBrf4M9F6Yp5OT12NDiI7oYq7+TP/YD4mxmqV1jKp25c8=
X-Received: by 2002:a1f:5fc7:: with SMTP id t190mr1890377vkb.52.1582680724738; 
	Tue, 25 Feb 2020 17:32:04 -0800 (PST)
MIME-Version: 1.0
References: <20200225162245.Horde.i6DmVIhAUjVbUGUQKtyMoua@crashcourse.ca>
	<CAJ86T=VvTrTLQLUeqQh8stS1ihQR4UQwi9faRG--FKP-wcLbqA@mail.gmail.com>
	<alpine.LFD.2.21.2002252006080.10052@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.21.2002252006080.10052@localhost.localdomain>
From: Andre McCurdy <armccurdy@gmail.com>
Date: Tue, 25 Feb 2020 17:31:52 -0800
Message-ID: <CAJ86T=XYp6GZqYiM+_JbR+1wdrdOzuBT6BoD0FLftAmEDUKCXg@mail.gmail.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: is there a bitbake equivalent to "touch"ing a file for gnu make?
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
X-List-Received-Date: Wed, 26 Feb 2020 01:32:04 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2020 at 5:07 PM Robert P. J. Day <rpjday@crashcourse.ca> wr=
ote:
>
> On Tue, 25 Feb 2020, Andre McCurdy wrote:
>
> > On Tue, Feb 25, 2020 at 1:22 PM <rpjday@crashcourse.ca> wrote:
> > >
> > >    colleague emails me the following puzzler =E2=80=A6 current projec=
t based on
> > > wind river linux 9 (so effectively morty 2.2), so it has bitbake 1.32=
.
> > > apparently, for a specific recipe, there are intermittent build error=
s
> > > which she suspects are caused by a race condition in the build of tha=
t
> > > recipe.
> > >
> > >    *but* that build error only occurs when something about the underl=
ying
> > > layers have changed; as in, someone checked *something* in somewhere
> > > forcing at least something to be rebuilt, and that error does not
> > > even occur on *all* rebuilds, just some of them. so the question is,
> > > which underlying recipe change and rebuild could be triggering this?
> > >
> > >    she *suspects* it might be openssl, as their project is making
> > > regular changes to openssl, and that recipe seems to be an ultimate
> > > dependency for quite a number of recipes, so she's just guessing
> > > that might be the cause.
> > >
> > >    in order to test this, she is currently running through a loop
> > > wherein, in order to kick off at least some recipe rebuilds, she
> > > makes some innocuous change to openssl, causing it to be rebuilt,
> > > which then rebuilds all recipes that depend on it and so on.
> > >
> > >    yuck.
> > >
> > >    on the other hand, i couldn't immediately suggest anything
> > > cleaner. my thought was to (somehow) fake a rebuild of openssl
> > > (perhaps by invalidating some timestamp), but that's not going
> > > to work as once it's rebuilt, it's just going to look like it
> > > did before, so nothing else will be rebuilt.
> >
> > Not sure what you mean by "fake" a rebuild. You can force a rebuild
> > by e.g. manually changing something in the recipe such as PR,
> > running "bitbake -c cleansstate openssl", ...
>
>   are you sure about that? i can test this when i get home, but i
> thought just cleaning the sstate would not force rebuilds of the rest
> of those recipes, just that one.

Not 100% sure. Changing PR in the recipe should work though.

But anyway you probably want to focus on the specific recipe which
fails intermittently. Forcing it to be rebuilt after removing tmp
should at least tell you if it's a missing build dependency. If it
fails then it's a missing dependency and it should be obvious from the
build error (missing header, library, etc) what the missing dependency
is.

If it passes then it suggests that recipe has an unconstrained
configure option which is behaving differently based on whether it
autodetects something in the sysroot (which is shared in OE 2.2). In
that case it should fail consistently if you run the full build (so
that sysroot in tmp is fully populated) and then cleansstate and
rebuild the failing recipe.

