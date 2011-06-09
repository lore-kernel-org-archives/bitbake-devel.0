Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1QUiqj-0006DT-Nz for bitbake-devel@lists.openembedded.org;
	Thu, 09 Jun 2011 19:16:54 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p59HDTUW015694;
	Thu, 9 Jun 2011 18:13:29 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 15230-07; Thu,  9 Jun 2011 18:13:25 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p59HDN23015688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 9 Jun 2011 18:13:24 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1307636663.git.paul.eggleton@linux.intel.com>
References: <cover.1307636663.git.paul.eggleton@linux.intel.com>
Date: Thu, 09 Jun 2011 18:13:14 +0100
Message-ID: <1307639594.15712.170.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/2] skipped recipe handling v2
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
X-List-Received-Date: Thu, 09 Jun 2011 17:16:54 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2011-06-09 at 17:42 +0100, Paul Eggleton wrote:
> For the description of this changeset please see the original mail:
> http://lists.linuxtogo.org/pipermail/bitbake-devel/2011-June/000911.html
> 
> Changes since v1: rebased against recent bitbake changes, added a cache
> version bump.
> 
> These patches are against Poky but they apply cleanly with -p2 against 
> bitbake master. They are also available in the git repository at:
>   git://git.pokylinux.org/poky-contrib paule/skippackage
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=paule/skippackage
> 
> Paul Eggleton (2):
>   bitbake: track skipped packages
>   bitbake-layers: handle skipped recipes

Merged to master, thanks.

Richard



