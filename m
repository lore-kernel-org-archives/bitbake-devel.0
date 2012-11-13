Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TYHcY-0002Rf-Ow for bitbake-devel@lists.openembedded.org;
	Tue, 13 Nov 2012 15:37:48 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qADENpV3004539;
	Tue, 13 Nov 2012 14:23:51 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 04019-07; Tue, 13 Nov 2012 14:23:47 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qADENgwY004533
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 13 Nov 2012 14:23:43 GMT
Message-ID: <1352816623.24487.128.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Seth Bollinger <seth.boll@gmail.com>
Date: Tue, 13 Nov 2012 14:23:43 +0000
In-Reply-To: <CA+JN8xNzAvDdt4bgS=z536YciYVAvZGE2+Z=qQa1XP4HCE8=gg@mail.gmail.com>
References: <CA+JN8xNzAvDdt4bgS=z536YciYVAvZGE2+Z=qQa1XP4HCE8=gg@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH v2] bitbake: Colorize knotty interactive console output
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
X-List-Received-Date: Tue, 13 Nov 2012 14:37:48 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2012-11-11 at 09:17 -0600, Seth Bollinger wrote:
> Add bold color output to log level name and standard color output to
> log msg
> when bitbake is run from an iteractive console.  Color output is only
> enabled
> if the terminal supports color.
>
> Signed-off-by: Seth Bollinger <seth.boll@gmail.com>
> ---
>  bitbake/lib/bb/msg.py       |   40
> ++++++++++++++++++++++++++++++++++++++++
>  bitbake/lib/bb/ui/knotty.py |    6 +++++-
>  2 files changed, 45 insertions(+), 1 deletions(-)

I love the idea. I tried testing it and realised that it doesn't work in
my black text on a white background terminals though, the result of the
patch was unreadable :(

Cheers,

Richard




