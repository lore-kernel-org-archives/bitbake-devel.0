Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 0503A6A91D
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Jun 2013 16:36:48 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r5HGgfAg007307; Mon, 17 Jun 2013 17:42:41 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id GBpYDjgAaECD; Mon, 17 Jun 2013 17:42:41 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r5HGgaG1007294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Mon, 17 Jun 2013 17:42:38 +0100
Message-ID: <1371486988.20823.112.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Olof Johansson <olof.johansson@axis.com>
Date: Mon, 17 Jun 2013 17:36:28 +0100
In-Reply-To: <20130614135545.GE13277@axis.com>
References: <1367918558-16136-1-git-send-email-olof.johansson@axis.com>
	<20130614135545.GE13277@axis.com>
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [WIP 0/2] Adding support for shell arithmetics
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 17 Jun 2013 16:36:49 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2013-06-14 at 15:55 +0200, Olof Johansson wrote:
> On 2013-05-07 11:22, Olof Johansson wrote:
> > Hi,
> > 
> > A week or so I found out that shell fragments in bitbake recipes
> > don't support shell arithmetics (`$((1+1))`). The reason for this
> > is the shell lexing throwing NotImplemented exceptions. I've made
> > some progress in adding support for shell arithmetics, but I have
> > a hard time getting support for corner cases.
> > 
> > It was suprising to see that currently, only a subset of posix
> > shell scripts is supported, even though they are sent through to
> > be executed by the system shell. I think I understand the reason
> > for having to do the shell lexing; knowing what functions and
> > variables to export right? But I wonder if it's possible to do
> > the shell lexing as a best effort, and ignore any errors.
> > 
> > What are the risks with this approach? Is it feasibile to do so?
> > 
> > This patch series is a work in progress, and does support the use
> > cases we had issues with, however, I currently skip one unit
> > test, as I can't get it to work. Comments and feedback much
> > appreciated!
> 
> Did anybody have any feedback on this? I have had a hard time
> understanding the design of the lexing. I really could use some
> pointers --- is there some documents somewhere that could make me
> understand it better? I haven't had time to work on this lately,
> but it would be great to get this fixed, so I figured I'll try to
> take some time in the near future.
> 
> /Olof
> 
> PS. Saw that RP merged the exception message patch, thanks :).

That one was easy :)

I'm afraid I don't have much knowledge of the sh lexing code, Chris
might have more knowledge than me...

Cheers,

Richard



