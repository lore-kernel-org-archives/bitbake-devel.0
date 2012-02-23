Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1S0aEe-00037b-Oi for bitbake-devel@lists.openembedded.org;
	Thu, 23 Feb 2012 16:05:32 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1NEvADI012945;
	Thu, 23 Feb 2012 14:57:10 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 12845-01; Thu, 23 Feb 2012 14:57:05 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1NEv2iP012939
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 23 Feb 2012 14:57:04 GMT
Message-ID: <1330009022.32110.61.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Lianhao Lu <lianhao.lu@intel.com>
Date: Thu, 23 Feb 2012 14:57:02 +0000
In-Reply-To: <cover.1329986451.git.lianhao.lu@intel.com>
References: <cover.1329986451.git.lianhao.lu@intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/1] Add new option --environment-more
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
X-List-Received-Date: Thu, 23 Feb 2012 15:05:32 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-02-23 at 16:49 +0800, Lianhao Lu wrote:
> This patch adds a new option --environment-more to bitbake to display 
> additional file dependency information. This kind of information can be used 
> by other recipe editors, e.g. the Eclipse bitbake commander plugin, to decide 
> when to reparse the recipes.
> 
> The following changes since commit d8b3718303c3d56394c722059f1a73bd79131d0a:
>   Zhai Edwin (1):
>         texi2html: Fix for multilib
> 
> are available in the git repository at:
> 
>   git://git.pokylinux.org/poky-contrib llu/bitbake_showmore
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=llu/bitbake_showmore
> 
> Lianhao Lu (1):
>   bitbake: Add new otpion --environment-more

Rather than add a new option specifically for this, I'm tempted just to
add the variables to the -e output...

The trouble is that variables starting "__" are considered internal use
by bitbake. Would it work if we merge __base_depends and __depends and
print this as some specific variable like BBINCLUDES ? I can imagine
that being useful elsewhere too and we don't expose the internal split
of the variable that way...

Cheers,

Richard



