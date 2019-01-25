Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
	[209.85.128.68])
	by mail.openembedded.org (Postfix) with ESMTP id 0900A7C367
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Jan 2019 12:24:00 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id a62so6577287wmh.4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Jan 2019 04:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:user-agent:mime-version:content-transfer-encoding;
	bh=JDSkY2ss/LH7lINx5OFk3AezrEYSXi+KaaQ3XLwVOKI=;
	b=EMISsUvMcYRLJvEr0OMflGAVDGJlf7qPcnRyFh5uVAI07IUywYdqWTtsHxkHwG2Kkb
	NbeD9+X4HBjr5MaxXSgYC/89DKxkcFUNh4fYgj0/+DenL9ggDaV+wQO3ZF2AQkgnPdbu
	+cTZHqjAoBqBpRUkKPDrTHN+t+xak21bk74yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=JDSkY2ss/LH7lINx5OFk3AezrEYSXi+KaaQ3XLwVOKI=;
	b=d7AQPx+IuWiycYZOOd3WCTf9/XVDBsChTOmiq3ytyVV0aGxKbfoyUzV6JyBxnBsBh1
	J/1DY5hk/gliSYjBZ6oNdlyIf7zc/9k+Rn27yRSwNuvXKUYQtbAjiWwiXbParxpW7K80
	+buJXbW1YaYEdB0qsxI9L6w2jnmDV3V2OmP2wm/u46LYxcUhcqf8TVSPyEc8Lo3JrKjI
	EWYMJkcOz+lHepYqSqedW3xNvQyJ7WHnQ4H2yihqhwvntHG74SL/DD9wQpxXBIpqVtBH
	Ugs9dtqPvacA6+mPqCGvoXTAH2vVhBZ7BTv89ZXw2DUSc2MnQK3x3cadEksDPsamWhsB
	IAww==
X-Gm-Message-State: AJcUukcQLKHmi9TWCZaOffOCZC6EdYyAlA7IrWGwKFfcx4lnq16Waaw/
	wBSj+J3oAAku+LfN1C5j/SIhJA==
X-Google-Smtp-Source: ALg8bN4lOh4QUMNqv5y69juFNygF4n46S3nq+odI07rhzvqLzLnnYgwbZuZq8E8+iCh8J0+v9rm/YQ==
X-Received: by 2002:a7b:c7c7:: with SMTP id z7mr7117708wmk.74.1548419041627;
	Fri, 25 Jan 2019 04:24:01 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	a18sm127628300wrp.13.2019.01.25.04.23.59
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 25 Jan 2019 04:24:00 -0800 (PST)
Message-ID: <1dbceb752ca54fcbb32c4c4325272b80670693f4.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Ming Liu <liu.ming50@gmail.com>
Date: Fri, 25 Jan 2019 12:23:59 +0000
In-Reply-To: <CALatG=7YgmkROJpk_6pfZFKGP3=RjoJC_mh3gRsKMF+e=6=aqA@mail.gmail.com>
References: <1548413847-32550-1-git-send-email-liu.ming50@gmail.com>
	<18561a9b63079e5dc2d4b4a8b6b12728475b0402.camel@linuxfoundation.org>
	<CALatG=7YgmkROJpk_6pfZFKGP3=RjoJC_mh3gRsKMF+e=6=aqA@mail.gmail.com>
User-Agent: Evolution 3.30.4-1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org,
	Stefan Agner <stefan.agner@toradex.com>, Luka Pivk <luka.pivk@toradex.com>
Subject: Re: [PATCH] fetch2/gitsm: fix config file concurrent update race
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
X-List-Received-Date: Fri, 25 Jan 2019 12:24:01 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2019-01-25 at 12:35 +0100, Ming Liu wrote:
> Hi, Stefan:
> 
> Could you help confirm this? 
> 
> Hi, Richard:
> 
> May I know how has the issue been fixed?
>
> I updated the tip to:
> ```
> commit 8c8ecec2a722bc2885e2648d41ac8df07bdf660d
>     gitsmy.py: Fix unpack of submodules of submodules
>     
>     If the submodule is in a subdirectory, it needs to have that
> structure
>     preserved.  This means the unpack path needs to be in the
> 'dirname' of the
>     final path -- since the unpack directory name is specified in the
> URI.
>     
>     Additional specific test cases were added to ensure this is
> working properly
>     based on two recent error reports.
>     
>     Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
>     Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org
> >
> ```
> on top of that commit, I could see there are "git config submodule"
> being called concurrently in different processes, which does have a
> race condition, and will lead to the error observed by Stefan,
> although it's not easy to be reproduced.

There are locks at a higher level in the fetchers, in
lib/bb/fetch2/__init__.py the download() method has:

if ud.lockfile:
    lf = bb.utils.lockfile(ud.lockfile)

and the unpack() method has similar locks.

Mark and I believe there were some code paths where the locks were
being bypassed in the gitsm fetcher but Mark reworked the code so that
we were both happy that there should always be a lock held.

We need to fix any races properly ensuring they're covered by the main
fetcher locks, adding new ones would only fix a symptom of the real
problem.

Cheers,

Richard




