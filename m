Return-Path: <olof.johansson@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id 022627451E
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  2 Oct 2018 16:58:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 71E8718440;
	Tue,  2 Oct 2018 18:58:03 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id Iwe_E-RaW1Z3; Tue,  2 Oct 2018 18:58:02 +0200 (CEST)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
	by bastet.se.axis.com (Postfix) with ESMTPS id BE7451844F;
	Tue,  2 Oct 2018 18:58:02 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 670311A080;
	Tue,  2 Oct 2018 18:58:02 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B60C1A07F;
	Tue,  2 Oct 2018 18:58:02 +0200 (CEST)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
	by boulder02.se.axis.com (Postfix) with ESMTP;
	Tue,  2 Oct 2018 18:58:02 +0200 (CEST)
Received: from lnxolofjn.se.axis.com (lnxolofjn.se.axis.com [10.92.17.1])
	by thoth.se.axis.com (Postfix) with ESMTP id 4FA2A2740;
	Tue,  2 Oct 2018 18:58:02 +0200 (CEST)
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)
	id 413F49C0E2; Tue,  2 Oct 2018 18:58:02 +0200 (CEST)
Date: Tue, 2 Oct 2018 18:58:02 +0200
From: Olof Johansson <olof.johansson@axis.com>
To: Florian Wickert <fw@javox-solutions.com>
Message-ID: <20181002165802.jv5cb4azi3d54gui@axis.com>
Mail-Followup-To: Florian Wickert <fw@javox-solutions.com>,
	bitbake-devel@lists.openembedded.org
References: <fa53fd11-b621-63ae-a1a6-bf2a4803a796@javox-solutions.com>
MIME-Version: 1.0
In-Reply-To: <fa53fd11-b621-63ae-a1a6-bf2a4803a796@javox-solutions.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-TM-AS-GCONF: 00
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: gitsm fetcher does not work anymore
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
X-List-Received-Date: Tue, 02 Oct 2018 16:58:03 -0000
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 18-10-02 18:24 +0200, Florian Wickert wrote:
> The SSH scheme is required for private repos on github because https doesn't
> work with SSH keys.

SSH keys have never worked for https. You have to authenticate in
other ways, like authentication tokens. But saying that private
repos *require* ssh transport is not true.

See for instance https://gist.github.com/technoweenie/1072829 for
how to use ~/.netrc to do this in non-interactive environments
like OE (or when you just can't stand having to enter your
password over and over).

-- 
olofjn

