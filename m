Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id D453277D76
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Apr 2017 08:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=intel.com; i=@intel.com; q=dns/txt; s=intel;
	t=1491553605; x=1523089605;
	h=from:to:cc:subject:date:message-id:in-reply-to:
	references:mime-version:content-transfer-encoding;
	bh=maflEXNhWZ7mxuLoc2KDMQzt5pOO9eFRUsf4CZigbbU=;
	b=WjCZ0iONOHepL29VXtwv5H5GjQ5+u7eRkZ0SQ/4Fvbw0VFppuK7m/GzQ
	I2YvF4qwnOij7l/e47OaV/SV6egqvA==;
Received: from orsmga005.jf.intel.com ([10.7.209.41])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	07 Apr 2017 01:26:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.37,164,1488873600"; d="scan'208";a="84612160"
Received: from anatara2-mobl2.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.141.179])
	by orsmga005.jf.intel.com with ESMTP; 07 Apr 2017 01:26:40 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Patrick Ohly <patrick.ohly@intel.com>
Date: Fri, 07 Apr 2017 20:26:37 +1200
Message-ID: <1955431.r1d7W8j1YV@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
In-Reply-To: <1491547069.10884.55.camel@intel.com>
References: <cover.1491514854.git.paul.eggleton@linux.intel.com>
	<9a743ad396af642fc20961e38fb7f6c5752f2446.1491514854.git.paul.eggleton@linux.intel.com>
	<1491547069.10884.55.camel@intel.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 09/11] lib/bb/siggen: add collapsed mode to compare_sigfiles()
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
X-List-Received-Date: Fri, 07 Apr 2017 08:26:44 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, 7 April 2017 6:37:49 PM NZST Patrick Ohly wrote:
> On Fri, 2017-04-07 at 09:52 +1200, Paul Eggleton wrote:
> > If we just want to drill down to the actual differences then we don't
> > need to see certain things in the output, e.g. basehash changing or the
> > signature of dependent tasks. This will be used for comparing signatures
> > within buildhistory-diff in OE-Core; the default mode as used by
> > bitbake-diffsigs and bitbake -S printdiff remains unchanged for the
> > moment.
> 
> This sounds interesting. The bitbake-diffsigs output I got for the
> yocto-compat-layer had such useless "basehash changed" comments. Should
> we add a mode parameter to bitbake-diffsigs that allows choosing this
> collapsed mode?

We could, but to be effective the caller needs to handle the output in a 
particular way (see what I've done in the buildhistory-diff patchset I sent 
today).

FYI my plan for 2.4 is to evaluate whether this collapsed mode or something 
like it is better as a default display mode.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

