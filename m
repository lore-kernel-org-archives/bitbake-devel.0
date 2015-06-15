Return-Path: <scott.m.rifenbark@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id C584374115
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Jun 2015 13:30:24 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga101.fm.intel.com with ESMTP; 15 Jun 2015 06:30:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.13,618,1427785200"; d="scan'208";a="746952933"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
	by orsmga002.jf.intel.com with ESMTP; 15 Jun 2015 06:30:26 -0700
Received: from orsmsx160.amr.corp.intel.com (10.22.226.43) by
	ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server
	(TLS) id 14.3.224.2; Mon, 15 Jun 2015 06:30:25 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.217]) by
	ORSMSX160.amr.corp.intel.com ([169.254.13.83]) with mapi id
	14.03.0224.002; Mon, 15 Jun 2015 06:30:25 -0700
From: "Rifenbark, Scott M" <scott.m.rifenbark@intel.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>, "Howlett, Liam (Wind
	River)" <liam.howlett@windriver.com>
Thread-Topic: [bitbake-devel] [PATCH v3] fetch2: Add BB_ALLOWED_NETWORKS
	support
Thread-Index: AQHQp281/ZMW97Mhrk2kb6q4lbShHJ2tj7/w
Date: Mon, 15 Jun 2015 13:30:24 +0000
Message-ID: <41DEA4B02DBDEF40A0F3B6D0DDB123798D203305@ORSMSX101.amr.corp.intel.com>
References: <1429121824-31200-2-git-send-email-Liam.Howlett@WindRiver.com>
	<1431429477.30971.123.camel@linuxfoundation.org>
	<20150512142807.GB15805@yow-lhowlett-d0.wrs.com>
	<2131793.ifvVUYI7Oy@peggleto-mobl.ger.corp.intel.com>
In-Reply-To: <2131793.ifvVUYI7Oy@peggleto-mobl.ger.corp.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.139]
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH v3] fetch2: Add BB_ALLOWED_NETWORKS support
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
X-List-Received-Date: Mon, 15 Jun 2015 13:30:28 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Liam,=20

I will take your raw information and create a new variable description in b=
oth the BitBake manual and the YP reference manual.  I will send out a revi=
ew link to you when it is ready.

Thanks,
Scott

>-----Original Message-----
>From: Paul Eggleton [mailto:paul.eggleton@linux.intel.com]
>Sent: Monday, June 15, 2015 6:28 AM
>To: Howlett, Liam (Wind River)
>Cc: Richard Purdie; Rifenbark, Scott M; bitbake-
>devel@lists.openembedded.org
>Subject: Re: [bitbake-devel] [PATCH v3] fetch2: Add
>BB_ALLOWED_NETWORKS support
>
>On Tuesday 12 May 2015 10:28:08 Liam R. Howlett wrote:
>> * Richard Purdie <richard.purdie@linuxfoundation.org> [150512 07:18]:
>> > On Thu, 2015-04-16 at 13:23 -0400, Liam R. Howlett wrote:
>> > > BB_ALLOWED_NETWORKS is a list of hosts that the fetcher will be
>> > > allowed to use when BB_NO_NETWORK is not set.
>> > >
>> > > If BB_NO_NETWORK is set, then networking is still disabled.
>> > >
>> > > If BB_ALLOWED_NETWORKS is not set, the behaviour remains the same
>> > > as today.
>> > >
>> > > If BB_NO_NETWORK is NOT set, and BB_ALLOWED_NETWORKS is
>> > > configured, then only the hosts in the list are usable by the fetche=
r.
>> > >
>> > > eg:
>> > > BB_ALLOWED_NETWORKS=3D"yoctoproject.org git.gnu.org"
>> > > The fetcher will be able to download from yoctoproject.org,
>> > > git.gnu.org, but not ftp.gnu.org or any other hostname that is not i=
n the
>list.
>> > >
>> > > There is also limited support for wildcards on the beginning of
>> > > the hosts, so BB_ALLOWED_NETWORKS=3D"*.gnu.org" with match
>> > > git.gnu.org and ftp.gnu.org as well as foo.git.gnu.org
>> > >
>> > > Signed-off-by: Liam R. Howlett <Liam.Howlett@WindRiver.com>
>> > > ---
>> > >
>> > >  lib/bb/fetch2/__init__.py | 53
>> > >  +++++++++++++++++++++++++++++++++++++++++++++++
>lib/bb/tests/fetch.py
>> > >     | 37 +++++++++++++++++++++++++++++++++
>> > >  2 files changed, 90 insertions(+)
>> >
>> > I've merged this, however, one of the things we're trying to do is
>> > improve the documentation of bitbake. Would you be able to work with
>> > Scott (cc'd) to ensure this is documented in the manual please?
>> >
>> > Cheers,
>> >
>> > Richard
>>
>> Absolutely, Thanks Richard.
>>
>> Hello Scott,
>>
>> If you don't have anything started, we can work from the text below if
>> you'd like.
>>
>> --------
>>
>> BB_ALLOWED_NETWORKS
>>
>> Specifies a space delimited list of hosts which are allowed to be used
>> by the fetcher to obtain the required source code.  This list is only
>> used if BB_NO_NETWORK is not set.  Wildcard matching at the beginning
>> of hosts is supported.  Mirrors that are not in the list will be
>> skipped and logged in debug.  Attempts to access networks that are not
>> in the BB_ALLOWED_NETWORKS will cause a failure.
>>
>> --------
>>
>> Thanks,
>> Liam
>
>Replying to add Scott on CC - I think he has something for review.
>
>Cheers,
>Paul
>
>--
>
>Paul Eggleton
>Intel Open Source Technology Centre

