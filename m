Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
	[209.85.128.68])
	by mail.openembedded.org (Postfix) with ESMTP id F363460107
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 May 2019 07:52:02 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id 198so5931597wme.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 May 2019 00:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=nTAR5FBEPcL6I+9QSATJ+8K6HpmBmVfHiAEedc0exO8=;
	b=WhpTnJ9BtWTZqBT3tgFPoJGI3Lj5VLsJAZdC8PIFLcZeG3BHfXkXk2FRusJdVzOORb
	MZalfdoCRykcK7Umzbo43y/q65JAZzYJYDT2vc/JiAl6THjyRmJ0kiIobUnhAbYnIpMu
	KrR0q29gylr4S83rD7iODpefBPDodjeq2kh5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=nTAR5FBEPcL6I+9QSATJ+8K6HpmBmVfHiAEedc0exO8=;
	b=G63huX8Tn/np7matrcntwP2DHN9gItKRbF2EeI4VaIedOvNxP5R8Sh0+bxOE6Riry4
	zntxZ54AfYUYi8V4HQ/YW5PtWxKCMP+2SCjGiKc0zLRWOmctm8wt4PFEhfk+gtxRLlqi
	mGnvz/raaDQbplxL0eyTU5C193+QXYZY03wU5qoajMfb7EBEnjUbxumYUKfZ8eFRLRz7
	O8j4rHuDojetmZoBXaLlJfYikYw6rRLlT976XrvWSL34KUoWal4dxfhDE4xF5JWlZiS6
	2IVwOvJkXGZFQDxiiEu6tgxihFHOrFHTRcq3Ap+NVdffABbhN5bZQCnZlTFQMs1hafXm
	oy6g==
X-Gm-Message-State: APjAAAXNmF1iSSKE0QZm+xCJzqzgeqfMYKE5ATkMfrMCAT0scsFKbGXs
	3PSYpWBSull0xhU8IvqIUyqrxA==
X-Google-Smtp-Source: APXvYqz4nmLj19oGFQsIRrEsWQspOsFVOzNKAAXGUsHWuv/g30H53OZ3dJmcx6guHJAbC+IsPJHGeg==
X-Received: by 2002:a1c:7a0d:: with SMTP id v13mr1237548wmc.44.1558079523663; 
	Fri, 17 May 2019 00:52:03 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id z8sm6557918wrs.84.2019.05.17.00.52.02
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 17 May 2019 00:52:03 -0700 (PDT)
Message-ID: <97bfd646631a525954986b31d56cd61612078fd4.camel@linuxfoundation.org>
From: richard.purdie@linuxfoundation.org
To: Mark Hatle <mark.hatle@windriver.com>, 
	bitbake-devel@lists.openembedded.org
Date: Fri, 17 May 2019 08:52:01 +0100
In-Reply-To: <96ea6f7b-e30d-d598-1d68-0b53ed373229@windriver.com>
References: <20190516104616.154845-1-mark.hatle@windriver.com>
	<bc82f26011bc7642e1fef6e8e2b52334a263fdb0.camel@linuxfoundation.org>
	<96ea6f7b-e30d-d598-1d68-0b53ed373229@windriver.com>
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
X-List-Received-Date: Fri, 17 May 2019 07:52:03 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2019-05-17 at 10:44 +0300, Mark Hatle wrote:
> On 5/17/19 9:16 AM, Richard Purdie wrote:
> > I did specifically test on debian 9 where we saw the problem last
> > time
> > and that issue is resolved and passes now.
> > 
> > The question now is whether we want to install subversion on all
> > our
> > workers, whether we download and install some kind of standalone
> > test
> > tarball for this test or whether we disable the test by default...
> 
> Is there a concept of a skipped test within bitbake-selftest?  It
> would be easy
> enough for me to check if 'svn' and 'svnadmin' were available in the
> environment
> and simply skip them.
> 
> Then it's up to you guys to figure out if this is a test you want to
> run on all
> of the builders by installing svn or a standalone test tarball as you
> suggested.

Its standard python unitttest which supports skipping so yes, I'd agree
this is the best way forward.

Cheers,

Richard


