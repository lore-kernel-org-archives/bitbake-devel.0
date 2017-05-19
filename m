Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 9284077F55
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 19 May 2017 09:48:32 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v4J9mVXu001959
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Fri, 19 May 2017 10:48:32 +0100
Message-ID: <1495187311.27342.149.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alan Levy <alan.levy@plextek.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Date: Fri, 19 May 2017 10:48:31 +0100
In-Reply-To: <76e10e401a174bdca9f6a65acafbff5e@PLEXTEK-EXCH1.plextek.lan>
References: <76e10e401a174bdca9f6a65acafbff5e@PLEXTEK-EXCH1.plextek.lan>
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Fri, 19 May 2017 10:48:33 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: Re: Problem using Subversion in Pyro
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
X-List-Received-Date: Fri, 19 May 2017 09:48:34 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Thu, 2017-05-18 at 14:22 +0000, Alan Levy wrote:
> --limit 1 --no-auth-cache ! http://server/path/my_module/ failed with
> exit code 127, output:
> /usr/bin/env: 'svn': No such file or directory
>  
> If I comment out the line containing SRCPV, all is well. Digging into
> the code it appears that svn is missing from ${HOSTTOOLS} in
> bitbake.conf.

I can understand how we end up in this situation.

In general, subversion-native is built before the recipe's do_fetch so
things work.

When you use SRCREV = "${AUTOREV}", it needs subversion at parse time
and its obviously not built it. You therefore need to use the host
version. You can enable that with:

HOSTTOOLS_append = " svn"

in your config. I'm not sure I see any way around that. We don't really
want to require subversion in general, its only needed if you're using
autorev svn recipes.

Obviously we could do with improving the failure messages though...

Cheers,

Richard

