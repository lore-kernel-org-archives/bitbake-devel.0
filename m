Return-Path: <olof.johansson@axis.com>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id 075E760144
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Mar 2014 15:43:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id 740592E383
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Mar 2014 16:43:45 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id G2LhwgtjIhDW for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Mar 2014 16:43:45 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bes.se.axis.com (Postfix) with ESMTP id DA5AE2E2E1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Mar 2014 16:43:44 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id BBFAA7F8
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Mar 2014 16:43:44 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id B106A61D
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Mar 2014 16:43:44 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by thoth.se.axis.com (Postfix) with ESMTP id AEFC534005
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Mar 2014 16:43:44 +0100 (CET)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.3.342.0; Wed, 19 Mar 2014
	16:43:44 +0100
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id 740329C29D; 
	Wed, 19 Mar 2014 16:43:44 +0100 (CET)
Date: Wed, 19 Mar 2014 16:43:44 +0100
From: Olof Johansson <olof.johansson@axis.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Message-ID: <20140319154344.GA951@axis.com>
References: <1390215804-20578-1-git-send-email-olof.johansson@axis.com>
MIME-Version: 1.0
In-Reply-To: <1390215804-20578-1-git-send-email-olof.johansson@axis.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Subject: Re: [PATCH 0/5] Improvements to bb.fetch2.URI class
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
X-List-Received-Date: Wed, 19 Mar 2014 15:43:54 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On 14-01-20 12:03 +0100, Olof Johansson wrote:
> This patch series fixes some issues that was encountered after the URI class
> was integrated to Bitbake's fetch2 package. Notably, it adds support for query
> parameters. This patch series does *not* make encode/decodeurl use the URI
> class, as I had issues getting uri_replace to work with it.

Ping?

-- 
olofjn

