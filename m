Return-Path: <paul.barker@konsulko.com>
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
	[209.85.210.66])
	by mail.openembedded.org (Postfix) with ESMTP id 3DEA5611CD
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Feb 2020 22:29:44 +0000 (UTC)
Received: by mail-ot1-f66.google.com with SMTP id h9so10228848otj.11
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Feb 2020 14:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=konsulko.com; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=j3Yur++rwfHpX7/1d/Q8l/0HwSB4WXktSrN3kr6ISiE=;
	b=l+ZdGufh9jHVxmi26jtWS8CDDYQqMfTcungjl4c8o22PZX9HGauL1UU8xRdL/dbLa5
	eSUFX2SPjrn9ZDcf7RKkHpsjm7BTzQQUToJLcrIIshVXIRZ8OowAFcI0ZOg0GSw9J1Dj
	EJbwBOgHMz4FUH1SgnhUWDghl2Di/MkRRl/q8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=j3Yur++rwfHpX7/1d/Q8l/0HwSB4WXktSrN3kr6ISiE=;
	b=lkFUncSVQUy/84x4c6Lh7j5Chjolmhf4a6EKuFepTjsbHu866AcELYrCEidNmDbUfF
	vN1ozuB50zfzhHZh80ztQfzmfvE3pip8reZ73j1kpEUgc9CcIiN6yW2idO724jDeTrBP
	tb+qQpjeZa/ZBTazvUS+qNT8nA/oce5xoBIGy3vwcCxpM1poPRKHTt5zgUrgBE79cNXP
	Oj1FEP8VqCHhJyT9VzRkTX5n7RJETjOsyhZ3bFRpYmH8hODF5SbWw1HWZKrZU40Ze4M9
	e1n3md+4JPZLmFr89QgSsM1AE1OVLfFTCP97oIyazI7jw42fKk5jE0i0uyh5dmJgrMBc
	fv2w==
X-Gm-Message-State: APjAAAV9Lxp3DKD1e59SEeWQ70cqVcrdof/eDHsdl1Wg5KTITUkwMCP4
	AUSEqOtwqVSdgDZwBc3mDQeHqpLTOLmizKMBRi1wHA==
X-Google-Smtp-Source: APXvYqwRdVt9uelTzPkTsmuhihsdohcdtSB6yFTuZagoyCtF4gSJqeWoH+gJ7IAr5rKRc8d4vAEX0yEz/eO1Z7SxW/s=
X-Received: by 2002:a05:6830:194:: with SMTP id
	q20mr43299369ota.92.1582583384979; 
	Mon, 24 Feb 2020 14:29:44 -0800 (PST)
MIME-Version: 1.0
References: <20200224201629.13774-1-pbarker@konsulko.com>
	<ab447cea74fea333860e75d1b2619a7215855e67.camel@linuxfoundation.org>
	<CAM9ZRVv3opmXyKAFPFaaUV7D33uNmxWmn47bQR_Ek_Z0eXqKxw@mail.gmail.com>
	<d79eb8997dcf6635856e574d407c9c805e14326c.camel@linuxfoundation.org>
In-Reply-To: <d79eb8997dcf6635856e574d407c9c805e14326c.camel@linuxfoundation.org>
From: Paul Barker <pbarker@konsulko.com>
Date: Mon, 24 Feb 2020 22:29:34 +0000
Message-ID: <CAM9ZRVtRhBeAdYSeODrxkPOpen3y-7NsJ-jvM5JN+mTO1A+ymA@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] fetch2/gitsm: Unpack shallow mirror tarballs
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
X-List-Received-Date: Mon, 24 Feb 2020 22:29:44 -0000
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Feb 2020 at 22:10, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> On Mon, 2020-02-24 at 21:46 +0000, Paul Barker wrote:
> > On Mon, 24 Feb 2020 at 21:32, Richard Purdie
> > <richard.purdie@linuxfoundation.org> wrote:
> > > On Mon, 2020-02-24 at 20:16 +0000, Paul Barker wrote:
> > > > When a shallow mirror tarball is used to satisfy a gitsm URI it
> > > > needs to
> > > > be unpacked so that the .gitmodules file can be examined.
> > > >
> > > > Signed-off-by: Paul Barker <pbarker@konsulko.com>
> > > > ---
> > > >  lib/bb/fetch2/gitsm.py | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > >
> > > > diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
> > > > index aa121cbe..98f5dae5 100644
> > > > --- a/lib/bb/fetch2/gitsm.py
> > > > +++ b/lib/bb/fetch2/gitsm.py
> > > > @@ -169,6 +169,12 @@ class GitSM(Git):
> > > >                  raise
> > > >
> > > >          Git.download(self, ud, d)
> > > > +
> > > > +        # If we're using a shallow mirror tarball it needs to be
> > > > unpacked so
> > > > +        # that we can examine the .gitmodules file
> > > > +        if ud.shallow and os.path.exists(ud.fullshallow) and
> > > > Git.need_update(self, ud, d):
> > > > +            bb.utils.mkdirhier(ud.clonedir)
> > > > +            runfetchcmd("tar -xzf %s" % ud.fullshallow, d,
> > > > workdir=ud.clonedir)
> > > >          self.process_submodules(ud, ud.clonedir,
> > > > download_submodule, d)
> > > >
> > > >      def unpack(self, ud, destdir, d):
> > >
> > > Does this mean we're missing a test?
> >
> > Possibly. Maybe a two step test with a recipe using a `gitsm://` URL:
> > 1) Fetch the recipe with BB_GENERATE_MIRROR_TARBALLS,
> > BB_GENERATE_SHALLOW_TARBALLS and BB_GIT_SHALLOW set. Copy the mirror
> > tarballs out of the downloads directory to a local mirror directory.
> > Throw away DL_DIR, SSTATE_DIR and TMPDIR.
> > 2) Using the mirror generated in step 1 try to fetch and unpack the
> > recipe.
> >
> > Does that sound like a sensible test? I think it would have to go in
> > oeqa rather than the bitbake tests if we do it that way.
>
> It sounds like it might be reasonable, I'm not sure why we can't do
> that in lib/bb/tests/fetch.py though? There are other tests which do
> similar sequences of commands.
>
> You'd do it with calls to the fetch and unpack Fetcerh APIs and alter a
> datastore and files in between but I can't see why it would need to be
> in oeqa?

Ok, I've looked more closely at GitMakeShallowTest in
lib/bb/tests/fetch.py. We could write a new
test_shallow_submodule_mirrors function based on
test_shallow_submodules and test_shallow_mirrors.

The case I would want to catch is do_unpack failing. I guess we could
check that fetcher.unpack() works as a proxy for that.

