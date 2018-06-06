Return-Path: <pb@pbcl.net>
X-Greylist: delayed 1151 seconds by postgrey-1.34 at layers.openembedded.org;
	Wed, 06 Jun 2018 23:03:59 UTC
Received: from mail.pbcl.net (mail.pbcl.net [88.198.119.4])
	by mail.openembedded.org (Postfix) with ESMTP id 666B677028
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Jun 2018 23:03:59 +0000 (UTC)
Received: from blundell.swaffham-prior.co.uk ([91.216.112.25] helo=tp13)
	by mail.pbcl.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.87) (envelope-from <pb@pbcl.net>)
	id 1fQhAc-0000F9-Jo; Thu, 07 Jun 2018 00:44:48 +0200
Message-ID: <1528325084.5982.1.camel@pbcl.net>
From: Phil Blundell <pb@pbcl.net>
To: Andre McCurdy <armccurdy@gmail.com>, bitbake-devel
	<bitbake-devel@lists.openembedded.org>
Date: Wed, 06 Jun 2018 23:44:44 +0100
In-Reply-To: <CAJ86T=U2s_uFMpc4ZwicFaixqfHo5ABMyKbbrU4XKtHV6-gwMQ@mail.gmail.com>
References: <CAJ86T=U2s_uFMpc4ZwicFaixqfHo5ABMyKbbrU4XKtHV6-gwMQ@mail.gmail.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Subject: Re: expand after getVar
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
X-List-Received-Date: Wed, 06 Jun 2018 23:03:59 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Wed, 2018-06-06 at 14:53 -0700, Andre McCurdy wrote:
> Is the following expression from trusted_network():
> 
>   d.expand(d.getVar('PN', False))
> 
> completely equivalent to:
> 
>   d.getVar('PN")
> 
> or is there something subtle going on?

I suspect that expression started out as d.expand(d.getVar('PN')) when
getVar() had expand=False by default, and it gained the explicit False
through some mechanical transformation at a later date when the default
was removed.  So yes, nowadays it's just equivalent to getVar().

There's probably more of this stuff in there.

p.


