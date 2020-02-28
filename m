Return-Path: <rpjday@crashcourse.ca>
Received: from cpanel7.indieserve.net (cpanel7.indieserve.net [199.212.143.8])
	by mail.openembedded.org (Postfix) with ESMTP id 5A92361960
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Feb 2020 13:33:36 +0000 (UTC)
Received: from [127.0.0.1] (port=49122 helo=cpanel7.indieserve.net)
	by cpanel7.indieserve.net with esmtpsa (TLS1.2) tls
	TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
	(envelope-from <rpjday@crashcourse.ca>) id 1j7flo-0008e0-NF
	for bitbake-devel@lists.openembedded.org;
	Fri, 28 Feb 2020 08:33:37 -0500
Received: from [66.129.241.14] ([66.129.241.14]) by crashcourse.ca (Horde
	Framework) with HTTPS; Fri, 28 Feb 2020 08:33:36 -0500
Date: Fri, 28 Feb 2020 08:33:36 -0500
Message-ID: <20200228083336.Horde.2i5ag6ZVWX3JF5j5y3bF1q2@crashcourse.ca>
From: rpjday@crashcourse.ca
To: bitbake-devel@lists.openembedded.org
User-Agent: Horde Application Framework 5
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse,
	please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel7.indieserve.net
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel7.indieserve.net: authenticated_id:
	rpjday@crashcourse.ca
X-Authenticated-Sender: cpanel7.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Subject: can i get a list of only bbappend'ed recipes that were *used* in a build?
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
X-List-Received-Date: Fri, 28 Feb 2020 13:33:36 -0000
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Content-Disposition: inline

looked around and i don't see an immediately obvious way to do this ...
is there a way to generate a list of *only* those recipes that were
used in the current build that had associated .bbappend files?

"bitbake-layers show-appends" will show all recipes with .bbappend
files, including those that are not included and processed for the
current build/image. here's the rationale, in case i'm missing
something.

been handed an existing vendor layer, with *tons* of bbappend'ed
recipes, some basic, some from meta-openembedded and many from
the vendor's proprietary layer. my go-to strategy is to always try
to build a core-image-minimal to establish a working baseline and,
when that works, it would be nice to know which of the recipes
that contributed to that core-image-minimal build were modified
in any way via a .bbappend file, then work my way out.

does that make sense? is there a way to do this, other than wander
down to tmp/work/... and try to figure out which recipes were
modified from the original? am i overlooking something simple?

rday





