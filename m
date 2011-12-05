Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RXbKm-0006PQ-10 for bitbake-devel@lists.openembedded.org;
	Mon, 05 Dec 2011 17:24:04 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pB5GHGAA023935;
	Mon, 5 Dec 2011 16:17:16 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 23002-08; Mon,  5 Dec 2011 16:17:12 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pB5GH7v0023929
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 5 Dec 2011 16:17:08 GMT
Message-ID: <1323101838.25960.97.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>
Date: Mon, 05 Dec 2011 16:17:18 +0000
In-Reply-To: <cover.1322644797.git.liezhi.yang@windriver.com>
References: <cover.1322644797.git.liezhi.yang@windriver.com>
X-Mailer: Evolution 3.2.1- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/2] Remove a few unwanted lines
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
X-List-Received-Date: Mon, 05 Dec 2011 16:24:05 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2011-11-30 at 17:23 +0800, Robert Yang wrote:
> Remove a few unwanted lines, and the following test is OK:
> 
> $ bitbake core-image-sato
> 
> // Robert
> 
> The following changes since commit cf02474bda67f4f1043b2e95e1b371b2354585a7:
> 
>   qt-mobility: Add missing patch (2011-11-29 14:36:18 +0000)
> 
> are available in the git repository at:
>   git://git.pokylinux.org/poky-contrib robert/remove_unwanted
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=robert/remove_unwanted
> 
> Robert Yang (2):
>   Remove the duplicated assignments of self.configuration.cmd

This was some corruption in the Poky repository, I've merged it there,
thanks.

>   Remove the async_cmds and sync_cmds from command.py

and I merged this to master, thanks.

Richard




