Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RXbLL-0006SC-V6 for bitbake-devel@lists.openembedded.org;
	Mon, 05 Dec 2011 17:24:40 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pB5GHqGP023960;
	Mon, 5 Dec 2011 16:17:52 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 23002-09; Mon,  5 Dec 2011 16:17:47 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pB5GHiPj023954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 5 Dec 2011 16:17:45 GMT
Message-ID: <1323101875.25960.98.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Matthew McClintock <msm@freescale.com>
Date: Mon, 05 Dec 2011 16:17:55 +0000
In-Reply-To: <1322673895-25682-1-git-send-email-msm@freescale.com>
References: <1322673895-25682-1-git-send-email-msm@freescale.com>
X-Mailer: Evolution 3.2.1- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] siggen.py: If both sigs have a variable in it's whitelist then don't say it's changed
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
X-List-Received-Date: Mon, 05 Dec 2011 16:24:40 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2011-11-30 at 11:24 -0600, Matthew McClintock wrote:
> Some BB_HASHBASE_WHITELIST variables are in the lists of variable
> dependencies for signatures. Ignore those differences in lists
> since this difference does not matter
> 
> Signed-off-by: Matthew McClintock <msm@freescale.com>
> ---
> I'm seeing variables in BB_HASHBASE_WHITELIST make it
> to the signature. Not sure if they are used to calculate
> the hash but assuming they are not we don't need to print
> out that they are different
> 
>  lib/bb/siggen.py |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)

Merged to master, thanks.

Richard



