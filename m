Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SX8zW-0004sT-5D for bitbake-devel@lists.openembedded.org;
	Wed, 23 May 2012 12:40:30 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4NAUKEn011296;
	Wed, 23 May 2012 11:30:20 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 10563-08; Wed, 23 May 2012 11:30:15 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4NAUDlU011290
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 23 May 2012 11:30:14 +0100
Message-ID: <1337769012.8248.59.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Date: Wed, 23 May 2012 11:30:12 +0100
In-Reply-To: <1337527151-3526-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
References: <1337527151-3526-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bitbake: support $BITBAKE_UI environment
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
X-List-Received-Date: Wed, 23 May 2012 10:40:30 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2012-05-20 at 17:19 +0200, Enrico Scholz wrote:
> Patch adds support for a $BITBAKE_UI environment variable which allows
> to configure the preferred user interface. Although an '-u' option
> (which will override the environment variable) exists already, it was
> required to specify this option on every invocation of bitbake.
> 
> Because user interface is instanciated very early in the program it is
> not possible to use bitbake.conf for setting up a default.  An
> environment variable (which acts in a similar category like $PAGER or
> $EDITOR) is a simple way for configuring the default.
> 
> Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
> ---
>  bin/bitbake   |    9 +++++----
>  doc/bitbake.1 |    6 ++++++
>  2 files changed, 11 insertions(+), 4 deletions(-)

Merged to master, thanks.

Richard



