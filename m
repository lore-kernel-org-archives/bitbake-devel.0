Return-Path: <tanuk@iki.fi>
X-Greylist: delayed 306 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 03 Mar 2020 08:01:41 UTC
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25])
	by mail.openembedded.org (Postfix) with ESMTP id BD5D261890
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  3 Mar 2020 08:01:41 +0000 (UTC)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id BE41B21F34;
	Tue,  3 Mar 2020 02:56:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
	by compute2.internal (MEProxy); Tue, 03 Mar 2020 02:56:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; bh=9Phleqets2ep9D010fnzSH4y0gGe4UKLs8Y3UQN2d
	J4=; b=NXmut9zUKT2wBfXnnFzCNkz6GGLEJOIYHih3XMp2KmpxnJe+UQ6tmE0PU
	uJacDGTrLNMrWIk4bGyl3EeNaezpySHL8vMPkShYqqrXqr7YynEeVwV/bQ3gS2Ps
	UIft+0mdSZ80e8kV6y+cPNa7fIkP18br0l822rfWdWP44kW4hBzNqRPhCpyjxfQT
	4i8cMTo/7KzAwHCFQI2aLB9l3A0thRPvUkLST61oR/Sue9tLmhBt/EeYYtQhxYW0
	OSQ/EDBWmWfnuKV3wTpIjV0DXztrK8QVTzJ+0GFlcYk2WCa2bSspIKsXwax4h3on
	pyrswtqDo2t20puZZ4Tk2gK3lb+eA==
X-ME-Sender: <xms:sg1eXtGbLyG4TZJp-iuro2SQAFdNSEBgV8x3ESoTUCY7aQ8eKNSvCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddthedgudduvdcutefuodetggdotefrod
	ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
	necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
	enucfjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefvrghn
	uhcumfgrshhkihhnvghnuceothgrnhhukhesihhkihdrfhhiqeenucffohhmrghinhepph
	grthhrvghonhdrtghomhdplhhisggvrhgrphgrhidrtghomhenucfkphepudeliedrvdeg
	gedrudeluddrheeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
	hfrhhomhepthgrnhhukhesihhkihdrfhhi
X-ME-Proxy: <xmx:sg1eXgfI4G1tajxIPW2bId2uHjOzo--X0KpM6YYfKaKRxFIX0pBmwQ>
	<xmx:sg1eXpvM1uxRGprHrHjH02SDCy40RzN1X_FbsHsCAH-ZkNzrOmsjJA>
	<xmx:sg1eXnl20GXqh147jYDY_rh3ZdiYLeKH6PHTRth3jQDjyH0Z-kiYoA>
	<xmx:sg1eXhzoFRpFwgq6OkLG4LjY_aCA0GQ2tu4IZc0bcjVODx44gRvyKQ>
Received: from laptop (unknown [196.244.191.58])
	by mail.messagingengine.com (Postfix) with ESMTPA id E116F3280059;
	Tue,  3 Mar 2020 02:56:33 -0500 (EST)
Message-ID: <736799570e22f93fdea25f2fb0ecb129dacd5760.camel@iki.fi>
From: Tanu Kaskinen <tanuk@iki.fi>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel@lists.openembedded.org
Date: Tue, 03 Mar 2020 09:56:29 +0200
In-Reply-To: <20200229161633.496077-1-richard.purdie@linuxfoundation.org>
References: <20200229161633.496077-1-richard.purdie@linuxfoundation.org>
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Subject: Re: [PATCH] fetch2: Limit shown checksums to sha256
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
X-List-Received-Date: Tue, 03 Mar 2020 08:01:41 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sat, 2020-02-29 at 16:16 +0000, Richard Purdie wrote:
> Currently bitbake will list many checksums for a recipe when none are
> present, encouraging users to add them all to a recipe. We don't
> need/want them all.
> 
> We used to show md5 and sha256 but given the concerns about md5,
> switch to showing just sha256 going forward which seems like the
> sensible one to standardise upon.

Should this be interpreted so that going forward, it's recommended to
drop the md5 checksums from recipes when doing version upgrades?

-- 
Tanu

https://www.patreon.com/tanuk
https://liberapay.com/tanuk


