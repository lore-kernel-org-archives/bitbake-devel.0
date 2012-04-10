Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SHkEK-0000d8-QN for bitbake-devel@lists.openembedded.org;
	Wed, 11 Apr 2012 01:12:16 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q3AN2q9k001544;
	Wed, 11 Apr 2012 00:02:52 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 01063-09; Wed, 11 Apr 2012 00:02:48 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q3AN2g7v001538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 11 Apr 2012 00:02:43 +0100
Message-ID: <1334098961.10826.90.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>
Date: Wed, 11 Apr 2012 00:02:41 +0100
In-Reply-To: <cover.1333630624.git.liezhi.yang@windriver.com>
References: <cover.1333630624.git.liezhi.yang@windriver.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/1] diskspace monitor: assign a default value when only of the interval is set
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
X-List-Received-Date: Tue, 10 Apr 2012 23:12:18 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-04-05 at 20:58 +0800, Robert Yang wrote:
> The following changes since commit 5607729d9901c394b7cd4db6e38fe7fb19116f39:
> 
>   self-hosted-image: Increase space for build and allow builder user sudo access (2012-04-04 17:17:55 +0100)
> 
> are available in the git repository at:
>   git://git.pokylinux.org/poky-contrib robert/monitor
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=robert/monitor
> 
> Robert Yang (1):
>   diskspace monitor: assign a default value when only of the interval
>     is set

Merged to master, thanks.

Richard



