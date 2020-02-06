Return-Path: <rpjday@crashcourse.ca>
Received: from jamecapital.com (cpanel4.indieserve.net [199.212.143.9])
	by mail.openembedded.org (Postfix) with ESMTP id AEE4360AE3
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Feb 2020 07:23:07 +0000 (UTC)
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com
	([174.114.57.56]:47604 helo=localhost.localdomain)
	by cpanel4.indieserve.net with esmtpsa
	(TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92)
	(envelope-from <rpjday@crashcourse.ca>) id 1izbVC-005KTs-OM
	for bitbake-devel@lists.openembedded.org;
	Thu, 06 Feb 2020 02:23:08 -0500
Date: Thu, 6 Feb 2020 02:23:04 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
In-Reply-To: <alpine.LFD.2.21.2002060214160.1991272@localhost.localdomain>
Message-ID: <alpine.LFD.2.21.2002060222360.1991636@localhost.localdomain>
References: <alpine.LFD.2.21.2002060214160.1991272@localhost.localdomain>
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
Subject: Re: confused by explanation of OVERRIDES in BB user manual
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
X-List-Received-Date: Thu, 06 Feb 2020 07:23:07 -0000
Content-Type: text/plain; charset=US-ASCII

On Thu, 6 Feb 2020, Robert P. J. Day wrote:

>
>   section 3.3.1:
>
>      OVERRIDES = "architecture:os:machine"
>      TEST = "default"
>      TEST_os = "osspecific"
>      TEST_nooverride = "othercondvalue"   <----- ?????
>
> 'In this example, the OVERRIDES variable lists three overrides:
> "architecture", "os", and "machine". The variable TEST by itself has a
> default value of "default". You select the os-specific version of the
> TEST variable by appending the "os" override to the variable
> (i.e.TEST_os).'
>
>   what is the meaning of that line above with "nooverride"? i don't
> recall that in earlier versions of the manual, and it doesn't seem to
> be explained underneath it.

  never mind, i see what that example is trying to say, but it takes a
couple reads for it to be clear.

rday

