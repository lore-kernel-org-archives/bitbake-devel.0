Return-Path: <raj.khem@gmail.com>
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
	[209.85.214.176])
	by mail.openembedded.org (Postfix) with ESMTP id BB9977FB11
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 Nov 2019 15:24:46 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id ay6so7952740plb.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 Nov 2019 07:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:organization:user-agent:mime-version:content-transfer-encoding;
	bh=Ww71jBAk8bZecNhAIZlhi2G0kwJHps+YYN4vbJ9o8Xk=;
	b=DSdvm4eIKOZyHPGzYM45xclhkDTAapH5tnBJchJVM7gAPKX3fXl/DiNh8XvpP47caY
	g6cTYpE5SfxMTHJoyX2G6eoYVhy/XhwML6OjtqmEAbQ8Skoj1wSi2q2ulDZxjOIcCfbv
	wZ6nBpubhgzxIGiXqt8tih30Ai9LH2czZ5fPogTzeY16CLOooPPT8LOMcDHoh9YrrEYx
	bsR7XjIBZsuZr0xpSOqEbHzIS71M81EHiNuEfXnMUY+YgAxN3Llu+pMEp9pY/0Y98nAt
	ZmoCWSQiGJgDpQdnAE8789bqOdM1/z5zQ29BxSOV1xUcJ4GNUC38RexUqtWb4rTcWdKW
	lhmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:organization:user-agent:mime-version
	:content-transfer-encoding;
	bh=Ww71jBAk8bZecNhAIZlhi2G0kwJHps+YYN4vbJ9o8Xk=;
	b=Svl6IoEEPmsv5RNt9dLBn5ODcXkum8askN7S3wMkFHimh+Xai2FZtL6FaKLNy71tdE
	tAlD0qCHCgFpdxdntQTdm+obvBoLcznqQudVC27KYcCql68q2nEaBM/xyBl9ggX/ci65
	J1TX6tCZNqDMMxCXJtt0XfiwK1qZzAEf2uCx91iqF2MySB+Ww/DRJtnKFdw/AyCzI8z3
	3mNUN73Pjtgic/xZaVhmXUpDQV8x2YfCiR76T7Jgft+mkI+P4SsyTHipAXGDleJq5RQl
	5CMMLcdrNAnhamTcmzSgKsAYKAt69BHef16b1g7qGZXH3VgngmzE9bxs255ZB7Zf/xr7
	o3nw==
X-Gm-Message-State: APjAAAUuM+TWnV8SUOUbR+j0PqAA6wJHQTcBcwLiYeQ0HdJjSYO2Ieqv
	IZGKCn+6sXTltRsF6MQ5fwo=
X-Google-Smtp-Source: APXvYqxBtdReWf2/s0ghXYy5PC/F7olrA9IXbrjv2fuBiApGMOQ446q6fXs6Qx6+a5kXE/RRhe2NzA==
X-Received: by 2002:a17:902:b416:: with SMTP id
	x22mr622804plr.12.1573485887372; 
	Mon, 11 Nov 2019 07:24:47 -0800 (PST)
Received: from apollo ([2601:646:8500:1c20::a99e])
	by smtp.gmail.com with ESMTPSA id
	r8sm15061716pgr.59.2019.11.11.07.24.46
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 11 Nov 2019 07:24:46 -0800 (PST)
Message-ID: <5018021771633c0e30b5789f31948fcfac633a15.camel@gmail.com>
From: Khem Raj <raj.khem@gmail.com>
To: Mikko.Rapeli@bmw.de, martin.jansa@gmail.com
Date: Mon, 11 Nov 2019 07:24:41 -0800
In-Reply-To: <20191111075820.GX2398@hiutale>
References: <6f692d96-9b78-b317-d033-09d1f140da62@linux.intel.com>
	<CA+chaQcOse_xmbyi0q=WXB1JQxV6AgGJtvrFZ_Wtmi-N2z0g6A@mail.gmail.com>
	<20191111075820.GX2398@hiutale>
Organization: HIMVIS LLC
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Patch idea - fetcher for gerrit patches
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
X-List-Received-Date: Mon, 11 Nov 2019 15:24:46 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2019-11-11 at 07:58 +0000, Mikko.Rapeli@bmw.de wrote:
> Hi,
> 
> Interesting idea.
> 
> We use gerrit but don't neeed to expose gerrit details to bitbake
> fetcher.
> 
> Instead, we use gerrit changes to fetch meta layer changes using a
> separate checkout
> script. It handles gerrit topics, e.g. same topic name is used to
> bundle changes
> from multiple meta layer git trees. This enables large transitions
> and updates as single
> topic.

There is a similar setup we have for CI using gerrit, but once you
start playing with fetchers, bitbake is not happy and the build
consistency is jeopardized as well, e.g. new QA checks etc, come in way
in other words you have to maintain this additional CI fetch method and
it grows cruft. So I would think if we were to do some additional work
in fetchers to achieve this, that would be long term sustainable, and
perhaps useful for other gerrit users or other SCMs

> 
> In our case it's a grave bug to use SRC_URIs in bitbake recipes
> without referring
> to proper branch and commit id. There have been cases where a commit-
> id from an open
> gerrit review got integrated which is bad, bad. I can only imagine
> that testing
> could be easier if bitbake recipes were to support gerrit directly,
> e.g. to trigger
> a bitbake test build for an open gerrit review change. But there are
> other ways
> to script that without exposing gerrit details to bitbake.
> 
> So I'm not sure if this gerrit fetcher is easier. At least I would
> like to disable it,
> or add a custom QA check which forbids its use in release build
> recipes.
> 
> Cheers,
> 
> -Mikko


