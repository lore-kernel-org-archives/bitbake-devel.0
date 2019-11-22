Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
	[209.85.128.68])
	by mail.openembedded.org (Postfix) with ESMTP id 3127D6BD08
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Nov 2019 09:03:59 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id b11so6560943wmb.5
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Nov 2019 01:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:user-agent:mime-version:content-transfer-encoding;
	bh=adGEQoH4E/jo0hV247V0zLTi90rSr/MRvyrL8uunZFc=;
	b=VEZnoBlW2fTJgs9sbkwY97B8leRLAAwuQlGyFjMNERUyCoL9L7+cdkbWIhT7LOjQzp
	OEmrRa8nnLi/o9VPDGy3TKBwEcSI8i/VH3AwVbB84N0STn2DsBeiOI4BbEmHiJYPPm+L
	nv4DjLI5jTHZEl2uIPd4dmG5wmfnXcAQtlPP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=adGEQoH4E/jo0hV247V0zLTi90rSr/MRvyrL8uunZFc=;
	b=jszKfuWbyMPfszKrztFiCI+oI1WfQJOyRHNqkXc+Sp8hHLiYWhTAVmwCMMiQqcGbXo
	Ddv+PgYvPk7ldP0wWitjf195gq/h+v/NtjH333+yxDeXEjG95CMyD6aZ/qFTzCwjTilp
	u8gF8AIaxj4BrGczB1fsWIlQ8uy2PxZYl5CJlszn7Tar/7Xd9lPciyRtlVSsN/RLQyiD
	nxfCZn5XObwPlICsDgt+V0VdlQQvBthSG72Gv0MHgJyFiiEzvQwlH0bIzjPF0SQkTtln
	XNzrm97V5u7j5N4zmGpPwovti599QkeroROVf7qYx4pHwrEAcZoG9SO9Ld8xn+wZ6Aod
	ULXQ==
X-Gm-Message-State: APjAAAXybC/S85jTkXKLmmUsYmkspo4Fd4EIUjCYjOZIiN7g9xBF5EA2
	yB60vpIh8Vqk4GyTosOjfFqbiQ==
X-Google-Smtp-Source: APXvYqydnUAmwZcUYvnZIPi2uBzO1SWyd3ut1TSUbeVjcPNK6CbVtHvh4BcLTO04I+ewrd354wgvKg==
X-Received: by 2002:a1c:ca:: with SMTP id 193mr15160323wma.103.1574413439952; 
	Fri, 22 Nov 2019 01:03:59 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id z8sm6817446wrp.49.2019.11.22.01.03.58
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 22 Nov 2019 01:03:59 -0800 (PST)
Message-ID: <689d2fc6cfdeee86fc84e487356b233e4894030e.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Khem Raj <raj.khem@gmail.com>, Alejandro del Castillo
	<alejandro.delcastillo@ni.com>
Date: Fri, 22 Nov 2019 09:03:58 +0000
In-Reply-To: <CAMKF1sqZFNWQKAyK3sz5Hk32o55OeLPgsmhWGK0FLc1v=5W-bQ@mail.gmail.com>
References: <20191121205415.25946-1-richard.purdie@linuxfoundation.org>
	<20191121205415.25946-2-richard.purdie@linuxfoundation.org>
	<CAMKF1sqZFNWQKAyK3sz5Hk32o55OeLPgsmhWGK0FLc1v=5W-bQ@mail.gmail.com>
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 2/5] opkg-utils: Fix silent empty/broken opkg package creation
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
X-List-Received-Date: Fri, 22 Nov 2019 09:04:00 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2019-11-21 at 16:38 -0800, Khem Raj wrote:
> On Thu, Nov 21, 2019 at 12:54 PM Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
> > opkg-build was failing on hosts where tar < 1.28 and reproducibile
> > builds
> > were enabled but it was doing this silently and generating
> > corrupted
> > (empty) ipk files. Add a fix for this (submitted upstream).
> > 
> > The fix requires bash but if you're building ipk files this
> > shoudn't be
> > a problem.
> 
> is the problem similar to this one
> 
> http://cfajohnson.com/shell/cus-faq-2.html#Q11

Yes.

> does it impact build times when default shell is not bash ?

I doubt very much whether it makes much difference at all. Its a single
execution per package of a script which takes a comparatively long
time. 

There are multiple places pipelines are used in the script and it would
be fairly invasive to try and use tricks like the ones in the link
above.

If it were something which looped tightly or has a short execution
time, it would make a difference but that isn't the case.

Cheers,

Richard



