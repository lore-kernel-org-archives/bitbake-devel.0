Return-Path: <jpewhacker@gmail.com>
Received: from mail-oi0-f68.google.com (mail-oi0-f68.google.com
	[209.85.218.68])
	by mail.openembedded.org (Postfix) with ESMTP id 2CB31744B5
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Jul 2018 17:44:00 +0000 (UTC)
Received: by mail-oi0-f68.google.com with SMTP id v8-v6so37468740oie.5
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Jul 2018 10:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=mTKERTbTWk5B24sEfoWFGsvkHrFPKMQ/arK1CniwgMk=;
	b=Jnfx5BIFTVOnFwP66KWOClPN2zaV0DkqzMMiqkeKQCi9+q2bnvnrTC1Sxn+G5PD/TJ
	P+l0JrVxXa0I2PagoHJNKS+MtWrX2mUNH869LwuNKb+M2nukrXw8e5Wz80WCqEEJ7Vgb
	vbQtxcBicVvQinxVkadL5p+yngibgxW9UaTvnxhpeSk4gqxxSbAPPItrW3MrS0p2fLfZ
	y5E7ggM7buw7qUSDYy1dXmZcxA1yqUlLHf4kHigYbh7fuzkAMpxX9ZPmBPIJ2UzDCZxC
	mW1fbMzgxBKWHYhHkoHU1Z3fDolUhBRH0x5ADvlJpX2kgQYTordxtUjjrYElCSDlDV/M
	5Kag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=mTKERTbTWk5B24sEfoWFGsvkHrFPKMQ/arK1CniwgMk=;
	b=jyCv0nbzmrKyolClZvtZocqvO/V66AIVhfO7UTn/R0rHTWAqhmcXQVJVHZijFfqd+Q
	kadWj33Ps2c4ZAffEokYsSwWgL7ovSfehhrDhauOPAZcyzq1BvJ179gqqkgnSxwoMcMt
	5tfER95WzePnRPPptXYhkG+vyNYmlR4v+OiSNjRGOtKqKNq9y4rIRS7ixmEUoq3GobrM
	DzfsbpsNmntBJjadnfm7rdUgZ8XanY6FLWfq8lRyAr+w7F5xuo2li4MoFQ/3EA8Qjqyn
	CtNGRn/9C82umRm4H3v2dxaljRd+4tvzrsxlhtnxVT4s5Xgcq1iYDTmVVUM+GIk1h8wQ
	NcuA==
X-Gm-Message-State: APt69E25YAmDpdsRc/9zH14TKgQYoSYHBNof3jZ9Rr47hqYMDzM3iZ+v
	E8Xib3dtJazj4XjuKNX65dJqnq3FGHsF7ugPW78=
X-Google-Smtp-Source: AAOMgpdSL0rkRgCUooDRIH+OX95t366NBWwrXujRDrJyMRFU/nqFgzrRLIP2aDZ6FFXliWnVrfGPGKX0yqSvmdjEdzU=
X-Received: by 2002:aca:aa8d:: with SMTP id
	t135-v6mr22798821oie.218.1531158241153; 
	Mon, 09 Jul 2018 10:44:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180706154200.28769-1-JPEWhacker@gmail.com>
	<20180706154200.28769-4-JPEWhacker@gmail.com>
	<13922122.yNMeuHNp9m@localhost.localdomain>
In-Reply-To: <13922122.yNMeuHNp9m@localhost.localdomain>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Mon, 9 Jul 2018 12:43:49 -0500
Message-ID: <CAJdd5GaDmE0Y4=5MsihNfCeJofXi+H0Q3ZkC4u=9Y9uCRT0uYw@mail.gmail.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 4/4] runqueue: Stop on first unsatisfied dependency
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
X-List-Received-Date: Mon, 09 Jul 2018 17:44:00 -0000
Content-Type: text/plain; charset="UTF-8"

On Mon, Jul 9, 2018 at 10:53 AM Paul Eggleton
<paul.eggleton@linux.intel.com> wrote:
>
> Hi Joshua
>
> On Friday, 6 July 2018 5:42:00 PM CEST Joshua Watt wrote:
> > runqueue: Stop on first unsatisfied dependency
>
> Richard merged this already, but for future non-trivial patches could you
> please include a commit message that explains the change (particularly why the
> change is being made, rather than just restating what's been changed).

Yes, sorry. I will try to be more diligent in the future.

Thanks,
Joshua Watt

>
> Thanks,
> Paul
>
> --
>
> Paul Eggleton
> Intel Open Source Technology Centre
>
>

