Return-Path: <scott.murray@konsulko.com>
Received: from mail-it1-f193.google.com (mail-it1-f193.google.com
	[209.85.166.193])
	by mail.openembedded.org (Postfix) with ESMTP id D23366C13D
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Mar 2019 15:28:05 +0000 (UTC)
Received: by mail-it1-f193.google.com with SMTP id k193so5562041ita.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Mar 2019 08:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=konsulko.com; s=google;
	h=date:from:to:cc:subject:in-reply-to:message-id:references
	:user-agent:mime-version;
	bh=3HdOdMeCxFBg2GgGFo4On4Y5plpZSNnyi8SN1lF3XFM=;
	b=gX8BcqYQg/kO5Tt02DmNfDVoV3cfTPPhVpW/Kdzj0J1G5ApyGDnQMX/GdLRNW4Eq1K
	d/dZqoIOyCxfPb+tVvvl9JxbO1J/e8i0fncp9BLdHWJXal/3ibJ4xiYxztAcVyZABwSJ
	AQqnbY9FqJt5bOf8BmDL50wjfq+3KEhPZvHW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
	:references:user-agent:mime-version;
	bh=3HdOdMeCxFBg2GgGFo4On4Y5plpZSNnyi8SN1lF3XFM=;
	b=IJF3GWTQUEqFCcRAkbaLDmwliKDXzGqhpM6viBmSIW/D0lwuE4gL/7/hx48V2BFRcp
	A4/a6EtE1RgvaCM4cinjNaY014DEgLWT3LaZkdmEG0XP5kW12BH0/+L6d2UADLXbi0+5
	XjckOwHinjmk6z4NA2iGMqEu9hBnfjppau4dSExS1WKlF8FHnovQXWsvAk5ryppl4hAY
	t07X3cDkJvZ7w2/35w9D5ADe++NAYrV5nZSucOymt4cKA6dt3hTs/qkAcPBVZs8LuS0x
	qvbFqQPnY1+HwBWpLTqKi23yPnZ6xHy7iwXhsZL3ikAifDCBWWQZnmWY7JlOvPcgcuM3
	LLwQ==
X-Gm-Message-State: APjAAAW0gnGH+EUQFKml46fyec3mw3FAUG0WIIgGqcLYs5L8OxGGKSls
	qVXK5Q1gy9bYJNKdFc99LBH/7w==
X-Google-Smtp-Source: APXvYqxLC7tvSY0RdBhwTwzWUVobULsie0oIKEoRWKgMtXoRdIxiTJ3Io+GMmOjFzY62VnKyMlQrNA==
X-Received: by 2002:a24:b24f:: with SMTP id h15mr2222764iti.126.1552577286546; 
	Thu, 14 Mar 2019 08:28:06 -0700 (PDT)
Received: from godzilla (69-165-244-87.cable.teksavvy.com. [69.165.244.87])
	by smtp.gmail.com with ESMTPSA id e5sm1387381ite.28.2019.03.14.08.28.05
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 14 Mar 2019 08:28:05 -0700 (PDT)
Date: Thu, 14 Mar 2019 11:27:51 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
X-X-Sender: scottm@godzilla.spiteful.org
To: akuster808 <akuster808@gmail.com>
In-Reply-To: <8edf457e-e537-9f9d-435a-e8acdcf2c3eb@gmail.com>
Message-ID: <alpine.LFD.2.21.1903141125230.20874@godzilla.spiteful.org>
References: <20190312224627.12667-1-scott.murray@konsulko.com>
	<8edf457e-e537-9f9d-435a-e8acdcf2c3eb@gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [1.40][PATCH 0/10] Backport gitsm fetcher fixes
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
X-List-Received-Date: Thu, 14 Mar 2019 15:28:06 -0000
Content-Type: text/plain; charset=US-ASCII

On Wed, 13 Mar 2019, akuster808 wrote:

>
>
> On 3/12/19 3:46 PM, Scott Murray wrote:
> > Backport Mark's git submodule fetcher fixes and a related testcase
> > change to the 1.40 branch so they can make their way into thud.  All
> > changes cherry-picked cleanly, and bitbake-selftest passes successfully.
> > Additional testing has been done with the Automotive Grade Linux (AGL)
> > build, which requires these fixes to build against poky thud.
>
> Seeing errors on the AB for fedora, ubuntu, centos and debian hosts.
>
> https://errors.yoctoproject.org/Errors/Details/232884/
>
> Have not triaged it yet.

Looks like git.infradead.org was down?:

fatal: unable to connect to git.infradead.org:
git.infradead.org[0: 2607:7c80:54:e::133]: errno=Connection refused
git.infradead.org[1: 198.137.202.133]: errno=Connection refused

I can clone mtd-utils here without issue ATM, so perhaps something
intermittent.

Scott

