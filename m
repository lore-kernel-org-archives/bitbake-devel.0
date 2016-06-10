Return-Path: <mariano.lopez@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 5D49662134
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Jun 2016 19:53:33 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga101.fm.intel.com with ESMTP; 10 Jun 2016 12:53:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,451,1459839600"; d="scan'208";a="995233155"
Received: from mlopezva-mobl2.zpn.intel.com (HELO [10.219.5.49])
	([10.219.5.49])
	by orsmga002.jf.intel.com with ESMTP; 10 Jun 2016 12:53:35 -0700
To: bitbake-devel@lists.openembedded.org
References: <cover.1465559091.git.mariano.lopez@linux.intel.com>
	<3da6a3ae457fb93388b3ae2a255a043b60626f42.1465559091.git.mariano.lopez@linux.intel.com>
From: Mariano Lopez <mariano.lopez@linux.intel.com>
Message-ID: <575B1ABE.8070506@linux.intel.com>
Date: Fri, 10 Jun 2016 14:53:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <3da6a3ae457fb93388b3ae2a255a043b60626f42.1465559091.git.mariano.lopez@linux.intel.com>
Subject: Re: [PATCH 1/1] update-rc.d.bbclass: Disable class when sysvinit is not in DISTRO_FEATURES
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
X-List-Received-Date: Fri, 10 Jun 2016 19:53:36 -0000
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 06/10/2016 06:45 AM, mariano.lopez@linux.intel.com wrote:
> From: Mariano Lopez <mariano.lopez@linux.intel.com>
>
> When sysvinit is not in use, update-rd.d class adds build dependencies
> that won't be needed, this patch removes the build dependecies and
> won't add the task to PACKAGESPLITFUNCS.
>
> [YOCTO #9515]
>
Please disregard this patch, it was meant for OE-core. Sorry for the spam

Mariano

