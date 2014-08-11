Return-Path: <rpjday@crashcourse.ca>
Received: from smtp684.redcondor.net (smtp684.redcondor.net [208.80.206.84])
	by mail.openembedded.org (Postfix) with ESMTP id BF2B765D5F
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 Aug 2014 17:27:09 +0000 (UTC)
Received: from astoria.ccjclearline.com ([64.235.106.9])
	by smtp684.redcondor.net ({700db0a8-6fb7-4c8b-9b2a-6812225182d8})
	via TCP (outbound) with ESMTPS id 20140811172709861
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 Aug 2014 17:27:09 +0000
X-RC-FROM: <rpjday@crashcourse.ca>
X-RC-RCPT: <bitbake-devel@lists.openembedded.org>
Received: from [99.240.204.5] (port=56253 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1XGtNA-0002qV-S5; Mon, 11 Aug 2014 13:27:04 -0400
Date: Mon, 11 Aug 2014 13:27:00 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To: Christopher Larson <clarson@kergoth.com>
In-Reply-To: <CABcZANkvKtcEfNBHJ3VfDV_A61WZ6H=bm_MgtJ4EbPcRgOdW0w@mail.gmail.com>
Message-ID: <alpine.LFD.2.11.1408111320560.6960@localhost>
References: <alpine.LFD.2.11.1408110806310.9162@localhost>
	<CABcZANkvKtcEfNBHJ3VfDV_A61WZ6H=bm_MgtJ4EbPcRgOdW0w@mail.gmail.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
X-AntiAbuse: This header was added to track abuse,
	please include it with any abuse report
X-AntiAbuse: Primary Hostname - astoria.ccjclearline.com
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-MAG-OUTBOUND: ccj.redcondor.net@64.235.106.9/32
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: bitbake user manual: shouldn't "Events" mention "[eventmask]"?
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
X-List-Received-Date: Mon, 11 Aug 2014 17:27:13 -0000
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-710235341-1407778023=:6960"

--8323328-710235341-1407778023=:6960
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 11 Aug 2014, Christopher Larson wrote:

>
> On Mon, Aug 11, 2014 at 5:08 AM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>
>   reading up on events in BB manual and section 3.7, "Events", talks
> of defining event handlers, but claims:
>
> "This event handler gets called every time an event is triggered."
>
> but don't you have to associate an event handler with one or more
> events using the "[eventmask]" flag? that seems like a fairly
> significant omission from that section. or am i just
> misunderstanding how events work?
>
> eventmask is a fairly recent addition. If eventmask is undefined,
> the handler is called for all events, and its left to the event
> handler to make sure it's only doing its logic for the right events
> (e.g. call isinstance() on 'e' to check what event it is). The docs
> likely were never updated to include it.

  yeah, that's probably something that should be in the bitbake manual
somewhere. :-)

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

--8323328-710235341-1407778023=:6960--
