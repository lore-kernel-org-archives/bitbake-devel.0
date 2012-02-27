Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1S1yOU-0006dv-09 for bitbake-devel@lists.openembedded.org;
	Mon, 27 Feb 2012 12:05:26 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1RAv0i5026078;
	Mon, 27 Feb 2012 10:57:00 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 22666-10; Mon, 27 Feb 2012 10:56:56 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1RAupQP026068
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 27 Feb 2012 10:56:52 GMT
Message-ID: <1330340212.4593.6.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Oren Leaffer <oren@ephemeron-labs.com>
Date: Mon, 27 Feb 2012 10:56:52 +0000
In-Reply-To: <CALvD2LjQx6M222rdd754cTZtx+fohvxC57+Efx3d=PF9YoNGXw@mail.gmail.com>
References: <CALvD2LjQx6M222rdd754cTZtx+fohvxC57+Efx3d=PF9YoNGXw@mail.gmail.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: getting started (well, trying to)
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
X-List-Received-Date: Mon, 27 Feb 2012 11:05:26 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2012-02-26 at 18:51 -0500, Oren Leaffer wrote:

> I'm sorry if this is the wrong list to direct this question, but I'm
> having a hard time getting bitbake/openembedded building anything.
>
> Right now, "bitbake nano" fails with the error "ERROR: Unable to
> parse /home/ol/openem/openembedded/recipes/wmiconfig/wmiconfig_svn.bb
> " and then gives some more details that are at the end of this
> message.
>
> What branch of bitbake and openembedded should I be on? I've been
> trying this all day and I can find several sets of mutually
> contradictory instructions, is there an authoritative one?
> 
I'd suggest using master from openembedded-core
(http://git.openembedded.org/openembedded-core/) with bitbake master
(http://git.openembedded.org/bitbake/).

Cheers,

Richard






