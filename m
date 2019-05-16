Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail.openembedded.org (Postfix) with ESMTP id 4325C7D1D3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 May 2019 06:41:38 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id r7so1908397wrr.13
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 May 2019 23:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=hhZx1wPXoeEfCxsew8gok0XyoqEa6lDNji1nd9fRdis=;
	b=T/Wjo4A1/MzdtPkyH0CcRCdZyS51e3bwIk0Sd2/CGhKKUSizSKH9fw3QgFkU01gpZS
	Es5M/fZld5pNWrTVtLqvZwFY9zCWR2k73TwMhLbrjS3XzoN8c7+9PxMnxSmCuz3yCCxj
	HxWDHWIHWwQhWNkM3bE8ASFbTamYDSi+IRlf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=hhZx1wPXoeEfCxsew8gok0XyoqEa6lDNji1nd9fRdis=;
	b=i3I+tCMDVz7CApke/zCNaUaEAjvpRsnYCDl3TKoz2vq5UD7/f6e8uoZv0/fBtlj4vv
	enS0dDMa7+wVJzHthJ0SxbKAbs3QgQt8Y6xagN/t2MC0xYnAnSrnYMZT9rzHd0qsSqwm
	SVbWDbnvRc3wzqHHR15+l+9HoG3v8OvjrHlaL+bCBBEAevrtCnvo6DZ5RQIwH/V3uOTZ
	2Jndt3zE5/jv72gfv9I9n2UApWrMgVsixOdpAzHED8fR18nA6owtU//VaEvbxuOOAY8d
	+kbnCauCFgZP4mglxGIMhbhlYl8m3DkghpqVrESr2tAX5PKYpmhV9c1yeCfMw85tct/y
	ucrg==
X-Gm-Message-State: APjAAAVDgEEt24ENJpGytORlqmHSlhInlVSNNGfb0ePOjCmw97Q7Xd99
	/F65OQ6MfCI+4pTA0DsN6OAd+Yu5anI=
X-Google-Smtp-Source: APXvYqw8Bsq9i8Hr/VXs9FfnREwgcjPXQT3Ut4XMAsU70Szh0M1n17u1CX44seRRBmxYhXnmcMauLA==
X-Received: by 2002:a5d:4fd2:: with SMTP id h18mr4092157wrw.117.1557988898908; 
	Wed, 15 May 2019 23:41:38 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	i185sm7883751wmg.32.2019.05.15.23.41.38
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 15 May 2019 23:41:38 -0700 (PDT)
Message-ID: <00abca9c644ab670e596afe8c73ee5627f3954b3.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Mark Hatle <mark.hatle@windriver.com>, 
	bitbake-devel@lists.openembedded.org
Date: Thu, 16 May 2019 07:41:37 +0100
In-Reply-To: <20190515180230.187728-1-mark.hatle@windriver.com>
References: <20190515180230.187728-1-mark.hatle@windriver.com>
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Subject: Re: [RFC PATCH] svn.py: Stop SVN from directly pulling from an external layer w/o fetcher
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
X-List-Received-Date: Thu, 16 May 2019 06:41:38 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2019-05-15 at 14:02 -0400, Mark Hatle wrote:
> Add a new option to the svn fetcher url "externals=allowed".  This will allow
> a user to enable svn co w/ externals.  However, this does avoid the fetcher,
> network access and mirror systems.
> 
> By default we no longer allow externals in the checkout.  This ensures a
> deterministic download.  The system does attempt to identify SVN repos that
> have externals enabled, and will warn the user.
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
>  This was done in response to the patch from Krzysztof Zawadzki and the resulting
>  discussion to make this the default instead of optional.

Patch looks good to me but the autobuilder didn't like it:

https://autobuilder.yoctoproject.org/typhoon/#/builders/56/builds/465/steps/7/logs/step1d

Cheers,

Richard


