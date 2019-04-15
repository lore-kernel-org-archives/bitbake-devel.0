Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
	[209.85.128.44])
	by mail.openembedded.org (Postfix) with ESMTP id 35C337D733
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Apr 2019 13:34:07 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id n25so20508405wmk.4
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Apr 2019 06:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:user-agent:mime-version:content-transfer-encoding;
	bh=l3eke0QVuSStOCz6xBw2huBaSs6Y92lPwh5G0nhSWh0=;
	b=IQqT/7gFM+MmV33Kavo4G93IEqE7SUJ89oLHHYgprUNFE/MTb9sRpbuDyfMsfgYrH4
	f0SBPtSz0Wrtw/hx6MfrQKY3p3pxkQsJF8d9wdSuDfe+9WyvYbTHX+twXiOcsqceEfAm
	2ErkMTmrXnTCCyYV249lIMyeC23k6n/TCd+7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=l3eke0QVuSStOCz6xBw2huBaSs6Y92lPwh5G0nhSWh0=;
	b=qvqv34+Ldy663hqtjjDrV2thV5kaTN3IUhx2lD0PsTyAzj2geyeiwzgWn8UyphYQ1Y
	jAJIIAoD42vCtENiYHpRoQP4xvwwLN9EIciO1IHNER3ionD4aObQaGV9JwqVXMVcEIgo
	ur+OACf5yPo/HgtzDyC3njldufrMUHRxSAwl6ZZMXfW5eyG5HfE+CuUWvmjQaZXE9lsV
	TGCBOzie2EWu7CfjF7Bf3fUZV0rdLKQwDPs0qsv/InNeG76ySNujTvBpdSilS7yHgTcE
	uicI+x0DAIGan0ZLTK0ysIaLb/+PSmDdDBwxeDBb/EfhS6DJz8JULYVTxGdc5W20uhX8
	CJZQ==
X-Gm-Message-State: APjAAAUcUoIphXpcoCMoB2KiYB+49KQnXX3uNFymUO9dK7XCiRABaA3U
	snp9LxNnV+XibRYNQcRaJvMtmg==
X-Google-Smtp-Source: APXvYqwxf7GnUtcA5+ifsN63GG2iacpKK1pH0mfLLnMaj2DGvfAuC+rXs0FYQQkBbW35xGhlYv/dBA==
X-Received: by 2002:a1c:cbc5:: with SMTP id b188mr21977810wmg.87.1555335248726;
	Mon, 15 Apr 2019 06:34:08 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	t15sm49843597wrx.22.2019.04.15.06.34.07
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 15 Apr 2019 06:34:08 -0700 (PDT)
Message-ID: <0d355dec3e98f63d574ad1967608556becc4a5fe.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: akuster808 <akuster808@gmail.com>, Martin Jansa
	<martin.jansa@gmail.com>,  akuster <akuster@mvista.com>
Date: Mon, 15 Apr 2019 14:34:06 +0100
In-Reply-To: <1c452d27-33c3-234b-9d57-b39689d3c3f9@gmail.com>
References: <1555031998-3975-1-git-send-email-akuster808@gmail.com>
	<CABcZAN=v6z1wYty0EbjVAtAKeR_EQgzRuZcYYXLBOWxh4m=-qw@mail.gmail.com>
	<79d20dc2-8f36-3c27-05e5-3517b2eb8e26@mvista.com>
	<CA+chaQc3w=8kPabdEt1Jz-O=5GfuUL0XZ6Y=Eyx27kFTxHwZYw@mail.gmail.com>
	<1c452d27-33c3-234b-9d57-b39689d3c3f9@gmail.com>
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH]] bitbake: update masters version to some farout version
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
X-List-Received-Date: Mon, 15 Apr 2019 13:34:08 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2019-04-12 at 08:39 -0700, akuster808 wrote:
> 
> 
> On 4/12/19 1:06 PM, Martin Jansa wrote:
> > > but so how is it Master is 1.40
> > 
> > It isn't, master is currently identical with 1.42 branch, so both
> > are 1.42.
>  Yes you are correct. As of this email it is.
> 
> Three hours ago master was updated to 1.42
> https://git.openembedded.org/bitbake/commit/?id=00b133af009f9e7c1a4c751b6ef4902f47a81fe2
> 
> Master then got bumped to 1.43
> https://git.openembedded.org/bitbake/commit/?id=aae15f3c16fb463962eee100a8b0bcd5fc01ad96
> 
> again three hours ago.
> 
> so now all it right with the world. : )

Just to follow up this was basically the release process working.
Master was in sync with 1.42, we released and 1.42 ended in the branch,
1.43 continued in master...

Cheers,

Richard


