Return-Path: <juro.bystricky@intel.com>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by mail.openembedded.org (Postfix) with ESMTP id 852076093F
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Apr 2017 15:41:07 +0000 (UTC)
Received: from orsmga005.jf.intel.com ([10.7.209.41])
	by orsmga105.jf.intel.com with ESMTP; 10 Apr 2017 08:41:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.37,182,1488873600"; d="scan'208";a="85635541"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
	by orsmga005.jf.intel.com with ESMTP; 10 Apr 2017 08:41:08 -0700
Received: from orsmsx160.amr.corp.intel.com (10.22.226.43) by
	ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server
	(TLS) id 14.3.319.2; Mon, 10 Apr 2017 08:41:08 -0700
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.213]) by
	ORSMSX160.amr.corp.intel.com ([169.254.13.129]) with mapi id
	14.03.0319.002; Mon, 10 Apr 2017 08:41:07 -0700
From: "Bystricky, Juro" <juro.bystricky@intel.com>
To: "Ohly, Patrick" <patrick.ohly@intel.com>
Thread-Topic: [PATCH v2] command.py: multiconfig support for findBestProvider
Thread-Index: AQHSsI5KrvCZ/8omGEGN7URC49sHeqG+k+yAgAAsPw8=
Date: Mon, 10 Apr 2017 15:41:06 +0000
Message-ID: <6E51916E4A1F32428260031F4C7CD2B611940F0F@ORSMSX112.amr.corp.intel.com>
References: <1491672821-14233-1-git-send-email-juro.bystricky@intel.com>,
	<1491804067.10884.88.camel@intel.com>
In-Reply-To: <1491804067.10884.88.camel@intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.19.9.41]
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH v2] command.py: multiconfig support for findBestProvider
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
X-List-Received-Date: Mon, 10 Apr 2017 15:41:09 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I concur, it is more readable and I think it merits v3.=0A=
V3 coming momentarily.=0A=
=0A=
Juro=0A=
=0A=
________________________________________=0A=
From: Patrick Ohly [patrick.ohly@intel.com]=0A=
Sent: Sunday, April 09, 2017 11:01 PM=0A=
To: Bystricky, Juro=0A=
Cc: bitbake-devel@lists.openembedded.org; richard.purdie@linuxfoundation.or=
g=0A=
Subject: Re: [PATCH v2] command.py: multiconfig support for findBestProvide=
r=0A=
=0A=
=0A=
> +def split_mc_pn(pn):=0A=
> +    if pn.startswith("multiconfig:"):=0A=
> +        mc =3D pn.split(":")[1]=0A=
> +        pn =3D ":".join(pn.split(":")[2:])=0A=
=0A=
I find this more readable:=0A=
=0A=
if pn.startswith("multiconfig:"):=0A=
    _, mc, pn =3D pn.split(":", 2)=0A=
=0A=
Not sure whether it is worth a v3, though.=0A=
=0A=
--=0A=
Best Regards, Patrick Ohly=0A=
=0A=
The content of this message is my personal opinion only and although=0A=
I am an employee of Intel, the statements I make here in no way=0A=
represent Intel's position on the issue, nor am I authorized to speak=0A=
on behalf of Intel on this matter.=0A=
=0A=
=0A=
=0A=

