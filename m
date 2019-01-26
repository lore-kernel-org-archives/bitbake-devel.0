Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail.openembedded.org (Postfix) with ESMTP id D92EF6BF33
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 26 Jan 2019 13:35:19 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id q18so13039057wrx.9
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 26 Jan 2019 05:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:user-agent:mime-version:content-transfer-encoding;
	bh=WZz29lxlbadjuBdMVxt2qnMTkoXwnefrkk3PzuDlslM=;
	b=GG87RpkQ9UxaK+VhWPrGa/Lt7+eT8w62vpOg9KpjwBs3u+3bhxDRCufuwRmOHBh5dz
	I4VUcnjf5zzh9OXhIWon+uBB3npXvDyRHvLu0OYM+AaQtlT2a+k2QQbu1EFQTVpBJmCn
	7xn9O8xzy7b1pqB8aO3PPLuEFcgYIlj+NTeYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=WZz29lxlbadjuBdMVxt2qnMTkoXwnefrkk3PzuDlslM=;
	b=k0A9RC032EMI6WpqhtMgWkkpZaUVmumJIf9/1uhz5iiPs9CgLyDbb3R/N1u6IORPoF
	RD8m8UMdhzlaVrXmSp8EPTZvDrGB7NwMXYR3XEDe8GmFjFoVGmE8KllRlVafgkL3UM9w
	dYNDwbIocZYIu1+ad3ms6iQ1SPdWoOjoM4Q4VNVWYXHMKFEYcf8znn2ZtXw1dYBhjDcj
	fWcZnHXZ7NrsUy8qQykdueYluC+dtG/+zEUqsyVQb2F5GdyiffNMwWbENd8BKngq3dLC
	L1Twq1LIkuHbg/zsRrBkwEDxpFY4+8hCA9hC4ihAf3U/kSK9DCjOb12/CfmUBGiCURTW
	kqgw==
X-Gm-Message-State: AJcUukeYpvO/SeTxv1LEmThvU/OFrqCmLl+G6RPeHbn8MPcZFkZ9AUgJ
	GeeHG+awJYPz9iaFyJdJuoThBw==
X-Google-Smtp-Source: ALg8bN52RRoxXdjB2o7W4wS2KDfX1DbZIygPueWbZGihhE3hUdNFoIyE1777+0fPhJbx3fKbHauuFg==
X-Received: by 2002:adf:ca13:: with SMTP id o19mr15017944wrh.148.1548509720553;
	Sat, 26 Jan 2019 05:35:20 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	l6sm101457244wrv.70.2019.01.26.05.35.19
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Sat, 26 Jan 2019 05:35:19 -0800 (PST)
Message-ID: <a20f847aaf0c90f4659147bf5f2e2bbe3e74bf40.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Patrick Vacek <patrickvacek@gmail.com>, Stefan Agner <stefan@agner.ch>
Date: Sat, 26 Jan 2019 13:35:18 +0000
In-Reply-To: <CAG+wK9nzO3WQfPTbf_8we_2xEm0JfevbrKM-E-Zov6qSz-sgrA@mail.gmail.com>
References: <1548427287-11934-1-git-send-email-liu.ming50@gmail.com>
	<238483ee79cc017f2b6603d562c26cb18036a037.camel@linuxfoundation.org>
	<7d80c538faadfdc9d2259bc37956835b@agner.ch>
	<fc0c4b8d-13a9-ad32-a017-27feb97fb8bd@windriver.com>
	<832b2810-7e11-fa18-b50e-b40b07c6e265@windriver.com>
	<3ea9bbe919c928366d71417e1cb8b73f@agner.ch>
	<CAG+wK9nzO3WQfPTbf_8we_2xEm0JfevbrKM-E-Zov6qSz-sgrA@mail.gmail.com>
User-Agent: Evolution 3.30.4-1 
Mime-Version: 1.0
Cc: stefan.agner@toradex.com, bitbake-devel@lists.openembedded.org,
	luka.pivk@toradex.com, liu.ming50@gmail.com
Subject: Re: [PATCH V2] fetch2/gitsm: fix config file concurrent update race
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
X-List-Received-Date: Sat, 26 Jan 2019 13:35:20 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sat, 2019-01-26 at 13:07 +0100, Patrick Vacek wrote:
> On Sat, Jan 26, 2019 at 11:15 AM Stefan Agner <stefan@agner.ch>
> wrote:
> > > So it seems to be that something in the recipe was expecting
> > semi-broken
> > > behavior.. and its actually a recipe problem.
> > 
> > Agreed, in this case we need to fix the recipe.
> 
> Sorry, I must be missing something. What might be wrong with the
> recipe? Is there more that needs to be specified than a SRCREV and a
> branch? As far as I understand git, it keeps track of the submodules,
> so I don't know what other information there would be to provide. The
> reason this particular case is difficult is because there are
> recursive submodules. When we build aktualizr, we have to be careful
> to specify that. See 
> https://github.com/advancedtelematic/aktualizr#building:
> 
> git submodule update --init --recursive

The problem is the checkout from the old version of the fetcher was
broken, it incorrectly checked out that SRCREV. The recipe was written
to build that broken checkout.

We've fixed the fetcher and Mark is saying that it now checks out the
correct thing (as compared with a git checkout outside of the build
system, independent of the fetcher).

The recipe assumed the old broken code so now fails to build. The
recipe therefore needs to change to adapt to the now correct source
code.

Cheers,

Richard





