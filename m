Return-Path: <andrei@gherzan.ro>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
	[209.85.212.170])
	by mail.openembedded.org (Postfix) with ESMTP id 3E5636CD4B
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 Jan 2014 17:18:56 +0000 (UTC)
Received: by mail-wi0-f170.google.com with SMTP id hq4so4302550wib.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 07 Jan 2014 09:18:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:date
	:message-id:subject:from:to:cc:content-type;
	bh=hMzpstjyTWlYFGHopV0jSqnleLYroUnUUm5iQl1FZfk=;
	b=TJ84FwTB8EAPPnpATbu8g4WDTxBdC5iQoolmlh/mAsPYTYdUGayb7ogMRKP3cCTqwd
	+r3N4hvCKWjW4AohqjMCSDmakQTkc2fCmD+EecPWxGVc1ZbBtCrmZhh59nV4Sr8Lh0vi
	8Vl3Zhf0gI9IxIm5Zq4zlduiGKSAnIuYDDDxV5Y6z0IeAKKMmL9BXhkjUGXizstfDhBd
	H/8T2/vqNjsCDxbWsnbWBIxp2d6ddm7nTw4K5Ak0s1XColCowaI4HKZsJqrMHwjiohHA
	C3r0eMVAch3qrKtnfyyEdR50gMo2R+kSGVvR92MpQ9qqgp9wwk3k0pLUeeEbX75YwEy0
	V3gw==
X-Gm-Message-State: ALoCoQn+1Pw09ZNDNuOEKEkt/USFUSYI4XTz97E4dGTgmURPSZ5mdAgBmbSWQALEvzzCVsfo/sam
MIME-Version: 1.0
X-Received: by 10.180.187.72 with SMTP id fq8mr17633778wic.26.1389115136283;
	Tue, 07 Jan 2014 09:18:56 -0800 (PST)
Received: by 10.217.150.199 with HTTP; Tue, 7 Jan 2014 09:18:56 -0800 (PST)
X-Originating-IP: [5.13.221.193]
Received: by 10.217.150.199 with HTTP; Tue, 7 Jan 2014 09:18:56 -0800 (PST)
In-Reply-To: <20140107154802.GA12425@axis.com>
References: <1388886808-25624-1-git-send-email-andrei@gherzan.ro>
	<20140107103602.GP31548@axis.com> <1389102055.6899.25.camel@ted>
	<20140107144635.GA5566@axis.com> <1389106946.6899.38.camel@ted>
	<20140107154802.GA12425@axis.com>
Date: Tue, 7 Jan 2014 19:18:56 +0200
Message-ID: <CAK18fxHAMDd59Scq6ChPNsOHsqbUWw_iDhYm5nDjPO5vgdjk1g@mail.gmail.com>
From: Andrei Gherzan <andrei@gherzan.ro>
To: Olof Johansson <olof.johansson@axis.com>
Cc: openembedded <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] bitbake: bb.fetch2.git: Fix _latest_revision function while using tags
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
X-List-Received-Date: Tue, 07 Jan 2014 17:18:56 -0000
Content-Type: multipart/alternative; boundary=001a11c2679c402a6c04ef64921f

--001a11c2679c402a6c04ef64921f
Content-Type: text/plain; charset=ISO-8859-1

On Jan 7, 2014 5:52 PM, "Olof Johansson" <olof.johansson@axis.com> wrote:
>
> On 14-01-07 16:02 +0100, Richard Purdie wrote:
> > On Tue, 2014-01-07 at 15:46 +0100, Olof Johansson wrote:
> > > I agree with your reasoning with regards to not needing a
> > > fallback for Andrei's patch, but my patch tries to first resolve
> > > refs/tags/<tag> (fully qualified) and then falls back to try
> > > refs/heads/<branch>. The reason for this is that ls-remote will
> > > return things like refs/heads/lalala/<tag> if you only do
> > > ls-remote <tag>.
> >
> > Can we somehow anchor the expression instead e.g. refs/*/<xxx>^{}
>
> Sure, we can do ls-remote without any arguments and parse the
> output. But this won't make the patch easier in any way. One less
> fork though.
>
> > > My attempt was also to break out the tasks into simple,
> > > atomic(-ish) functions that would later be easier to write unit
> > > tests for. You complained on IRC that changes to the fetcher
> > > usually comes back to bite you. I believe increased unit test
> > > coverage on low level functions, as a compliment to the existing
> > > more high level suite, can be beneficial in this regard.
> >
> > I believe that my complaint could also be addressed by ensuring the high
> > level tests had more coverage of the variety of supported use cases. In
> > this case a range of tags of differing types, branches and hanging
> > commits would have helped ensure the changes to the fetcher didn't break
> > things.
>
> Yes, that probably possible. *I* find low level unit tests easier
> to work with, and I wanted to do what I could to alleviate the
> situation; making sure that (at least) our use cases are covered
> by automated tests.
>
> > I'm less keen on forcing an atom like set of functions on the fetcher
> > just for the purposes of the test suite. Sorry I was unclear on that, I
> > guess different people have different understandings of what increased
> > coverage would mean.
>
> I find it easier to work in functions with limited scopes, with
> clear purposes --- with or without unittests (unittests being
> preferable, obviously). But then again, I'm not the maintainer,
> so your preferences are more important :-).
>
> > > Also, if you are holding things off, I would really appreciate
> > > you letting us know so that we can make appropriate workarounds
> > > if needed (as in this case, where we have had to supsend testing
> > > on master :-().
> >
> > Well, it wasn't a conscious decision so much as the holidays came along
> > and I ran out of time to look at it. I'm trying to get this resolved now
> > since obviously various people are hitting the problem cases.
>
> I really appreciate the hard work you are doing :-).

Me too :-)

I agree that we really need to fix this as we are breaking layers out in
the wild with this issue.

@olof sorry for duplicate email.

ag

--001a11c2679c402a6c04ef64921f
Content-Type: text/html; charset=ISO-8859-1

<p dir="ltr"><br>
On Jan 7, 2014 5:52 PM, &quot;Olof Johansson&quot; &lt;<a href="mailto:olof.johansson@axis.com">olof.johansson@axis.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On 14-01-07 16:02 +0100, Richard Purdie wrote:<br>
&gt; &gt; On Tue, 2014-01-07 at 15:46 +0100, Olof Johansson wrote:<br>
&gt; &gt; &gt; I agree with your reasoning with regards to not needing a<br>
&gt; &gt; &gt; fallback for Andrei&#39;s patch, but my patch tries to first resolve<br>
&gt; &gt; &gt; refs/tags/&lt;tag&gt; (fully qualified) and then falls back to try<br>
&gt; &gt; &gt; refs/heads/&lt;branch&gt;. The reason for this is that ls-remote will<br>
&gt; &gt; &gt; return things like refs/heads/lalala/&lt;tag&gt; if you only do<br>
&gt; &gt; &gt; ls-remote &lt;tag&gt;.<br>
&gt; &gt;<br>
&gt; &gt; Can we somehow anchor the expression instead e.g. refs/*/&lt;xxx&gt;^{}<br>
&gt;<br>
&gt; Sure, we can do ls-remote without any arguments and parse the<br>
&gt; output. But this won&#39;t make the patch easier in any way. One less<br>
&gt; fork though.<br>
&gt;<br>
&gt; &gt; &gt; My attempt was also to break out the tasks into simple,<br>
&gt; &gt; &gt; atomic(-ish) functions that would later be easier to write unit<br>
&gt; &gt; &gt; tests for. You complained on IRC that changes to the fetcher<br>
&gt; &gt; &gt; usually comes back to bite you. I believe increased unit test<br>
&gt; &gt; &gt; coverage on low level functions, as a compliment to the existing<br>
&gt; &gt; &gt; more high level suite, can be beneficial in this regard.<br>
&gt; &gt;<br>
&gt; &gt; I believe that my complaint could also be addressed by ensuring the high<br>
&gt; &gt; level tests had more coverage of the variety of supported use cases. In<br>
&gt; &gt; this case a range of tags of differing types, branches and hanging<br>
&gt; &gt; commits would have helped ensure the changes to the fetcher didn&#39;t break<br>
&gt; &gt; things.<br>
&gt;<br>
&gt; Yes, that probably possible. *I* find low level unit tests easier<br>
&gt; to work with, and I wanted to do what I could to alleviate the<br>
&gt; situation; making sure that (at least) our use cases are covered<br>
&gt; by automated tests.<br>
&gt;<br>
&gt; &gt; I&#39;m less keen on forcing an atom like set of functions on the fetcher<br>
&gt; &gt; just for the purposes of the test suite. Sorry I was unclear on that, I<br>
&gt; &gt; guess different people have different understandings of what increased<br>
&gt; &gt; coverage would mean.<br>
&gt;<br>
&gt; I find it easier to work in functions with limited scopes, with<br>
&gt; clear purposes --- with or without unittests (unittests being<br>
&gt; preferable, obviously). But then again, I&#39;m not the maintainer,<br>
&gt; so your preferences are more important :-).<br>
&gt;<br>
&gt; &gt; &gt; Also, if you are holding things off, I would really appreciate<br>
&gt; &gt; &gt; you letting us know so that we can make appropriate workarounds<br>
&gt; &gt; &gt; if needed (as in this case, where we have had to supsend testing<br>
&gt; &gt; &gt; on master :-().<br>
&gt; &gt;<br>
&gt; &gt; Well, it wasn&#39;t a conscious decision so much as the holidays came along<br>
&gt; &gt; and I ran out of time to look at it. I&#39;m trying to get this resolved now<br>
&gt; &gt; since obviously various people are hitting the problem cases.<br>
&gt;<br>
&gt; I really appreciate the hard work you are doing :-).</p>
<p dir="ltr">Me too :-)</p>
<p dir="ltr">I agree that we really need to fix this as we are breaking layers out in the wild with this issue.</p>
<p dir="ltr">@olof sorry for duplicate email.</p>
<p dir="ltr">ag<br>
</p>

--001a11c2679c402a6c04ef64921f--
