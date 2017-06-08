Return-Path: <mark.hatle@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 2532871AB7
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  8 Jun 2017 14:21:26 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id v58ELMV6018186
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK);
	Thu, 8 Jun 2017 07:21:22 -0700
Received: from soho-mhatle-m.local (172.25.36.226) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.294.0;
	Thu, 8 Jun 2017 07:21:21 -0700
To: Patrick Ohly <patrick.ohly@intel.com>, Peter Kjellerstedt
	<peter.kjellerstedt@axis.com>
References: <cover.36a6c17ae3fab020393e82b397fb5a16681be9d7.1496843701.git-series.patrick.ohly@intel.com>
	<c05bcbe8dd83f969f56e7ef93a2ea545fab4cf2c.1496843701.git-series.patrick.ohly@intel.com>
	<4c164d2f9d254f8cbb09e54fe6d9424e@XBOX02.axis.com>
	<1496903047.30163.127.camel@intel.com>
From: Mark Hatle <mark.hatle@windriver.com>
Organization: Wind River Systems
Message-ID: <3b8cc699-8c79-0b8d-9baf-b5c4b051bf8f@windriver.com>
Date: Thu, 8 Jun 2017 09:21:21 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
	Gecko/20100101 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <1496903047.30163.127.camel@intel.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 1/2] ConfHandler.py: allow inherit or include without parameter
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
X-List-Received-Date: Thu, 08 Jun 2017 14:21:27 -0000
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 6/8/17 1:24 AM, Patrick Ohly wrote:
> On Wed, 2017-06-07 at 14:47 +0000, Peter Kjellerstedt wrote:
>>> -----Original Message-----
>>> From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
>>> devel-bounces@lists.openembedded.org] On Behalf Of Patrick Ohly
>>> Sent: den 7 juni 2017 15:56
>>> To: bitbake-devel@lists.openembedded.org
>>> Subject: [bitbake-devel] [PATCH 1/2] ConfHandler.py: allow inherit or
>>> include without parameter
>>
>> Change "inherit or include" to "include or require".
>>
>>> Writing .bbappends that only have an effect when some configuration
>>> variable like DISTRO_FEATURES is changed becomes easier when allowing
>>> "inherit" or "require" without a parameter. The same was already
>>
>> Change "inherit" to "include".
> 
> You are right of course. At least I was consistent in my mistake ;-} I
> guess I'm still struggling with the oddly named "require" vs. "include"
> distinction.

require -- it's an error if it doesn't exist
include -- it's NOT an error if it doesn't exist

Yes, this has messed up others, but too late to do anything about it without a
massive change.  (These can load 'any' files...)

(while inherit is only class files)

--Mark

> I can send a V2 if there are no other objections, or perhaps it can be
> fixed up as part of merging?
> 


