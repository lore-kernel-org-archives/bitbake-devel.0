Return-Path: <olof.johansson@axis.com>
X-Greylist: delayed 505 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 08 Aug 2016 16:47:48 UTC
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id 6563C771C7
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Aug 2016 16:47:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id D4AC918117;
	Mon,  8 Aug 2016 18:39:23 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id i9sbVdYPK0FO; Mon,  8 Aug 2016 18:39:23 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bastet.se.axis.com (Postfix) with ESMTP id 488291811B;
	Mon,  8 Aug 2016 18:39:23 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 328F71BD4;
	Mon,  8 Aug 2016 18:39:23 +0200 (CEST)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id 27B6216C0;
	Mon,  8 Aug 2016 18:39:23 +0200 (CEST)
Received: from lnxolofjn.se.axis.com (lnxolofjn.se.axis.com [10.92.17.1])
	by seth.se.axis.com (Postfix) with ESMTP id 263EE401;
	Mon,  8 Aug 2016 18:39:23 +0200 (CEST)
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)
	id 3DD3F9C09F; Mon,  8 Aug 2016 18:39:27 +0200 (CEST)
Date: Mon, 8 Aug 2016 18:39:27 +0200
From: Olof Johansson <olof.johansson@axis.com>
To: Khem Raj <raj.khem@gmail.com>, bitbake-devel@lists.openembedded.org
Message-ID: <20160808163926.GO4674@axis.com>
References: <1470645281559.73326@axis.com>
	<1470650127.8166.40.camel@linuxfoundation.org>
	<7a284480-47ae-674c-3073-5680e626f769@smile.fr>
	<C61ACEF2-94CC-4609-91F5-D9139A779926@gmail.com>
MIME-Version: 1.0
In-Reply-To: <C61ACEF2-94CC-4609-91F5-D9139A779926@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Subject: Re: [PATCH] BB_NO_NETWORK: Fallback to local source for git lsremote
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
X-List-Received-Date: Mon, 08 Aug 2016 16:47:51 -0000
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 16-08-08 08:35 -0700, Khem Raj wrote:
> tags are floating types in git, you can not use them reliably.

This is not always true. We could choose to trust tags set
according to our processes to not move (e.g. enforced rules that
disallows deletion/updates of tags), and only use tags for these
recipes, and rely on commit object ids eleswhere.

Tags are only a problem in git if people insist on
modifying/deleting them.

-- 
olofjn

