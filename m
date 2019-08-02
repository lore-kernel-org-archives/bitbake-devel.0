Return-Path: <wbourque@gmail.com>
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com
	[209.85.210.52])
	by mail.openembedded.org (Postfix) with ESMTP id 1820A7C86A;
	Fri,  2 Aug 2019 13:58:56 +0000 (UTC)
Received: by mail-ot1-f52.google.com with SMTP id j19so1566388otq.2;
	Fri, 02 Aug 2019 06:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=C8ymqktiWFiY1nXg+G4/AL0jjyNHhgONLI4oBxn6yrI=;
	b=ZWUJIqz9YolGMwddHAyVeZwS+EjNjoSpdqKaYZRdRsFzYpiesERTqt0mimEo2a+VaR
	nAfHcXVspikg+TA/0GkcpohA/5yOHZ9Bu4amk6ONcg64NqgtfBqG4yaMb+IlH0VC3X+S
	95GvT9X6TNLpyl/cr3WuCrjQVMnxtckYckdK4e4AmjHJV/3mabKCwfleOD8akcqoHXtf
	6G47APcXX1p7w2sJV38GcwYCf5A5NViJ5cG3NMQvjbvgMTM6DiI0HYxABqoeHTIyYO/u
	b6nwATYG3WHkBXOWEA9NUuPL+xM3oUG/sBnfgCrxa0paCteeyWjDwbbKOvnoPeWURoxH
	XuWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=C8ymqktiWFiY1nXg+G4/AL0jjyNHhgONLI4oBxn6yrI=;
	b=TRzwME56Tzc+vMo6e+sfWVLyc7nNjBYJcDNLtmIfq0A7f9vezLRXIIGN3Hc+Eti1hn
	KZEj/dz9UccPTpdNwbJDdzVbke6N9ZVR9KCkNmbkqg1TNLafc1lILrwrsLsQrRWagJ1r
	QAl5Lpv3XckUgK9ODSEohgm2VSFS8d524FJBtcH4xmPK/Hpr9F0py2C0/D9Efd/eSY6P
	71I+oG966/PDMcns8zDLT1ZwRlTKar5u3p8t8vLviLxolni+20ZQ3CNe4YaVjEvINqXx
	LROgEIO4qutA9mazBDZ9HfWA4AOr8iHsYTh3uT1ls2F1XCQpiADMwotlxd+6MsnGC9ht
	NHWA==
X-Gm-Message-State: APjAAAWe2T9LPpR4I/qm8shuqI+yGeTwS6/cvS39aNAiB/R5OZbkwzuo
	z0fP8MKUKgmp2HWqEnLExPBW+rga60zmQPQKM7v76w==
X-Google-Smtp-Source: APXvYqwJ+2Z29MLEEPH7P03RcFUPOXYm98SepxeVOOPHTBesPJXiH3GRUzJzCqdd/e+bOhkrlls4HpDqji/bbIMDe5k=
X-Received: by 2002:a9d:3e4e:: with SMTP id h14mr98505404otg.182.1564754337999;
	Fri, 02 Aug 2019 06:58:57 -0700 (PDT)
MIME-Version: 1.0
References: <CY4PR12MB1653C06268B3B4B862119BE18BDE0@CY4PR12MB1653.namprd12.prod.outlook.com>
	<20190802073741.GI3459@hiutale>
In-Reply-To: <20190802073741.GI3459@hiutale>
From: William Bourque <wbourque@gmail.com>
Date: Fri, 2 Aug 2019 09:58:46 -0400
Message-ID: <CANBSh+OGvD1wqrXGRfufYf2KpKJPM44fUcoeangTBVMSJBKxRg@mail.gmail.com>
To: Mikko.Rapeli@bmw.de
X-Mailman-Approved-At: Sat, 03 Aug 2019 09:15:17 +0000
Cc: bitbake-devel@lists.openembedded.org,
	Openembedded-core@lists.openembedded.org
Subject: Re: [OE-core] RFC: exposing information about the SRC_URI(s)/branch via buildhistory (or similar mechanism)
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
X-List-Received-Date: Fri, 02 Aug 2019 13:58:57 -0000
Content-Type: text/plain; charset="UTF-8"

I'd be curious to see the patches.
It's definitely something we could use here; we used to have nightly
build checking the build using AUTOREV as well.

On Fri, Aug 2, 2019 at 3:43 AM <Mikko.Rapeli@bmw.de> wrote:
>
> Hi,
>
> On Thu, Aug 01, 2019 at 04:51:38PM +0000, chris.laplante--- via Openembedded-core wrote:
> <snip>
> > I'm interesting in adding SRC_URI support to buildhistory (or a similar mechanism), and would like to get some input.
>
> Yes to this.
>
> Also would be nice if there was an easy way to add bitbake variables to
> buildhistory.
>
> I've patched our tree so that SRC_URI, LICENSE and CVE_PRODUCT are archived
> in buildhistory. SRC_URI has many uses and changes and patches can
> be easily identified. Same with LICENSE, any changes trigger a review.
> CVE_PRODUCT is exported so that we can do QA check to make sure mapping
> from CVE_PRODUCT for non CLOSED licenses exists to NVD database product
> names (maintaining a white list of recipes which don't have any CVEs yet).
>
> We've also changed the SDK name to be stable across builds and added
> DISTRO to the path. In our case IMAGE_NAME and SDK_NAME will include
> git tree tag and hash if tree is dirty, which changes buildhistory SDK paths
> for every build with different input.
>
> I could submit the patches if there is interest in them.
>
> Cheers,
>
> -Mikko
> --
> _______________________________________________
> Openembedded-core mailing list
> Openembedded-core@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/openembedded-core

