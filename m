Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	by mail.openembedded.org (Postfix) with ESMTP id 781727FC8A
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 17 Sep 2019 22:25:40 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	17 Sep 2019 15:25:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,518,1559545200"; d="scan'208";a="211645750"
Received: from mnazeli-mobl.gar.corp.intel.com (HELO linux.fritz.box)
	([10.255.175.201])
	by fmsmga004.fm.intel.com with ESMTP; 17 Sep 2019 15:25:35 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Yeoh Ee Peng <ee.peng.yeoh@intel.com>
Date: Wed, 18 Sep 2019 10:25:33 +1200
Message-ID: <5382761.1ppftfcbhl@linux.fritz.box>
Organization: Intel Corporation
In-Reply-To: <1568347121-43357-2-git-send-email-ee.peng.yeoh@intel.com>
References: <1568347121-43357-1-git-send-email-ee.peng.yeoh@intel.com>
	<1568347121-43357-2-git-send-email-ee.peng.yeoh@intel.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/3] bitbake: bitbake-layers: show-recipes: Show unique packagenames
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
X-List-Received-Date: Tue, 17 Sep 2019 22:25:40 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, 13 September 2019 3:58:39 PM NZST Yeoh Ee Peng wrote:
> Currently, show-recipes will show all recipes available (both
> recipes with different version and recipes provided by more
> than one layer).
> 
> Example of default $ bitbake-layers show-recipes:
> core-image-rt:
>   meta-intel           unknown (skipped)
>   meta                 unknown (skipped)
> 
> yajl:
>   meta-oe              2.1.0
>   meta-oe              1.0.12
> 
> Add -p argument to enable showing unique packagenames. This
> provide a focus view on unique recipes available.

In this context, these aren't package names, they are recipe names - so we need to be using that naming. Accordingly I would recommend -r/--recipe-only as the option name.
 
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre



