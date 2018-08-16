Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
	[209.85.221.49])
	by mail.openembedded.org (Postfix) with ESMTP id 01FD579298
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Aug 2018 08:57:32 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id e7-v6so3421970wrs.9
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Aug 2018 01:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=99mD0JRRZowH+loKADIA+az4lr/6Y1DXnJc/KqDpHNQ=;
	b=Bsk6i6SWm1c24vRksyHukq+CfR8hKqJCJX6Bo8h8bIeKlGJdZc6u96xiK7ZtE4983J
	vm6WM1/LHFv9qochigrUP8yAgPFQbU4azrJH0eMI0sj7wIQetuKr6Hwe54Txxh2ZsZ3j
	nIYv98B7+LIN8+I1ZcVBLC4c+ZbLCNF48ulZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=99mD0JRRZowH+loKADIA+az4lr/6Y1DXnJc/KqDpHNQ=;
	b=pF+3kchtn/IOhvavdgiHPgQ+1kw21UNfiO25UHD+ytKFjrCVYhD4le45zXYn/Rbw+I
	2MbqKwpzhcsP98hzs/DkWsFciYyz5dLHwMcrzF8s3vkQasWREhOcv5zZcPCam9tx2H5m
	FBQptZFHRKaeSFtsID3ZsKN52lurRQiskEtVpighMpnqzechHfC2BAobiS5SSOd7t0a+
	WSqV/Uzpxux+5w5YZTNfyBHmFpxytc51F8kt+xgiJpt1BUh/AjchGlSf6i1+SRtVCjjK
	yKu+JKybyIql2My523JP7G8a42259LMoWD3Ex7LUwQucgpQ4ushiUqRuqVJ6e8+HOCHr
	fh9Q==
X-Gm-Message-State: AOUpUlH514NSMlb4QrLAdHuz948IpEhzfZmtZBUzT34qeqMwU0+tRYJ6
	jpmHvHRhbzY7fLUMi2s5pq9Z5g==
X-Google-Smtp-Source: AA+uWPxjAoqTAw2R57eabfas61NMIVxnuyxUcNo4pEdH1dKnDemUdetIY1KX23/uD/rKOHOAHi6GQQ==
X-Received: by 2002:adf:f28c:: with SMTP id
	k12-v6mr18732663wro.263.1534409853715; 
	Thu, 16 Aug 2018 01:57:33 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	y18-v6sm24654755wrh.85.2018.08.16.01.57.32
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 16 Aug 2018 01:57:32 -0700 (PDT)
Message-ID: <51d27f87c9fb766697826c8969166e44d4f87cbf.camel@linuxfoundation.org>
From: richard.purdie@linuxfoundation.org
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
	bitbake-devel@lists.openembedded.org
Date: Thu, 16 Aug 2018 09:57:29 +0100
In-Reply-To: <1fd3956c-d7c9-445a-b8ad-6770998801d3@prevas.dk>
References: <08a61d76-d0b7-ce93-180c-5c4eab3ee150@prevas.dk>
	<1fd3956c-d7c9-445a-b8ad-6770998801d3@prevas.dk>
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Subject: Re: commit 6c3281a14 / set_context broken?
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
X-List-Received-Date: Thu, 16 Aug 2018 08:57:33 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2018-08-16 at 10:40 +0200, Rasmus Villemoes wrote:
> On 2018-07-10 11:31, Rasmus Villemoes wrote:
> > AFAICT, set_context in lib/bb/utils.py doesn't actually set the
> > module-global _context variable, but just assigns to function-local
> > variable by the same name. Hence it is effectively a no-op.
> > 
> > The python fix would be to add a "global _context" declaration, but
> > since things have apparently worked for 5 years, perhaps one can
> > simply
> > delete set_context and remove the calls?
> 
> Ping.

I just had a quick look at the code and you're right, there is a bug
there. It might explain some of the issues with memory resident bitbake
and things not being quite reset properly at times. With it just
covering os/bb/time, it probably isn't a huge deal but I'd prefer to
fix the code as the API is meant to be generic.

Cheers,

Richard

