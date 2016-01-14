Return-Path: <olof.johansson@axis.com>
X-Greylist: delayed 426 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 14 Jan 2016 17:14:59 UTC
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id 686196AC4B
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Jan 2016 17:14:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id DB0D22E167;
	Thu, 14 Jan 2016 18:07:53 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id WiaMD0Xu14PB; Thu, 14 Jan 2016 18:07:53 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bes.se.axis.com (Postfix) with ESMTP id F19D12E118;
	Thu, 14 Jan 2016 18:07:52 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id DA7B315E7;
	Thu, 14 Jan 2016 18:07:52 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id CE20B15E6;
	Thu, 14 Jan 2016 18:07:52 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by seth.se.axis.com (Postfix) with ESMTP id C79283E31B;
	Thu, 14 Jan 2016 18:07:52 +0100 (CET)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.3.342.0; Thu, 14 Jan 2016
	18:07:52 +0100
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id 82D8A9C724; 
	Thu, 14 Jan 2016 18:07:52 +0100 (CET)
Date: Thu, 14 Jan 2016 18:07:52 +0100
From: Olof Johansson <olof.johansson@axis.com>
To: Andre McCurdy <armccurdy@gmail.com>, Richard Purdie
	<richard.purdie@linuxfoundation.org>, bitbake-devel
	<bitbake-devel@lists.openembedded.org>
Message-ID: <20160114170752.GH31212@axis.com>
References: <1452172732.7598.114.camel@linuxfoundation.org>
	<CAJ86T=Xb6HHZm0BaqtGeCUknP1_dTy6t1L7LtZru9F+=j-BmSg@mail.gmail.com>
	<1452723582.28375.118.camel@linuxfoundation.org>
	<90f0d7cacc2743e58535b16f6fe316bd@XBOX02.axis.com>
	<1452785159.28375.135.camel@linuxfoundation.org>
	<CAJ86T=X9LU04NhjnaLtq+G7WSE6=9t2yiNF2MiuDrnn+M5exLQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJ86T=X9LU04NhjnaLtq+G7WSE6=9t2yiNF2MiuDrnn+M5exLQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: pkj@axis.com
Subject: Re: [PATCH] fetch/git: Change to use clearer ssh url syntax for broken servers
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
X-List-Received-Date: Thu, 14 Jan 2016 17:15:02 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On 16-01-14 08:51 -0800, Andre McCurdy wrote:
> > I'm not sure there is one other than special casing bitbucket urls in
> > the fetcher.
> 
> But I don't think there is any problem with BitBucket. The original
> bug report was caused by trying to use a URL with a ':' between the
> host and the repo path. A URL like that does not work when prefixed by
> ssh://, it's the same for GitHub URLs too.

Indeed, the reported URL is not an RFC 3986 comformant URI. While

  ssh://example.com:/username/project.git

would be a kind of valid URI (the RFC doesn't forbid having an
empty port, see section 3.2.3), not having a path delimiter at
all however is not allowed. And fixing this by breaking RFC
comformant use cases is very suprising to me.

-- 
olofjn

