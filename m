Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
	[209.85.128.65])
	by mail.openembedded.org (Postfix) with ESMTP id EB8E67E094
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 May 2019 06:16:32 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id y3so5706068wmm.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 May 2019 23:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=Hkv1F44MTeszXz1r/7Ky/67q7xi1zaZQQKH39K1ZKkc=;
	b=JUscEEfq7kCDiw6Srg2vXkXEcqA7lFcNWcMM4Cp2W0udj/4aoQejb2aHv5kO89frAp
	so3HOcXyoJNWuPAcmddhrpMifdcYT99zWqOCGktRyO5hBf/rVmkYlzu5GQxgi/884Y+L
	095Hl4bEilIIFAoeg3Ke3EuuwEPfVEBhOl9zU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=Hkv1F44MTeszXz1r/7Ky/67q7xi1zaZQQKH39K1ZKkc=;
	b=B49PfM56zjRe4FC4mguiiFTGhs49a07eDgkqFMcSNn0KKYSAwoRDOBtPdiNsEKGDxV
	twKICh/KyHGpijvlOHz4fnMnonubQ0wxDq4NMso1LBDe0CqNGnfYmiwqD453MYuXzIcR
	9SOBSrZ9EjdhmwtgWMdw/GMH74oHRcRdG0FFxT8IdJWYedZzcYvUgC35ncZ+/5VHq2jU
	vML/yVeY9CTIUWgMW7EaXTu8kND3gURHWbTcSZJvucj6VoBC2Yc0SFUDYP14tqSHAwVo
	xwBc+2afqTnOgK+nGIvBKl78MPSs6t5tomUCBaYqz7gHLyftpfck9QXUKSes/eCJ5msp
	kytA==
X-Gm-Message-State: APjAAAV3HE6ruFeUqW7Vg5mFB4L4ojA6bbo83Hx246/eaTVYUmLSDd/7
	r1bkqdrCWx4anXEUDWiErfHYF7dGvOs=
X-Google-Smtp-Source: APXvYqxp5+ldihFcjOaZjMHDqZPOWMuHirdnKqhg0TxhW5qzJq32WHET/fNiX9NRvebL6xXhic6cBA==
X-Received: by 2002:a05:600c:2289:: with SMTP id
	9mr16236165wmf.106.1558073793710; 
	Thu, 16 May 2019 23:16:33 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	c14sm1347472wrt.45.2019.05.16.23.16.32
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 16 May 2019 23:16:33 -0700 (PDT)
Message-ID: <bc82f26011bc7642e1fef6e8e2b52334a263fdb0.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Mark Hatle <mark.hatle@windriver.com>, 
	bitbake-devel@lists.openembedded.org
Date: Fri, 17 May 2019 07:16:31 +0100
In-Reply-To: <20190516104616.154845-1-mark.hatle@windriver.com>
References: <20190516104616.154845-1-mark.hatle@windriver.com>
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Subject: Re: [PATCH v2] svn.py: Stop SVN from directly pulling from an external layer w/o fetcher
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
X-List-Received-Date: Fri, 17 May 2019 06:16:33 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2019-05-16 at 06:46 -0400, Mark Hatle wrote:
> Add a new option to the svn fetcher url "externals=allowed".  This will allow
> a user to enable svn co w/ externals.  However, this does avoid the fetcher,
> network access and mirror systems.
> 
> By default we no longer allow externals in the checkout.  This ensures a
> deterministic download.  The system does attempt to identify SVN repos that
> have externals enabled, and will warn the user.  It is up to the user to
> determine if these are necessary for the recipe.  They may disable the warning
> by adding "externals=nowarn" to the url.
> 
> In the future we would like to parse this list and see if the items are already
> in the SRC_URI for that recipe, but with SVN being in limited use these days
> that extra work is likely not worth the trouble.
> 
> Add test cases that generated a local SVN tree, with an external source
> set to github bitbake in svn format.  One test case checks that externals are
> ignored, and one checks that they in downloaded.
> 
> Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
> ---
> v2:
>  Refactored the test case to use --non-interactive option to try to avoid
>  the controlling terminal failure.

I think this is working better but it leaves us with a second issue,
not all our autobuilder workers have subversion installed:

https://autobuilder.yoctoproject.org/typhoon/#/builders/80/builds/177
https://autobuilder.yoctoproject.org/typhoon/#/builders/86/builds/176
https://autobuilder.yoctoproject.org/typhoon/#/builders/87/builds/175

(a pass: 
https://autobuilder.yoctoproject.org/typhoon/#/builders/79/builds/180)

I did specifically test on debian 9 where we saw the problem last time
and that issue is resolved and passes now.

The question now is whether we want to install subversion on all our
workers, whether we download and install some kind of standalone test
tarball for this test or whether we disable the test by default...

Cheers,

Richard




