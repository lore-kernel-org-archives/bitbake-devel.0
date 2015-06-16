Return-Path: <scott.m.rifenbark@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 31305737AF
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 16 Jun 2015 19:25:56 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 16 Jun 2015 12:25:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.13,627,1427785200"; d="scan'208";a="728659889"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
	by fmsmga001.fm.intel.com with ESMTP; 16 Jun 2015 12:25:58 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.217]) by
	ORSMSX110.amr.corp.intel.com ([169.254.3.157]) with mapi id
	14.03.0224.002; Tue, 16 Jun 2015 12:25:57 -0700
From: "Rifenbark, Scott M" <scott.m.rifenbark@intel.com>
To: "Howlett, Liam (Wind River)" <liam.howlett@windriver.com>
Thread-Topic: [bitbake-devel] [PATCH v3] fetch2: Add	BB_ALLOWED_NETWORKS
	support
Thread-Index: AQHQqDpGfojCq1JbGUCMjb89gsHvrJ2vQKRwgAC4WYD//4rDoA==
Date: Tue, 16 Jun 2015 19:25:57 +0000
Message-ID: <41DEA4B02DBDEF40A0F3B6D0DDB123798D203D7F@ORSMSX101.amr.corp.intel.com>
References: <1429121824-31200-2-git-send-email-Liam.Howlett@WindRiver.com>
	<41DEA4B02DBDEF40A0F3B6D0DDB123798D203356@ORSMSX101.amr.corp.intel.com>
	<1FDE9321-AA20-49D9-A4BE-A4B4514439DB@gmail.com>
	<1946263.B0TEDLLAIC@peggleto-mobl.ger.corp.intel.com>
	<20150616134205.GG26078@yow-lhowlett-d0.wrs.com>
	<41DEA4B02DBDEF40A0F3B6D0DDB123798D203C80@ORSMSX101.amr.corp.intel.com>
	<20150616192423.GL26078@yow-lhowlett-d0.wrs.com>
In-Reply-To: <20150616192423.GL26078@yow-lhowlett-d0.wrs.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.138]
MIME-Version: 1.0
Cc: Paul Eggleton <paul.eggleton@linux.intel.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, Gary Thomas <gary@mlbassoc.com>
Subject: Re: [PATCH v3] fetch2: Add	BB_ALLOWED_NETWORKS support
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
X-List-Received-Date: Tue, 16 Jun 2015 19:26:00 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable



>-----Original Message-----
>From: Liam R. Howlett [mailto:Liam.Howlett@windriver.com]
>Sent: Tuesday, June 16, 2015 12:24 PM
>To: Rifenbark, Scott M
>Cc: Paul Eggleton; Bernhard Reutner-Fischer; Gary Thomas; bitbake-
>devel@lists.openembedded.org
>Subject: Re: [bitbake-devel] [PATCH v3] fetch2: Add
>BB_ALLOWED_NETWORKS support
>
>* Rifenbark, Scott M <scott.m.rifenbark@intel.com> [150616 11:25]:
>>
>>
>> >-----Original Message-----
>> >From: Liam R. Howlett [mailto:Liam.Howlett@windriver.com]
>> >Sent: Tuesday, June 16, 2015 6:42 AM
>> >To: Paul Eggleton
>> >Cc: Bernhard Reutner-Fischer; Rifenbark, Scott M; Gary Thomas;
>> >bitbake- devel@lists.openembedded.org
>> >Subject: Re: [bitbake-devel] [PATCH v3] fetch2: Add
>> >BB_ALLOWED_NETWORKS support
>> >
>> >* Paul Eggleton <paul.eggleton@linux.intel.com> [150616 04:40]:
>> >> On Monday 15 June 2015 23:47:29 Bernhard Reutner-Fischer wrote:
>> >> > On June 15, 2015 4:03:11 PM GMT+02:00, "Rifenbark, Scott M"
>> >> <scott.m.rifenbark@intel.com> wrote:
>> >> > >Hi,
>> >> > >
>> >> > >Here is a first draft of documenting the BB_ALLOWED_NETWORKS
>> >> > >variable in the BitBake User Manual.  I re-wrote the original
>> >> > >text to be active voice and applied some different organization
>> >> > >of the facts to help the flow out.  Regarding Gary's input about
>> >> > >BB_NO_NETWORK..... I took a half guess at incorporating it.
>> >> > >Please look this new description over and let me know of any
>> >> > >corrections I need
>> >to make.
>> >> > >http://www.yoctoproject.org/docs/1.9/bitbake-user-manual/bitbake
>> >> > >-us
>> >> > >er-manua
>> >> > >l.html#var-BB_ALLOWED_NETWORKS.
>> >
>> >Hi,
>> >
>> >The documentation looks correct, however it might be worth noting
>> >that adding the host you'd like to use to PREMIRROR will result in
>> >the source code being fetched from an allowed location and avoid
>> >raising an error when a host that is not allowed is in a SRC_URI
>> >because the fetcher will not attempt to use the SRC_URI host after a
>> >successful fetch from the PREMIRROR.  Using BB_ALLOWED_NETWORK in
>> >conjunction with PREMIRROR is where this feature is very useful.
>>
>> Check the link to the variable description out now Liam.  Let me know if=
 this
>addition is okay.
>
>This looks good!
>
>Thanks,
>Liam

Awesome... I will get the commit into the Bitbake repo and then duplicate t=
he entry in the YP ref-manual.

Thanks,
Scott

>
>>
>> >
>> >
>> >> > Was the v3 fixed / extended to allow for netmasks, btw?
>> >> > Think
>> >> > /etc/hosts
>> >> > foo.example.com 10.0.0.1
>> >> > bar.example.com 10.0.0.254
>> >> > baz.example.com ::1
>> >> >
>> >> > BB_ALLOWED_NETWORKS =3D 10.0.0.0/24 1.1.1.1/31 ::1/127
>> >>
>> >> I don't believe so. You can see what actually went in here:
>> >>
>> >> http://git.yoctoproject.org/cgit/cgit.cgi/poky/commit/?id=3D59ce7d02a
>> >> 57e
>> >> 0a642d839ab48677f6ac1886180f
>> >>
>> >> Cheers,
>> >> Paul
>> >
>> >
>> >There isn't netmask support, but you can achieve the same result in
>> >your example above by using BB_ALLOWED_NETWORKS =3D
>"*.example.com"
>> >
>> >Version 2 updated the host matching and added a few more tests.
>> >
>> >Version 3 changed the name from BB_TRUSTED_NETWORKS to
>> >BB_ALLOWED_NETWORKS.
>> >
>> >
>> >Thanks,
>> >Liam R. Howlett
>> >
>> >>
>> >> --
>> >>
>> >> Paul Eggleton
>> >> Intel Open Source Technology Centre

