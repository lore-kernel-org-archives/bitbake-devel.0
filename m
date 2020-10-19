Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
 by mx.groups.io with SMTP id smtpd.web12.10598.1603104214548946401
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 19 Oct 2020 03:43:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=If+sPi93;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.67, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f67.google.com with SMTP id d3so12282168wma.4
        for <bitbake-devel@lists.openembedded.org>; Mon, 19 Oct 2020 03:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=rHHVYllXWcefi3tdfooAPSMJA8KjuDU9ZJGyST50U8c=;
        b=If+sPi93CCkWzbl6GMe2DQt54jo08EB5Ofw5VIAOgUxeRLPchenDLyYIOmtKba82/N
         Lq8amwjVUnW6oPd5qvZHGvoMdO3GNMcVwJG26ayljP8TuscMy7HK3QexCNm8DkP/8VPK
         YiZGWL2s1RQzGMG9XtMY0CwUXbZOcbzm8J1fI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=rHHVYllXWcefi3tdfooAPSMJA8KjuDU9ZJGyST50U8c=;
        b=EWvqbVKINxADR+veJqNbr55pFvsConmgO8veU0B8CcDe8U4JNCA1Yus7ydsDZxHlij
         2+t59sLOyrlX6qzoVb3O7kiDpqaeMt8uxvp0ZdHBRa9414EV1FnWeXmZEbtkvEUJA/IH
         Q7YUDRicHj6e/TwMN2Uptl/y0NtircofC5HpxnZVWvG5qmOcJc/BVH4hO33wl3x58Fvo
         mV6qugHqCWNlPXsSEKyEq/aWXJispJGmuWj8w5hazlShoyrGaZXLJH2gPuLkMnTNDYNO
         RwqDuTi5jDVx/0y+SKuOa8A46K2rKOnyA6uABpN6h2eStPphECvdQ+mr7YUo//V4sWaK
         tOlg==
X-Gm-Message-State: AOAM531CSxbDMUeyUoFbmP69+IWfvlAeUQAyrIalTIK/evGyb8iq5ZCD
	mr2vq2f0uF1hd14XJJUCMImlcA==
X-Google-Smtp-Source: ABdhPJxZSbCi48/UhuJ3zS0pn4VQRQa3fPab91EbnZFfOuRs5sSk5FgsN61oNztMX8rWGdmRl9IHWw==
X-Received: by 2002:a1c:e283:: with SMTP id z125mr17889198wmg.154.1603104212834;
        Mon, 19 Oct 2020 03:43:32 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from e.c.4.c.b.d.d.d.d.1.e.7.a.1.c.1.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (e.c.4.c.b.d.d.d.d.1.e.7.a.1.c.1.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:1c1a:7e1d:dddb:c4ce])
        by smtp.gmail.com with ESMTPSA id l3sm17540195wmg.32.2020.10.19.03.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 03:43:32 -0700 (PDT)
Message-ID: <5db6530fb6bf4bb39c9e5bbe4b44e57fb30c02e9.camel@linuxfoundation.org>
Subject: Re: [PATCH] fetch: git: add reference parameter
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
	bitbake-devel@lists.openembedded.org
Date: Mon, 19 Oct 2020 11:43:30 +0100
In-Reply-To: <419c5a91-a38b-5b87-31c9-b1dc72adf1be@prevas.dk>
References: <20201018213352.32692-1-rasmus.villemoes@prevas.dk>
	 <5654d90cef29064a898f279d73c6deb6f6f91052.camel@linuxfoundation.org>
	 <419c5a91-a38b-5b87-31c9-b1dc72adf1be@prevas.dk>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2020-10-19 at 12:25 +0200, Rasmus Villemoes wrote:
> On 19/10/2020 11.09, Richard Purdie wrote:
> > On Sun, 2020-10-18 at 23:33 +0200, Rasmus Villemoes wrote:
> > > The --reference(-if-able) option to git clone can significantly
> > > speed
> > > up the initial do_fetch if one is able to point git at a local
> > > repository containing a large number of the objects that would
> > > otherwise need to be downloaded.
> > > 
> > > Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> > > ---
> > >  lib/bb/fetch2/git.py | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > 
> > Whilst I can see why this is useful, it is going to end up causing
> > problems when you share that recipe using this term with others :(.
> > I
> > don't think we should add API which will cause scaling issues end
> > "encourage" behaviour which leads to problems.
> > 
> > Clone by reference also causes problems for the archiver.
> 
> How? Note that I unconditionally add the --dissociate, so that after
> the download, there's absolutely no link between the referenced and
> the cloned repository. Also, I use the -if-able variant which will
> just silently ignore the given repo if it cannot be used (often,
> because it doesn't exist). So I don't think the presence of absence
> of ;reference= can ever affect the correctness or end result. But see
> below;

Ok, I'd missed that dissociate was available. I think that is new since
the last time I looked at this (its been a while) and that helps
simplify things.

>  I don't think any recipes should/would ever grow a ;reference=
> directly, as it's really a local opt-in optimization, so the recipe
> should just be written to allow that easily.

You know how this works, why and what it means. Most people won't so it
will get added to public recipes and it will cause problems. I've been
a maintainer long enough to know how this kind of works out
unfortunately.

I realised there is also a bigger problem. You're changing SRC_URI to
be specific to local paths. This will affect the sstate checksums and
break sstate reuse. We don't want to do that. My counter-proposal of an
identifier in SRC_URI like ";reference=linux-kernel" won't cause a
problem with checksums.

> > I have often wondered about this issue though, my own thoughts were
> > some kind of "keyword" system where if present, a base repository
> > could
> > be cloned, then added to from the original upstream. At the end of
> > cloning, revisions could be pushed back into that making it a kind
> > of
> > mirror.
> > 
> > So yes, I see the attraction/need but I think to have something
> > merged,
> > it would need to be more usable in the general case.
> 
> By far, the biggest pain point and what we're mostly going to use
> this for is cloning linux repositories - those are usually at least
> 2G in size, and every project/board uses such a thing. So my example
> is based on that. In our linux recipe, we have (simplified)
> 
> LINUX_SRC_URI ?= "git://our.server/generic/linux.git;protocol=ssh"
> SRC_URI = "${LINUX_SRC_URI}"
> SRC_URI += [various .cfg files etc.]
> 
> i.e., we have made sure that the main component of SRC_URI is its own
> variable, which can thus easily be overridden from machine config or
> elsewhere - when doing development, it's nice to able to just put
> 
> LINUX_SRC_URI = "git:///some/local/path;protocol=file"
> 
> in local.conf (the branch and SRCREV are similarly defined via such
> LINUX_* variables). So I was thinking that a LINUX_SRC_URI_append =
> ";reference=..." would do the trick. Alternatively, I'd rewrite the
> recipe to read
> 
> SRC_URI = "${LINUX_SRC_URI}${LINUX_SRC_URI_REF}"
> 
> with LINUX_SRC_URI_REF of course being ?= "". Then any developer can
> just set LINUX_SRC_URI_REF = ";reference=/my/local/linux-tree", and
> our CI setup (which, when asked to do clean build, runs with an empty
> initial downloads dir) could similarly be taught to set that
> variable.
> 
> Sure, this is all just for one recipe/repo, but (a) the user would
> necessarily need to provide such a reference for each recipe making
> use of this and (b) there are not really that many projects whose
> repo sizes warrant this, so it's quite manageable to tweak the few
> recipes.
> 
> I'll also note that this has been a bigger pain for the past few
> months when I've been working from home, connected to our
> infrastructure over a slow vpn connection. Nothing indicates that
> things are returning to normal any time soon, so I'd really like to
> find some way to reduce the necessary network traffic.

As I said, I totally understand the need/usage. I just don't think the
implementation can be merged as is for various reasons, we need
something more generic. I've tried to give some hints on a better
"interface" which would allow something to be merged.

Cheers,

Richard

