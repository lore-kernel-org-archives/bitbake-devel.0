Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TYIXg-00047f-8d for bitbake-devel@lists.openembedded.org;
	Tue, 13 Nov 2012 16:36:48 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qADFMqBh005129;
	Tue, 13 Nov 2012 15:22:52 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 04745-03; Tue, 13 Nov 2012 15:22:48 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qADFMjbn005123
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 13 Nov 2012 15:22:46 GMT
Message-ID: <1352820166.24487.136.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Seth Bollinger <seth.boll@gmail.com>
Date: Tue, 13 Nov 2012 15:22:46 +0000
In-Reply-To: <CA+JN8xOF_iVQb30NVdrXEtqieh0E6m2-tSE2uG6UiG+f9C6qHw@mail.gmail.com>
References: <CA+JN8xNzAvDdt4bgS=z536YciYVAvZGE2+Z=qQa1XP4HCE8=gg@mail.gmail.com>
	<1352816623.24487.128.camel@ted>
	<CA+JN8xOF_iVQb30NVdrXEtqieh0E6m2-tSE2uG6UiG+f9C6qHw@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
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
X-List-Received-Date: Tue, 13 Nov 2012 15:36:48 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2012-11-13 at 08:45 -0600, Seth Bollinger wrote:
> I'm not sure how best to resolve this.  Would you like me to add some
> code to try and detect background color?  This seems like it might be
> more complex than it's worth...
>
> Or would it be better to have a selectable light background color
> set?  If you think light background is more common (I dislike staring
> at large blocks of white :)) it could default to the light color set.

I have not looked into this and am not an expert on terminals and colour
control of them. I don't know how we can solve this but the current
situation where it prints white on white on my terminal is clearly
unacceptable. This has to be a problem others have run into and solved
before though...

Cheers,

Richard






