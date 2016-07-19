Return-Path: <belen.barros.pena@intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 46F3360746
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Jul 2016 09:43:17 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga104.fm.intel.com with ESMTP; 19 Jul 2016 02:43:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,389,1464678000"; d="scan'208";a="141767063"
Received: from irsmsx107.ger.corp.intel.com ([163.33.3.99])
	by fmsmga004.fm.intel.com with ESMTP; 19 Jul 2016 02:43:17 -0700
Received: from irsmsx110.ger.corp.intel.com ([169.254.15.97]) by
	IRSMSX107.ger.corp.intel.com ([169.254.10.204]) with mapi id
	14.03.0248.002; Tue, 19 Jul 2016 10:43:16 +0100
From: "Barros Pena, Belen" <belen.barros.pena@intel.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>, Gary Thomas
	<gary@mlbassoc.com>
Thread-Topic: [bitbake-devel] New progress meters
Thread-Index: AQHR4aH5NEeTa9ZtOki7ZG6hjsCATg==
Date: Tue, 19 Jul 2016 09:43:16 +0000
Message-ID: <D3B3B3B3.81640%belen.barros.pena@intel.com>
References: <578DC9D2.1060607@mlbassoc.com>
	<9795063.LvlJDZtIeJ@peggleto-mobl.ger.corp.intel.com>
In-Reply-To: <9795063.LvlJDZtIeJ@peggleto-mobl.ger.corp.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/14.6.5.160527
x-originating-ip: [10.252.2.235]
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: New progress meters
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
X-List-Received-Date: Tue, 19 Jul 2016 09:43:20 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <52ACF67787DF494490AE68CB729CBF68@intel.com>
Content-Transfer-Encoding: quoted-printable



On 19/07/2016 10:16, "bitbake-devel-bounces@lists.openembedded.org on
behalf of Paul Eggleton" <bitbake-devel-bounces@lists.openembedded.org on
behalf of paul.eggleton@linux.intel.com> wrote:

>Hi Gary,
>
>On Tue, 19 Jul 2016 08:33:54 Gary Thomas wrote:
>> I quite like the new progress meters, but they seem to not be very
>> accurate.  I was just rebuilding webkitgtk and got this:
>>=20
>> 0: webkitgtk-2.12.3-r0 do_compile (pid 30494)  96%
>> |#######################################  | ETA:  0:02:58
>>=20
>> Sadly, it sat there, waffling between 02:58 and 03:44 for about
>> 10 minutes...
>>=20
>> * How is this [estimate] calculated?
>> * Should I be concerned when it's not accurate (or even moving)?
>
>There are a few different types of progress handling for different types
>of=20
>tasks. To be specific in this example, for recipes that inherit cmake
>during=20
>do_compile we report the progress that the cmake-produced makefile prints
>out.=20
>The ETA, which is implemented in the python-progressbar code we are using
>is=20
>kind of a rolling average calculated based on recent progress, so it's
>possible it's inaccurate in this instance if there are places where it
>stalls.=20
>Python-progressbar has an alternative ETA mode which we could try, but to
>be=20
>honest when the progress value sent to it isn't evenly apportioned with
>respect to time and we don't have any weighting information, there's not
>a lot=20
>anyone can do to estimate time remaining accurately. If it's truly
>bothersome=20
>we could just turn off the ETA display I suppose.

Big caveat: this is just my opinion. Displaying information we are not
sure is accurate is probably not a good idea: it disconcerts people,
creates false expectations and ultimately undermines trust on the system.

If you are not sure the ETA is reliable, I would remove it.

Just my 2c.

Cheers

Bel=E9n
=20
>
>> n.b. I wasn't sure the best place for this question, the bitbake
>> list, generic Yocto or OE-core.  Feel free to redirect as needed.
>
>Technically this is an OE question although I know that isn't obvious -
>there=20
>are parts of this that are implemented in BitBake and parts in OE, so
>asking=20
>here is fine.
>
>Cheers,
>Paul
>
>--=20
>
>Paul Eggleton
>Intel Open Source Technology Centre
>--=20
>_______________________________________________
>bitbake-devel mailing list
>bitbake-devel@lists.openembedded.org
>http://lists.openembedded.org/mailman/listinfo/bitbake-devel


