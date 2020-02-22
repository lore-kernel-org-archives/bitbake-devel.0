Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
	[209.85.221.48])
	by mail.openembedded.org (Postfix) with ESMTP id 65DAD60AF4
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 22 Feb 2020 15:54:55 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id e8so5395061wrm.5
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 22 Feb 2020 07:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=R+WjogC1lKOYflckFzOh5ajdxGsyEW3CeQAkOUIWc+A=;
	b=OZBETUkDd9EnNBL1O3ix5RaTS6tx3z4XBM5pAlnuiS6XTx6XqVEKB9yYKR9SXrwLzK
	T3ma4WQQovhScUkWx2dFDBeHSnfDJ3lij6Xfy6MmYbEX0WFyrbyf6uNQPk0/a1+4kahe
	vjDja5DycMZ+FZ+0N+pPf+3jf/KrvYzBPJ2Cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=R+WjogC1lKOYflckFzOh5ajdxGsyEW3CeQAkOUIWc+A=;
	b=Cjmly46LmLtRZudZTNuH2UIK6iGrCBKDy+He8JOMD1Nq1Y/km3L1zwt9aU52pBrATs
	1Gt+OtL5Fvvnjo5YcC1W/mxVh0n1zHlzVqgciQOTvPTHFDOf1KhzL06znbnkk5iJ6hbC
	2y5UxJj3E3MXsrBS8G5s/AGaKyFZiv7gZemmiPdiPwfhSwFR4fD42BmrYJtokU/fU3ag
	UXGJsLvuE5YP6WwONG+EISrGyI6rjjymDqspK+ckinKVXTmILQzasEJoB0xkf2Se0+sv
	TzlFzplpXHFRJUpZ9ThWkagzMuusiCafQ7CSnRDKIMhBgAclydhuWRhRew/tFGpYtTIX
	1SxQ==
X-Gm-Message-State: APjAAAXMU/LiPfMRSj0KYc2a6jtYKPCIM2ULc8r/eJGz6Kcl5sduvHnU
	mM2xMq/V3yGKSPQlXLGkGvWFvA==
X-Google-Smtp-Source: APXvYqwPwlSvEbzuTmOvHdFlZPVkFvdrkD3o3yuLMWsp1MAwcYoP/KtIHsM4K2cE65zqDo/IIPSHYw==
X-Received: by 2002:adf:dfc8:: with SMTP id q8mr55474543wrn.135.1582386895910; 
	Sat, 22 Feb 2020 07:54:55 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id w8sm9278654wmm.0.2020.02.22.07.54.54
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Sat, 22 Feb 2020 07:54:55 -0800 (PST)
Message-ID: <e349f1cc1d3b36fdff330dc7eab1f213a67d32b1.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Adrian Bunk <bunk@stusta.de>, bitbake-devel@lists.openembedded.org
Date: Sat, 22 Feb 2020 15:54:54 +0000
In-Reply-To: <20200221205213.16130-1-bunk@stusta.de>
References: <20200221205213.16130-1-bunk@stusta.de>
User-Agent: Evolution 3.34.1-4 
MIME-Version: 1.0
Subject: Re: [PATCH] Lower priority of debug messages that should not be shown on the console
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
X-List-Received-Date: Sat, 22 Feb 2020 15:54:55 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2020-02-21 at 22:52 +0200, Adrian Bunk wrote:
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> ---
>  bitbake/lib/bb/runqueue.py | 8 ++++----
>  bitbake/lib/bb/siggen.py   | 6 +++---
>  2 files changed, 7 insertions(+), 7 deletions(-)

The trouble here is that if we remove these messages (and I can
understand why people want to), if there is a problem with hashequiv, I
can simply look at the result and say "yes, it broke" with zero ability
to understand why as we can't tell what happened in the build.

The correct fix is probably to change the console log messages to log
differently to the on disk log file. Even then, it means we can't debug
autobuilder failures unless we save those logs.

So in summary, there is a choice:

a) We can compel me to merge patches like this. I will then just have
to close all hashequiv bug reports as WORKSFORME.

b) We actually fix/improve the way logging works.

I'd prefer b).

Cheers,

Richard




