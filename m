Return-Path: <rich.tollerton@ni.com>
Received: from ni.com (skprod3.natinst.com [130.164.80.24])
	by mail.openembedded.org (Postfix) with ESMTP id 6D0D6728AC
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 19 Dec 2014 00:03:36 +0000 (UTC)
Received: from us-aus-mgwout1.amer.corp.natinst.com (nb-chan1-1338.natinst.com
	[130.164.19.134])
	by us-aus-skprod3.natinst.com (8.14.5/8.14.5) with ESMTP id
	sBJ03ZkZ009452; Thu, 18 Dec 2014 18:03:35 -0600
Received: from weregild ([130.164.14.198])
	by us-aus-mgwout1.amer.corp.natinst.com (Lotus Domino Release 8.5.3FP6)
	with ESMTP id 2014121818033552-238921 ;
	Thu, 18 Dec 2014 18:03:35 -0600 
From: Richard Tollerton <rich.tollerton@ni.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
In-Reply-To: <87r3vwttad.fsf@weregild.i-did-not-set--mail-host-address--so-tickle-me>
References: <1418865078-10484-1-git-send-email-rich.tollerton@ni.com>
	<1418898565.5106.19.camel@linuxfoundation.org>
	<87tx0su2ys.fsf@weregild.i-did-not-set--mail-host-address--so-tickle-me>
	<1418941736.13316.4.camel@linuxfoundation.org>
	<87r3vwttad.fsf@weregild.i-did-not-set--mail-host-address--so-tickle-me>
User-Agent: Notmuch/0.18.1 (http://notmuchmail.org) Emacs/24.4.1
	(x86_64-unknown-linux-gnu)
Date: Thu, 18 Dec 2014 18:03:35 -0600
Message-ID: <87oar0tsiw.fsf@weregild.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on US-AUS-MGWOut1/AUS/H/NIC(Release
	8.5.3FP6|November 21, 2013) at 12/18/2014 06:03:35 PM,
	Serialize by Router on US-AUS-MGWOut1/AUS/H/NIC(Release
	8.5.3FP6|November 21, 2013) at 12/18/2014 06:03:35 PM,
	Serialize complete at 12/18/2014 06:03:35 PM
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.13.68, 1.0.33,
	0.0.0000
	definitions=2014-12-18_07:2014-12-18, 2014-12-18,
	1970-01-01 signatures=0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] data: Avoid attempting to assign readonly shell vars
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
X-List-Received-Date: Fri, 19 Dec 2014 00:03:38 -0000
Content-Type: text/plain

Richard Tollerton <rich.tollerton@ni.com> writes:

> What do you think about this for a fix:
>
> This only appears to be an issue with code that's using bb.data as a
> part of a shell script generation, which AFAIK is only done from
> terminal.py to build a run.do_terminal. (Otherwise, nothing would be
> building right now.) What if we run e.g. `env -i run.do_terminal`
> instead of `run.do_terminal`? That will completely clear the environment
> prior to execution.
>
> I'll try to take a stab at implementing this.

Never mind, this was a stupid idea -- bash in POSIX mode continues to set
BASHOPTS under `env -i`, so this buys us nothing.

New idea: Terminal allows passing in an environment directly, which is
currently unused. What if we passed the execution environment in through
that, instead of encoding it into the script?

(Yes, this probably belongs in oe-core more than bitbake-devel at this
point...)


-- 
Richard Tollerton <rich.tollerton@ni.com>

