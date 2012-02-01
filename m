Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Rsbwc-0007VN-JC for bitbake-devel@lists.openembedded.org;
	Wed, 01 Feb 2012 16:17:58 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q11FA2M1023241;
	Wed, 1 Feb 2012 15:10:02 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 22819-05; Wed,  1 Feb 2012 15:09:54 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q11F9nTK023226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 1 Feb 2012 15:09:51 GMT
Message-ID: <1328108992.13744.73.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Lianhao Lu <lianhao.lu@intel.com>
Date: Wed, 01 Feb 2012 15:09:52 +0000
In-Reply-To: <cover.1327990542.git.lianhao.lu@intel.com>
References: <cover.1327990542.git.lianhao.lu@intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/1] bitbake: fix bug #1492
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
X-List-Received-Date: Wed, 01 Feb 2012 15:17:58 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2012-01-31 at 14:18 +0800, Lianhao Lu wrote:
> The following changes since commit 636d7e308fefe7cca67166d564c3a8f877f2ca86:
>   Richard Purdie (1):
>         useradd.bbclass: Fix missing quote
> 
> are available in the git repository at:
> 
>   git://git.pokylinux.org/poky-contrib llu/bug1942
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=llu/bug1942
> 
> Lianhao Lu (1):
>   prserv: Do not ping PRService if not required

Merged to master, thanks.

Richard



