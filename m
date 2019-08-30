Return-Path: <andrew@aj.id.au>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
	[66.111.4.29])
	by mail.openembedded.org (Postfix) with ESMTP id D3C137F3B1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 30 Aug 2019 00:13:46 +0000 (UTC)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 65D0821731;
	Thu, 29 Aug 2019 20:13:47 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
	by compute4.internal (MEProxy); Thu, 29 Aug 2019 20:13:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
	mime-version:message-id:in-reply-to:references:date:from:to:cc
	:subject:content-type; s=fm3; bh=8g2zWNK24c0WNBHwaW8BYbjT3WhWbq4
	FOSn5l+Hqas4=; b=d8gTYBIkwy1y/78ekmrH3xnglG1HJ+693yLvH92pMyfTpld
	v/rlHsIrYjJIlYwelCQZBqezZJNBhdOZn+VOPiTXVu9h6cuON89sFbwefRIpueHv
	VlOSm1DuNU5502hhhViklBljsL5ZHh9kGkedxwCjEfL0La2/SHzMxMpW1q85+DpJ
	CNeZljw7pzwqVnI5h2TPPSq1LUBrH9LHAItUTuvA8WbCZiMNl6dOk2labYcz/6Jz
	VZTmt5jdfLnKDtZWrJs5tZEWnKNT8eICnadyO5QvzlcFnHIrLSzGvJOxFZFQTDm4
	nXdN7LpqlCOVyRNEeyU7jel3vAIPd6rZLgmIWDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=8g2zWN
	K24c0WNBHwaW8BYbjT3WhWbq4FOSn5l+Hqas4=; b=ZgoIeVysrxP7FwmSJ1bNJL
	s1plCRW4is2KmTwTLkcdZ5mYGJPa35A17g14pJDbFZul5HXQvpAYE84VrnDjmZWu
	xpEk1Ay4aWCjJPO//88BMiaQsE2wJA1GJERuupzOYREFfvc3y1jyC//8zTrY5s4P
	/CXG5vN6cQ3D7a1sIZ0lUkbgb/U66FxI2cc30/GCkBrFEMg+plG3h+Q4rDLpe8Mu
	YxeD/C4RJ4sKbTePB4/mkvZ4cKUuK45O2TIzLbQl1CjwPW94oiSiAPawi+d8FF6t
	H0z4riGrQ+WXKNKp/MQ9LgzJz4QDeimtD5WtYAnCHI112rJaCOLUfDIaXc7oOzVg
	==
X-ME-Sender: <xms:OmpoXR1pbDcqE52MHznz5_F_cs6-ASzWORAkdf5i26AyfJT69-Zh0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudeifedgvdelucetufdoteggodetrfdotf
	fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
	uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
	cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdetnhgu
	rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuffhomh
	grihhnpehgihhthhhusgdrtghomhenucfrrghrrghmpehmrghilhhfrhhomheprghnughr
	vgifsegrjhdrihgurdgruhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:OmpoXTPAO4PQbls6sb7H4azQsA-CIysWZ5NfCxMXp7_697diyaF0zg>
	<xmx:OmpoXcPXls9sbwWLpqco1N_a0GWrAXrLDktWszVaDQrMnhpjPwPlrQ>
	<xmx:OmpoXbYHoIn1tKTrqjEvaxcjJNJIob3b7C2U4-_IBdG-ncweoRDJUg>
	<xmx:O2poXe7dY2Bwj_MNqWip4MblxwgCBZkOq6jaCwB2bzqdeO9ZOqQlyA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 86046E00A3; Thu, 29 Aug 2019 20:13:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-154-gfa7592a-fmstable-20190829v1
Mime-Version: 1.0
Message-Id: <2cae4e10-485d-4b6f-bad3-4766be7be6d3@www.fastmail.com>
In-Reply-To: <CANNYZj-mt-djAF2xnhLduA8O9Zzgc7VsiPFjXXZKzNHkR8uM0A@mail.gmail.com>
References: <20190827000358.25777-1-andrew@aj.id.au>
	<a0279d01-3d06-3648-f63c-9392be141397@windriver.com>
	<2e4b0f4a-8288-490a-8bc2-7d49f460487e@www.fastmail.com>
	<CANNYZj-mt-djAF2xnhLduA8O9Zzgc7VsiPFjXXZKzNHkR8uM0A@mail.gmail.com>
Date: Fri, 30 Aug 2019 09:44:09 +0930
From: "Andrew Jeffery" <andrew@aj.id.au>
To: "Alexander Kanavin" <alex.kanavin@gmail.com>
Cc: Brad Bishop <bradleyb@fuzziesquirrel.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>, ojayanth@in.ibm.com
Subject: Re: [RESEND RFC PATCH] gitsm: Control submodule recursion
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
X-List-Received-Date: Fri, 30 Aug 2019 00:13:47 -0000
Content-Type: text/plain



On Thu, 29 Aug 2019, at 00:49, Alexander Kanavin wrote:
> On Wed, 28 Aug 2019 at 16:38, Andrew Jeffery <andrew@aj.id.au> wrote:
> > Can you expand a bit more on how I'd do this (examples?), or point me in
> >  the right direction with documentation? There don't appear to be any
> >  pointers in the git:// fetcher section of the mega manual.
> 
> I believe you simply need to specify several git:// entries for the 
> submodules you want like for example vulkan-demos does:
> 
> SRCREV_glm = "01f9ab5b6d21e5062ac0f6e0f205c7fa2ca9d769"
> SRCREV_gli = "8e43030b3e12bb58a4663d85adc5c752f89099c0"
> SRCREV = "ae0b59c6e2e8630a2ae26f4a0b7a72cbe7547948"
> 
> SRC_URI = "git://github.com/SaschaWillems/Vulkan.git \
>  git://github.com/g-truc/glm;destsuffix=git/external/glm;name=glm \
>  git://github.com/g-truc/gli;destsuffix=git/external/gli;name=gli \
>  file://0001-Don-t-build-demos-with-questionably-licensed-data.patch \
> "

Great, this is exactly what I was after.

Thanks!

Andrew

