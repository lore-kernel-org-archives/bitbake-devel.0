Return-Path: <persaur@gmail.com>
Received: from mail-il1-f195.google.com (mail-il1-f195.google.com
	[209.85.166.195])
	by mail.openembedded.org (Postfix) with ESMTP id 804C47F89D
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  6 Jan 2020 15:46:02 +0000 (UTC)
Received: by mail-il1-f195.google.com with SMTP id v69so42878861ili.10
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 06 Jan 2020 07:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=content-transfer-encoding:mime-version:subject:from:in-reply-to:cc
	:date:message-id:references:to;
	bh=kRDhIWaCtCOBfrT0lA/1bGKD5gTwpE7CQcpIxOfkcI0=;
	b=sYpluwIDaQ/FaJCfvK5873zXoeEWrd813sW3izyN7RextzkEUKur9Y5Ttp4ilYj/HZ
	uAyYN8cO27NWWffwzcYbToIc5zbE1sQgvkHf6pZbDVyywuUM6HlVx1w/IgYxQ+j5aXUa
	y3rKUf9tcTU8j2iI+28Fyjp8rEhSpy8kRmSuiCKxBYrKwUzR1W8ML3HSbNfXbnbEfCxG
	sJ6xKltWR2q5Zee7N1Q2rtQme8U7BexCBnLwrLlE0k7BBK5SWRG8sOAxTfcZo8Q/Glm3
	wTpRuZQLiRUykJoAe+Ax7vncSHfbqPKMVp1AH4m6ekemo39zFRJOMt4TMt+yxPwKDUg0
	EViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:content-transfer-encoding:mime-version:subject
	:from:in-reply-to:cc:date:message-id:references:to;
	bh=kRDhIWaCtCOBfrT0lA/1bGKD5gTwpE7CQcpIxOfkcI0=;
	b=PP/5Xi69ZKBn7IlUeSPSZkfMrnQpHSx5uci0rwI9x4Wjj591HoEjc55u+IWOxZM9g+
	o2rzxu7p5tWjwbudBdVsND6u8xz3Xkj6fAirKXGb4DpEAG5byvG++wqXtvqOD6bO3nl4
	VLc/pCTQfHhPICyTGMdc05aTG2HLeHGhf9BqHK//n6PXGg/6Q6Ds45ITFhblW9U7alUn
	0OUL1X6Shm/Zux3nosdkCR7OrDJ7u/86Q3qHo6eZ5By81IGqGZc1VF7QC5KvM4AEooUE
	KjcCOFFuRe3K3+FZpdZVBht7znJnh2aJRbY4mNVJeNBOWLFze1CxUuTAYcooU70M0AHg
	liyA==
X-Gm-Message-State: APjAAAUETu0lHKSieWxyeUMOxjzC18vXzp/cTOSk1ttNtCtSZKwSQxhN
	Yhnb07QDtGcknQ0oa8//4xc=
X-Google-Smtp-Source: APXvYqxts9owg3L/gIQaDvZ+J82juY1+YEY1dDRswHsHlJQQa9KOMymhN5dUuq/x++uBY1OLF2M3nA==
X-Received: by 2002:a92:d2:: with SMTP id 201mr89557240ila.22.1578325563836;
	Mon, 06 Jan 2020 07:46:03 -0800 (PST)
Received: from [100.64.72.6] ([173.245.215.240])
	by smtp.gmail.com with ESMTPSA id
	l22sm24260339ilh.37.2020.01.06.07.46.02
	(version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
	Mon, 06 Jan 2020 07:46:03 -0800 (PST)
Mime-Version: 1.0 (1.0)
From: Rich Persaud <persaur@gmail.com>
In-Reply-To: <ec84fd38-c014-0014-2dbb-b3bb06364ce1@gmail.com>
Date: Mon, 6 Jan 2020 10:46:02 -0500
Message-Id: <91D12B92-6D18-4C3A-930F-45E2B2227600@gmail.com>
References: <ec84fd38-c014-0014-2dbb-b3bb06364ce1@gmail.com>
To: Pascal Huerst <pascal.huerst@gmail.com>
X-Mailer: iPad Mail (17C54)
Cc: Philip Balister <philip@balister.org>, bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH v1] bitbake: fetch2/git: add SRC_URI option versiontag
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
X-List-Received-Date: Mon, 06 Jan 2020 15:46:03 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> On Jan 6, 2020, at 10:15, Pascal Huerst <pascal.huerst@gmail.com> wrote:
>=20
> =EF=BB=BFHey Rich,
>=20
>> On 29/12/2019 03:04, Rich Persaud wrote:
>>> On Dec 4, 2019, at 04:16, pascal.huerst@gmail.com wrote:
>>> =EF=BB=BFFrom: Pascal Huerst <pascal.huerst@gmail.com>
>>> Use latest_versionstring() to find the latest tagged release for use wit=
h
>>> AUTOREV. This can be useful, if you want to build the latest tagged
>>> release
>>> instead of a branch. UPSTREAM_CHECK_GITTAGREGEX can be used to specify a=

>>> version format.
>> Have you seen this approach?
>> https://code.ossystems.com.br/gitweb?p=3Dmeta-ossystems-base.git;a=3Dblob=
;f=3Dclasses/ossystems-srcrev-handler.bbclass
>=20
> Thanks for the hint, this goes into the right direction, but does not
> solve my problem.
>=20
>> For development workflows, it would be useful to override a
>> recipe-specific branch/tag via bitbake CLI.  For production/stable
>> release workflows, it would be useful to override a layer-specific
>> branch/tag via bitbake CLI, which could be propagated to all recipes
>> within the layer.   This would help when maintaining multiple versions
>> of a layer, corresponding to multiple OE versions.
>=20
> That's exactly how we manage our development releases, but what I wanted
> to achieve with this patch is to just tag releases in our repositories
> and let bitbake figure out the latest releases to create an image from
> it. That way we don't have to fiddle around with bitbake CLI or yocto at
> all, but can just tag releases in our repositories.
>=20
> I find that quite useful, but the interest has been near zero for that
> patch and I'm not sure, whether this is such an exotic use-case or if
> there are quality issues with my patch...?

Maybe start a thread on another mailing list (oe-arch? oe-core?) to collect r=
equirements for related workflows, so your patch can be generalized to addre=
ss more use cases, before extending the syntax for bitbake invocation?  Ther=
e may be other bitbake improvements that OE developers have done downstream,=
 which could be consolidated.

Rich=

