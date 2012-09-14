Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TCRRw-0006wS-Eu for bitbake-devel@lists.openembedded.org;
	Fri, 14 Sep 2012 10:40:32 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8E8RuAT007706;
	Fri, 14 Sep 2012 09:27:56 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 05870-07; Fri, 14 Sep 2012 09:27:48 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8E8RiNZ007679
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 14 Sep 2012 09:27:45 +0100
Message-ID: <1347611266.9456.2.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Date: Fri, 14 Sep 2012 09:27:46 +0100
In-Reply-To: <cover.1347382193.git.paul.eggleton@linux.intel.com>
References: <cover.1347382193.git.paul.eggleton@linux.intel.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/3] More Hob fixes
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
X-List-Received-Date: Fri, 14 Sep 2012 08:40:32 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2012-09-11 at 17:51 +0100, Paul Eggleton wrote:
> The following changes (against Poky, but apply cleanly with -p2 against
> bitbake master) are available in the git repository at:
> 
>   git://git.yoctoproject.org/poky-contrib paule/hob-fixes
>   http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/hob-fixes
> 
> Paul Eggleton (3):
>   hob: don't reorder layers list
>   lib/bb/command.py: ensure setVariable only sets values as strings
>   hob: sort base image drop-down list

Merged to master, thanks.

We should keep in mind the strong coercion issue for future improvements
but I'm not going to hold the setVariable patch on that.


Richard



