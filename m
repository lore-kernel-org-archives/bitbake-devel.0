Return-Path: <mark.hatle@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id C69AC60746
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 30 May 2017 19:54:58 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id v4UJsvPG022851
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 30 May 2017 12:54:57 -0700 (PDT)
Received: from soho-mhatle-m.local (172.25.36.235) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.294.0;
	Tue, 30 May 2017 12:54:57 -0700
To: Christopher Larson <kergoth@gmail.com>, Patrick Ohly
	<patrick.ohly@intel.com>
References: <cf231a157650f22c55ce6861ce824b74b245af55.1495450175.git-series.patrick.ohly@intel.com>
	<CABcZAN=d7BHGOM9602pfbA4N6chDB8b8RDKB4xo6fhCChDx0Rg@mail.gmail.com>
From: Mark Hatle <mark.hatle@windriver.com>
Organization: Wind River Systems
Message-ID: <82a538e6-bc83-a7f8-87f5-f5d198101028@windriver.com>
Date: Tue, 30 May 2017 14:54:55 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
	Gecko/20100101 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CABcZAN=d7BHGOM9602pfbA4N6chDB8b8RDKB4xo6fhCChDx0Rg@mail.gmail.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] cooker.py: allow dangling bbappends if explicitly whitelisted
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
X-List-Received-Date: Tue, 30 May 2017 19:54:59 -0000
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit

On 5/25/17 10:50 AM, Christopher Larson wrote:
> 
> On Mon, May 22, 2017 at 3:50 AM, Patrick Ohly <patrick.ohly@intel.com
> <mailto:patrick.ohly@intel.com>> wrote:
> 
>     Having a .bbappend without corresponding .bb file triggers an error or
>     at least warning, depending on the global BB_DANGLINGAPPENDS_WARNONLY.
> 
>     Some layers (for example, meta-freescale) avoid that message by only
>     adding .bbappends to the BBFILES when the layers they apply to are
>     present. Others (like intel-iot-refkit) avoid such .bbappends by
>     falling back to global assignments with _pn-<recipe> as override. Both
>     is complicated.
> 
>     Now the warning code checks BBAPPENDS_DANGLING_WHITELIST and ignores
>     all bbappends which match a file pattern in that list. This is an
>     easier way to have bbappends which may or may not apply to an
>     existing recipe.
> 
> 
> IMHO this makes it too easy to miss legitimate problems. By adding them only
> when the layers are present, you ensure that if that layer removes the recipe
> you’re appending, you’ll immediately know it. This hides such actual problems by
> suppressing for all optional appends across the board.

I agree.  I prefer the Freescale approach.  Only add the bbappend when the thing
it should be appending is present.

Avoids the problem of 'hidden' errors (things missing), but does cause an issue
with more combinations needing to be tested, but at least this is more explicit.

--Mark

