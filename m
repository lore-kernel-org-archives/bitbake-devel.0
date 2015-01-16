Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 961E965C7B
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Jan 2015 08:28:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t0G8SeAZ032718; Fri, 16 Jan 2015 08:28:40 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Sn03UDEJsyC1; Fri, 16 Jan 2015 08:28:40 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t0G8SOTY032709
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 16 Jan 2015 08:28:36 GMT
Message-ID: <1421396904.1798.5.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Gary Thomas <gary@mlbassoc.com>
Date: Fri, 16 Jan 2015 08:28:24 +0000
In-Reply-To: <54B80569.5030507@mlbassoc.com>
References: <54B80569.5030507@mlbassoc.com>
X-Mailer: Evolution 3.12.7-0ubuntu1 
Mime-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: Parsing recipes progress bar doesn't show incremental progress
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 16 Jan 2015 08:28:49 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2015-01-15 at 11:22 -0700, Gary Thomas wrote:
> I think there has been a recent change in behaviour.  When
> you start up bitbake there is a progress bar during the recipe
> parsing:
>    Parsing recipes: 100% |##########################################| Time: 00:00:05
> 
> I used to see this bar fill as it went, but now it sits there
> at 0% until it is completely done and then BAM goes to 100%
> 
> Has anyone else seen this?  I'm running Poky/Yocto updated
> to 2b925045877aeb44d9823a8c9515e8ab8fca1e52 as of 2015-01-15

My guess is that the delay introduced after parsing from pyinotify is
causing the bar to be visible at 100% for a while. I've just merged the
performance fix for pyinotify, can you see if its still doing what you
describe after that?

Cheers,

Richard


