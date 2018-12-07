Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by mail.openembedded.org (Postfix) with ESMTP id EE38F6058C
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Dec 2018 13:04:10 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id q18so3717589wrx.9
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 07 Dec 2018 05:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:user-agent:mime-version:content-transfer-encoding;
	bh=lpZzW2DV4Kd2KNfJLDDrw6tnu1RwOzqwZ+1+lzK2RHY=;
	b=W2ql9ppQZ/xQrN1GWMnU91H/H9aMtU86zN/wzV3NEm5MHWiVzXX/43pCnfYbJVzFqo
	FvOAgMcLcHJPQJnJb7ZvgQZvSKEOUhDlpLpGi5N6UcWn5X5lqbQsdpLLUInt04qd/L1I
	oHI0wok8ps/cqWS2KDvHq7Qkhxfnpd6IOglk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=lpZzW2DV4Kd2KNfJLDDrw6tnu1RwOzqwZ+1+lzK2RHY=;
	b=hDQ74ENNxqAWTQIjGO7WLYynEhpGuFlAQyLyRCZQDsp+oMkTRo/MJZkh27gHoW9eDF
	rGfW5SCGHW7XaICXXZo9j8qb+pDQe4HtTB67BQ3XaH+ipYWpI/uJ8dEDppPN3fOtAZ8d
	2Bv479Wqp6ePrMXeK5GJ5uYhmNDBI/ZbyAx9bTQEmnPTI1llbLVUnfJeZiHJaojVYWmj
	UW4Gyo7g6Sm91YIJ8UyfeiBG7CctZTvSvCV3IRMT+QZSX2avddK+HetqnRKLOta+tjcw
	eiZ3bixkLLurZ5Z0VT3Ogi5rEMLTBjelzJoDnemXk2ZqjxOOqj6LZuzNjqi4DHJLAGRB
	4LAw==
X-Gm-Message-State: AA+aEWZ9F+kLcmJ29DOxtHagzucgC6jlcWUEdQHKlwADD/07HJKLDs55
	7xGXC8hgD/7gfDl8Z1b+YoPz0g==
X-Google-Smtp-Source: AFSGD/VwudRvEzkGHnmhmvVJvqZc0rW7N85dWd9bqwcLTr6aJ34kmKC4jDs6pQ+X8gsjKOUGLf8Dqg==
X-Received: by 2002:a5d:548d:: with SMTP id h13mr1672389wrv.80.1544187851578; 
	Fri, 07 Dec 2018 05:04:11 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	c129sm2749185wma.48.2018.12.07.05.04.10
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 07 Dec 2018 05:04:10 -0800 (PST)
Message-ID: <eb636ddb0503dd0c271d51b3f7de32b23096fe51.camel@linuxfoundation.org>
From: richard.purdie@linuxfoundation.org
To: Joshua Watt <jpewhacker@gmail.com>
Date: Fri, 07 Dec 2018 13:04:09 +0000
In-Reply-To: <CAJdd5GbfV4vm9eoCPYxme7s31vvoK-M_jbCPKfzkLWxNH=BT-w@mail.gmail.com>
References: <20181206185535.12523-1-JPEWhacker@gmail.com>
	<76873c27c0f7da4f8339b25f009150d7b38d1e72.camel@linuxfoundation.org>
	<CAJdd5GbfV4vm9eoCPYxme7s31vvoK-M_jbCPKfzkLWxNH=BT-w@mail.gmail.com>
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] Add a variable to pass flags to fakeroot (pseudo)
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
X-List-Received-Date: Fri, 07 Dec 2018 13:04:11 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2018-12-06 at 21:27 -0600, Joshua Watt wrote:
> On Thu, Dec 6, 2018 at 4:05 PM Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
> > On Thu, 2018-12-06 at 12:55 -0600, Joshua Watt wrote:
> > > It is occasionally useful to pass additional flags to fakeroot
> > > (pseudo)
> > > either for debugging or for behavioral system changes. Add a
> > > variable
> > > called "FAKEROOTARGS" that can be used for this purpose.
> > 
> > Why wouldn't you just append to FAKEROOT/FAKEROOTCMD ?
> 
> You can't currently add arguments to FAKEROOTCMD because it is passed
> as an array member to subprocess.Popen sort of like:
> 
>  subprocess.Popen([d.getVar('FAKEROOTCMD'), 'blah', 'blah', ...
> 
> In order to pass arguments, it would probably have to have split into
> an array i.e. :
> 
>  subprocess.Popen(d.getVar('FAKEROOTCMD').split() + ['blah', 'blah',
> ...
> 
> I wasn't sure if that was desirable or if it would break anything, so
> I went with the lower risk approach of adding a new variables. I can
> certainly make a change to modify the usage of FAKEROOTCMD as
> described above and simply append the flags to it if that is
> preferred.

I'd prefer to fix this to work than add more variables...

Cheers,

Richard


