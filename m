Received: from mail-vs1-f66.google.com (mail-vs1-f66.google.com [209.85.217.66])
 by mx.groups.io with SMTP id smtpd.web12.27432.1586123470306493779
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 05 Apr 2020 14:51:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=f8RRQPMW;
 spf=pass (domain: gmail.com, ip: 209.85.217.66, mailfrom: armccurdy@gmail.com)
Received: by mail-vs1-f66.google.com with SMTP id u11so8603444vsg.2
        for <bitbake-devel@lists.openembedded.org>; Sun, 05 Apr 2020 14:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N1RvRiukjIl6xolXsjyGhU89wsp9cI7Eu4TDMwaDXJU=;
        b=f8RRQPMWrWymTnXoB+VZCJpNn8dXbuQMG3ceMklJKt/T3vQUuh/Z7jOkPLA//q4MH3
         G58G28GH8931nfu3sjKBsvw1GlZJe1UAJ50gZ0Bg2X9GYPVG/zDoITRUfM99ZGNsx4qy
         23x9EUvsp3pqi0i5yUfAIEvlt6UEnhV92vLYQLOy/YGowuU5/hKvl1e2xYZv8rlHxZvU
         bi/r0bPmOwc1cNyGTsAL3F+So4wmZxYTHnlfNu3GkSQ2b2GhOigS5121xi1RCIPBrDEr
         M1QDOM3jwiP0vcPnG+oAUOkKJvAM1VV8AO4hgAZjYw5wAmrazCPFKRleQ1ItVDsh/z7Z
         5bUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N1RvRiukjIl6xolXsjyGhU89wsp9cI7Eu4TDMwaDXJU=;
        b=I81tik3Wjvou/kp4EI72Ab2C1zTjgna5rIbzQteYUJVzjTiTHBSmmlUstIKO4ztD8B
         dMLNW+ius9voqjVEvxm9vKdyOG9eHP2VDlN3j8QP/qqkSdYfZv/t2e7KGXFHMuUiOPF9
         ohr8QJhBeORjKCuKoqV5mzq4NOSCIhccxco+ymiBF+cTYd85WdkcBVf3Yc7N5Z8d5kvt
         4hu+m/gDyWdpBqYVT8dwnam3/miS2LKGcqpzNHx7QJ/BOWDdZspfgnWKM8cgP9tpk3Px
         EYtGCzVFhaABmGu6PbMmVJcLBHNN2+7thAu2f0uGcwMZ8OMW/pu9X4tYmzm14Ow7vPlc
         sXXw==
X-Gm-Message-State: AGi0PuZ3j3fWSgJtVvqLSX9IrEwjb7PWNB3WzPWfNRm7WREEZ8OA8r53
	3jY3nEJKPf9wVuQdlsKR+l5NpAkMMpea8ykW094=
X-Google-Smtp-Source: APiQypK3ISMafMi9jJipPhX6/0BKWh8rcfzfp+1gAhhUBwRBeBwfSTgbGsYHoaqA9ZoG5kFgPidyTfflaWse5KkGkWI=
X-Received: by 2002:a67:2284:: with SMTP id i126mr13060405vsi.223.1586123469356;
 Sun, 05 Apr 2020 14:51:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200402195104.2405-1-bernd.bauer@gmx.at> <fb960c2f15390746d24fd95368478c518748c957.camel@linuxfoundation.org>
 <55c322d4-aa7a-4a6e-6fbe-70ab9eecee83@gmx.at> <d5b377f1-413b-6e50-87f3-c77e37ca9c35@gmail.com>
In-Reply-To: <d5b377f1-413b-6e50-87f3-c77e37ca9c35@gmail.com>
From: "Andre McCurdy" <armccurdy@gmail.com>
Date: Sun, 5 Apr 2020 14:51:02 -0700
Message-ID: <CAJ86T=XbybfQkxtKbc8SbEU2d638Hz30A2641ymFUmxQf9P_Jw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] Gitsm does not use credentials when cloning submodules
To: Khem Raj <raj.khem@gmail.com>
Cc: bernd.bauer@gmx.at, bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, Apr 3, 2020 at 10:21 AM Khem Raj <raj.khem@gmail.com> wrote:
> On 4/3/20 12:29 AM, Bernd Bauer wrote:
> > Am 02.04.20 um 23:08 schrieb Richard Purdie:
> >> On Thu, 2020-04-02 at 21:51 +0200, Bernd Bauer wrote:
> >>> If the git server needs authentication the credentials are
> >>> encoded in the URL of the repositories.
> >>> The credentials from the main repository are deposited in the
> >>> recipe so main repository can still be cloned.
> >>>
> >>> But the URLs from the submodules are listed in the .gitmodules
> >>> file.
> >>> The submodule url is encoded with an username and a password
> >>> or a bitbucket URL token. See example.
> >>>
> >>> The password is not stored in the ud.user but in the ud.pswd
> >>> variable. So in this case the url is made up by ud.user and
> >>> ud.pswd.
> >>>
> >>> Example:
> >>> [submodule "sub1"]
> >>>          path = sub1
> >>>          url = https://user:password@test.org/url/to/sub1
> >>>
> >>> Signed-off-by: Bernd Bauer <bernd.bauer@gmx.at>
> >>> ---
> >>>   bitbake/lib/bb/fetch2/git.py | 4 +++-
> >>>   1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> We have had requests for this before and we've said "no" since
> >> encouraging people to put passwords in urls is bad and it leads to
> >> people making accidental exposures. Its basically too risky.
> >>
> >> For git submodules the line becomes blurred.
> >>
> >> I'm open to the opinions of others but in this form the patch applies
> >> to git and gitsm and that in itself makes it more risky.
> >>
> >> I do understand why people want this, equally it really isn't a great
> >> idea in general :/.
> >>
> >> Cheers,
> >>
> >> Richard
> >
> > Hi!
> >
> > Of course it is not a good idea to write the credentials directly
> > in the recipe or in the .gitmodules.
> > Unfortunately I have no other choice than to encode the username
> > and password in the URL. This GIT server only allows HTTPS with
> > authentication. No SSH keys, no anonymous checkout.
>
> perhaps you should talk to your infosec about this.
> this is unusual setup, using key based authentication is far better than
> username/password mechanism.

Unfortunately there are some projects which haven't got that message.
Are you familiar with the RDK?

> > But without my patch the result would be the same.
> > I would have the URL with username and password in the
> > recipe and also in the submodules.
> > The only difference would be that I would have to define a
> > task in the recipe to check out the submodules.
> > So my recipe is getting complexer.
> >
> > do_configure_prepend() {
> >    cd ${WORKDIR}/git
> >    git submodules update --init --recursive
> > }
> >
> >  From my point of view, my patch would be more like
> > fixing a bug than an extension.
>
> >
> > Just my two cents...
> >
> > Greets Bernd
> >
> >
> >
> >
> 
