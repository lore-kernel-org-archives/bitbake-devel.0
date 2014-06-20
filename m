Return-Path: <rpjday@crashcourse.ca>
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
	[64.235.106.9])
	by mail.openembedded.org (Postfix) with ESMTP id 0C1FF65F19
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Jun 2014 16:27:02 +0000 (UTC)
Received: from [69.196.158.250] (port=54917 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1Wy1eV-000053-Qh; Fri, 20 Jun 2014 12:26:59 -0400
Date: Fri, 20 Jun 2014 12:23:12 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To: Christopher Larson <clarson@kergoth.com>
In-Reply-To: <CABcZAN=qpQ3FEO-bzj0hiGrNGcoghkK8UT0G4RXyhFXgJSutNA@mail.gmail.com>
Message-ID: <alpine.LFD.2.11.1406201215310.1690@localhost>
References: <alpine.LFD.2.11.1406201157320.11539@localhost>
	<CABcZAN=qpQ3FEO-bzj0hiGrNGcoghkK8UT0G4RXyhFXgJSutNA@mail.gmail.com>
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
Subject: Re: are the fetch-related variables in bitbake's bitbake.conf of any value?
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
X-List-Received-Date: Fri, 20 Jun 2014 16:27:08 -0000
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-444567705-1403281400=:1690"

--8323328-444567705-1403281400=:1690
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 20 Jun 2014, Christopher Larson wrote:

>
> On Fri, Jun 20, 2014 at 9:00 AM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>
>   more specific question related to my earlier post -- is there any
> value whatever in the variables in bitbake's bitbake.conf file of the
> form:
>
>   FETCHCOMMAND*
>   RESUMECOMMAND*
>   UPDATECOMMAND*
>   MKTEMP*CMD
>
> nothing seems to use any of those. can they all just be deleted?
> certainly, the FETCHCOMMAND* variables have been superseded by the
> FETCHCMD* variables, no? i don't know about the remainder of them.
>
> As far as I know, as you say, those were deprecated in favor of the
> FETCHCMD vars, so can almost certainly be dropped.

  one more question before i submit a patch to do some cleaning.
AFAICT, the bitbake.conf settings for RESUMECOMMAND* and
UPDATECOMMAND* variables can be removed as well since nothing in
bitbake refers to those variables, and it seems logical that bitbake
should not be setting variables that it doesn't directly use in some
way.

  however, i'm puzzled by this from the bitbake codebase:

$ grep -r "MKTEMP.*CMD" *
conf/bitbake.conf:MKTEMPCMD = "mktemp -q ${TMPBASE}"
conf/bitbake.conf:MKTEMPDIRCMD = "mktemp -d -q ${TMPBASE}"
lib/toaster/orm/fixtures/orm_views_testdata.json:        "variable_name": "MKTEMPCMD"
lib/toaster/orm/fixtures/orm_views_testdata.json:        "variable_name": "MKTEMPDIRCMD"
$

  so the only reference to the MKTEMP-related variables are in the
toaster directory in some .json files. what does that mean? if one
wanted to remove the MKTEMP* variables, would one also have to adjust
those .json files accordingly?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

--8323328-444567705-1403281400=:1690--
