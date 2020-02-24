Return-Path: <paul.barker@konsulko.com>
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
	[209.85.210.65])
	by mail.openembedded.org (Postfix) with ESMTP id C71066161A
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Feb 2020 21:46:40 +0000 (UTC)
Received: by mail-ot1-f65.google.com with SMTP id r16so10179882otd.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Feb 2020 13:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=konsulko.com; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=hEcCrmY6wYSsTazxbIi91OBMFYFihdoKdEKZX4RGdGg=;
	b=Et12nlmi3N8wHrGvPsDFYONGn9qUX14b/QDcMNEBUCBt27Fn/4ygyfOZkk8VAa7pGu
	XvoynGjwAm/xxGVL5SX88XwHR5QCQlp1LZ0Uc5lq6eHiG+50BaWFPcdW292GVvy5yJS5
	UvhgWgzHZ5m24MC8j4CkB10NkSNfquD7N35Cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=hEcCrmY6wYSsTazxbIi91OBMFYFihdoKdEKZX4RGdGg=;
	b=Y8Sc02gZcBLO8/zxtGqMNfstvUv5RvZbA8a+hYM+KP+Q61+30UQGFd0ml+p2JHNFDs
	rKm65p6AMPjY2BDITgZ/6u8BUstEPDDFXwh+0edlFZNVOaJg/4qdF+VNXcZfU3AIDG7f
	jslpghLA53ZXTm1LUTKpihZ2XWp4ikNXNc/ZHLhURD9Ic/8ZhuDbGeASPTUCZmlQrCCG
	ChcN1TYA1xAfOZ2/hGEDrIasqeePraN/4J45QgTDwKTgds0qZT7tGTvc8Mf7xIQcw5fg
	niKTBEtIG19rslUDhPibtoAfRxqThBMUslKPXWn3z72EHGlho6GI6AuH84XDJjdp4l1Z
	6ZKw==
X-Gm-Message-State: APjAAAVXGV4BoBbVdq0VE3Kz8dOSdE7AfmiB73nBNZItgJbjXrj1XFh9
	nQG9B0tYDVlyE3N7DPYq0U8itl5XmUHclcy6pb3CbA==
X-Google-Smtp-Source: APXvYqxGZge31NjNOt/cF551FVq8UdjDXb9eMkWjh3iR/btqUHIOatz5sk4PRb/0joL9t5i9GrDdbDpsPt0OC4feIvw=
X-Received: by 2002:a9d:4801:: with SMTP id c1mr43134260otf.258.1582580801924; 
	Mon, 24 Feb 2020 13:46:41 -0800 (PST)
MIME-Version: 1.0
References: <20200224201629.13774-1-pbarker@konsulko.com>
	<ab447cea74fea333860e75d1b2619a7215855e67.camel@linuxfoundation.org>
In-Reply-To: <ab447cea74fea333860e75d1b2619a7215855e67.camel@linuxfoundation.org>
From: Paul Barker <pbarker@konsulko.com>
Date: Mon, 24 Feb 2020 21:46:31 +0000
Message-ID: <CAM9ZRVv3opmXyKAFPFaaUV7D33uNmxWmn47bQR_Ek_Z0eXqKxw@mail.gmail.com>
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
X-List-Received-Date: Mon, 24 Feb 2020 21:46:41 -0000
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Feb 2020 at 21:32, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> On Mon, 2020-02-24 at 20:16 +0000, Paul Barker wrote:
> > When a shallow mirror tarball is used to satisfy a gitsm URI it needs to
> > be unpacked so that the .gitmodules file can be examined.
> >
> > Signed-off-by: Paul Barker <pbarker@konsulko.com>
> > ---
> >  lib/bb/fetch2/gitsm.py | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
> > index aa121cbe..98f5dae5 100644
> > --- a/lib/bb/fetch2/gitsm.py
> > +++ b/lib/bb/fetch2/gitsm.py
> > @@ -169,6 +169,12 @@ class GitSM(Git):
> >                  raise
> >
> >          Git.download(self, ud, d)
> > +
> > +        # If we're using a shallow mirror tarball it needs to be unpacked so
> > +        # that we can examine the .gitmodules file
> > +        if ud.shallow and os.path.exists(ud.fullshallow) and Git.need_update(self, ud, d):
> > +            bb.utils.mkdirhier(ud.clonedir)
> > +            runfetchcmd("tar -xzf %s" % ud.fullshallow, d, workdir=ud.clonedir)
> >          self.process_submodules(ud, ud.clonedir, download_submodule, d)
> >
> >      def unpack(self, ud, destdir, d):
>
> Does this mean we're missing a test?

Possibly. Maybe a two step test with a recipe using a `gitsm://` URL:
1) Fetch the recipe with BB_GENERATE_MIRROR_TARBALLS,
BB_GENERATE_SHALLOW_TARBALLS and BB_GIT_SHALLOW set. Copy the mirror
tarballs out of the downloads directory to a local mirror directory.
Throw away DL_DIR, SSTATE_DIR and TMPDIR.
2) Using the mirror generated in step 1 try to fetch and unpack the recipe.

Does that sound like a sensible test? I think it would have to go in
oeqa rather than the bitbake tests if we do it that way.

