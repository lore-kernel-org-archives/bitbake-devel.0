Return-Path: <ross.burton@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 0D0DF79AE7
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Jan 2020 14:07:56 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	15 Jan 2020 06:07:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,322,1574150400"; d="scan'208";a="213710493"
Received: from jmmarti7-mobl1.amr.corp.intel.com (HELO rburton-mac01.local)
	([10.252.51.74])
	by orsmga007.jf.intel.com with ESMTP; 15 Jan 2020 06:07:57 -0800
To: frazer.clews@codethink.co.uk, bitbake-devel@lists.openembedded.org
References: <20200114144024.163030-1-frazer.clews@codethink.co.uk>
From: Ross Burton <ross.burton@intel.com>
Organization: Intel Corporation (UK) Ltd. - Co. Reg. #1134945 - Pipers Way,
	Swindon SN3 1RJ
Message-ID: <1b13f770-5d64-8c62-9baa-f0be71be374f@intel.com>
Date: Wed, 15 Jan 2020 14:07:55 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
	Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200114144024.163030-1-frazer.clews@codethink.co.uk>
Subject: Re: [PATCH] lib: amend code to use proper singleton comparisons where possible
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
X-List-Received-Date: Wed, 15 Jan 2020 14:07:57 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 14/01/2020 14:40, frazer.clews@codethink.co.uk wrote:
> --- a/lib/bb/fetch2/osc.py
> +++ b/lib/bb/fetch2/osc.py
> @@ -43,7 +43,7 @@ class Osc(FetchMethod):
>           else:
>               pv = d.getVar("PV", False)
>               rev = bb.fetch2.srcrev_internal_helper(ud, d)
> -            if rev and rev != True:
> +            if rev and not rev:
>                   ud.revision = rev
>               else:
>                   ud.revision = ""

I don't think that's what was intended!

The previous logic is saying "if rev as a bool is true and if rev is not 
actually True" then do something.  srcrev_internal_helper appears to 
always return a string or None so I'd imagine this test could be 
simplified to just if rev.

Ross

