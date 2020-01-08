Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
	[209.85.221.44])
	by mail.openembedded.org (Postfix) with ESMTP id BA53E7FA27
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 Jan 2020 08:48:47 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id q6so2404540wro.9
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 08 Jan 2020 00:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=v/kQO/isRknQS2anWldb/B9ts+bW7HToDDTJ/1BAuUA=;
	b=hXXeMP7oVidUcTBvTmTvBtHOxSlqoZlGNjYT7YTmTFvWnSgk+A0b7F3L6VmatJMlFt
	+VYr8cA/CyAlETXJoxexUoxLVM0uY2m7p6aJ4l3RKDhZh+JlbvXgdvwXBMvTOme3huQ1
	mWrIJN7rEmJnjl5I5H90oiy4pL/S04PDZiKso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=v/kQO/isRknQS2anWldb/B9ts+bW7HToDDTJ/1BAuUA=;
	b=Jd6G/VvWENomuPcki/fv3yb1Pd2IthllFH5tmAsH8crMoo3GEtWZWuYHTARW79azY8
	4ZbAK5OaqYg+w6IAVxskYm/dkqK0YhNOH299/vr2T79OUh2nFY9a0MYguyr0J0YBuZp2
	Nv4oFk7/zvDTOOe+shHsOd0SzLjmy/eurazgt48Lf8U6pCYlUJzvChDvvxxINvHMPV7b
	kO9uE4WCrDGFvDjlsLsdsCTkYVX2FsteFVZ346aL/y3FpEgmHaTrevQDRWYJfaJJT6dd
	VTaIlOzaeAKJL64nMOFXDCC5gwMPbrYbUOckxGmz+pMnZjn0O3kk/Hork3wRtBcsVROB
	kcPA==
X-Gm-Message-State: APjAAAWd8R3z376iD+FVadzkcYSbZZIBM8ooFrlksXfhYgvGJ3gRRfMR
	LiUC/Suv+gv5mQEYwl3bhYNzxA==
X-Google-Smtp-Source: APXvYqz9TVzeTWlUf49vwpunakI12NpwAlwhamYUvfzvNINzdZmofrFoXo4ol/OvkfePetOPjj5UNw==
X-Received: by 2002:adf:f847:: with SMTP id d7mr3301039wrq.35.1578473328398;
	Wed, 08 Jan 2020 00:48:48 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	l18sm2856911wme.30.2020.01.08.00.48.47
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 08 Jan 2020 00:48:47 -0800 (PST)
Message-ID: <d5d59f4d6db40c644c9f827697b38d216b251e8a.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Masahiro Yamada <masahiroy@kernel.org>, 
	bitbake-devel@lists.openembedded.org
Date: Wed, 08 Jan 2020 08:48:46 +0000
In-Reply-To: <CAK7LNARkXaLFq8eJpNkbbkXDnRrVdXjXfYtHuqRA1OdO7AfU4g@mail.gmail.com>
References: <CAK7LNARkXaLFq8eJpNkbbkXDnRrVdXjXfYtHuqRA1OdO7AfU4g@mail.gmail.com>
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Subject: Re: Why does recrdeptask delete a task from the dependency graph?
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
X-List-Received-Date: Wed, 08 Jan 2020 08:48:48 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2020-01-08 at 13:26 +0900, Masahiro Yamada wrote:
> If I add
>   do_build[recrdeptask] = "do_build"
> to recipes/bar.bb
> 
> "bitbake foo" shows
> 
> baz.do_build
> foo.do_build
> 
> 
> So, bar:do_build is dropped from the dependency.
> 
> What is the intent of this behavior?

Quickly looking at your testcase, I'm not sure it is the intended
behaviour so it could be a bug.

Cheers,

Richard


