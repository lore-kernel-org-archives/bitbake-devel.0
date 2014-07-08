Return-Path: <scott.m.rifenbark@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 278AE609C0
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Jul 2014 11:44:51 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 08 Jul 2014 04:44:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,625,1400050800"; d="scan'208";a="569922876"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
	by orsmga002.jf.intel.com with ESMTP; 08 Jul 2014 04:44:52 -0700
Received: from orsmsx113.amr.corp.intel.com (10.22.240.9) by
	ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server
	(TLS) id 14.3.123.3; Tue, 8 Jul 2014 04:44:51 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.157]) by
	ORSMSX113.amr.corp.intel.com ([169.254.7.22]) with mapi id
	14.03.0123.003; Tue, 8 Jul 2014 04:44:52 -0700
From: "Rifenbark, Scott M" <scott.m.rifenbark@intel.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>, BitBake developer list
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] how much effort is going into updating bitbake
	user	manual?
Thread-Index: AQHPmqBC2T/Wk1z6s0aIygl3IDyTTZuWDkbg
Date: Tue, 8 Jul 2014 11:44:51 +0000
Message-ID: <41DEA4B02DBDEF40A0F3B6D0DDB1237983FB688C@ORSMSX101.amr.corp.intel.com>
References: <alpine.LFD.2.11.1407080725470.32352@localhost>
In-Reply-To: <alpine.LFD.2.11.1407080725470.32352@localhost>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.140]
MIME-Version: 1.0
Subject: Re: how much effort is going into updating bitbake user	manual?
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
X-List-Received-Date: Tue, 08 Jul 2014 11:44:59 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable



>-----Original Message-----
>From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
>devel-bounces@lists.openembedded.org] On Behalf Of Robert P. J. Day
>Sent: Tuesday, July 08, 2014 4:31 AM
>To: BitBake developer list
>Subject: [bitbake-devel] how much effort is going into updating bitbake us=
er
>manual?

I am working on it in parallel with the YP docs.  It is prioritized no high=
er or lower.

>
>
>  i ask since i'm teaching an OE/yocto course in a couple weeks, and i wan=
t to
>make the bitbake user manual part of the student kit, which is why i'm
>currently clawing my way through it, being pedantic and all and doing lots=
 of
>(admittedly picky) touchups.
>
>  case in point -- there are at least some BB variables that aren't listed=
 in the
>glossary, such as PARALLEL_MAKE. i'm making a list of these, but i know th=
at
>the yocto project also has a massive reference manual which includes a
>variable glossary. so where should i concentrate my efforts? personally, i=
f
>something is BB-specific, i'd rather it go into the BB user manual.

If it is BB-specific then it definitely goes in the BB-manual

>
>  also, what's the timeframe for getting my patches into the repo? the cou=
rse
>isn't til the week of jul 21-24 so there's lots of time for the patches to=
 be
>applied, it would just be nice to know that they'll be incorporated by the=
 time
>the course starts.

I should have your patches and changes in by end of this week.

>
>  thanks, back to proofreading ...
>
>rday
>
>--
>
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>Robert P. J. Day                                 Ottawa, Ontario, CANADA
>                        http://crashcourse.ca
>
>Twitter:                                       http://twitter.com/rpjday
>LinkedIn:                               http://ca.linkedin.com/in/rpjday
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>--
>_______________________________________________
>bitbake-devel mailing list
>bitbake-devel@lists.openembedded.org
>http://lists.openembedded.org/mailman/listinfo/bitbake-devel

