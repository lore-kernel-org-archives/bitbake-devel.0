Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web11.28273.1617438837005507288
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 03 Apr 2021 01:33:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=O0wEiPIQ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id c8so6468762wrq.11
        for <bitbake-devel@lists.openembedded.org>; Sat, 03 Apr 2021 01:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Hjm24jp+2ARwUVh77N5ELe8VBCDR45RMg/JV3mArjjk=;
        b=O0wEiPIQX5gcNsd0C5wYqN1nmRE6FPviAfqRvOgOppEXE+uo4hD5g3EZN+kLsHvN+h
         t9JC/m9cjfd7Hc+HdaR7/oakU6Jlv3kSNuOE023D9ytzD6BHduyZaF5UX3oYP+E0TsOf
         Ow9Dq+kSapOyI1gnAbcWqN8DAQnKweR+9a8eQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Hjm24jp+2ARwUVh77N5ELe8VBCDR45RMg/JV3mArjjk=;
        b=DkCnMojczNP+kQ/xYVv3Ewn+PFG4o0ZafwWC4bN6XETixZ1DJv4aOa0ONrQy3oYzh/
         cHGQC2oVGL4PA6VFrNAaDLwMiw1g08R+IFkFTHQVjk9Hf/Vsk5WEbLufrWVfKmVry/IE
         lS43FXNrDOrId2v6kaO1ck9LXC4mewhVO6kTmbj17SHrsjLR4/Br+PzFNikhvbqqh9TJ
         NMcSMyE2KSbCua3bIXHuq+gsXKY98jlyELOVQfsxKh9eR/WR3Pz0ySIRPYUjRygtKWnL
         Cy9sssmN76A7F9r7dgIhiMkgruSdSyIPv2N4d+pa4YZRHiEkqFn4G2q8mH8+GK4/YR04
         UhfQ==
X-Gm-Message-State: AOAM531KVW066hZFBN+IRkF4+swFIw3BNybou+8MdIUYq8lplUduOsL4
	eXY2d0J9mB0dxPzgoJ1Oa3iV5g==
X-Google-Smtp-Source: ABdhPJyZgbnTvBuT1sw6b3RrrJ2DZrBIEq7F0rH99RqqC79Bx8lM5NKyJEQkqJrKvmdrhIK4M6SvhA==
X-Received: by 2002:adf:f841:: with SMTP id d1mr19004558wrq.36.1617438835378;
        Sat, 03 Apr 2021 01:33:55 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:a3bb:8f94:1e3d:b6? ([2001:8b0:aba:5f3c:a3bb:8f94:1e3d:b6])
        by smtp.gmail.com with ESMTPSA id 61sm6762261wrn.25.2021.04.03.01.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 01:33:55 -0700 (PDT)
Message-ID: <9279ee33ac07ba53ad8d1e28583ce90d83d94ff1.camel@linuxfoundation.org>
Subject: Re: [PATCH RFC 00/21] Git repository sharing for kernel (and other) repos
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Bruce Ashfield <bruce.ashfield@gmail.com>, 
	linux-yocto@lists.yoctoproject.org, bitbake-devel@lists.openembedded.org
Date: Sat, 03 Apr 2021 09:33:54 +0100
In-Reply-To: <20210403014439.GA162790@windriver.com>
References: <20210402171557.981599-1-paul.gortmaker@windriver.com>
	 <929dcfb2b10aba2ca29d0b1cba44dbc148e0643a.camel@linuxfoundation.org>
	 <20210403014439.GA162790@windriver.com>
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Fri, 2021-04-02 at 21:44 -0400, Paul Gortmaker wrote:
> [Re: [PATCH RFC 00/21] Git repository sharing for kernel (and other) repos] On 02/04/2021 (Fri 23:14) Richard Purdie wrote:
> 
> > On Fri, 2021-04-02 at 13:15 -0400, Paul Gortmaker wrote:
> > > Next Steps:
> > > -----------
> > > With this being a functional implementation, it seems like a good time to
> > > get other people looking at it.  Ideally step #1 will be getting general
> > > agreement that this is something we need, something that is overdue,
> > > and that the implementation as shown here makes sense in the absence of
> > > any similar effort from anyone that does the same but in a better way.
> > > 
> > > From there, we'll want more people not just looking at it, but testing it
> > > as well.   I know I want to write a commit (script?) that will avoid any
> > > "transition tax" by prepopulating new repos with "old" already downloaded
> > > git objects where we can.  And to add/do tests with my own popluated mirror
> > > and NO_NETWORK, and also try to ensure nothing in BB_SHALLOW gets upset,
> > > but I wasn't going to hold up starting a review of this any longer.
> > > 
> > > I suspect I can get some co-workers using/testing it too, but Yocto gets
> > > used in a bunch of different ways by different groups, so we'll no doubt
> > > have to do some additional fixups to ensure everybody gets the benefits of
> > > this sharing.  But I'm hopeful that when people see the benefits above,
> > > they'll pitch in to help take this the final mile by ensuring it works for
> > > their use case as well.
> > > 
> > > I'm not too worried about pontificating out beyond that until we get past
> > > the acceptance/testing hurdles outlined above.  So, please do have a read
> > > of the commits, kick the tires, put on your bikeshedding clothes and grab
> > > a brush, and lets see where it goes from here...
> > > 
> > > https://github.com/paulgortmaker/poky/compare/reference-RC1
> > 
> > I've only briefly looked through this but the more I look, the more worried
> > I'm getting which is never a good sign.
> 
> Well, firstly thanks for the quick response, and I hope you'll give it
> another look when you have more time, because I'm not quite convinced
> I've conveyed how it is to be used in a way that got through as intended.

> 
> > I totally agree with the use case and agree we need to do something in this 
> > area. I'm not sure the implementation looks right though, its clever but I
> > don't think its very usable to end users.
> 
> Not sure who you consider "end users".  I don't really consider myself
> or Bruce or anyone else crafting up a kernel recipe from scratch as an
> end user.

With the bitbake fetcher you are exposing an API. Anyone using that API is an
end user of that API. You and Bruce are, as is anyone writing a git:// url into
a recipe. I've drilled down into one of the changes in a separate mail to try 
and give a bit more of an idea about what I mean about usability of the API.

Yes, we can just add variables and hardcoded bits of git commandlines but we have
been here before with the old bitbake fetcher v1 code. As soon as you start bolting
in extra variables, things start to interact really badly. That change already
breaks mirroring in ways which isn't obvious even to you/Bruce.

This why I care quite a lot about how we expose the controls and we try and do it
in a way which gives you the capabilities you want/need but in a way which allows
us to change the fetcher in the future, allow people to understand what the fetcher
is doing from the configuration in the url and have decent tests.

> But even if an "end user" wants to do that, everything here is opt-in.  If you 
> want to go clone 3G of stuff from mysuperkernel.org in your new recipe, then feel 
> free.  Nothing stops them.

I'm not asking this to be made kernel only. I do want a generic API which everyone
can use. Ideally I want one which all end users and not just you+Bruce understand
too and part of that is making the user visible API simple and intuitive so everyone
can get in on the action. If that makes the fetcher a little more complex behind the
scenes, that is ok, we do ask for tests for that.

> > The warning signs to me are:
> > 
> > a) Needing new/confusing "fetch only" recipes
> 
> Not sure how they are confusing - and not really new either; I stole the
> idea of zeroing out all the tasks from kernel-devsrc if I recall...

I think you misunderstand me. I don't mean the recipes are confusing, I don't 
want them to exist at all. Consider these two ways of enabling alternates:

a) The user needs to add a new fetch-only recipe, update the SRC_URI, depend on 
the fetch only recipe, set several other variables

b) The user adds a parameter to the SRC_URI specifying the series it matches
and if not already there, adds an entry to the alternates mirror list

I would argue b) is a lot simpler to the end user and will allow more people
to join in using it.

> > b) A large number of new options and variables to the fetcher
> 
> I'd disagree with the characterization of "large" - but if you do have
> the time, please go look over the commit logs for each again.

You added two variables, GITCLONEARGS and GITFETCHREFS and four new parameters 
(dlname, static, altref, packref). The only variables currently in use in the 
fetcher are global behaviour ones, not url specific. There are currently 8 
documented parameters.

I've tried to explain why the variables worry me and why we don't see them in the
fetcher at all. A 50% increase in parameters is a large increase.

>   They all clearly indicate a necessary use case we don't handle well (or at
> all) -- and we'll have to solve them one way or another.  I'm open to
> considering alternate solutions for any of them.
> 
> > c) Needing recipes to change and people to migrate, potentially with scripts
> >    between old and new
> 
> It feels like we are looking at two different things.  The users or
> "people" don't really migrate and the only people changing things would
> be a small subset of people who maintain kernel recipes - which is a
> small group to begin with.  Recycling old git objects from existing
> downloads would most likey be done in a transparent and hands free way.
> 
> > d) Variable namespacing needs work
> 
> OK - if given specifics it can and will be addressed.
> 
> > I'm very worried this confuses up the git fetcher code and nobody will be able
> > to tell what is going on any more :/.
> 
> That kind of surprises me, to hear that after having looked at the shallow clone
> changes to the fetcher, but again - I'm listening - what can we change
> in the fetcher?  What is off limits?  The "pool" idea below doesn't address
> the fact that "--mirror" is simply not viable for some repos, and that
> is hard-coded into the fetcher.   Similar for the other fetcher changes.
> And the "pool" idea is still going to have to teach the fetcher about
> some kind of "--reference" because that *has* to be added at fetch/clone
> time and not as some later afterthought post-fetch.
> 
> I could simply take over do_fetch for the kernel and leave the fetcher
> untouched, but when the problems being solved weren't really kernel
> specific, that didn't seem like the right approach.

I think we're thinking about this from two different approaches. You're taking a 
design of what you want to happen and then pushing the fetcher around to do what 
you need. I think we need to look at how the user would configure and use this,
then work backwards to what the fetcher needs to do to support that.

There are a lot of moving parts here and it would help to simplify things down
to not try and solve every problem in one go. I'm going to focus on the alternates
issue here. This doesn't mean I don't understand the desire to be more efficient
about clones for example, I just need to start somewhere and see if we can move
forward.

The current way this is configured in your series is:

KREF = "git.kernel.org.preempt-rt.linux-5.4.y"
GITFETCHREFS_machine += " refs/heads/v5.4/*:refs/heads/v5.4/*"
GITCLONEARGS_machine = "--bare --single-branch --branch v5.4/base"

SRC_URI = "git://git.yoctoproject.org/linux-yocto.git;name=machine;branch=${KBRANCH};altref=${KREF} \
           git://git.yoctoproject.org/yocto-kernel-cache;type=kmeta;name=meta;branch=yocto-5.4;destsuffix=${KMETA}"
do_fetch[depends] += "linux-rt-5.4:do_fetch"


and what I'd much prefer is something simpler like:


SRC_URI = "git://git.yoctoproject.org/linux-yocto.git;name=machine;branch=${KBRANCH};altref=preempt-rt-linux-kernel \
           git://git.yoctoproject.org/yocto-kernel-cache;type=kmeta;name=meta;branch=yocto-5.4;destsuffix=${KMETA}"

BB_GIT_ALTREF_URLMAP[preempt-rt-linux-kernel] = "git.kernel.org.preempt-rt.linux-5.4.y"


Ignoring the lack of efficiency of the cloning bit, the usability win if we 
could do that is that anyone can start to benefit from the mirroring, just by
adding a single extra parameter to their git url.

The knowledge of the upstream clone repo can be encoded into one variable, 
centrally which everyone can use and I'd imagine we'd quickly build up a decent set
of mirror urls which everyone would build around. Its easy to extend/share.
I'd also note the variable is for central config to the fetcher, it isn't url
specific and it is namespaced as bitbake bitbake and git fetcher (which sounds
trivial but it is a huge problem in the wider code).

Now I'd defined how I'd like the user to see it, the question is can we implement 
that? I understand why you added extra 'fetch only' recipes, they are there 
basically to allow you to fetch a different url. I think it shouldn't be too 
painful to actually have the fetcher fetch that other url behind the scenes.
The gitsm fetcher (for all I dislike it) already does this.

The idea here would therefore be to teach the git fetcher that when it finds
configuration like this, it would look for and update a altref repo first
before it would then make its own clone.

Does that sound reasonable in principle at least? You'd agree that if we can, 
dropping the need for the "fetch-only" recipes would be good, ideally?

> > What I'd envisaged was git urls having something like a "mainline-linux-kernel"
> > tag added in the url as a parameter and a table somewhere which meant the checkout
> > for this would share git objects in a common pool. There would be a variable 
> > mapping that name to git.kernel.org/pub/scm/linux/kernel/git somewhere but that
> > should be all that is needed.
> 
> I saw this idea floated in the earlier thread that Randy pointed me at,
> but I just don't see it being viable or the right solution even if one
> could make it work.  How do you decide what lives in the pool?  If it is
> just mainline, then it really isn't a pool.  Are we only solving for the
> kernel, or are we making a solution for any repo that is unweildy?  What
> triggers populating the pool?  Do you stuff all mainline and -rt and all
> of stable in the pool?  Or just chunks of rt and stable?  If you aren't
> tracking what is in there via encapsulating chunks somehow, how do you
> expire stuff from the pool?  If it is one giant blob covering mainline
> and linux-yocto objects, with no fetch-on-demand properties, then we are
> back to the same old 3G-downloads-from-the-mirror problem.  How do you
> split that monster?  The devil is in the details.

Firstly, there isn't one pool, there are multiple "pools" each with some 
namespace. I was thinking they'd just track that particular upstream repo
and the name of the pool would indicate what you'd expect to find there.
Basically its like your altref parameter but I'm abstracting away their
creation/maintenance to be more magic.

The nice thing about altref "pools" is that they don't have mirroring 
constraints but lets try and come back to revision/branch/object filtering
once we get the above discussed.

> > No, this wouldn't cover 100% of artefacts but it should cover a majority of them
> > and be much simpler for users to comprehend. I haven't gone into this in detail
> > and perhaps I'm missing some problem that prevents it? :/
> 
> Well, I've thought about this a bunch, and I didn't come up with a whole
> bunch of options to choose from that deliver what this delivers.
> 
> A mainline-only kernel-specific non-pool "pool" would be better than
> nothing, but I'd still want to hear you flesh out how you thought it
> would look and operate before I went out and tried to guess what you had
> in mind.
> 
> Also, I'm still confused by this use of  "users" - what is here all
> happens transparently in the background and users aren't aware of it any
> more than they are aware of what the fetcher is currently doing today.

See if I managed to explain it better above.

> > The other issue here is there are no tests. The bitbake fetcher code is one of
> > the few pieces of the project where we do have a fairly complete test suite and
> > we don't add things there without tests (see bitbake-selftest and lib/bb/tests/).
> 
> Yes, of course; and I've been told that by several people in advance.
> But as you can imagine, I wasn't going to write tests without 1st
> floating the general concept as an RFC and seeing how that went.

You could have mentioned that you planned to add them :)

> Anyway, thanks for the initial scan and I do hope you have a chance to
> revisit it in more detail and consider the various problems it solves.

It was late and I clearly didn't convey what I'm thinking in that reply
or in the previous thread. I've tried to do so more above, I did spend 
half the night with this going around in my head and I've spent quite
some time trying to write it down this morning. See if that makes
my concerns clearer and whether what I'm thinking could be made to work.

Cheers,

Richard

