Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id AEF7478555
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 22 Jan 2018 20:02:36 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	22 Jan 2018 12:02:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,398,1511856000"; d="scan'208";a="25421819"
Received: from cdsouzax-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.249.64.40])
	by orsmga001.jf.intel.com with ESMTP; 22 Jan 2018 12:02:34 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Amanda Brindle <amanda.r.brindle@intel.com>
Date: Tue, 23 Jan 2018 09:02:30 +1300
Message-ID: <6192920.y9QKLpEl5j@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
In-Reply-To: <57f40b8b016e6f9e4539d919d323dd6b6d75c31a.1516394932.git.amanda.r.brindle@intel.com>
References: <cover.1516394932.git.amanda.r.brindle@intel.com>
	<57f40b8b016e6f9e4539d919d323dd6b6d75c31a.1516394932.git.amanda.r.brindle@intel.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] tinfoil.py: Check if BUILDDIR exists
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
X-List-Received-Date: Mon, 22 Jan 2018 20:02:36 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Amanda,

On Saturday, 20 January 2018 9:53:13 AM NZDT Amanda Brindle wrote:
> +        basepath = os.environ.get('BUILDDIR')
> +        if not basepath:
> +            print("Tinfoil can only be run after initialising the build
> environment (e.g. by using oe-init-build-env)")
> +            sys.exit(1)
> +

We should be raising an exception here - tinfoil is utility code, it shouldn't 
be calling sys.exit(). Additionally, bitbake shouldn't be referring to 
oe-init-build-env, that's something from OpenEmbedded; even mentioning Tinfoil 
isn't going to be much use to the user. I would simply raise a custom 
exception class with the message "Build environment not initialised" or 
similar, and if tinfoil-using want to catch that exception and produce a more 
friendly message they can fairly easily do so.

Cheers,
Paul


-- 

Paul Eggleton
Intel Open Source Technology Centre

