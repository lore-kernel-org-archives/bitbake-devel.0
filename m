Return-Path: <jair.de.jesus.gonzalez.plascencia@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 1FBF677E4D
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  8 Dec 2017 21:24:21 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	08 Dec 2017 13:24:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.45,379,1508828400"; 
   d="scan'208";a="1079151"
Received: from jairdeje-mobl3.amr.corp.intel.com (HELO jairdejeMOBL3)
	([10.218.162.94])
	by fmsmga008.fm.intel.com with ESMTP; 08 Dec 2017 13:24:22 -0800
From: "Jair Gonzalez" <jair.de.jesus.gonzalez.plascencia@linux.intel.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 8 Dec 2017 15:24:22 -0600
Message-ID: <005001d3706a$ea82c7c0$bf885740$@linux.intel.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AdNwaseOAORpUOTDTYScJXsmughprA==
x-ctpclassification: CTP_IC
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiN2IwNzBhYWMtMGRlNS00NzAyLWJhNjItYTY3YTQ0YjBlNTQ0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX0lDIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE2LjUuOS4zIiwiVHJ1c3RlZExhYmVsSGFzaCI6InVNWWlHekw1bWlpSHU4WjRSNnl2SWlxSzJGTld5QUt1YTdtd0VIZERpUHM9In0=
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
Subject: Re: [selftest][PATCH V1 0/5] QA: Extend unit tests for event module
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
X-List-Received-Date: Fri, 08 Dec 2017 21:24:22 -0000
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: en-us

Hello,

Have you been able to review this series of patches? It's being tracked on
bug 10773.

Please let me know if you have any doubts or comments about it.

Regards,
Jair Gonzalez

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-devel-
> bounces@lists.openembedded.org] On Behalf Of Jair Gonzalez
> Sent: Thursday, August 17, 2017 3:41 PM
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [selftest][PATCH V1 0/5] QA: Extend unit tests
for event
> module
> 
> Included on V1:
> 
>   This patch-set extends the unit test module for bitbake event
>   including increased coverage for event filtering features and
>   testing of public interfaces of event and helper classes. It
>   also includes two small fixes for issues found during the unit
>   test development.
> 
> [YOCTO #10773]
> 
> The following changes since commit
> 6016ec177af2406cacfeb3276dfcb8bfc3df8fce:
> 
>   poky.conf: Enable vulkan by default (2017-08-16 00:04:39 +0100)
> 
> are available in the git repository at:
> 
>   git://git.yoctoproject.org/poky-contrib jairglez/bbevent_extended
>   http://git.yoctoproject.org/cgit.cgi/poky-
> contrib/log/?h=jairglez/bbevent_extended
> 
> Jair Gonzalez (5):
>   bitbake: tests: Include tests for event filtering features
>   bitbake: tests: Add test for bb.event.worker_fire
>   bitbake: tests: Remove empty assignments from event tests
>   bitbake: tests: Initialize data attribute on BuildBase event
>   bitbake: tests: Add event classes test class
> 
>  lib/bb/event.py       |   1 +
>  lib/bb/tests/event.py | 646
> +++++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 634 insertions(+), 13 deletions(-)
> 
> --
> 2.7.4
> 
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel


