Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SouZX-0004OM-9c for bitbake-devel@lists.openembedded.org;
	Wed, 11 Jul 2012 12:55:07 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q6BAhtub002975;
	Wed, 11 Jul 2012 11:43:55 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 02807-03; Wed, 11 Jul 2012 11:43:51 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q6BAhnVF002969
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 11 Jul 2012 11:43:50 +0100
Message-ID: <1342003430.7934.7.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Andrei Gherzan <andrei@gherzan.ro>
Date: Wed, 11 Jul 2012 11:43:50 +0100
In-Reply-To: <cover.1341955881.git.andrei@gherzan.ro>
References: <cover.1341955881.git.andrei@gherzan.ro>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH-V2 0/5] Warn user if "param" is used in SRC_URI
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
X-List-Received-Date: Wed, 11 Jul 2012 10:55:07 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-07-11 at 00:34 +0300, Andrei Gherzan wrote:
> The following changes since commit 90ad663909c0c8a405b22a510c9f957007d02669:
> 
>   upstream_tracking: update boost (2012-07-09 17:21:38 +0100)
> 
> are available in the git repository at:
> 
>   git://git.yoctoproject.org/poky-contrib ag/protocol
>   http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=ag/protocol
> 
> Andrei Gherzan (5):
>   fetch2/svn.py: Use "protocol" parameter to get the protocol
>   fetch2/osc.py: Use "protocol" parameter to get the protocol
>   fetch2/hg.py: Use "protocol" parameter to get the protocol
>   fetch2/bzr.py: Use "protocol" parameter to get the protocol
>   fetch2/__init__.py: Warn user if SRC_URI is using "proto" and not
>     "protocol"

Merged to master, thanks.

Richard



