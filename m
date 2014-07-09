Return-Path: <rpjday@crashcourse.ca>
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
	[64.235.106.9])
	by mail.openembedded.org (Postfix) with ESMTP id E68727026E
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Jul 2014 15:25:56 +0000 (UTC)
Received: from [69.196.158.250] (port=46098 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1X4tkr-0004jr-7c; Wed, 09 Jul 2014 11:25:57 -0400
Date: Wed, 9 Jul 2014 11:25:48 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To: Christopher Larson <clarson@kergoth.com>
In-Reply-To: <CABcZAN=OPjSrfQNSjarThUu37Q3LgoZc8jvX4t1+CN8nZnEh=w@mail.gmail.com>
Message-ID: <alpine.LFD.2.11.1407091123270.10635@localhost>
References: <alpine.LFD.2.11.1407090934540.8165@localhost>
	<CABcZAN=OPjSrfQNSjarThUu37Q3LgoZc8jvX4t1+CN8nZnEh=w@mail.gmail.com>
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
Subject: Re: should list of "Variable Flags" include "fakeroot"?
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
X-List-Received-Date: Wed, 09 Jul 2014 15:26:04 -0000
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-928502733-1404919557=:10635"

--8323328-928502733-1404919557=:10635
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 9 Jul 2014, Christopher Larson wrote:

>
> On Wed, Jul 9, 2014 at 6:38 AM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>         user manual, "3.6 Variable Flags" includes "fakeroot" as one of the
>       numerous flags, but that section claims that all of those flags can be
>       set using the standard variable syntax. but IIRC, fakeroot is set as
>       an *attribute* on tasks these days, as in:
>
>         fakeroot tar_sdk() {
>
>       so how should that entry be worded/reworded? unless i'm misreading
>       something.
>
>
> It likely shouldn't be mentioned as a flag. The fact that it's a
> flag internally is a bitbake implementation detail that likely isn't
> something they need to be aware of, in my personal opinion, anyway.

  that's the way i read it ... all the underlying support code still
treats it as a "flag", but since i see no usage of it with the flag
syntax, i'll just submit a patch to delete it from the flag list,
assuming it's discussed adequately elsewhere.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

--8323328-928502733-1404919557=:10635--
