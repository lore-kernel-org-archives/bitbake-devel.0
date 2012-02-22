Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1S0JuB-0000D5-6M for bitbake-devel@lists.openembedded.org;
	Wed, 22 Feb 2012 22:39:19 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1MLUuma001792;
	Wed, 22 Feb 2012 21:30:56 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 01655-02; Wed, 22 Feb 2012 21:30:52 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1MLUkqs001786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 22 Feb 2012 21:30:47 GMT
Message-ID: <1329946247.32110.22.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Date: Wed, 22 Feb 2012 21:30:47 +0000
In-Reply-To: <cover.1329945681.git.paul.eggleton@linux.intel.com>
References: <cover.1329945681.git.paul.eggleton@linux.intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/1] fix incorrect exit code
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
X-List-Received-Date: Wed, 22 Feb 2012 21:39:19 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-02-22 at 21:24 +0000, Paul Eggleton wrote:
> Fixes a moderately serious regression caused by my recently merged
> Ctrl+C patch.
> 
> The patch (against poky, but applies cleanly against bitbake master with
> -p2) is available in the git repository at:
>   git://git.yoctoproject.org/poky-contrib paule/bitbake-shutdown-fix
>   http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bitbake-shutdown-fix
> 
> Paul Eggleton (1):
>   bitbake/ui/knotty: fix incorrect exit code

Merged to master, thanks.

Richard



