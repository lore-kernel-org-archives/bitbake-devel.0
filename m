Return-Path: <jpewhacker@gmail.com>
Received: from mail-it0-f66.google.com (mail-it0-f66.google.com
	[209.85.214.66])
	by mail.openembedded.org (Postfix) with ESMTP id A3437752D7
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  8 Jun 2018 13:17:40 +0000 (UTC)
Received: by mail-it0-f66.google.com with SMTP id u4-v6so2302736itg.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 08 Jun 2018 06:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:message-id:subject:to:cc:date:in-reply-to:references
	:mime-version; bh=njTfodSxMDZPLxYipIC0UHggWsq6FoWXyEGGWRkXclQ=;
	b=gtbajGpHKl+wygzr5duTDAAxWwhaWa20Hhc8w4SqyidbaYknQcI5cMItgcgkO6AuQL
	iZwVwJ9UGAkYLXOo/S3FT2O4baJtbi0Uda70DCqglK6ZHzlHDo0SQmwqXTTQi877hh6i
	d8i7TymXIHWezrWwQHg/LWu0ujCT3Wa+9Y4ez+UTYAjUscNJG8K7OUdILyZS6/QcYFHL
	v2AwMI12gLyxbqcsbX2KmCtOJ8qaAlwuVyjECmoeXwv1zfMXZjmkpruoiHZdgujfm0sq
	xSTCti48TMOdhlGG/jsue/sB0+rTbti4dL2g+tTCdUtZWtYorf43ywbt8PXtZcLEP38+
	rSjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:message-id:subject:to:cc:date:in-reply-to
	:references:mime-version;
	bh=njTfodSxMDZPLxYipIC0UHggWsq6FoWXyEGGWRkXclQ=;
	b=s0lWN6SXHkR3EGsZi+EXCbEd0NCOl+hWJEo9JCZh0jP/KWCLZXIbr4jdUz09o7qjb8
	fLbBH4AlBqeJv8iRYZCFtn9uGSkXYSs+PiAFCH+gzhAV4XFWmAaAxoG7bkuDqSY50o4+
	92aiAF+oeD+lf2Nei5fgv//+y7DvVidRarvphvNaoLaAdUPF3Ce7gX5b8Wni/Qkq7iTO
	IHQM8BXDz9A12JAtXhFl1hqhMUBL8x4OpwgKzu8XM81EgOz8pN6rbiPJUt8HmyMkz6Tt
	yPxIUhlQfB4+wAsl//ZAVVnIDDQ1iRn2rOYb8sLw3L3p39LEiELzDoR9tx5tEgw6zgBa
	Clrw==
X-Gm-Message-State: APt69E17xFJBWFoCfjYeplFaLXsNFyfV8knS0wfmSEKRJUX39MI7Nr/s
	BcIztmso4itS5hQwDjEX38w=
X-Google-Smtp-Source: ADUXVKK1N0s44sLRcdkuO3jGTsW0PmckMCyHFcWaCDkF1EqlEFQ3jb883tLeIeXHP6IimrtH3Jg31g==
X-Received: by 2002:a24:7311:: with SMTP id
	y17-v6mr1758740itb.105.1528463861490; 
	Fri, 08 Jun 2018 06:17:41 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.googlemail.com with ESMTPSA id
	q203-v6sm686373itb.32.2018.06.08.06.17.40
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 08 Jun 2018 06:17:41 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
Message-ID: <687733779e6ea63ae93d800e0f04c02bbd55d4d4.camel@gmail.com>
To: Matt Hoosier <matt.hoosier@gmail.com>, richard.purdie@linuxfoundation.org
Date: Fri, 08 Jun 2018 08:17:40 -0500
In-Reply-To: <CAJgxT3_UDioHqCadrXKBqJYw1GE54mgcK5DM_RB68_kCCfTdDA@mail.gmail.com>
References: <20180525134537.27659-1-matt.hoosier@gmail.com>
	<03bb3ecd46e56bc21799d56f723bc01d966230c8.camel@linuxfoundation.org>
	<CAJgxT3_8t-OKSuAvY_NJKWoiAXfs_YuTmB9S6K-MV9QBYJhh_g@mail.gmail.com>
	<f6d6f5fa735580808180883de3eed143c10d6002.camel@linuxfoundation.org>
	<CAJgxT39m+ex8F+mjaq5+zzxps7DaPO=iUu=1PO=U3SW-NWp5_Q@mail.gmail.com>
	<CAJgxT3__308KPPC9MS+xOA9ExnUgYAx6bS82RLfG41A8vk=pBg@mail.gmail.com>
	<65e369d383320a651429a9b59a8eb71c862b1d95.camel@linuxfoundation.org>
	<CAJgxT3_UDioHqCadrXKBqJYw1GE54mgcK5DM_RB68_kCCfTdDA@mail.gmail.com>
X-Mailer: Evolution 3.28.2 (3.28.2-1.fc28) 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH v5] fetch/gitsm: avoid live submodule fetching during unpack()
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
X-List-Received-Date: Fri, 08 Jun 2018 13:17:40 -0000
Content-Type: multipart/alternative; boundary="=-mlC+w9Kd4FaorhdYxDxA"

--=-mlC+w9Kd4FaorhdYxDxA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2018-06-08 at 07:36 -0500, Matt Hoosier wrote:
> On Fri, Jun 8, 2018 at 5:20 AM Richard Purdie <richard.purdie@linuxfo
> undation.org> wrote:
> > On Thu, 2018-06-07 at 08:47 -0500, Matt Hoosier wrote:
> > 
> > > Thanks for the help getting this landed. With this change being
> > part
> > 
> > > of Bitbake, what's the procedure for attempting to get it
> > backported
> > 
> > > to the final MR of Yocto 2.2? Do I just backport it to a certain
> > 
> > > maintenance branch of Bitbake (announced somehow with a prefix on
> > the
> > 
> > > git-send-email subject) and it would magically pop up out the
> > 
> > > corresponding branch of poky if accepted to Bitbake?
> > 
> > 
> > 
> > With bitbake its a case of requesting backports to the appropriate
> > 
> > stable release branches, either in the form of a patch with [1.3X]
> > in
> > 
> > the subject, or just mention which revision to cherry-pick to which
> > 
> > branch if it cherry-picks cleanly.
> > 
> > 
> > 
> > I think to get back to 2.2, we'd have to backport to 1.38, 1.36,
> > 1.34
> > 
> > and 1.32. I do get nervous about patches which land in master and
> > then 
> > 
> > immediately get backported across so many releases. I'm less
> > nervous if
> > 
> > the patches cleanly cherry-pick as at least the code is the same.
> > How
> > 
> > cleanly does it backport?
> > 
> > 
> > 
> > Cheers,
> > 
> > 
> > 
> > Richard
> > 
> > 
> 
> It's not a completely clean back-port; some of the context lines
> don't match because of changes to the logic that detect when a
> repository uses gitsubmodules to begin with. The actual logic changes
> lift pretty-much straight in though.
> 
> I appreciate your point about being cautious when putting unproven
> code straight into a branch that gets used for maintenance releases
> though. So I could understand wanting to let it prove out on master
> for a while. Conversely, there are no recipes in Poky that use gitsm
> to begin with, so I don't know how much additional confidence would
> really be gained just through time. Is that also an argument that the
> potential impact to the stable branch of poky's own metadata is
> small?

It might be worth looking through meta-oe also, at least as a reference
point.


--=-mlC+w9Kd4FaorhdYxDxA
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 7bit

<html><head></head><body><div>On Fri, 2018-06-08 at 07:36 -0500, Matt Hoosier wrote:</div><blockquote type="cite" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex"><div dir="ltr">On Fri, Jun 8, 2018 at 5:20 AM Richard Purdie &lt;<a href="mailto:richard.purdie@linuxfoundation.org">richard.purdie@linuxfoundation.org</a>&gt; wrote:<br><div class="gmail_quote"><blockquote type="cite" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">On Thu, 2018-06-07 at 08:47 -0500, Matt Hoosier wrote:<br>
&gt; Thanks for the help getting this landed. With this change being part<br>
&gt; of Bitbake, what's the procedure for attempting to get it backported<br>
&gt; to the final MR of Yocto 2.2? Do I just backport it to a certain<br>
&gt; maintenance branch of Bitbake (announced somehow with a prefix on the<br>
&gt; git-send-email subject) and it would magically pop up out the<br>
&gt; corresponding branch of poky if accepted to Bitbake?<br>
<br>
With bitbake its a case of requesting backports to the appropriate<br>
stable release branches, either in the form of a patch with [1.3X] in<br>
the subject, or just mention which revision to cherry-pick to which<br>
branch if it cherry-picks cleanly.<br>
<br>
I think to get back to 2.2, we'd have to backport to 1.38, 1.36, 1.34<br>
and 1.32. I do get nervous about patches which land in master and then <br>
immediately get backported across so many releases. I'm less nervous if<br>
the patches cleanly cherry-pick as at least the code is the same. How<br>
cleanly does it backport?<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br></blockquote><div><br></div><div>It's not a completely clean back-port; some of the context lines don't match because of changes to the logic that detect when a repository uses gitsubmodules to begin with. The actual logic changes lift pretty-much straight in though.</div><div><br></div><div>I appreciate your point about being cautious when putting unproven code straight into a branch that gets used for maintenance releases though. So I could understand wanting to let it prove out on master for a while. Conversely, there are no recipes in Poky that use gitsm to begin with, so I don't know how much additional confidence would really be gained just through time. Is that also an argument that the potential impact to the stable branch of poky's own metadata is small?</div></div></div>
</blockquote><div><br></div><div>It might be worth looking through meta-oe also, at least as a reference point.</div><div><br></div></body></html>

--=-mlC+w9Kd4FaorhdYxDxA--
