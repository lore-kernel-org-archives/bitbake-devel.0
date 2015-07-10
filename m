Return-Path: <anibal.limon@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id AE6EB73710
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Jul 2015 20:14:44 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga101.fm.intel.com with ESMTP; 10 Jul 2015 13:14:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,449,1432623600"; d="scan'208";a="522194798"
Received: from mtedesco-mobl3.amr.corp.intel.com (HELO [10.254.109.160])
	([10.254.109.160])
	by FMSMGA003.fm.intel.com with ESMTP; 10 Jul 2015 13:14:44 -0700
Message-ID: <55A02839.9040907@linux.intel.com>
Date: Fri, 10 Jul 2015 15:16:57 -0500
From: =?UTF-8?B?QW7DrWJhbCBMaW3Ds24=?= <anibal.limon@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <1436546684-30539-1-git-send-email-anibal.limon@linux.intel.com>
	<1436547305.3310.13.camel@linuxfoundation.org>
In-Reply-To: <1436547305.3310.13.camel@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] parse/ast.py: MethodNode fix character mapping error
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
X-List-Received-Date: Fri, 10 Jul 2015 20:14:48 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Richard,

Sorry it was my mistake in my code because i'm loading a recipe file 
using bb.cache.Cache.loadDataFull
passing an unicode filepath this causes the error but i think it need to 
be sanitized? to avoid this kind of
problems.

Cheers,
     alimon

On 10/07/15 11:55, Richard Purdie wrote:
> On Fri, 2015-07-10 at 11:44 -0500, Aníbal Limón wrote:
>> When found an anonymous function the func name is made by filename
>> and lineno, the filename need to be converted to string before using
>> translation because produces an error of encoding.
> Could you explain a little about why we don't hit this error in general?
>
> Cheers,
>
> Richard
>


