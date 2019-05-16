Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by mail.openembedded.org (Postfix) with ESMTP id 271EC7D34E
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 May 2019 07:47:21 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id l2so2151646wrb.9
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 May 2019 00:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=p/30J1f9RufDI/nw0ke9QQk8eYzPcFaS1vjb9i2FlUE=;
	b=a/d/GEONkshoLT4scsoKDwW0qS1TfJHFunzDpXPVw1UMNPrVnGsjR3qc3PdePd5Ofr
	KDVAwNHD8bV0dRypuDYqMKfDPBh8KWs9Ebfh8BujvgU8WvnR2OP16NANXcFkVqYs14N4
	xMLPj6dwWJrpzvVYO0VvwmzjwHpXpMRgrU4+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=p/30J1f9RufDI/nw0ke9QQk8eYzPcFaS1vjb9i2FlUE=;
	b=I7kRDYyIrCl5O3zGvtiH+TkwidqKq4zgm7gW4FZf9PpHcB53Wbx+ZYs05pVorIqytV
	UCLJRvMmZEXlQKe/sctUDfkXxLF8QwSb8Cad9Fa6+MSXtQAM1u+nqqMhqEHMOeCoQFLQ
	06svNKP7uBIKrxIroLSRwsnNRvifg6tYeRI+jE+YzXkiSPFJl3auqGfmGAtQmi5VHQbo
	IK8Lh7txBOovhz7BdLiN2oXqWlVo3CeFpwsD/TDAw7gw6NxgA/bOSWRZWtxxbXqukebC
	eiFIdBO3dPPfBXT1RMKLwQA3Iu6Ulshe58o4nLAXEW7zu9rgkOqO81kfDfBkvq6gIGlk
	z3Ew==
X-Gm-Message-State: APjAAAXBGvOnbWyZ+uNs0uT3OHspUe+CZOQmoP/OXx0yssWOoxbruZ2v
	anNbA/6E9aWnn/QMKnD8lfK4cQ==
X-Google-Smtp-Source: APXvYqzjhBwV1Z+X5rr3LzeBDB7MmnQdJlk0h7rtGp/h4UpkZJAd+x2Pfy8y5KCVqdAZ5OWe+tGq/Q==
X-Received: by 2002:adf:db0b:: with SMTP id s11mr29133090wri.180.1557992842658;
	Thu, 16 May 2019 00:47:22 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id 34sm4624409wre.32.2019.05.16.00.47.21
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 16 May 2019 00:47:21 -0700 (PDT)
Message-ID: <6b8fcaa8f9628fac7353ffbba9a6c0497107b03a.camel@linuxfoundation.org>
From: richard.purdie@linuxfoundation.org
To: Mark Hatle <mark.hatle@windriver.com>, 
	bitbake-devel@lists.openembedded.org
Date: Thu, 16 May 2019 08:47:20 +0100
In-Reply-To: <a40c00ba-741b-f114-2da9-edc1b3b02a38@windriver.com>
References: <20190515180230.187728-1-mark.hatle@windriver.com>
	<00abca9c644ab670e596afe8c73ee5627f3954b3.camel@linuxfoundation.org>
	<a40c00ba-741b-f114-2da9-edc1b3b02a38@windriver.com>
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
X-List-Received-Date: Thu, 16 May 2019 07:47:22 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2019-05-16 at 10:22 +0300, Mark Hatle wrote:
> On 5/16/19 9:41 AM, Richard Purdie wrote:
> > On Wed, 2019-05-15 at 14:02 -0400, Mark Hatle wrote:
> > > Add a new option to the svn fetcher url "externals=allowed".  This will allow
> > > a user to enable svn co w/ externals.  However, this does avoid the fetcher,
> > > network access and mirror systems.
> > > 
> > > By default we no longer allow externals in the checkout.  This ensures a
> > > deterministic download.  The system does attempt to identify SVN repos that
> > > have externals enabled, and will warn the user.
> > > 
> > > In the future we would like to parse this list and see if the items are already
> > > in the SRC_URI for that recipe, but with SVN being in limited use these days
> > > that extra work is likely not worth the trouble.
> > > 
> > > Add test cases that generated a local SVN tree, with an external source
> > > set to github bitbake in svn format.  One test case checks that externals are
> > > ignored, and one checks that they in downloaded.
> > > 
> > > Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
> > > ---
> > >  This was done in response to the patch from Krzysztof Zawadzki and the resulting
> > >  discussion to make this the default instead of optional.
> > 
> > Patch looks good to me but the autobuilder didn't like it:
> > 
> > https://autobuilder.yoctoproject.org/typhoon/#/builders/56/builds/465/steps/7/logs/step1d
> 
> What is the host system type on the autobuilder?  Everything I see in the
> traceback is as intended.  So it's likely a version or argument change in a
> different version of SVN.

That one was debian9.

rpurdie@debian9-ty-2:~$ svn --version
svn, version 1.9.5 (r1770682)
   compiled Jul 21 2018, 02:35:40 on x86_64-pc-linux-gnu

Worryingly I looked on debian9-ty-1 first and subversion isn't
installed there at all. In builds we'd build subversion-native.

This could get quite tricky to handle...

Cheers,

Richard


