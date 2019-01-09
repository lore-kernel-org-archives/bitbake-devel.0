Return-Path: <olof.johansson@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id E54876C4A5
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Jan 2019 01:29:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 520AB1849B;
	Wed,  9 Jan 2019 02:29:04 +0100 (CET)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id uW8rPvPGR2dI; Wed,  9 Jan 2019 02:29:03 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
	by bastet.se.axis.com (Postfix) with ESMTPS id C916A18488;
	Wed,  9 Jan 2019 02:29:03 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5CEB1E079;
	Wed,  9 Jan 2019 02:29:03 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA9C91E074;
	Wed,  9 Jan 2019 02:29:03 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
	by boulder03.se.axis.com (Postfix) with ESMTP;
	Wed,  9 Jan 2019 02:29:03 +0100 (CET)
Received: from lnxolofjn.se.axis.com (lnxolofjn.se.axis.com [10.92.17.1])
	by thoth.se.axis.com (Postfix) with ESMTP id 9E98B218;
	Wed,  9 Jan 2019 02:29:03 +0100 (CET)
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)
	id 920239C4F2; Wed,  9 Jan 2019 02:29:03 +0100 (CET)
Date: Wed, 9 Jan 2019 02:29:03 +0100
From: Olof Johansson <olof.johansson@axis.com>
To: Mark Hatle <mark.hatle@windriver.com>, bitbake-devel@lists.openembedded.org
Message-ID: <20190109012903.e4dfrmnlagpjpapw@axis.com>
Mail-Followup-To: Mark Hatle <mark.hatle@windriver.com>,
	bitbake-devel@lists.openembedded.org
References: <20190108233847.81353-1-mark.hatle@windriver.com>
	<20190108233847.81353-3-mark.hatle@windriver.com>
	<20190109011827.4crsftenh2c5pfst@axis.com>
MIME-Version: 1.0
In-Reply-To: <20190109011827.4crsftenh2c5pfst@axis.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-TM-AS-GCONF: 00
Subject: Re: [PATCH 2/3] gitsm.py: Add support for alternative URL formats from submodule files
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
X-List-Received-Date: Wed, 09 Jan 2019 01:29:04 -0000
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 19-01-09 02:18 +0100, Olof Johansson wrote:
> The path in an ssh:// uri is absolute, so the relative case must
> be handled differently. But it's easy, git supports ~ expansion,
> like:
> 
>   alice@example.com:foo.git -> ssh://alice@example.com/~/foo.git

Tested some more. This works with git over openssh (possibly only
against unix systems), but not with github it seems, so this
wasn't as general of a solution I hoped. Sorry. I think the issue
is real, but my proposed solution wasn't :(.

And, of course, the github ssh remote specifiers all look like
git@github.com:alice/foo.

-- 
olofjn

