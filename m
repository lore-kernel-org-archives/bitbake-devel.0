Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 69E4276DEB
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Sep 2015 13:23:18 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga101.jf.intel.com with ESMTP; 25 Sep 2015 06:23:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,587,1437462000"; d="scan'208";a="812819536"
Received: from jjkivilu-mobl2.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.20.126])
	by fmsmga002.fm.intel.com with ESMTP; 25 Sep 2015 06:23:16 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 25 Sep 2015 14:23:16 +0100
Message-ID: <1482465.yFbZt7i8TL@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.9 (Linux/4.1.6-100.fc21.x86_64; KDE/4.14.9; x86_64; ; )
In-Reply-To: <1443099743-17231-1-git-send-email-markus.lehtonen@linux.intel.com>
References: <1443099743-17231-1-git-send-email-markus.lehtonen@linux.intel.com>
MIME-Version: 1.0
Subject: Re: [PATCH] utils: only add layer once in edit_bblayers_conf()
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
X-List-Received-Date: Fri, 25 Sep 2015 13:23:21 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 24 September 2015 16:02:23 Markus Lehtonen wrote:
> Prevent edit_bblayers_conf() from adding layer(s) multiple times. This
> happened when BBLAYERS variable was "listed" multiple times in
> bblayer.conf - i.e. the configuration was split into multiple separate
> assignments.
> 
> [YOCTO #8316]
> 
> Signed-off-by: Markus Lehtonen <markus.lehtonen@linux.intel.com>
> ---
>  lib/bb/utils.py | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/bb/utils.py b/lib/bb/utils.py
> index 91faa49..9b550ef 100644
> --- a/lib/bb/utils.py
> +++ b/lib/bb/utils.py
> @@ -1249,6 +1249,7 @@ def edit_bblayers_conf(bblayers_conf, add, remove):
>                      bblayers.append(addlayer)
>                  else:
>                      notadded.append(addlayer)
> +            del addlayers[:]
> 
>          if updated:
>              return (bblayers, None, 2, False)

Nice, a much simpler fix than I'd immediately assumed it would be when I read 
the bug :)

Acked-by: Paul Eggleton <paul.eggleton@linux.intel.com>

-- 

Paul Eggleton
Intel Open Source Technology Centre

