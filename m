Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1S0ItM-0006Os-MD for bitbake-devel@lists.openembedded.org;
	Wed, 22 Feb 2012 21:34:25 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1MKQ3sJ001010;
	Wed, 22 Feb 2012 20:26:03 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 32559-05; Wed, 22 Feb 2012 20:25:58 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1MKPuSN001003
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 22 Feb 2012 20:25:57 GMT
Message-ID: <1329942356.32110.10.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Date: Wed, 22 Feb 2012 20:25:56 +0000
In-Reply-To: <cover.1329133148.git.paul.eggleton@linux.intel.com>
References: <cover.1329133148.git.paul.eggleton@linux.intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/3] bitbake error fixes
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
X-List-Received-Date: Wed, 22 Feb 2012 20:34:25 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2012-02-13 at 11:41 +0000, Paul Eggleton wrote:
> The following changes (against Poky, but apply cleanly with -p2 against
> bitbake master) are available in the git repository at:
>   git://git.yoctoproject.org/poky-contrib paule/bberrors1
>   http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bberrors1
> 
> Paul Eggleton (3):
>   bitbake: show appropriate warnings for universe target
>   bitbake/knotty: ensure we return non-zero exit code on Ctrl+C
>   bitbake/knotty: ensure CommandFailed increases error count
> 

Merged to master, thanks.

Richard



