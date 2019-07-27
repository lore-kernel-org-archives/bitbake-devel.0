Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
	[209.85.221.54])
	by mail.openembedded.org (Postfix) with ESMTP id 8DB9D6007A
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 27 Jul 2019 10:26:39 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id x1so6947892wrr.9
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 27 Jul 2019 03:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:user-agent:mime-version:content-transfer-encoding;
	bh=5L+a5IfH3orf4L8q33uG3gLeRjqHfgG7TCAQMbumOSU=;
	b=JKx/EIInEKNYXc+uqSLlB8ID9ifpuI3fUnyLLFT76bjN1kcDiQPmw6VSHIzfRs4K9S
	cnKW3PkSoiAPiRmFI1m4KlO9GXqDq1luRyL6QuQxYqxiXp/1ljDwmbkkT3B7UbNfmFHX
	yxGsh6Znwpa0eSFXshPPrEURb7reTSMbu5vrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=5L+a5IfH3orf4L8q33uG3gLeRjqHfgG7TCAQMbumOSU=;
	b=enOi9+7suOXEe4T/8336K56mCzieeDeER7EsfQbjFBwnLZKjGzC0+CVi0Bi+zh1+jt
	OHhj6Aw/SSUTYnNoyuM4kUiJf6bb/cI8R4lUijT4pGW8qDDsW510TyE/NFoM3ALf9WXi
	Bw3+bR1VYVdi8oWz/5z1WxiGsiNJ8wavXaJGw3fAq38/G2DOWtklzxW+ETAlBG6qKWps
	7ser20wGVpsGGagZNexA2ZVOGHymhklvBO6h2+V2D4vAmI9Dxtiv/IzcLuseXunazqwN
	992eKdNhBshn2nU8mlkJreAqSATV6d7I3VNkhlSiWMyi1NTOehcq9T+JfmMTSCGIy3YV
	eiHg==
X-Gm-Message-State: APjAAAWl2fL1n59W+usnKyJttmm1iupVgUgRjsOeztiGS2Xm/yJZbIc3
	KFTjFrUJAxqo0B3adHUj5vLIeA==
X-Google-Smtp-Source: APXvYqyyydRP5u4s4nrFtiSHwfX27YHplTdaaAM9mMK9qV0Cyt7iavE7WzyIm/Dc5rGsgD1wimt8jA==
X-Received: by 2002:a5d:630c:: with SMTP id i12mr19654432wru.312.1564223200249;
	Sat, 27 Jul 2019 03:26:40 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	v23sm48178129wmj.32.2019.07.27.03.26.39
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Sat, 27 Jul 2019 03:26:39 -0700 (PDT)
Message-ID: <67699ebfc6de01ea166ea537a64ff658c9f3b14b.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "chris.laplante@agilent.com" <chris.laplante@agilent.com>, Alexander
	Kanavin <alex.kanavin@gmail.com>
Date: Sat, 27 Jul 2019 11:26:38 +0100
In-Reply-To: <CY4PR12MB1653B3168D82F8A1E6AC390C8BC00@CY4PR12MB1653.namprd12.prod.outlook.com>
References: <1564149248-7626-1-git-send-email-chris.laplante@agilent.com>
	<CANNYZj_ykVaOvq4EKtJ=7qpTNt5HcdpYqE+z4dRpqNQH-6ykYA@mail.gmail.com>
	<CY4PR12MB1653B3168D82F8A1E6AC390C8BC00@CY4PR12MB1653.namprd12.prod.outlook.com>
User-Agent: Evolution 3.32.2-1 
MIME-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] fetch2: add ability to skip recipes when get_srcrev fails via BB_FETCH_SKIP_ON_SRCREV_ERROR
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
X-List-Received-Date: Sat, 27 Jul 2019 10:26:39 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Fri, 2019-07-26 at 15:46 +0000, chris.laplante--- via bitbake-devel
wrote:
> > -----Original Message-----
> > From: Alexander Kanavin <alex.kanavin@gmail.com>
> > Sent: Friday, July 26, 2019 11:06 AM
> > To: LAPLANTE,CHRIS (Agilent USA) <chris.laplante@agilent.com>
> > Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
> > Subject: Re: [bitbake-devel] [PATCH] fetch2: add ability to skip
> > recipes when get_srcrev fails via BB_FETCH_SKIP_ON_SRCREV_ERROR
> > 
> > I think it's better to rearrange the layer itself, and split it
> > into a privileged and a non-privileged one.
> > 
> 
> Yes, that's the "cleanest" solution, but it doesn’t necessarily scale
> well when you add more and more disjoint sets of users that can/can't
> access particular recipes. 
> 
> Also, just to add some more context to how we are using this: for
> each of our "skippable" recipes, we have alternative providers that
> pull pre-compiled artifacts from "pool" repositories. It is nice to
> keep the providers' recipes in one place.
> 
> > This patch seems to enable skipping the recipe, regardless of what
> > the actual issue with fetching was (which may or may not be 'access
> > denied'). Skipping on any error doesn't seem right to me as it may
> > mask other types of problems.
> 
> I see your point (in general), but note that this only skips the
> recipe if an error occurs in get_srcrev during the parsing stage (and
> we are not executing in a task). The original exception will still be
> displayed to the user. 
> 
> But it certainly would be better to be more selective with which kind
> of errors get swallowed. I will try to look into that.

I have some quite strong feelings on when recipes should or shouldn't
be skipped.

Skipped recipes are problematic in that they "disappear" from the user
view and it can be hard to understand why. I've therefore always wanted
a strongly deterministic and obvious approach to when it happens and
when it doesn't.

Alex just commented on another thread where he didn't like recipe
dependencies needing to be marked as skipped individually rather than
some automatic magic. That was deliberate as it would be far too easy
for bitbake to mark nearly everything as skipped should something
simple go wrong. I've seen that happen and I could barely unravel it
despite knowing what was happening.

This SRCREV change feels similar, I can just imagine the bug reports
for user A able to build just fine, user B can't even see the recipe
and its all down to say their git config in their homedir.

You can likely do something similar to this by checking access earlier
in the recipe with an immediate expansion calling your custom function
which traps FetchError and have a similar effect to what you want. I
think this is a sufficiently niche and also specialised use case that
we don't want to encourage it or "pollute" the core with code for it.

Cheers,

Richard





