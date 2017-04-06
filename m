Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id DB6C377CFF
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Apr 2017 20:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=intel.com; i=@intel.com; q=dns/txt; s=intel;
	t=1491511249; x=1523047249;
	h=from:to:cc:subject:date:message-id:in-reply-to:
	references:mime-version:content-transfer-encoding;
	bh=Dt9KiAuFcbIM65Xnx2tqPBIxeme0HUjxD6HEVgO9v8w=;
	b=e+XujHFnF01gDczJ7HXLN4hdEJmZ5Odn9H75MnPrkrsD4UU6z+n2S+0O
	rVpv07TgpZe7fFlQDaAhhOniR1U/AQ==;
Received: from orsmga005.jf.intel.com ([10.7.209.41])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	06 Apr 2017 13:40:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.37,161,1488873600"; d="scan'208";a="84298679"
Received: from anatara2-mobl2.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.141.179])
	by orsmga005.jf.intel.com with ESMTP; 06 Apr 2017 13:40:46 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: "Bystricky, Juro" <juro.bystricky@intel.com>
Date: Fri, 07 Apr 2017 08:40:45 +1200
Message-ID: <2597068.qIm7XQQg7K@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
In-Reply-To: <6E51916E4A1F32428260031F4C7CD2B61193F7F1@ORSMSX112.amr.corp.intel.com>
References: <1491427991-8595-1-git-send-email-juro.bystricky@intel.com>
	<CABcZAN=6rGsbmXsQaDdpRspNwJBv5p5zD_DqJkJxBMs42j0K+Q@mail.gmail.com>
	<6E51916E4A1F32428260031F4C7CD2B61193F7F1@ORSMSX112.amr.corp.intel.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] tinfoil.py: validate argument in parse_recipe_file
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
X-List-Received-Date: Thu, 06 Apr 2017 20:40:48 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, 7 April 2017 3:15:21 AM NZST Bystricky, Juro wrote:
> parse_recipe can be called from parse_recipe_file as well. If
> parse_recipe_file is called with a non-existing recipe, you end up with the
> exception as well. IMHO for a  non-existent recipe parse_recipe should
> return None (instead of an exception)

I'm not sure I agree - an exception under these circumstances seems completely 
reasonable to me as well.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

