Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id BE23974E04
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  6 May 2018 21:21:52 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	06 May 2018 14:21:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,371,1520924400"; d="scan'208";a="56435687"
Received: from xuanthon-mobl.ccr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.249.69.224])
	by orsmga002.jf.intel.com with ESMTP; 06 May 2018 14:21:50 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Luis Martins <luis_martins_5@hotmail.com>
Date: Mon, 07 May 2018 09:21:48 +1200
Message-ID: <5674928.R4laaQO6yt@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
In-Reply-To: <AM5PR0902MB2034393B2A72AD72872D272B87820@AM5PR0902MB2034.eurprd09.prod.outlook.com>
References: <AM5PR0902MB2034393B2A72AD72872D272B87820@AM5PR0902MB2034.eurprd09.prod.outlook.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Help with Bitbake: (bitbake-layers show-recipes)
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
X-List-Received-Date: Sun, 06 May 2018 21:21:52 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Luis

FYI this isn't really a question for this mailing list - better the 
openembedded-core list, but I will answer it here anyway.

On Tuesday, 1 May 2018 1:37:47 AM NZST Luis Martins wrote:
> which triggered exception NameError: name 'base_path_relative' is not
> defined

"base_path_relative" and some other related functions have recently been 
removed in master for the upcoming release, and I suspect the other layers you 
are using have not been updated to accommodate this change. You will probably 
need to use the most recent stable release of openembedded-core before this 
change (i.e. the "rocko" branch) in order to be able to build successfully. If 
there is a "rocko" branch available for any other layers you are using you 
would usually be best advised to use that there too - you shouldn't be mixing 
branches.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre



