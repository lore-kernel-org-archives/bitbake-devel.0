Received: from mail-gh0-f179.google.com ([209.85.160.179])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <raj.khem@gmail.com>) id 1U3ZOm-0007ID-SG
	for bitbake-devel@lists.openembedded.org;
	Thu, 07 Feb 2013 22:52:53 +0100
Received: by mail-gh0-f179.google.com with SMTP id r14so746877ghr.24
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 07 Feb 2013 13:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:mime-version:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=BOmZc3n6+n5fQixoDeiX/QhDZmYIGxt+GKRLjr3TZ2w=;
	b=D5qcyIgtKRSIzR9bGfyfGDTlZb1QJgK28B43nc8H6NFI6aTGqlh+5QTIV2Nj0caxK0
	vdzFHa4WoEI5HXjR7uOBx+zMCJUBKXDyC7GIkiCCa1j5A5D62XNkaafl771jIlgGuuJV
	XGXXVKK9hcOMhFPsASB1Moza7+LNphAVR4gRay/9F1AJAG8tbyE0suNGx2IejixlagQI
	Gb/MhM9LVeTG6eAvGOzkdv7eLCA5YonW0UoNrt2PTv8vR2luvGSZyzKHoOTqlsB5/YQn
	eFY6cYrWU+JGk06PHWA8+mMjPuZFBI3USaqafbZ+niQv9TKUF+4alM2YNHRa1Y0qfy3W
	29MQ==
X-Received: by 10.101.138.33 with SMTP id q33mr11109309ann.9.1360207049083;
	Wed, 06 Feb 2013 19:17:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.147.65.1 with HTTP; Wed, 6 Feb 2013 19:16:58 -0800 (PST)
In-Reply-To: <alpine.DEB.2.02.1212031726110.5149@heron.softorchestra.com>
References: <alpine.DEB.2.02.1212031726110.5149@heron.softorchestra.com>
From: Khem Raj <raj.khem@gmail.com>
Date: Wed, 6 Feb 2013 19:16:58 -0800
Message-ID: <CAMKF1spTSz-7_eR-zTzSP39eOyp2v_GNNugyTSGQW7aqE9=Zkw@mail.gmail.com>
To: Alan DuBoff <aland@softorchestra.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: libstdc++.so.6 not in target image
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 07 Feb 2013 21:52:54 -0000
Content-Type: text/plain; charset=UTF-8

On Mon, Dec 3, 2012 at 5:30 PM, Alan DuBoff <aland@softorchestra.com> wrote:
> I tried to inclue gcc-runtime in my image recipe, but it complains that it
> can't build the image.
>
> I was wanting to get libstdc++.so.6 in my target image so I don't need to
> build as static.
>
> What is the recommended way to achieve this?

wrong ml I guess. if you are using openembedded asking it there might
draw more answers

>
> --
>
> Regards,
> Alan
>
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel


