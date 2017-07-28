Return-Path: <mark.hatle@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 0D91E78527
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Jul 2017 16:04:24 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id v6SG4PVC003298
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Fri, 28 Jul 2017 09:04:26 -0700 (PDT)
Received: from soho-mhatle-m.local (172.25.36.227) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.294.0;
	Fri, 28 Jul 2017 09:04:25 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
References: <1501256242-37784-1-git-send-email-mark.hatle@windriver.com>
	<1501256242-37784-4-git-send-email-mark.hatle@windriver.com>
Organization: Wind River Systems
Message-ID: <e32b065d-0f56-c352-ce8a-f522f8ccf42c@windriver.com>
Date: Fri, 28 Jul 2017 11:04:24 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
	Gecko/20100101 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1501256242-37784-4-git-send-email-mark.hatle@windriver.com>
Cc: toaster@yoctoproject.org
Subject: Re: [PATCH 3/5] lib/bblayers: Add support for the new layer modules
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
X-List-Received-Date: Fri, 28 Jul 2017 16:04:26 -0000
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 7/28/17 10:37 AM, Mark Hatle wrote:
> Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
> ---
>  lib/bblayers/layerindex.py        | 313 +++++++++++---------------------------
>  lib/layers/layerindex/__init__.py |  28 +++-
>  lib/layers/layerindex/cooker.py   |   2 +-
>  lib/layers/layerindex/restapi.py  |  95 +++++++-----
>  lib/layers/manager/__init__.py    |  59 ++++---
>  5 files changed, 210 insertions(+), 287 deletions(-)

Argh, I just realized a bunch of fixes got merge to this patch, they should have
been merged to 1/5.

I've fixed this in the git tree.

--Mark


