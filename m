Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SZlls-0005Ak-KN for bitbake-devel@lists.openembedded.org;
	Wed, 30 May 2012 18:29:17 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4UGIw3h023298;
	Wed, 30 May 2012 17:18:58 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 23236-01; Wed, 30 May 2012 17:18:54 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4UGImlb023292
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 30 May 2012 17:18:49 +0100
Message-ID: <1338394728.20169.153.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>
Date: Wed, 30 May 2012 17:18:48 +0100
In-Reply-To: <cover.1338367258.git.liezhi.yang@windriver.com>
References: <cover.1338367258.git.liezhi.yang@windriver.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: Re: [PATCH 0/1] HOB: 'str' object has no attribute 'close'
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
X-List-Received-Date: Wed, 30 May 2012 16:29:17 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-05-30 at 18:19 +0800, Robert Yang wrote:
> Hi Shane,
>   The "run qemu" and "deploy image" works correctly now, and doesn't hang.
> 
> // Robert
> 
> The following changes since commit f28209d9d3c67203a2c7a2b25cacfe31643d1bfa:
> 
>   cooker.py: terminate the Parser processes (2012-05-25 11:39:33 +0100)
> 
> are available in the git repository at:
>   git://git.pokylinux.org/poky-contrib robert/hob
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=robert/hob
> 
> Robert Yang (1):
>   HOB: 'str' object has no attribute 'close'

Merged to master, thanks.

Richard



