Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
 by mx.groups.io with SMTP id smtpd.web12.11176.1603107478485118608
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 19 Oct 2020 04:37:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ZmNIKZfH;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.65, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f65.google.com with SMTP id 13so9966827wmf.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 19 Oct 2020 04:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=q7tI01hTxnZntZpayt3FC+nN44Hz65MzuyM5LxQQOmU=;
        b=ZmNIKZfHaBD8rqfu/2qAJmA5m4fONZSTL1EZGIISAzh6d6zvbsMxi+56LcToGWNiUi
         +4YTJbjU3sNqgDZiPQupPrx+3X5mkK8hP0oXFC94JxCekLzXksW1Ay98DWslTQglm07B
         3NpzwRHqK36pS3v0DZAJH0a8O1Qjlj0+ha8xQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=q7tI01hTxnZntZpayt3FC+nN44Hz65MzuyM5LxQQOmU=;
        b=svh+jQ+6LRBJDYkggAcsdz/nljPVop7uNxXqQ1S8LplLN6wQw9LcHipgWTqElYT2W1
         unGQ81sYp3mp2SMZA8JDTvLWrdHZuj4fCfmcF6UHYUwhn86lANFlAAbyUZSuusGmlkFw
         rM9OzmLmMKNtRfz2YGhv6WgUGJ3HyZF+AZ8wDgWw5jpxb7gSG3TRzxKRdsCLO/heqKUp
         PN8OGOennfosWmnd74NiItPoSkmLn9gJP5gnMur0HpdUiixdr7n3F8YlecKhznwepLXm
         ctOapQE9375wahEv8SQdy1B42f9GX9maiB/6E3eRMNaf+e/F5HmEsqGrFM+hLwTa6Oxj
         G9+w==
X-Gm-Message-State: AOAM533MHIDcNlAjCi0rJYNrwilW9w9EcwBijWO0cip27UHLdFjzX8wp
	9VmRXNybW1Kl+4h1FemqaR/yYA==
X-Google-Smtp-Source: ABdhPJwAggIsREFZ2KRZ1udPOuuijbykpLumdFexA7QW7xez04SdhD1Sho2rpPA4Tr5Kcp2whEIOcw==
X-Received: by 2002:a05:600c:228a:: with SMTP id 10mr17238555wmf.123.1603107476876;
        Mon, 19 Oct 2020 04:37:56 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from e.c.4.c.b.d.d.d.d.1.e.7.a.1.c.1.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (e.c.4.c.b.d.d.d.d.1.e.7.a.1.c.1.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:1c1a:7e1d:dddb:c4ce])
        by smtp.gmail.com with ESMTPSA id 10sm15743719wmn.9.2020.10.19.04.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 04:37:56 -0700 (PDT)
Message-ID: <0b4b27c9446be03e2bc6f9df61345b34bafc8721.camel@linuxfoundation.org>
Subject: Re: [PATCH] fetch: git: add reference parameter
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
	bitbake-devel@lists.openembedded.org
Date: Mon, 19 Oct 2020 12:37:55 +0100
In-Reply-To: <194b0b91-dad8-e355-b290-e27141995d6b@prevas.dk>
References: <20201018213352.32692-1-rasmus.villemoes@prevas.dk>
	 <5654d90cef29064a898f279d73c6deb6f6f91052.camel@linuxfoundation.org>
	 <419c5a91-a38b-5b87-31c9-b1dc72adf1be@prevas.dk>
	 <5db6530fb6bf4bb39c9e5bbe4b44e57fb30c02e9.camel@linuxfoundation.org>
	 <194b0b91-dad8-e355-b290-e27141995d6b@prevas.dk>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2020-10-19 at 13:25 +0200, Rasmus Villemoes wrote:
> On 19/10/2020 12.43, Richard Purdie wrote:
> > On Mon, 2020-10-19 at 12:25 +0200, Rasmus Villemoes wrote:
> > > On 19/10/2020 11.09, Richard Purdie wrote:
> > > > On Sun, 2020-10-18 at 23:33 +0200, Rasmus Villemoes wrote:
> > > > > The --reference(-if-able) option to git clone can
> > > > > significantly
> > > > > speed
> > > > > up the initial do_fetch if one is able to point git at a
> > > > > local
> > > > > repository containing a large number of the objects that
> > > > > would
> > > > > otherwise need to be downloaded.
> > > > > 
> > > > > Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> > > > > ---
> > > > >  lib/bb/fetch2/git.py | 11 +++++++++++
> > > > >  1 file changed, 11 insertions(+)
> > > > 
> > > > Whilst I can see why this is useful, it is going to end up
> > > > causing
> > > > problems when you share that recipe using this term with others
> > > > :(.
> > > > I
> > > > don't think we should add API which will cause scaling issues
> > > > end
> > > > "encourage" behaviour which leads to problems.
> > > > 
> > > > Clone by reference also causes problems for the archiver.
> > > 
> > > How? Note that I unconditionally add the --dissociate, so that
> > > after
> > > the download, there's absolutely no link between the referenced
> > > and
> > > the cloned repository. Also, I use the -if-able variant which
> > > will
> > > just silently ignore the given repo if it cannot be used (often,
> > > because it doesn't exist). So I don't think the presence of
> > > absence
> > > of ;reference= can ever affect the correctness or end result. But
> > > see
> > > below;
> > 
> > Ok, I'd missed that dissociate was available. I think that is new
> > since
> > the last time I looked at this (its been a while) and that helps
> > simplify things.
> 
> Well, yes, I glossed over the git version requirements. --dissociate
> is from v2.3 (Feb 2015, fb1d6dab), while the -if-able variant
> requires 2.11
> (Nov 2016, f7415b4d711). It would probably be nice if this was all
> just
> silently ignored when git is too old. Do we have some way to get the
> git
> version? I suppose a simple "git --version" subprocess isn't really
> that
> costly given that we're about to spawn a "git clone" anyway. And we'd
> only have to do it in the case where a reference is actually given.
> But
> then, since the developer must have opted in by providing some path
> (through whichever means we can agree on), perhaps the documentation
> should just mention that requirement.

sanity.bbclass documents the current minimum git version as 1.8.3.1.

We could make the check conditional upon whether
BBFETCH_GIT_REFERENCEDIR is set (see below).

> Competely agreed, and I oversimplified. I'd expect the
> LINUX_SRC_URI_REF
> to have a vardepvalue of "". But yeah, it's easy to forget to add
> that.

I think we can do something simpler.

>  My counter-proposal of an
> > identifier in SRC_URI like ";reference=linux-kernel" won't cause a
> > problem with checksums.
> 
> Perhaps, but where would you get the information on what linux-kernel
> should result in? I guess one could have the user set
> 
> SRC_URI_GIT_REFERENCE[linux-kernel] = "/some/path"
> 
> and then in urldata_init() do d.getVarFlag() to get the path. With
> SRC_URI_GIT_REFERENCE having whatever appropriate magic necessary to
> avoid its flags affecting checksums.
> 
> But, do we even need that indirection through a keyword? What if
> bitbake.conf (or whatever more appropriate place there might be) grew
> a
> 
> SRC_URI_GIT_REFERENCE ?= ""
> SRC_URI_GIT_REFERENCE[vardepvalue] = ""
> 
> Recipes where one wants to support this could then just be written
> 
>   SRC_URI +=
> "git://:some.where/foo/bar;protocol=https;reference=${SRC_URI_GIT_REF
> ERENCE}"
> 
> [an empty reference= parameter is equivalent to none at all],
> and the way for a developer to opt-in and specify a reference would
> be
> the usual pn overrides
> 
> SRC_URI_GIT_REFERENCE_pn-the-kernel-recipe = "/my/local/path"
> 
> ?
> 
> > As I said, I totally understand the need/usage. I just don't think
> > the
> > implementation can be merged as is for various reasons, we need
> > something more generic. I've tried to give some hints on a better
> > "interface" which would allow something to be merged.
> 
> I can certainly try doing it with the keyword approach, but could you
> put a few more words on what you were thinking? I.e., am I right
> about
> how you thought the path should be stored and retrieved?
> 
> I'll have to respin for the git version issue anyway I think, so what
> do you prefer?

How about we just have the user set:

BBFETCH_GIT_REFERENCEDIR = "${DL_DIR}/git-reference-mirrors/"

and then unconditionally mark up recipes with:

;reference=linux-kernel

then the fetcher code looks in ${BBFETCH_GIT_REFERENCEDIR}/<reference>
for reference clones if and only if BBFETCH_GIT_REFERENCEDIR is set?

This avoids all the messing with vardeps, keeps the SRC_URIs simple and
should generally be much more usable/scalable?

If BBFETCH_GIT_REFERENCEDIR is set, we'd also probably want to make
successful clones push references into that directory to cache them?

In general you'd set this globally but if you do really need do
something specific to a recipe, a recipe specific override would also
happen to work.

Cheers,

Richard


