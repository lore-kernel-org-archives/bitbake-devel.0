Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
	[209.85.128.66])
	by mail.openembedded.org (Postfix) with ESMTP id 892156C0B0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Nov 2018 23:13:33 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id f1-v6so12211302wmg.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Nov 2018 15:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=T8/ov44sjq9PeMpYNapte3rcRa3JG2zh3VYK0Ev/2E8=;
	b=LLWtmAfgOS8cWhBLvYPRvzQzTPaLr9/R4NdN5HiJs8fdQ4rdIgsjBt7F0Jkh2vitnJ
	xsthwkfOa2YYR8qH0ahX8Oi9v5BnmeolU3k2cbG8uz/j+r2wv1TtsXMc5PwRup6CwPun
	LUXS2BAoTMKwGrJnAAFO0DiP7RQuskupQmjcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=T8/ov44sjq9PeMpYNapte3rcRa3JG2zh3VYK0Ev/2E8=;
	b=YzXkjBgr4Pg5rcGZslBDbXZWcUsA8N3IohGrJIV/QbFcZfUgAbmzNY5OQBLLyWvUdD
	RPSWJR9OZyN5wtM0/rxD8ZJq34spKQis1th+iWetLFWNszBlZ5frGQva9c8W4KMFbsCc
	WVIJ+R26VSVgdx/82euEWulHJdfq/uUcdytzxdoHIY7FIsDJYVTjDfXJioD2/5CMQkvP
	LfqgKJHOLO8/pAlqFLxBrAE/UrCQPGe8znwbJZo9ixwAuwTka9C4qsBjT0j8s27+zGAw
	vCAbFD/ePej9w86m462CZbeom4RWI12nT+MlfIblbXzWKEdP8mnlp3QokY6R9snRJB1l
	2cdw==
X-Gm-Message-State: AGRZ1gKmlEzrVW/swqpRP3fhVn/UoJMSZ+TAB290jrV+YOabkJpT9jQN
	SkL5fTuqSqvJ67R1puzPsp6iUg==
X-Google-Smtp-Source: AJdET5c/qGY7OI72HZI3g2jVNWR2jublnKz7/+3fMOar7i5YrLukj8lsJD/hNM0172scr57CDL3dGg==
X-Received: by 2002:a1c:c911:: with SMTP id
	f17-v6mr4964192wmb.41.1542150814289; 
	Tue, 13 Nov 2018 15:13:34 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	y190-v6sm7533167wmd.41.2018.11.13.15.13.32
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 13 Nov 2018 15:13:33 -0800 (PST)
Message-ID: <de2b8c792e0f012f62aeb990bc8bdb0066b56ac4.camel@linuxfoundation.org>
From: richard.purdie@linuxfoundation.org
To: akuster808 <akuster808@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Tue, 13 Nov 2018 23:13:30 +0000
In-Reply-To: <2a132f70-529e-cb9b-d028-de4707fe2c95@gmail.com>
References: <20181113225942.17780-1-richard.purdie@linuxfoundation.org>
	<2a132f70-529e-cb9b-d028-de4707fe2c95@gmail.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Subject: Re: [PATCH 1/2] utils: Avoid warnings about deprecated imp module
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
X-List-Received-Date: Tue, 13 Nov 2018 23:13:34 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2018-11-13 at 15:11 -0800, akuster808 wrote:
> On 11/13/18 2:59 PM, Richard Purdie wrote:
> > The imp module is deprecated, port the code over to use importlib.
> > 
> > bitbake/lib/bb/utils.py:30: DeprecationWarning: the imp module is
> > deprecated in favour of importlib; see the module's documentation
> > for alternative uses
> >   import imp
> 
> so host side? Thud and Sumo backport?

Yes, but I think the patch crashes and burns on python34 as I clearly
didn't understand the docs correctly as I thought this was 3.4 safe.

So more investigation/work needed...

We hide most of these warnings anyway, I just decided we should really
fix some of them before 3.7+ bites us.

Cheers,

Richard


