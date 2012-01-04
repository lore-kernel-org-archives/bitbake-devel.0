Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RiRjn-0000Dj-US for bitbake-devel@lists.openembedded.org;
	Wed, 04 Jan 2012 15:22:44 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q04EFMbo019577;
	Wed, 4 Jan 2012 14:15:22 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 18593-08; Wed,  4 Jan 2012 14:15:18 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q04EFER9019571
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 4 Jan 2012 14:15:15 GMT
Message-ID: <1325686513.20759.1.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Date: Wed, 04 Jan 2012 14:15:13 +0000
In-Reply-To: <1325169252-7588-1-git-send-email-paul.eggleton@linux.intel.com>
References: <1325169252-7588-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bitbake-layers: fix Python error during parse
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
X-List-Received-Date: Wed, 04 Jan 2012 14:22:44 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2011-12-29 at 14:34 +0000, Paul Eggleton wrote:
> If "bitbake-layers show_layers" was run when the cache was dirty forcing
> a parse, it failed with the following error:
> 
> ERROR: Failure expanding variable SRCPV, expression was
> ${@bb.fetch2.get_srcrev(d)} which triggered exception AttributeError:
> 'module' object has no attribute 'fetch2'
> 
> A simple import of bb.fetch2 in bitbake-layers fixes this.
> 
> Fixes [YOCTO #1855].
> 
> Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>

Merged to master, thanks.

Richard



