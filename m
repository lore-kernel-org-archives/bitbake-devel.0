Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by mail.openembedded.org (Postfix) with ESMTP id 18A9260AF3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Feb 2020 22:09:59 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id g3so12252033wrs.12
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Feb 2020 14:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:user-agent:mime-version:content-transfer-encoding;
	bh=2IcqtMOmuCORtslN9J48t0UzHHgox5yk15mBB27Ut9E=;
	b=WDYRpKYDeLhli34foa95ZxAIPNmo6S9XdEOHUGP2FHBc2wCP4x91X7CjClDVv8zxT4
	fvikhjL24b0NvDKGKcVHwITs9Dj5C0QFOgaK2wV9RkcwC1HJ1S2hTw3cbwGmH/B4yY6W
	lcm1DYK/rOoWphydRRN0KSYoFIzisru4v5zfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=2IcqtMOmuCORtslN9J48t0UzHHgox5yk15mBB27Ut9E=;
	b=sS1f+vHMO+MLGKa8zkwr/36zsJABqlOaR+eRMdJkk4sRaz4klBmiCfBDxLb4v6qj8v
	kR2ApckwXvdnUg8Nsm2Ig6oZkr8a5eJwWZyW6zrMeoDa9mvOQPw1DK3uhulqWv011VJD
	DnweZqnxuPbX/C0gqyuoS9vGuAezTKGUskS35cY1aXo9Phco1MZEEk9heIwFc4lF7L7t
	G3BhCikMMzJmDCP/6Lbe6mRznNzRpaHwz0gd+S3aaLqyebO2bwdBzNa+42Nv/PjT8yIe
	+aMf2UnDUW3PHmFZyja2lMwcUbFd7B8AuutHK2VWStcREE2fTAT13CH29DNFJqHw6cGM
	c2eA==
X-Gm-Message-State: APjAAAVIfeNapSetcqYtHxGYcgd30Yy0FTgpJ+UiZeav4FC+etDpH+lr
	C6tOxXMqpMuupXXy3SzsSvNPsHAxlWs=
X-Google-Smtp-Source: APXvYqxIrjVXT8xzvt5WA65ItHrrX3Yd2pL/s5Bp78q62Q7CFTzoLVdO/jY48LSWc2BJPuypIdvoOA==
X-Received: by 2002:adf:f58c:: with SMTP id f12mr65949636wro.22.1582582200631; 
	Mon, 24 Feb 2020 14:10:00 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	i204sm1136632wma.44.2020.02.24.14.09.59
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 24 Feb 2020 14:09:59 -0800 (PST)
Message-ID: <d79eb8997dcf6635856e574d407c9c805e14326c.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Barker <pbarker@konsulko.com>
Date: Mon, 24 Feb 2020 22:09:57 +0000
In-Reply-To: <CAM9ZRVv3opmXyKAFPFaaUV7D33uNmxWmn47bQR_Ek_Z0eXqKxw@mail.gmail.com>
References: <20200224201629.13774-1-pbarker@konsulko.com>
	<ab447cea74fea333860e75d1b2619a7215855e67.camel@linuxfoundation.org>
	<CAM9ZRVv3opmXyKAFPFaaUV7D33uNmxWmn47bQR_Ek_Z0eXqKxw@mail.gmail.com>
User-Agent: Evolution 3.34.1-4 
MIME-Version: 1.0
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
X-List-Received-Date: Mon, 24 Feb 2020 22:10:00 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2020-02-24 at 21:46 +0000, Paul Barker wrote:
> On Mon, 24 Feb 2020 at 21:32, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
> > On Mon, 2020-02-24 at 20:16 +0000, Paul Barker wrote:
> > > When a shallow mirror tarball is used to satisfy a gitsm URI it
> > > needs to
> > > be unpacked so that the .gitmodules file can be examined.
> > > 
> > > Signed-off-by: Paul Barker <pbarker@konsulko.com>
> > > ---
> > >  lib/bb/fetch2/gitsm.py | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
> > > index aa121cbe..98f5dae5 100644
> > > --- a/lib/bb/fetch2/gitsm.py
> > > +++ b/lib/bb/fetch2/gitsm.py
> > > @@ -169,6 +169,12 @@ class GitSM(Git):
> > >                  raise
> > > 
> > >          Git.download(self, ud, d)
> > > +
> > > +        # If we're using a shallow mirror tarball it needs to be
> > > unpacked so
> > > +        # that we can examine the .gitmodules file
> > > +        if ud.shallow and os.path.exists(ud.fullshallow) and
> > > Git.need_update(self, ud, d):
> > > +            bb.utils.mkdirhier(ud.clonedir)
> > > +            runfetchcmd("tar -xzf %s" % ud.fullshallow, d,
> > > workdir=ud.clonedir)
> > >          self.process_submodules(ud, ud.clonedir,
> > > download_submodule, d)
> > > 
> > >      def unpack(self, ud, destdir, d):
> > 
> > Does this mean we're missing a test?
> 
> Possibly. Maybe a two step test with a recipe using a `gitsm://` URL:
> 1) Fetch the recipe with BB_GENERATE_MIRROR_TARBALLS,
> BB_GENERATE_SHALLOW_TARBALLS and BB_GIT_SHALLOW set. Copy the mirror
> tarballs out of the downloads directory to a local mirror directory.
> Throw away DL_DIR, SSTATE_DIR and TMPDIR.
> 2) Using the mirror generated in step 1 try to fetch and unpack the
> recipe.
> 
> Does that sound like a sensible test? I think it would have to go in
> oeqa rather than the bitbake tests if we do it that way.

It sounds like it might be reasonable, I'm not sure why we can't do
that in lib/bb/tests/fetch.py though? There are other tests which do
similar sequences of commands.

You'd do it with calls to the fetch and unpack Fetcerh APIs and alter a
datastore and files in between but I can't see why it would need to be
in oeqa?

Sorry to push testing btw but the git fetcher is one of our better
tested pieces of code so I do want to try and maintain good test
coverage!

Cheers,

Richard





