Return-Path: <rpjday@crashcourse.ca>
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
	[64.235.106.9])
	by mail.openembedded.org (Postfix) with ESMTP id 9784065D6E
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Jun 2014 15:59:05 +0000 (UTC)
Received: from [69.196.158.250] (port=53649 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1Wy1DV-00070y-J8; Fri, 20 Jun 2014 11:59:05 -0400
Date: Fri, 20 Jun 2014 11:55:23 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To: Christopher Larson <clarson@kergoth.com>
In-Reply-To: <CABcZANn_x7Y9XJ-g861+9YEsXtVNwF-krtf7QBgrG50PxUdEPw@mail.gmail.com>
Message-ID: <alpine.LFD.2.11.1406201152050.4233@localhost>
References: <alpine.LFD.2.11.1406200725340.5971@localhost>
	<CABcZANn_x7Y9XJ-g861+9YEsXtVNwF-krtf7QBgrG50PxUdEPw@mail.gmail.com>
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
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: distinguishing between bitbake and "higher" layers WRT fetching variables [LONG]
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
X-List-Received-Date: Fri, 20 Jun 2014 15:59:07 -0000
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1773431158-1403279726=:4233"

--8323328-1773431158-1403279726=:4233
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 20 Jun 2014, Christopher Larson wrote:

>
> On Fri, Jun 20, 2014 at 8:47 AM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>         (note: more annoying pedantry regarding bitbake configuration and
>       documentation but, if i'm going to explain this to my students, i
>       really need to understand it completely.)
>
>         some questions and observations about how bitbake defines some
>       fetch-related variables as opposed to how those variables are defined
>       in higher layers such as oe-core and poky. as richard purdie(?)
>       pointed out recently, the goal should be to document bitbake as
>       independently as possible from what happens in layers such as oe and
>       poky, but it seems this is not as clean as it could be.
>
>         consider first bitbake's current bitbake.conf file. first, can we
>       agree that this set of variables:
>
>
> Before I dive into the remainder of the email, we should note that
> the bitbake.conf in bitbake is never used when you use oe, it's
> solely as an example / starting point for other non-oe projects
> wanting to use bitbake. Presumably it gets forgotten about when
> changes to bitbake itself are made, and so it's fallen behind.

  oh, i realize that but (i think) my main point was that it seems
almost impossible to document bitbake completely stand-alone when
almost everyone is going to use it in the context of a higher layer
like OE, and there just seem to be unnecessary inconsistencies between
bitbake and OE that make the bitbake user manual confusing.

  more in a bit ...

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

--8323328-1773431158-1403279726=:4233--
