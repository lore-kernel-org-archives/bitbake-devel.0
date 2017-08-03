Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by mail.openembedded.org (Postfix) with ESMTP id 347076076F
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  3 Aug 2017 22:15:02 +0000 (UTC)
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
	by fmsmga105.fm.intel.com with ESMTP; 03 Aug 2017 15:15:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.41,318,1498546800"; d="scan'208";a="135866716"
Received: from getta-mobl.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.39.169])
	by fmsmga006.fm.intel.com with ESMTP; 03 Aug 2017 15:15:03 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Mark Hatle <mark.hatle@windriver.com>
Date: Fri, 04 Aug 2017 00:15:02 +0200
Message-ID: <1573680.eRU8eE1tyc@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
In-Reply-To: <1fcf3861-fd8e-042d-2a05-0bfe9c6aab14@windriver.com>
References: <1501256242-37784-1-git-send-email-mark.hatle@windriver.com>
	<7053389.oLP1XTmJTf@peggleto-mobl.ger.corp.intel.com>
	<1fcf3861-fd8e-042d-2a05-0bfe9c6aab14@windriver.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org, toaster@yoctoproject.org
Subject: Re: [PATCH 4/5] toaster/orm/management/commands/lsupdates.py: Use new layerindex module
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
X-List-Received-Date: Thu, 03 Aug 2017 22:15:03 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, 3 August 2017 8:18:03 PM CEST Mark Hatle wrote:
> On 8/3/17 1:06 PM, Paul Eggleton wrote:
> > On Friday, 28 July 2017 5:37:21 PM CEST Mark Hatle wrote:
> >> Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
> > 
> > Missing a commit message - and you wrote the book on proper commit 
> > messages :p
> 
> In this case, what is wrong with the message.  The change doesn't do
> anything but use the new layer index module.  Functionality remains the 
> same.

Wouldn't you at minimum want to state exactly that last bit then? That isn't 
clear without carefully looking through the patch.

Same for the other commit, except there what is displayed by bitbake-layers 
layerindex-fetch has changed a little bit.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

