Return-Path: <olof.johansson@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id 41E1D75A31
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Apr 2016 15:02:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 44D8418344
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Apr 2016 17:02:57 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id lEBpqHju8Klg for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Apr 2016 17:02:56 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bastet.se.axis.com (Postfix) with ESMTP id B4FA918113
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Apr 2016 17:02:56 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 9F6E61105
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Apr 2016 17:02:56 +0200 (CEST)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id 949FCC6
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Apr 2016 17:02:56 +0200 (CEST)
Received: from lnxolofjn.se.axis.com (lnxolofjn.se.axis.com [10.92.17.1])
	by thoth.se.axis.com (Postfix) with ESMTP id 9321910D2
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Apr 2016 17:02:56 +0200 (CEST)
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)
	id 87FC79C09E; Fri,  1 Apr 2016 17:02:56 +0200 (CEST)
Date: Fri, 1 Apr 2016 17:02:56 +0200
From: Olof Johansson <olof.johansson@axis.com>
To: bitbake-devel@lists.openembedded.org
Message-ID: <20160401150255.GU4238@axis.com>
References: <1459522188-4421-1-git-send-email-olof.johansson@axis.com>
MIME-Version: 1.0
In-Reply-To: <1459522188-4421-1-git-send-email-olof.johansson@axis.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Subject: Re: [PATCH] fetch2: BB_ALLOWED_NETWORKS should not care about port numbers
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
X-List-Received-Date: Fri, 01 Apr 2016 15:02:59 -0000
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 16-04-01 16:49 +0200, Olof Johansson wrote:
> Bitbake would fail to classify the following URL as belonging to a
> allowed network, because of the port number in the url.
> 
>  BB_ALLOWED_NETWORKS = "*.example.com"
>  SRC_URI = "http://git.example.com:8080/foo.tar.gz"
> 
> Since protocols aren't specified in the BB_ALLOWED_NETWORKS variable,
> it's reasonable to believe that this should work regardless of protocol
> being used.

I noticed that this area actually has test coverage, so I resent
an updated patch series with updates to the unit tests as well.

-- 
olofjn

