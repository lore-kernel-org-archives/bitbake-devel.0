Return-Path: <rpjday@crashcourse.ca>
Received: from oxfordrollform.com (cpanel4.indieserve.net [199.212.143.9])
	by mail.openembedded.org (Postfix) with ESMTP id 0E79360C96
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  5 Feb 2020 13:58:18 +0000 (UTC)
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com
	([174.114.57.56]:42504 helo=localhost.localdomain)
	by cpanel4.indieserve.net with esmtpsa
	(TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1izLC6-003dU3-F5; Wed, 05 Feb 2020 08:58:19 -0500
Date: Wed, 5 Feb 2020 08:58:16 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To: Joshua Watt <jpewhacker@gmail.com>
In-Reply-To: <CAJdd5GaxuOnQ_aWgn_tZABXs4LK+fOFMfpYN2jLCAohzO3f-KA@mail.gmail.com>
Message-ID: <alpine.LFD.2.21.2002050856530.1960626@localhost.localdomain>
References: <alpine.LFD.2.21.2002050523360.1950893@localhost.localdomain>
	<CAJdd5GaxuOnQ_aWgn_tZABXs4LK+fOFMfpYN2jLCAohzO3f-KA@mail.gmail.com>
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse,
	please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id:
	rpjday+crashcourse.ca/only user confirmed/virtual account not
	confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: confused by multiconfig explanation in bitbake manual
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
X-List-Received-Date: Wed, 05 Feb 2020 13:58:19 -0000
Content-Type: multipart/mixed;
	boundary="8323328-1675482722-1580911099=:1960626"

--8323328-1675482722-1580911099=:1960626
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 5 Feb 2020, Joshua Watt wrote:

>
>
> On Wed, Feb 5, 2020, 4:26 AM Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>
>         i've never defined a multiconfig build, but this section explaining
>       it in the BB user manual seems confusing:
>
>       ///// start
>
>       The following statement in the local.conf file both enables BitBake to
>       perform multiple configuration builds and specifies the two extra
>       multiconfigs:
>
>            BBMULTICONFIG = "target1 target2"
>
>       Once the target configuration files are in place and BitBake has been
>       enabled to perform multiple configuration builds, use the following
>       command form to start the builds:
>
>            $ bitbake [mc:multiconfigname:]target [[[mc:multiconfigname:]target] ... ]
>
>       Here is an example for two extra multiconfigs: target1 and target2:
>
>            $ bitbake mc::target mc:target1:target mc:target2:target
>
>       ///// end
>
>         i don't understand the "mc::target" part of that last command, as it
>       does not seem to be compatible with the definition of the general form
>       of the command just above that, specifically:
>
>             $ bitbake [mc:multiconfigname:]target ...
>
>       can someone clarify this?
>
>
> "target" is the recipe you want to build, just as you would have specified if you were not using a "mc:multiconfig:"
> prefix. For examples:
>
>  # build core-image-minimal
>  bitbake mc:my-mulitconfig:core-image-minimal
>
>  # build BusyBox
>  bitbake mc:my-mulitconfig:busybox
>
  my confusion was with the example that started with the two colons:

  $ bitbake mc::target ...

the manual doesn't seem to explain the meaning of that "::" bit.

rday

--8323328-1675482722-1580911099=:1960626--
