Return-Path: <paul@betafive.co.uk>
X-Greylist: delayed 324 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 28 May 2019 09:26:05 UTC
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
	[66.111.4.28])
	by mail.openembedded.org (Postfix) with ESMTP id DD0557DEA7
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 May 2019 09:26:05 +0000 (UTC)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id DC3B22229F;
	Tue, 28 May 2019 05:20:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
	by compute1.internal (MEProxy); Tue, 28 May 2019 05:20:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=betafive.co.uk;
	h=subject:to:references:from:message-id:date:mime-version
	:in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=A
	qa3+tn/T2I3IEF3crlhmlvMz1ltj7dHL1oCvbcc3UM=; b=PrmetqoLcHcW5CPNj
	oBBl2DZ6TE5LM56XYzG3ohfJ57eJpcVHZpsYZ77SDJm5+p4WOJa2b8x5ucV1DwxO
	EC6UbrPJ9jek2HbRh6kpZNDbhxfbQfZFZGMBkXwrzORm96GfLkE0a52fgUGIovRp
	6Y+EJ6AO8PuQOCi4kqWLID9+Ju4gzUDmQmIUVU8gLu4e44uYI0mNK8vzm4dnkPDF
	4PXOI2misK6rwGzecuAjwflcxOt7nFli0CwJV7OBB2r6MS9Fpb4WSAvzDYLK8+Jj
	dNGif7qcr/fo7CXsFnWUk/Huev3tIO+orSgEUDeGD9Q9kaKihUpZiw3M0shntAGr
	viJpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; bh=Aqa3+tn/T2I3IEF3crlhmlvMz1ltj7dHL1oCvbcc3
	UM=; b=wQ+V6p5bkPIog4bQ6SDYsFNqmEphw5NyN9TJfl83YUsLgjAfvE+x6HgJc
	YDbxfyAnDJ+8ldj1JCWdzuWbBIQfWcY0wE5H+b4YbNtnn0q/FaBaBBKM9WGPVo58
	u2I4pN/SEpmO3PCxVmErmV1yCuvLEC6+sJIcAwx2FoCW4eXO5fMM+oy+rfQa9iPT
	cTMVLr4LwZBX4+Nb/dVLT6rIsmK/TxWVGSXIwfKL4GoQB4AEzOkUOz3H2C1ON7TR
	miExAMb7ITqY4ln0iqeCIyTVuEYv3WmPmOX4imNa319eY0y6weM1GnDXQarcWRx3
	71iFfifJaafkVxmG2u27xkcc41qDA==
X-ME-Sender: <xms:af3sXGAyB9EbxYXcYyiYX2liaw_xlPky4zE2s_ASVxULCaj6GM4ZDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddruddvhedgudehucetufdoteggodetrfdotf
	fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
	uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
	cujfgurhepuffvfhfhohfkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefrrghu
	lhcuuegrrhhkvghruceophgruhhlsegsvghtrghfihhvvgdrtghordhukheqnecuffhomh
	grihhnpehgihhthhhusgdrtghomhenucfkphepkedurddukeejrdefvddrudefkeenucfr
	rghrrghmpehmrghilhhfrhhomhepphgruhhlsegsvghtrghfihhvvgdrtghordhukhenuc
	evlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:af3sXEyo98gdmY1kn8nk9uP8qNCdS6FvZDCLSRkMUejh0I7eFYD9FA>
	<xmx:af3sXEndYeLMlY85mA-haF2TzpmYX43abvKGRc0at6toiYCd52nuyw>
	<xmx:af3sXJHXxaz2xsjfU64IUcz4XqM9hHupQ2q3OmD0haQZRF-eP8D0Zw>
	<xmx:af3sXDM8vDO_m-_UGGxtgsXRaj4Ma4I0ddnknqm8kXgjzXIfMFJocQ>
Received: from [192.168.1.120] (138.32.187.81.in-addr.arpa [81.187.32.138])
	by mail.messagingengine.com (Postfix) with ESMTPA id 904288005C;
	Tue, 28 May 2019 05:20:40 -0400 (EDT)
To: Schneider Oliver <O.Schneider@precitec-optronik.de>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
References: <58a1f0cc-7bb8-9b35-7142-23d95537cdf8@precitec-optronik.de>
From: Paul Barker <paul@betafive.co.uk>
Organization: Beta Five Ltd
Message-ID: <be4f1c5d-d00a-92f8-2b67-be969f325871@betafive.co.uk>
Date: Tue, 28 May 2019 10:20:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <58a1f0cc-7bb8-9b35-7142-23d95537cdf8@precitec-optronik.de>
Subject: Re: Typo in main.py
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
X-List-Received-Date: Tue, 28 May 2019 09:26:06 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 27/05/2019 11:27, Schneider Oliver wrote:
> Hi,
> 
> just stumbled over this because I had copied/pasted the variable name
> from the error output to my invocation.
> 
> https://github.com/openembedded/bitbake/blob/master/lib/bb/main.py#L494
> 
> A cursory look over the code base seems to suggest that BBPATH is
> incorrectly spelled as BBAPTH.
> 

Are you able to send a patch for this? Seems like a simple change to make.

-- 
Paul Barker
Managing Director & Principal Engineer
Beta Five Ltd

