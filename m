Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by mail.openembedded.org (Postfix) with ESMTP id 8C0EA780BD
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Jun 2017 06:26:32 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga105.fm.intel.com with ESMTP; 06 Jun 2017 23:26:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.39,310,1493708400"; d="scan'208";a="1179296861"
Received: from tamesede-mobl2.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.37.222])
	by fmsmga002.fm.intel.com with ESMTP; 06 Jun 2017 23:26:33 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: vijaikumar k <vijaikumar.k@mistralsolutions.com>
Date: Wed, 07 Jun 2017 08:26:31 +0200
Message-ID: <2162628.u3sMv0zo5j@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
In-Reply-To: <CADOTBT2Ps9wzWRGogvZJ1PX6zeuAUXhiyzEjiqDdzsbKDCHLGQ@mail.gmail.com>
References: <CADOTBT2Ps9wzWRGogvZJ1PX6zeuAUXhiyzEjiqDdzsbKDCHLGQ@mail.gmail.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Overriding bitbake functions
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
X-List-Received-Date: Wed, 07 Jun 2017 06:26:34 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, 6 June 2017 9:16:02 AM CEST vijaikumar k wrote:
> I need to override an append function in bitbake. Just wondering if
> there is a way to do it.
> 
> do_configure()
> do_configure_append()
> do_configure_append_mymachine()
> 
> I want to replace/override do_configure_append() with
> do_configure_append_mymachine(). Is this possible? I do not want to
> disturb do_configure and do_configure_append function. All the
> functions are in the same bb file.

_append operations stack up, they can't override eachother, so if MACHINE is 
"mymachine" then the final do_configure that gets executed will consist of 
do_configure, do_configure_append, and do_configure_append_mymachine. You 
should set the contents of those accordingly.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

