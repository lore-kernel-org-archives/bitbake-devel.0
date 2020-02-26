Return-Path: <armccurdy@gmail.com>
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com
	[209.85.222.41])
	by mail.openembedded.org (Postfix) with ESMTP id D65E261837
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Feb 2020 00:31:23 +0000 (UTC)
Received: by mail-ua1-f41.google.com with SMTP id p2so349529uao.9
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Feb 2020 16:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=3akvDJVYzwr+tmVlnNVjKLtvv1XqoRvXlTJHhInbOzk=;
	b=dntGRRgoBKoGC0Bw0l+tV375YUvs+AWqzWbeIl26T4X9/AbcMOdzrZ4TGSBqcF+bPZ
	1fvJad3LsFU6t8JWVBTJy9WbL4WHDZ4IPMtdVAsfQndmAA/yL2BwA7+JGUlrb78lzK89
	xiKRkyct7/K458ytG5OQsUOg0lZwCVxfk8jQmx8CZBPPtI4ToX8pDtsyHO2KIXnOHbRB
	mYI+XOiA+qVlpYY6knz/42cCqAa5O8T16yu6zkHyVooCs7wxoAB6QiH+i3qvY9ciVAzs
	HIL4pR6KsFQoi2fAFExmKKBL0wSn+x8bL1ZgoOTC6eEd4NbWw1wFoioNfa1Wjt0ZCyoY
	i4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=3akvDJVYzwr+tmVlnNVjKLtvv1XqoRvXlTJHhInbOzk=;
	b=f13ruROkFyrFXrajqKDedrWwdDCaYCUIXoZvSw8D8vX/rmOf/sg7wkCAwptC06zewy
	+pjWlbd7zK2BiKLkUkQ4kYiesgGSupE8oIhgkZ5ok/qdV2+XrSnwnoSXbXR+WJcI5JA6
	RxueUf85Euf1GmRCj90i6rzqDor09uP/NHH3ooBi5XdG9YauHd82DiQ3ODoSntOP8XYg
	/YDoYarKXC35zfN6XjCds+c665xmJxd3+hCVYAsFcu7HJrKj6ZkQzUzQn+iZOt2hRhmf
	LQmOefT9vG2hmu5XEflYNVcHDPnUjJmc4RV3qikxVBF5RC7WN9u5m8lmTDRcAf5GSXmS
	R4Qg==
X-Gm-Message-State: APjAAAWEy3Ps3V/Dze53sXPO1yJKX06PajkFmutqZolNXy73xyf6FXgT
	guxICF0xUKtMC7Ypv2Xk8n+DRay5viOgMfdllFkEquVm
X-Google-Smtp-Source: APXvYqwoWzv94+BK3kw003boaUWKTfv57o6IJm8LWUq8Wx6a21XZfPAr70XI+2u6jviUGRAekZyj/iSzaKUB/+sTV+c=
X-Received: by 2002:ab0:710c:: with SMTP id x12mr1852764uan.81.1582677084602; 
	Tue, 25 Feb 2020 16:31:24 -0800 (PST)
MIME-Version: 1.0
References: <20200225162245.Horde.i6DmVIhAUjVbUGUQKtyMoua@crashcourse.ca>
In-Reply-To: <20200225162245.Horde.i6DmVIhAUjVbUGUQKtyMoua@crashcourse.ca>
From: Andre McCurdy <armccurdy@gmail.com>
Date: Tue, 25 Feb 2020 16:31:12 -0800
Message-ID: <CAJ86T=VvTrTLQLUeqQh8stS1ihQR4UQwi9faRG--FKP-wcLbqA@mail.gmail.com>
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
X-List-Received-Date: Wed, 26 Feb 2020 00:31:24 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2020 at 1:22 PM <rpjday@crashcourse.ca> wrote:
>
>    colleague emails me the following puzzler =E2=80=A6 current project ba=
sed on
> wind river linux 9 (so effectively morty 2.2), so it has bitbake 1.32.
> apparently, for a specific recipe, there are intermittent build errors
> which she suspects are caused by a race condition in the build of that
> recipe.
>
>    *but* that build error only occurs when something about the underlying
> layers have changed; as in, someone checked *something* in somewhere
> forcing at least something to be rebuilt, and that error does not
> even occur on *all* rebuilds, just some of them. so the question is,
> which underlying recipe change and rebuild could be triggering this?
>
>    she *suspects* it might be openssl, as their project is making
> regular changes to openssl, and that recipe seems to be an ultimate
> dependency for quite a number of recipes, so she's just guessing
> that might be the cause.
>
>    in order to test this, she is currently running through a loop
> wherein, in order to kick off at least some recipe rebuilds, she
> makes some innocuous change to openssl, causing it to be rebuilt,
> which then rebuilds all recipes that depend on it and so on.
>
>    yuck.
>
>    on the other hand, i couldn't immediately suggest anything
> cleaner. my thought was to (somehow) fake a rebuild of openssl
> (perhaps by invalidating some timestamp), but that's not going
> to work as once it's rebuilt, it's just going to look like it
> did before, so nothing else will be rebuilt.

Not sure what you mean by "fake" a rebuild. You can force a rebuild by
e.g. manually changing something in the recipe such as PR, running
"bitbake -c cleansstate openssl", etc, but then it's a real a rebuild.
It doesn't matter if the output of the rebuild is identical to a
previous build, anything which depends on openssl will get rebuilt too
(at least for OE 2.2).

>    is there an easier way to do this? i don't have a system
> with that old a YP version at hand, so i can't test this, and
> nothing leaps to mind. is there a "make touch" equivalent
> that would drive a full rebuild of all recipes that depend
> on a given recipe, without having to actually mess with it?
>
>    i figured, "ah, this can't be that hard," but i haven't
> come up with anything.
>
> rday
>
> p.s. simply cleaning the offending recipe and rebuilding it
> won't trigger the build error (at least that's what I've been
> told) =E2=80=A6 one must change the underlying recipes at least a
> little in order to *force* a rebuild allegedly based on
> dependencies.

Right, clean doesn't remove sstate, so just running clean won't force
something to be rebuilt. You need to use cleansstate instead.

Anyway, it sounds like you just have a missing build dependency
somewhere. Making a change to openssl causes a lot of stuff to get
rebuilt (but perhaps in a different order than a full rebuild from
scratch) which is highlighting the missing dependency. Best way to
debug is to find out which recipe fails intermittently and then try
building just that recipe after running cleansstate for that recipe
and removing the entire tmp directory. It should then fail
consistently.

