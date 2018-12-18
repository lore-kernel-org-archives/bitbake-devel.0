Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by mail.openembedded.org (Postfix) with ESMTP id 7CBB66BA72
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Dec 2018 21:16:54 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id v13so17375757wrw.5
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Dec 2018 13:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=bGkPOrmPr8JUcCkI5I/pjh+vh9dQcgM3h+fwsrjqJe4=;
	b=TJ9GT5LUYIpSyPkebGcdIkPdSGtRZHmC9EZkj481ZedwoqOS+zOoCwTEKUbDVa7R5n
	q82DPdVsGy+U1PJ3LRoSVBq3o8WGQbkA1hG2UfS7KKdHR4PtwoYs/VYKkutPsNkR+Ifr
	QYD0/Pc/iiXM6BWDRDkUCwo0hOZFWv+EZgFgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=bGkPOrmPr8JUcCkI5I/pjh+vh9dQcgM3h+fwsrjqJe4=;
	b=hzUos6vuXbefNImxhapX+Elsb/4w6P7/laST8HWlyaEMW8LAmU38s0ZLRS+k0m3JbZ
	okiP/tYMymrIcpqmaq/jTF6THkkfvim84l0j+ltMptSUn/m39XKzzXudUtqZY9DZ/y64
	It3GjjrmxEb0DPVl9FCnTX2Im4XruYLmLAVHBAxhzM/2hfQWwBNG33hFxDuYCgTbpYqn
	gw0OdtdB0HacL1RBtWBQepZ6ohPnCiO0Usp+eXODbfeVX6MLbTji5yG7q85RmyRQbDYI
	OeFVSBA3qOt4WqeXar88pzSlV6Ql+NTV/qE3mFNo5nVfKeKsRiI27LoS1V8tzW/mhZe7
	rN7w==
X-Gm-Message-State: AA+aEWZ/7QiLjr0LUvRf/IjljKSUDP3MRs1ghJPRrz3f/+R+qdA3NMy2
	1BwXMnwUTEwa2nfhdGYMj+H54Q==
X-Google-Smtp-Source: AFSGD/U5+WDwPFGsq/97ZOIFF0FsY7VJZ0n4UJcQ+5WkobAs3IWAuQCpHfxWFMSFiFJc2vTaUZnBZw==
X-Received: by 2002:adf:f703:: with SMTP id r3mr15836969wrp.93.1545167815061; 
	Tue, 18 Dec 2018 13:16:55 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	t70sm4459339wmd.36.2018.12.18.13.16.52
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 18 Dec 2018 13:16:53 -0800 (PST)
Message-ID: <eae945fea01f12c8abd559b4988ae34f9e2fe405.camel@linuxfoundation.org>
From: richard.purdie@linuxfoundation.org
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>, 
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Date: Tue, 18 Dec 2018 21:16:48 +0000
In-Reply-To: <ca187ac1c83d43b282db6b8d66d416a8@XBOX04.axis.com>
References: <20181214140219.1553-1-richard.purdie@linuxfoundation.org>
	<20181214140219.1553-2-richard.purdie@linuxfoundation.org>
	<ca187ac1c83d43b282db6b8d66d416a8@XBOX04.axis.com>
User-Agent: Evolution 3.30.2-1 
Mime-Version: 1.0
Subject: Re: [PATCH 2/3] data_smart: Allow numeric characters in	overrides
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
X-List-Received-Date: Tue, 18 Dec 2018 21:16:54 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2018-12-18 at 21:05 +0000, Peter Kjellerstedt wrote:
> I do not understand this commit. The commit explanation and the code change 
> don't match up. The motivation in the commit message is that there was 
> problems with overrides such as x86-64 containing digits and that the 
> code should be changed to allow overrides to be lower case and numeric.
> However, the modified code changes the test from using islower(), which as 
> far as I can tell only validates the alpha-characters in the string and 
> ignores all else, to using a regular expression r'[a-z0-9]+', which will 
> match as long as the first character is a lower case character or a numeric 
> character (note that there is no $ at the end of the regular expression).
> 
> Here are tests with islower(), which correctly validates "x86" and
> "x86-64" 
> as lower case overrides, but not "fooBar":
> 
> > > > "x86".islower()
> True
> > > > "x86-64".islower()
> True
> > > > "fooBar".islower()
> False
> 
> Here are the corresponding tests using the r'[a-z0-9]+' regular
> expression.
> Note that it only matches "x86" from "x86-64" and "foo" from
> "fooBar", and 
> will incorrectly allow "fooBar" as an override:
> 
> > > > re.match(r'[a-z0-9]+', "x86")
> <_sre.SRE_Match object; span=(0, 3), match='x86'>
> > > > re.match(r'[a-z0-9]+', "x86-64")
> <_sre.SRE_Match object; span=(0, 3), match='x86'>
> > > > re.match(r'[a-z0-9]+', "fooBar")
> <_sre.SRE_Match object; span=(0, 3), match='foo'>
> 
> So why change from islower(), which as far as I can tell did the
> right thing from the beginning?

The commit is clearly wrong. The intent of the commit message is
correct, it doesn't match what that regex actually does :(

Cheers,

Richard


