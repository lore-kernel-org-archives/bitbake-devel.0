Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id BBC1D71ADE
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 12 Mar 2017 23:18:44 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	12 Mar 2017 16:18:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.36,154,1486454400"; d="scan'208";a="1107680351"
Received: from duylanng-mobl.ccr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.130.13])
	by orsmga001.jf.intel.com with ESMTP; 12 Mar 2017 16:18:44 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: kk <pinganddu90@gmail.com>
Date: Mon, 13 Mar 2017 12:18:41 +1300
Message-ID: <2127452.SPVY650BJx@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
In-Reply-To: <CAKHP1dvO0V3+d5jbAXx6-3t+TxnjZzh210voMqrbxZKGmrai1A@mail.gmail.com>
References: <CAKHP1dvO0V3+d5jbAXx6-3t+TxnjZzh210voMqrbxZKGmrai1A@mail.gmail.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: What does the "fn" represent for in "<fn>:<taskname>"?
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
X-List-Received-Date: Sun, 12 Mar 2017 23:18:46 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi there,

On Monday, 13 March 2017 2:24:32 AM NZDT kk wrote:
> In commit:
>     2c88afb60da54e58f555411a7bd7b006b0c29306
> uses "<fn>:<taskname>" as the ID for tasks rather than a number, I know
> taskname represent for, but the <fn> I don't understand, does it means file
> name or function name?

File name.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

