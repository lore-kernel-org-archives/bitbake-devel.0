Return-Path: <rpjday@crashcourse.ca>
X-Greylist: delayed 433 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 22 Jul 2014 16:44:17 UTC
Received: from smtp684.redcondor.net (smtp684.redcondor.net [208.80.206.84])
	by mail.openembedded.org (Postfix) with ESMTP id 1EA3E70727
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Jul 2014 16:44:17 +0000 (UTC)
Received: from astoria.ccjclearline.com ([64.235.106.9])
	by smtp684.redcondor.net ({700db0a8-6fb7-4c8b-9b2a-6812225182d8})
	via TCP (outbound) with ESMTPS id 20140722163704239
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Jul 2014 16:37:04 +0000
X-RC-FROM: <rpjday@crashcourse.ca>
X-RC-RCPT: <bitbake-devel@lists.openembedded.org>
Received: from [64.102.254.34] (port=36479 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1X9d3j-0008W5-80; Tue, 22 Jul 2014 12:36:59 -0400
Date: Tue, 22 Jul 2014 12:36:52 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To: Christopher Larson <clarson@kergoth.com>
In-Reply-To: <CABcZAN=nRqo7sYm9=MkAT0r0uAnR_oVBMEnMYGJz_=h-mZ6p2Q@mail.gmail.com>
Message-ID: <alpine.LFD.2.11.1407221236210.8695@localhost>
References: <alpine.LFD.2.11.1407220618060.25977@localhost>
	<CABcZAN=nRqo7sYm9=MkAT0r0uAnR_oVBMEnMYGJz_=h-mZ6p2Q@mail.gmail.com>
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
Subject: Re: should "bitbake -e" refer to per-recipe, not per-package?
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
X-List-Received-Date: Tue, 22 Jul 2014 16:44:18 -0000
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-877131170-1406047018=:8695"

--8323328-877131170-1406047018=:8695
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 22 Jul 2014, Christopher Larson wrote:

> On Tue, Jul 22, 2014 at 3:19 AM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>         i notice that, in "bitbake -h", the explanation of "bibake -e" is
>       that it potentially allows the display of "per-package" environment
>       info. should that not more accurately say "per-recipe"?
>
>
> Yep.

  ok, i'll submit patch for that tonight.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

--8323328-877131170-1406047018=:8695--
