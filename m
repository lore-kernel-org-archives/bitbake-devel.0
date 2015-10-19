Return-Path: <belen.barros.pena@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 7C08C7708E
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 Oct 2015 10:32:24 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga102.fm.intel.com with ESMTP; 19 Oct 2015 03:32:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,701,1437462000"; d="scan'208";a="667167795"
Received: from irsmsx152.ger.corp.intel.com ([163.33.192.66])
	by orsmga003.jf.intel.com with ESMTP; 19 Oct 2015 03:32:23 -0700
Received: from irsmsx110.ger.corp.intel.com ([169.254.15.151]) by
	IRSMSX152.ger.corp.intel.com ([169.254.6.38]) with mapi id
	14.03.0248.002; Mon, 19 Oct 2015 11:32:21 +0100
From: "Barros Pena, Belen" <belen.barros.pena@intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, "Smith, Elliot"
	<elliot.smith@intel.com>
Thread-Topic: [bitbake-devel] [PATCH] cooker: Ensure BB_CONSOLE remains
	correct over server resets
Thread-Index: AQHRCllvEuOGO4/ywU2iv0f73NTTvQ==
Date: Mon, 19 Oct 2015 10:32:20 +0000
Message-ID: <D24A84FE.68625%belen.barros.pena@intel.com>
References: <1444555346.14364.24.camel@linuxfoundation.org>
	<CA+1hgUj5Lty=V_jSWE1YA2CPJuaY5-PAoj+P8gEtzSKDN5gVjA@mail.gmail.com>
	<1445011191.17974.34.camel@linuxfoundation.org>
In-Reply-To: <1445011191.17974.34.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/14.5.6.150930
x-originating-ip: [10.237.224.32]
MIME-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] cooker: Ensure BB_CONSOLE remains correct over server resets
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
X-List-Received-Date: Mon, 19 Oct 2015 10:32:28 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D5AA3BB33715394C8557EAFA4CA9E287@intel.com>
Content-Transfer-Encoding: quoted-printable



On 16/10/2015 16:59, "bitbake-devel-bounces@lists.openembedded.org on
behalf of Richard Purdie" <bitbake-devel-bounces@lists.openembedded.org on
behalf of richard.purdie@linuxfoundation.org> wrote:

>On Fri, 2015-10-16 at 16:57 +0100, Smith, Elliot wrote:
>> Thanks for these, Richard.
>>
>> On 11 October 2015 at 10:22, Richard Purdie
>> <richard.purdie@linuxfoundation.org> wrote:
>>         The console log data is written to is created at console
>>         initialisation
>>         time and does not change over reset events. This ensures the
>>         BB_CONSOLELOG value is correct over such resets by preserving
>>         it.
>>
>> I've put your three patches on top of master and ran a few builds. The
>> result is that all of the logs for those builds are going into a
>> single timestamped file. Before, they went to separate files. Is this
>> intentional, or was the old behaviour incorrect? (Ideally, toaster
>> needs a separate log file for each build.)
>>=20
>It should generate one log file for each "session". A session would be
>one logfile for all bitbake memory resident transactions and a log file
>for each commandline transaction.
>
>It is a "console log", not an individual build log.

Mmmm, for Toaster we need an individual build log, not a console log :/

>
>Cheers,
>
>Richard
>
>
>
>--=20
>_______________________________________________
>bitbake-devel mailing list
>bitbake-devel@lists.openembedded.org
>http://lists.openembedded.org/mailman/listinfo/bitbake-devel


