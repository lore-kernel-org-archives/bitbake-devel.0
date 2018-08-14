Return-Path: <alex.kanavin@gmail.com>
Received: from mail-oi0-f66.google.com (mail-oi0-f66.google.com
	[209.85.218.66])
	by mail.openembedded.org (Postfix) with ESMTP id 5E1CB74576
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Aug 2018 08:07:43 +0000 (UTC)
Received: by mail-oi0-f66.google.com with SMTP id j205-v6so32068062oib.4
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Aug 2018 01:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=IQgG61XIrEHeqHR6bitUqXnMpnrGOU9iKKBGWMa6nLM=;
	b=I5RwBLo0IMy/hAlxiVdHcmeGHvwzwH+OMurP9IRajDmerilwFhNbsVA7q8DS4V9ZvU
	dNB5XXGaRP6LIuHbu72jKYdWj28zZeBs9Nxtf5F5Fh9+1oMrLauzEq2zyHk1HtBP1g9c
	BHGhptIxMVJ+mfVO0OBmyyE09ncYpZljqzY5qURX6RacwDPfC16RG8j/pKXm/lavW+me
	2Fcu2+M1HyHMrEUqQiB6Gh02IKsDu5bOFp8i6SY0sV8EdxWSPSlMzxl4PK+YaDP2RPv+
	+dxLidHBWuzlJUEF7jh0TDNdGVBWwSi2W8EDywYSIgd7mV6PXrJcNUKykBW/SX4xruPG
	+Jpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=IQgG61XIrEHeqHR6bitUqXnMpnrGOU9iKKBGWMa6nLM=;
	b=KFuET+cJH1NwcYKh+2ruYJqBkM6d0rjGlIyBbvh3OhHgmIOTh6lraP2wAzdamCUf0R
	befzrcYsY8tvDsxA9Jre7P5fZFUsAcd1NCaRrTk3BEc4VEDsXvrjwBeNxIiAt8EfF2zh
	q72Pm2Dk9KAwsDL1ZnAbdwLfQAPS/5iJTpkLPnKRN6Ji0X4YRVAQPNjub+t+s1AeWqzn
	mYnpvSOvYttl90Mu3Ly9DBasygexIqPH9zXyKXWS9VBVjHDUt7xzRfhB8mmCDPCUpBHV
	hapOzaExu80Y+EEeUhYq3qUEj8y3tcddjFFeprewt6ebEUeSfkA2dhfMPF+lsi+83MxY
	eRLw==
X-Gm-Message-State: AOUpUlHMuymDcPhtX/VDvSA9KNAJuvJ277CzU28tQOpxLURqlVkTp+QK
	KBnE5mfr6xklZGzWkh0RFYOCUJWQOonIB6pd3Tc=
X-Google-Smtp-Source: AA+uWPwiHTJQei/byGcEYBZj0MIyYdBCpcSEU3tB+ui+xGpeTtKCTiq6hiC7tJ8TeWAkgSzoK/fx2NJHsV5rqJ9esNU=
X-Received: by 2002:aca:3e03:: with SMTP id
	l3-v6mr19706728oia.54.1534234064377; 
	Tue, 14 Aug 2018 01:07:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:90c5:0:0:0:0:0 with HTTP; Tue, 14 Aug 2018 01:07:43
	-0700 (PDT)
In-Reply-To: <20180814063203.GJ8291@hiutale>
References: <20180813210445.32496-1-schnitzeltony@gmail.com>
	<20180813210445.32496-3-schnitzeltony@gmail.com>
	<CANNYZj-3OQ7gPEop3OcDL5bnv3x9Q=DmEFCYi4-K7B3Xqp5v0Q@mail.gmail.com>
	<20180814011119.GA1391@jama> <20180814063203.GJ8291@hiutale>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 14 Aug 2018 10:07:43 +0200
Message-ID: <CANNYZj-b4D5FOc-S2_EbLYvpzdM4u4H8DeJP3JUbmeJJAsAcWA@mail.gmail.com>
To: Mikko.Rapeli@bmw.de
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 2/2] runqueue: Introduce load balanced task spawning
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
X-List-Received-Date: Tue, 14 Aug 2018 08:07:43 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2018-08-14 8:32 GMT+02:00  <Mikko.Rapeli@bmw.de>:
> Just my 2 =E2=82=AC cents to the discussion:
>
> we had to limit number of threads because heavy C++ projects were using
> all of RAM and causing heavy swapping. Single g++ processes were eating
> up to 20 gigabytes of physical ram. It's not just the CPU which is the
> limiting factor to parallel task execution.

I do believe some kind of clever dynamic limiter would be useful here.
Obviously it's an absurd situation when on a 32 core processor there
are 32 do_compile c++ tasks, each running 32 instances of g++ - which
is the default configuration. On the other hand running things like
do_configure or do_install should happen in parallel. I like Andre's
idea, but it should also watch the available RAM.

Alex

