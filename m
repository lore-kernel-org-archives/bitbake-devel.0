Return-Path: <alexander.kanavin@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 69A3974D38
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Jun 2018 14:20:34 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	01 Jun 2018 07:20:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,467,1520924400"; d="scan'208";a="59556366"
Received: from kanavin-desktop.fi.intel.com (HELO [10.237.68.161])
	([10.237.68.161])
	by fmsmga004.fm.intel.com with ESMTP; 01 Jun 2018 07:20:34 -0700
To: Matt Hoosier <matt.hoosier@gmail.com>, bitbake-devel@lists.openembedded.org
References: <20180525134537.27659-1-matt.hoosier@gmail.com>
	<CAJgxT3_wpJWAdH--G5=W9rqCP9Hg97WvVjXBJHGbeojkWOvD+A@mail.gmail.com>
From: Alexander Kanavin <alexander.kanavin@linux.intel.com>
Message-ID: <3a26a73a-5344-d921-0aeb-cebf7de38b52@linux.intel.com>
Date: Fri, 1 Jun 2018 17:20:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAJgxT3_wpJWAdH--G5=W9rqCP9Hg97WvVjXBJHGbeojkWOvD+A@mail.gmail.com>
Subject: Re: [PATCH v5] fetch/gitsm: avoid live submodule fetching during unpack()
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
X-List-Received-Date: Fri, 01 Jun 2018 14:20:34 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 06/01/2018 05:02 PM, Matt Hoosier wrote:
> I was just wondering what the expected procedure is here among the 
> bitbake devs. Should I be contacting the specific people that have 
> historically been the committers for the particular code affected by the 
> change?

Ross is on holiday this week, so some patience is advised.

Alex

