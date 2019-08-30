Return-Path: <andrew@aj.id.au>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
	[66.111.4.29])
	by mail.openembedded.org (Postfix) with ESMTP id A5FD37ED22
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 30 Aug 2019 00:18:03 +0000 (UTC)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id C306721FA9;
	Thu, 29 Aug 2019 20:18:04 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
	by compute4.internal (MEProxy); Thu, 29 Aug 2019 20:18:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
	mime-version:message-id:in-reply-to:references:date:from:to:cc
	:subject:content-type; s=fm3; bh=OXTtYgJFKNpaO5E3KgUDO8PyIwuglen
	+M6VoNLM3NzY=; b=NKsbsWSd6pN7xPc/UGUNERlaW9S7Y4uyB9JTiwNleFaOBIW
	ww+nhXBG1cKh9JjPB9FVdLrb6kkM8dg8hzqbFVCn2XvRinYS5zD8z0xiswVdLE6r
	SnMcJpVeLnK2Tu7cFQdPoUOaHQKdJJJ6ftIE/OYbaZuDjxVwUdi3k+Hjb/DXTR/H
	ScaE8qNkUNnoL4fZ/tQuEuUksm/XZjlH0uB60U0zGi3elL/WzI1+LfpiKU6JQk9/
	TLrZqwV8rbaD6dZEWB21U9AtqgN9RDBenkwi5CinQIP7D5Cvy/i650Bfgp2nvAUx
	4D9tqRR6tHWDBof1fxLj1vYUR4RX5DdAucDQdgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=OXTtYg
	JFKNpaO5E3KgUDO8PyIwuglen+M6VoNLM3NzY=; b=N6YbqbqL6+zfKi65apdL0v
	W3xNXkltL2ZNhC8EWCMo6BKBQlvhKyfaKevNKyiRrG+c6y742f6+p6m9oucGlgik
	PZefRB9N7pr/UuoXo1XWjtAUqV3s7tiAiJ9RYnumNEogqcsUadwiSTPCD409hJFS
	PmkRF8r7zD41+WYdxE9Nbla10xjiAa/68RyRZ7XSo30de1J25sEPOp1B0rFbqD5b
	Vzgn0B1dYp8zIX5UrmdI8uy4tvZD6MraYWwQAo2b4v8sYp7A7xzw4opdfe9JQccs
	14Jy5JQI7Ge2RQ8aOuYLMw3oLK8MqXKY4lrlwxT7QYwz/xgqWDgoBdKytCr2A4BA
	==
X-ME-Sender: <xms:O2toXZsA-Q204ORw6Jo1Z4nkTjXfXu21dg5a7wFDSEyEv4i7ZhHtRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudeifedgfedtucetufdoteggodetrfdotf
	fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
	uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
	cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdetnhgu
	rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuffhomh
	grihhnpehgihhthhhusgdrtghomhenucfrrghrrghmpehmrghilhhfrhhomheprghnughr
	vgifsegrjhdrihgurdgruhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:O2toXZTplEatzC3bJsZjfNmU-23eUVvnJA9O5EPPUiir8to8hsIN5Q>
	<xmx:O2toXVsCQGGGrgOi1HnbB_sr_QdT5zffzZXvLCk01exmr_RNwdG_Aw>
	<xmx:O2toXTCORBjcJ-O3jEIF9nusV02BWB4resgEZMUKzeSYqgNk1UdGUA>
	<xmx:PGtoXTuwaSa9tl6u-ri6KCrmbJy-WDE3JuUEgrmZMIHV_bs5UX9NeA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C6D4FE00A3; Thu, 29 Aug 2019 20:18:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-154-gfa7592a-fmstable-20190829v1
Mime-Version: 1.0
Message-Id: <0a78764d-8b0e-4c41-9c33-dc48fe5cfcde@www.fastmail.com>
In-Reply-To: <8c839340-36e8-1c42-a242-9c9eb8720147@windriver.com>
References: <20190827000358.25777-1-andrew@aj.id.au>
	<a0279d01-3d06-3648-f63c-9392be141397@windriver.com>
	<2e4b0f4a-8288-490a-8bc2-7d49f460487e@www.fastmail.com>
	<8c839340-36e8-1c42-a242-9c9eb8720147@windriver.com>
Date: Fri, 30 Aug 2019 09:48:25 +0930
From: "Andrew Jeffery" <andrew@aj.id.au>
To: "Mark Hatle" <mark.hatle@windriver.com>,
	bitbake-devel@lists.openembedded.org
Cc: Brad Bishop <bradleyb@fuzziesquirrel.com>, ojayanth@in.ibm.com
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
X-List-Received-Date: Fri, 30 Aug 2019 00:18:03 -0000
Content-Type: text/plain



On Thu, 29 Aug 2019, at 01:02, Mark Hatle wrote:
> On 8/28/19 9:38 AM, Andrew Jeffery wrote:
> > Hi Mark,
> > 
> > On Wed, 28 Aug 2019, at 23:30, Mark Hatle wrote:
> >> On 8/26/19 7:03 PM, Andrew Jeffery wrote:
> >>> There exist some use-cases where repositories related by submodules do
> >>> not require submodules be recursively initialised despite needing the
> >>> first layer of submodules to be fetched. Enable this usecase in gitsm by
> >>> implementing a `recurse=X` SRC_URI parameter. The current implementation
> >>> of the recurse parameter defaults to enabling exhaustive recursion to
> >>> match the current behaviour of gitsm, with the one alternative being no
> >>> recursion. Enough rope is provided to allow specific recursion depths to
> >>> be implemented if necessary via the same interface. Values currently
> >>> unsupported for the recurse parameter raise a ValueError to ensure
> >>> forward compatibility.
> >>
> >> I was thinking about this patch and I'm not sure it's needed.  There are ways to
> >> do this without using gitsm.
> >>
> >> If you don't want recursion, then why are you specifying 'gitsm' at all? 
> > 
> > As far as I'm aware the git fetcher doesn't handle submodules at all. If I
> > have a misunderstanding there and this patch is unnecessary then that's
> > excellent, because I hate it :D
> 
> Yes, that is the point.  Since it doesn't handle submodules, there it won't
> recurse and you are fine.
> 
> For example:
> 
> SRC_URI =
> "gitsm://github.com/bus1/dbus-broker;protocol=git;rev=fc874afa0992d0c75ec25acb43d344679f0ee7d2"
> 
> This will result in the following submodules:
> 
> > Submodule 'edgelet/hsm-sys/azure-iot-hsm-c/deps/azure-c-shared-utility' (https://github.com/Azure/azure-c-shared-utility.git) registered for path 'edgelet/hsm-sys/azure-iot-hsm-c/deps/c-shared'
> > Submodule 'edgelet/hsm-sys/azure-iot-hsm-c/deps/azure-utpm-c' (https://github.com/Azure/azure-utpm-c.git) registered for path 'edgelet/hsm-sys/azure-iot-hsm-c/deps/utpm'
> > Submodule 'testtools/ctest' (https://github.com/Azure/azure-ctest.git) registered for path 'testtools/ctest'
> > Submodule 'testtools/testrunner' (https://github.com/Azure/azure-c-testrunnerswitcher.git) registered for path 'testtools/testrunner'
> > Submodule 'testtools/umock-c' (https://github.com/Azure/umock-c.git) registered for path 'testtools/umock-c'
> > Submodule 'deps/azure-ctest' (https://github.com/Azure/azure-ctest.git) registered for path 'deps/ctest'
> > Submodule 'deps/testrunner' (https://github.com/Azure/azure-c-testrunnerswitcher.git) registered for path 'deps/testrunner'
> > Submodule 'deps/c-utility' (https://github.com/Azure/azure-c-shared-utility.git) registered for path 'deps/c-utility'
> > Submodule 'testtools/ctest' (https://github.com/Azure/azure-ctest.git) registered for path 'testtools/ctest'
> > Submodule 'testtools/testrunner' (https://github.com/Azure/azure-c-testrunnerswitcher.git) registered for path 'testtools/testrunner'
> > Submodule 'testtools/umock-c' (https://github.com/Azure/umock-c.git) registered for path 'testtools/umock-c'
> > Submodule 'deps/azure-ctest' (https://github.com/Azure/azure-ctest.git) registered for path 'deps/ctest'
> > Submodule 'deps/testrunner' (https://github.com/Azure/azure-c-testrunnerswitcher.git) registered for path 'deps/testrunner'
> 
> With the following commits:
> 
> > Submodule path 'edgelet/hsm-sys/azure-iot-hsm-c/deps/c-shared': checked out '4deb950a4154e9baa39c87d75dd323dd58e239b7'
> > Submodule path 'edgelet/hsm-sys/azure-iot-hsm-c/deps/c-shared/testtools/ctest': checked out 'b1d09aff8212f1fb62ca9d6014cb3509d8b5559a'
> > Submodule path 'edgelet/hsm-sys/azure-iot-hsm-c/deps/c-shared/testtools/testrunner': checked out '721daafd8c34616f77a7697210470c0227dca20b'
> > Submodule path 'edgelet/hsm-sys/azure-iot-hsm-c/deps/c-shared/testtools/umock-c': checked out 'c2c0f18d785ba85fef213302266f520c64201bb1'
> > Submodule path 'edgelet/hsm-sys/azure-iot-hsm-c/deps/c-shared/testtools/umock-c/deps/ctest': checked out 'b1d09aff8212f1fb62ca9d6014cb3509d8b5559a'
> > Submodule path 'edgelet/hsm-sys/azure-iot-hsm-c/deps/c-shared/testtools/umock-c/deps/testrunner': checked out '721daafd8c34616f77a7697210470c0227dca20b'
> > Submodule path 'edgelet/hsm-sys/azure-iot-hsm-c/deps/utpm': checked out 'a82e758bfcea806167e19d9dd94c2e1cc223aaee'
> > Submodule path 'edgelet/hsm-sys/azure-iot-hsm-c/deps/utpm/deps/c-utility': checked out '4deb950a4154e9baa39c87d75dd323dd58e239b7'
> > Submodule path 'edgelet/hsm-sys/azure-iot-hsm-c/deps/utpm/deps/c-utility/testtools/ctest': checked out 'b1d09aff8212f1fb62ca9d6014cb3509d8b5559a'
> > Submodule path 'edgelet/hsm-sys/azure-iot-hsm-c/deps/utpm/deps/c-utility/testtools/testrunner': checked out '721daafd8c34616f77a7697210470c0227dca20b'
> > Submodule path 'edgelet/hsm-sys/azure-iot-hsm-c/deps/utpm/deps/c-utility/testtools/umock-c': checked out 'c2c0f18d785ba85fef213302266f520c64201bb1'
> > Submodule path 'edgelet/hsm-sys/azure-iot-hsm-c/deps/utpm/deps/c-utility/testtools/umock-c/deps/ctest': checked out 'b1d09aff8212f1fb62ca9d6014cb3509d8b5559a'
> > Submodule path 'edgelet/hsm-sys/azure-iot-hsm-c/deps/utpm/deps/c-utility/testtools/umock-c/deps/testrunner': checked out '721daafd8c34616f77a7697210470c0227dca20b'
> 
> If we clone this WITHOUT gitsm, it would be done as, and only want a subset, we
> could do:
> 
> > 
> > SRC_URI = "git://github.com/bus1/dbus-broker;protocol=git;rev=fc874afa0992d0c75ec25acb43d344679f0ee7d2 \
> >            git://github.com/Azure/azure-c-shared-utility.git;protocol=git;subpath=edgelet/hsm-sys/azure-iot-hsm-c/deps/c-shared;rev=4deb950a4154e9baa39c87d75dd323dd58e239b7 \
> >            "
> 

Makes sense, and I'm pleased we don't need my patch in the end.

Thanks for your help,

Andrew

