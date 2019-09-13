Return-Path: <ross.burton@intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id D9F7C60557
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Sep 2019 11:14:51 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
	by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	13 Sep 2019 04:14:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,500,1559545200"; d="scan'208";a="186406801"
Received: from asomsiko-mobl1.ccr.corp.intel.com (HELO blackadder.local)
	([10.252.54.186])
	by fmsmga007.fm.intel.com with ESMTP; 13 Sep 2019 04:14:52 -0700
To: bitbake-devel@lists.openembedded.org
References: <20190912123627.96-1-Martin.Jansa@gmail.com>
From: Ross Burton <ross.burton@intel.com>
Organization: Intel Corporation (UK) Ltd. - Co. Reg. #1134945 - Pipers Way,
	Swindon SN3 1RJ
Message-ID: <9f114bd9-64cc-b98a-9caa-a1078a93243d@intel.com>
Date: Fri, 13 Sep 2019 12:14:51 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
	Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190912123627.96-1-Martin.Jansa@gmail.com>
Subject: Re: [PATCH] Revert "bitbake: cooker: Ensure bbappends are found in stable order"
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
X-List-Received-Date: Fri, 13 Sep 2019 11:14:52 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 12/09/2019 13:36, Martin Jansa wrote:
> This reverts commit 94c0c7f15c7a6244a8576ed948ffc21afb96ba82.
> 
> This ignores the layer priority, making the issue much worse.
> E.g. I'm seeing a lot of failures caused by missing users, because
> base-passwd bbappends applied in unexpected order caused different
> passwd.master to be found in re-ordered FILESPATH.

Would you be able to write a little test case to verify that this sort 
of behavioural change doesn't sneak in again?

Ross

