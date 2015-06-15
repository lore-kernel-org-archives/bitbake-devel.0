Return-Path: <scott.m.rifenbark@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 7D5D460097
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Jun 2015 12:57:36 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga102.jf.intel.com with ESMTP; 15 Jun 2015 05:57:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.13,618,1427785200"; d="scan'208";a="727618995"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
	by fmsmga001.fm.intel.com with ESMTP; 15 Jun 2015 05:57:35 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.217]) by
	ORSMSX102.amr.corp.intel.com ([169.254.1.15]) with mapi id
	14.03.0224.002; Mon, 15 Jun 2015 05:57:35 -0700
From: "Rifenbark, Scott M" <scott.m.rifenbark@intel.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] Allow access to specific git server while
	BB_FETCH_PREMIRRORONLY ="1"
Thread-Index: AQHQputJB8nOYFBfi0ePO3beOl35PZ2t/MKA//+K8xA=
Date: Mon, 15 Jun 2015 12:57:34 +0000
Message-ID: <41DEA4B02DBDEF40A0F3B6D0DDB123798D20329F@ORSMSX101.amr.corp.intel.com>
References: <355BE46A91031048906B695426A8D8E616BEA6C0@DEFTHW99EH4MSX.ww902.siemens.net>
	<CABcZANnmPX=wU8BNt+y3UnCLOkbB9LWR-Lwgw6zVxa-_+PF6kQ@mail.gmail.com>
	<FDD27E4D-9B52-49FA-A99A-076F615C3A5D@gmail.com>
	<2537868.NScFGFhOWl@peggleto-mobl.ger.corp.intel.com>
In-Reply-To: <2537868.NScFGFhOWl@peggleto-mobl.ger.corp.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.139]
MIME-Version: 1.0
Cc: Christopher Larson <clarson@kergoth.com>
Subject: Re: Allow access to specific git server while	BB_FETCH_PREMIRRORONLY ="1"
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
X-List-Received-Date: Mon, 15 Jun 2015 12:57:36 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Someone?  Ha. =20

>-----Original Message-----
>From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
>devel-bounces@lists.openembedded.org] On Behalf Of Paul Eggleton
>Sent: Monday, June 15, 2015 5:56 AM
>To: bitbake-devel@lists.openembedded.org
>Cc: Christopher Larson
>Subject: Re: [bitbake-devel] Allow access to specific git server while
>BB_FETCH_PREMIRRORONLY =3D"1"
>
>On Sunday 14 June 2015 23:43:54 Bernhard Reutner-Fischer wrote:
>> On June 12, 2015 3:04:17 PM GMT+02:00, Christopher Larson
><clarson@kergoth.com> wrote:
>> >On Fri, Jun 12, 2015 at 7:47 AM, Bach, Pascal
>> ><pascal.bach@siemens.com>
>> >
>> >wrote:
>> >> I was wondering if there is a way to allow access to specific urls
>> >
>> >even if
>> >
>> >> BB_NO_NETWORK or BB_FETCH_PREMIRRORONLY is set.
>> >>
>> >> The use case I have at hand it that we want to fetch all 3rd party
>> >
>> >sources
>> >
>> >> from a HTTP premirror we have internally. Except for some packages
>> >
>> >that
>> >
>> >> are hosted on a git server where we would like bitbake to always
>> >
>> >fetch from
>> >
>> >> there (no tarball on the pre mirror).
>> >>
>> >> I tried:
>> >> PREMIRROR_prepend =3D "git@local/foo.git git@local/foo.git \n"
>> >>
>> >>
>> >> But this doesn't seem to work.
>> >>
>> >> Is there way to achieve this with the current PREMIRROR variable?
>> >> Or
>> >
>> >is
>> >
>> >> this functionality currently missing?
>> >
>> >See the recently added BB_TRUSTED_NETWORK variable.
>>
>> I hope the v3 with BB_ALLOWED_NETWORKS was applied instead but
>cannot
>> currently check.
>
>Looking at master, it was - BB_ALLOWED_NETWORKS is indeed the new
>variable for this.
>
>(Speaking of which, someone needs to add that to the docs...)
>
>Cheers,
>Paul
>
>--
>
>Paul Eggleton
>Intel Open Source Technology Centre
>--
>_______________________________________________
>bitbake-devel mailing list
>bitbake-devel@lists.openembedded.org
>http://lists.openembedded.org/mailman/listinfo/bitbake-devel

