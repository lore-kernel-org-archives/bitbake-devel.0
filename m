Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Qbxva-0006kO-Pi for bitbake-devel@lists.openembedded.org;
	Wed, 29 Jun 2011 18:47:51 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p5TGFPmr005952;
	Wed, 29 Jun 2011 17:15:25 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 05442-08; Wed, 29 Jun 2011 17:15:17 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p5TGFDAd005935
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 29 Jun 2011 17:15:14 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Cui, Dexuan" <dexuan.cui@intel.com>
In-Reply-To: <1865303E0DED764181A9D882DEF65FB6A167F0C723@shsmsx502.ccr.corp.intel.com>
References: <cover.1308544082.git.dexuan.cui@intel.com>
	<BANLkTinCB95DBHinewz+A1a7BHiZJzV1Mg@mail.gmail.com>
	<1865303E0DED764181A9D882DEF65FB6997B5E7675@shsmsx502.ccr.corp.intel.com>
	<201106271406.45596.paul.eggleton@linux.intel.com>
	<1309264777.20015.280.camel@rex>
	<1865303E0DED764181A9D882DEF65FB6A167F0C723@shsmsx502.ccr.corp.intel.com>
Date: Wed, 29 Jun 2011 17:14:57 +0100
Message-ID: <1309364097.20015.414.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	'Martin Jansa' <martin.jansa@gmail.com>
Subject: Re: [PATCH 1/1] die if a .bbappend file matches no existing .bb recipe
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
X-List-Received-Date: Wed, 29 Jun 2011 16:47:51 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2011-06-30 at 00:03 +0800, Cui, Dexuan wrote:
> Sorry -- what's the conclusion?
> Keeping the v2 patch
> (http://git.pokylinux.org/cgit/cgit.cgi/poky-contrib/commit/?h=dcui/bb-v2&id=2a520959f71ec2cd80ed2088bfcf082631161a1a)
> , or changing bb.error() to bb.warn()?

Where you have:

  bb.error('No recipes available for:\n%s' % '\n'.join(appendlines))

this would become something like:

  msg = 'No recipes available for:\n%s' % '\n'.join(appendlines)
  if d.getVar("BB_DANGLINGAPPENDS_WARNONLY", False):
     bb.warn(msg)
  else:
     bb.fatal(msg)

which means we can have a strong default but advanced
users/distros/whoever can avoid this.

Cheers,

Richard



