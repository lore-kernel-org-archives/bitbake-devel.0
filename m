Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
	[209.85.128.65])
	by mail.openembedded.org (Postfix) with ESMTP id 39E2B7C6E2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Feb 2019 23:00:20 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id v26so11276641wmh.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Feb 2019 15:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=umtXhwLxzB8a+zOuL1iPE2iAf1rD9+3XBQTjUZPSF9A=;
	b=iFTGejTXXNPTfQBSKxEbCU/wl0/wGwfrEef0qtn2js0zMTy85hbXGpIMefKaNqhwZH
	XIU+Pl2JMfKUIMr5sSe/FVWR9nJWx25Fu/Lf+k9oCaSHrzWOu4YiFHO0+u57kKm4sSBI
	xa1TVIKTJFFWXBdPZ8TFsAVuswWb1hParUlX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=umtXhwLxzB8a+zOuL1iPE2iAf1rD9+3XBQTjUZPSF9A=;
	b=DS1u+fRe8vobHBrp7Y3Vmqc3sbxJkMw+z5aZjtsIy0uwMouAKhgbFrnTuLmts6VwJZ
	iI0f1chOLxLhQI28WlXzyxTfZKAuWLDy6oQTbNSxxBLey/dMhbnKk1KfylTJubu/n+Ov
	/0J7/DiaLepte0yftDElO1Snt9rDEgg5RFoDXhZhM1lKB4bFvIwBDfiHfOCqIKGySAHz
	TVk9gQ0NGbPfocXj1114RW7/XEb7SHEE22m3qHoBMyjF9omj7ZO6EuH43oPAYX2berdL
	sfZXE/lk/IstQzjrbdqqwgNOeKg6XyOv3uNDheSF+6fjSYigGuG9FddbGSOkOz61Wu0Q
	6obQ==
X-Gm-Message-State: AHQUAubxqEqA92TSdKovFXeQDUfKZ+6d0I57ttBTc6SKblDhijsnHA8b
	brbRydMvIS6uLv01uFf/Evu8Hg==
X-Google-Smtp-Source: AHgI3IY81gNqU9ozSCbLi3hOeBikr0hQSmc+0IGD+lsbKA2xNory44CxchrsnuN+nsQHoYToNcL8sA==
X-Received: by 2002:a1c:7fcb:: with SMTP id a194mr8204687wmd.51.1550271620701; 
	Fri, 15 Feb 2019 15:00:20 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	184sm9638750wmz.18.2019.02.15.15.00.19
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 15 Feb 2019 15:00:19 -0800 (PST)
Message-ID: <7dd4a96220566dc8d9a1db6a6430aba8bed8b596.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Krzysztof Zawadzki <mr.k.zawadzki@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Date: Fri, 15 Feb 2019 23:00:18 +0000
In-Reply-To: <20190215032539.5297-1-mr.k.zawadzki@gmail.com>
References: <20190215032539.5297-1-mr.k.zawadzki@gmail.com>
User-Agent: Evolution 3.30.4-1 
Mime-Version: 1.0
Subject: Re: [PATCH] fetch2/svn: adds svn --ignore-externals option
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
X-List-Received-Date: Fri, 15 Feb 2019 23:00:20 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2019-02-15 at 04:25 +0100, Krzysztof Zawadzki wrote:
> With this option we can force users to provide all used sources in
> recipe.
> Without this there is possibility that repositories which are using
> svn:externals
>  can point to source code from HEAD or to nonexisting repository.
> This can cause attempt to reproduce build after some time impossible.
> 
> Signed-off-by: Krzysztof Zawadzki <mr.k.zawadzki@gmail.com>
> ---
>  lib/bb/fetch2/svn.py | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

I'm wondering if this should be the default and is something people
have to explicitly opt out of?

Cheers,

Richard


