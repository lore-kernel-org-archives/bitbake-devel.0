Return-Path: <olof.johansson@axis.com>
X-Greylist: delayed 339 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 31 May 2016 13:44:54 UTC
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id 9F0AA77175
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 31 May 2016 13:44:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id 255EF2E25B;
	Tue, 31 May 2016 15:39:15 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id TbiJmw3GoN7t; Tue, 31 May 2016 15:39:14 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bes.se.axis.com (Postfix) with ESMTP id 323092E1C0;
	Tue, 31 May 2016 15:39:14 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 1CC0014BD;
	Tue, 31 May 2016 15:39:14 +0200 (CEST)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id 118E4833;
	Tue, 31 May 2016 15:39:14 +0200 (CEST)
Received: from lnxolofjn.se.axis.com (lnxolofjn.se.axis.com [10.92.17.1])
	by seth.se.axis.com (Postfix) with ESMTP id 0F65BFAA;
	Tue, 31 May 2016 15:39:14 +0200 (CEST)
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)
	id A0B639C09F; Tue, 31 May 2016 15:39:14 +0200 (CEST)
Date: Tue, 31 May 2016 15:39:14 +0200
From: Olof Johansson <olof.johansson@axis.com>
To: fabien.proriolpatch@kazoe.org
Message-ID: <20160531133914.GC2814@axis.com>
References: <1464700684-24169-1-git-send-email-fabien.proriolpatch@kazoe.org>
MIME-Version: 1.0
In-Reply-To: <1464700684-24169-1-git-send-email-fabien.proriolpatch@kazoe.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bb.fetch.git: add a way to avoid git protocol, and force http or https mirrors
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
X-List-Received-Date: Tue, 31 May 2016 13:44:54 -0000
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 16-05-31 15:18 +0200, fabien.proriolpatch@kazoe.org wrote:
> From: Fabien Proriol <fabien.proriol@jdsu.com>
> 
> This patch add the possibility to bitbake to avoid git protocol to fetch sources.
> This is usefull in some network with firewall blocking git port.
> 
> When BB_GIT_PROTOCOL_FIREWALL is set, the PROTOCOL_MIRRORS table is used to find the new protocol (http or https) and the new host (if different) to used.
> 
> BB_GIT_PROTOCOL_FIREWALL can also contains a list of host accepted. This is usefull for exemple, if we use local git repository inside the network.

Can't you use PREMIRRORS instead? Something along the lines:

 PREMIRRORS = "git://.*/.* https://mirrorhost.example.com/"

There's even a variable, BB_FETCH_PREMIRRORONLY, for when the
original host shouldn't be contacted at all.

-- 
olofjn

