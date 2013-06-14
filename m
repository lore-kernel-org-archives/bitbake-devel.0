Return-Path: <olof.johansson@axis.com>
Received: from anubis.se.axis.com (anubis.se.axis.com [195.60.68.12])
	by mail.openembedded.org (Postfix) with ESMTP id 3F3AF6A8DB
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Jun 2013 13:55:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by anubis.se.axis.com (Postfix) with ESMTP id 0DF3719DE5
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Jun 2013 15:55:48 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at anubis.se.axis.com
Received: from anubis.se.axis.com ([127.0.0.1])
	by localhost (anubis.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Jij3natshsiO for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Jun 2013 15:55:47 +0200 (CEST)
Received: from boulder.localdomain (boulder.se.axis.com [10.0.2.104])
	by anubis.se.axis.com (Postfix) with ESMTP id 4DF2D19D7D
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Jun 2013 15:55:47 +0200 (CEST)
Received: from boulder.localdomain (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 2FB36B1B
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Jun 2013 15:55:47 +0200 (CEST)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.localdomain (Postfix) with ESMTP id 24E4D1F5
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Jun 2013 15:55:47 +0200 (CEST)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by thoth.se.axis.com (Postfix) with ESMTP id 235F43423A
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Jun 2013 15:55:47 +0200 (CEST)
Received: from axis.com (10.92.17.1) by xmail2.se.axis.com (10.0.5.74) with
	Microsoft SMTP Server (TLS) id 8.2.176.0;
	Fri, 14 Jun 2013 15:55:46 +0200
Date: Fri, 14 Jun 2013 15:55:45 +0200
From: Olof Johansson <olof.johansson@axis.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Message-ID: <20130614135545.GE13277@axis.com>
References: <1367918558-16136-1-git-send-email-olof.johansson@axis.com>
MIME-Version: 1.0
In-Reply-To: <1367918558-16136-1-git-send-email-olof.johansson@axis.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
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
X-List-Received-Date: Fri, 14 Jun 2013 13:55:50 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On 2013-05-07 11:22, Olof Johansson wrote:
> Hi,
> 
> A week or so I found out that shell fragments in bitbake recipes
> don't support shell arithmetics (`$((1+1))`). The reason for this
> is the shell lexing throwing NotImplemented exceptions. I've made
> some progress in adding support for shell arithmetics, but I have
> a hard time getting support for corner cases.
> 
> It was suprising to see that currently, only a subset of posix
> shell scripts is supported, even though they are sent through to
> be executed by the system shell. I think I understand the reason
> for having to do the shell lexing; knowing what functions and
> variables to export right? But I wonder if it's possible to do
> the shell lexing as a best effort, and ignore any errors.
> 
> What are the risks with this approach? Is it feasibile to do so?
> 
> This patch series is a work in progress, and does support the use
> cases we had issues with, however, I currently skip one unit
> test, as I can't get it to work. Comments and feedback much
> appreciated!

Did anybody have any feedback on this? I have had a hard time
understanding the design of the lexing. I really could use some
pointers --- is there some documents somewhere that could make me
understand it better? I haven't had time to work on this lately,
but it would be great to get this fixed, so I figured I'll try to
take some time in the near future.

/Olof

PS. Saw that RP merged the exception message patch, thanks :).

