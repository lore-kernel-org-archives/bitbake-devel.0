Return-Path: <olof.johansson@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id 3DD62764A3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 11:48:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 65E53180C4;
	Fri, 31 Jul 2015 13:48:35 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id E5KxysvY3-1u; Fri, 31 Jul 2015 13:48:34 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bastet.se.axis.com (Postfix) with ESMTP id B2BE51807D;
	Fri, 31 Jul 2015 13:48:34 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 9BC5E1302;
	Fri, 31 Jul 2015 13:48:34 +0200 (CEST)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id 8F72410F6;
	Fri, 31 Jul 2015 13:48:34 +0200 (CEST)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by seth.se.axis.com (Postfix) with ESMTP id 8D0973E049;
	Fri, 31 Jul 2015 13:48:34 +0200 (CEST)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.3.342.0; Fri, 31 Jul 2015
	13:48:34 +0200
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id 3DC009C68B; 
	Fri, 31 Jul 2015 13:48:34 +0200 (CEST)
From: Olof Johansson <olof.johansson@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
In-Reply-To: <1438336806.22462.3.camel@linuxfoundation.org>
References: <1438266455-sup-7263@axis.com>
	<1438336442.22462.2.camel@linuxfoundation.org>
	<1438336806.22462.3.camel@linuxfoundation.org>
Date: Fri, 31 Jul 2015 13:48:34 +0200
Message-ID: <1438343225-sup-6774@axis.com>
User-Agent: Sup/0.20.0
MIME-Version: 1.0
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
X-List-Received-Date: Fri, 31 Jul 2015 11:48:40 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Excerpts from Richard Purdie's message of 2015-07-31 12:00:06 +0200:
> The OE-Core change I made for a similar case was:
> 
> http://git.yoctoproject.org/cgit.cgi/poky/commit/meta/classes/update-rc.d.bbclass?id=3b627bb28c4ea2ea33050ad4884c6351e2d6ebad
> 
> i.e. moved to anonymous python. Not ideal, but more explicit.

Ah, thanks. Didn't see this before replying to your other mail. But I
agree, not ideal at all. It's very surprising. What I would expect is
that the _append is postponed and only done on the expanded vars, but
that's not the case? Why not?

-- 
olof johansson

