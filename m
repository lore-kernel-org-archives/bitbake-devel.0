Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id E21E976537
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 15:42:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t6VFgsOq014246; Fri, 31 Jul 2015 16:42:54 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id UCIXJwoZijhO; Fri, 31 Jul 2015 16:42:54 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t6VFgdZr014241
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 31 Jul 2015 16:42:50 +0100
Message-ID: <1438357359.22462.89.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Olof Johansson <olof.johansson@axis.com>
Date: Fri, 31 Jul 2015 16:42:39 +0100
In-Reply-To: <1438343225-sup-6774@axis.com>
References: <1438266455-sup-7263@axis.com>
	<1438336442.22462.2.camel@linuxfoundation.org>
	<1438336806.22462.3.camel@linuxfoundation.org>
	<1438343225-sup-6774@axis.com>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: Variable key replaces original warnings
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
X-List-Received-Date: Fri, 31 Jul 2015 15:43:00 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2015-07-31 at 13:48 +0200, Olof Johansson wrote:
> Excerpts from Richard Purdie's message of 2015-07-31 12:00:06 +0200:
> > The OE-Core change I made for a similar case was:
> > 
> > http://git.yoctoproject.org/cgit.cgi/poky/commit/meta/classes/update-rc.d.bbclass?id=3b627bb28c4ea2ea33050ad4884c6351e2d6ebad
> > 
> > i.e. moved to anonymous python. Not ideal, but more explicit.
> 
> Ah, thanks. Didn't see this before replying to your other mail. But I
> agree, not ideal at all. It's very surprising. What I would expect is
> that the _append is postponed and only done on the expanded vars, but
> that's not the case? Why not?

Its all about the timing of the override expansion (_append is
effectively an override) and the key expansion. Taking:

PN = A
RRECOMMENDS_${PN} = "X" 
UPDATERCPN = "${PN}" 
RRECOMMENDS_${UPDATERCPN}_append = "Y"

if you expand overrides first it changes to:

RRECOMMENDS_${PN} = "X" 
UPDATERCPN = "${PN}" 
RRECOMMENDS_${UPDATERCPN} = "Y"

and it then becomes:

RRECOMMENDS_A = "Y"

however if you do key expansion first it becomes:

RRECOMMENDS_A = "X" 
RRECOMMENDS_A_append = "Y"

so RRECOMMENDS_A = "XY" 

We're now using the former rather than the latter in bitbake however it
will generate warnings where it sees variables conflict since users tend
not to realise and mean something different.

Worst case we could make the warnings configurable or whitelist them but
simply changing the code not to be ambiguous is likely the best all
around solution.

Cheers,

Richard









