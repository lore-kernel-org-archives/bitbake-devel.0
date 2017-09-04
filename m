Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 7F3527772F
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  4 Sep 2017 21:42:04 +0000 (UTC)
Received: from orsmga005.jf.intel.com ([10.7.209.41])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	04 Sep 2017 14:42:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.41,476,1498546800"; d="scan'208";a="145411412"
Received: from abestola-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.140.43])
	by orsmga005.jf.intel.com with ESMTP; 04 Sep 2017 14:42:03 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 05 Sep 2017 09:42:00 +1200
Message-ID: <2258613.sUVGlg7gIR@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
In-Reply-To: <0a90099ead0da210757f2a585f626a0a144c6fe1.1504515728.git.paul.eggleton@linux.intel.com>
References: <cover.1504515728.git.paul.eggleton@linux.intel.com>
	<0a90099ead0da210757f2a585f626a0a144c6fe1.1504515728.git.paul.eggleton@linux.intel.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] cooker: clear extra config settings and remote datastores on client disconnect
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
X-List-Received-Date: Mon, 04 Sep 2017 21:42:05 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 4 September 2017 9:03:11 PM NZST Paul Eggleton wrote:
> +    def reset(self):
> +        self.remotedatastores = bb.remotedata.RemoteDatastores(cooker)
> +

Oops, that should have been self.cooker - I only noticed when I happened to 
look at bitbake-cookerdaemon.log. I've re-pushed the branch with that fixed.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

