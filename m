Return-Path: <praveenreddy.p@hcl.com>
Received: from GWS07.hcl.com (gws07.hcl.com [192.8.186.130])
	by mail.openembedded.org (Postfix) with ESMTP id 34800607A5
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 Mar 2016 13:05:29 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.24,320,1454956200"; d="scan'208";a="46866852"
Received: from unknown (HELO CHN-CORP-HT02.CORP.HCL.IN) ([10.249.2.34])
	by GWS07.hcl.com with ESMTP/TLS/AES128-SHA; 11 Mar 2016 18:35:25 +0530
Received: from CHN-HCLT-CSHT02.HCLT.CORP.HCL.IN (10.150.12.27) by
	CHN-CORP-HT02.CORP.HCL.IN (10.249.2.34) with Microsoft SMTP Server
	(TLS) id 14.3.123.3; Fri, 11 Mar 2016 18:35:24 +0530
Received: from CHN-HCLT-MBS02.HCLT.CORP.HCL.IN ([fe80::45e7:d7f7:b243:fdd9])
	by CHN-HCLT-CSHT02.HCLT.CORP.HCL.IN ([::1]) with mapi id 14.03.0235.001;
	Fri, 11 Mar 2016 18:35:25 +0530
From: Praveenreddy Padamati <praveenreddy.p@hcl.com>
To: Robert Yang <liezhi.yang@windriver.com>,
	"'bitbake-devel@lists.openembedded.org'"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] Hi
Thread-Index: AQHRe0U5iJoGSOvEPUOgHKwpXrfIY59UNmlE
Date: Fri, 11 Mar 2016 13:05:24 +0000
Message-ID: <09856974BCEE6F48AB378E52E4CAA73C226DBD49@CHN-HCLT-MBS02.HCLT.CORP.HCL.IN>
References: <09856974BCEE6F48AB378E52E4CAA73C226DA890@CHN-HCLT-MBS02.HCLT.CORP.HCL.IN>,
	<56E239E0.7010003@windriver.com>
In-Reply-To: <56E239E0.7010003@windriver.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.151.34.14]
MIME-Version: 1.0
Subject: Re: Hi
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
X-List-Received-Date: Fri, 11 Mar 2016 13:05:33 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,=0A=
=0A=
I tried IMAGE_INSTALL_append =3D " zetakey". But it is failed. Below is the=
 Log=0A=
=0A=
HCL-Desktop:~/fsl-release-bsp/build$ bitbake core-image-sato=0A=
Parsing recipes: 100% |####################################################=
###########################################| Time: 00:01:26=0A=
Parsing of 1747 .bb files complete (0 cached, 1747 parsed). 2189 targets, 8=
4 skipped, 1 masked, 0 errors.=0A=
NOTE: Resolving any missing task queue dependencies=0A=
ERROR: Nothing RPROVIDES 'zetakey' (but /home/kumarn/fsl-release-bsp/source=
s/poky/meta/recipes-sato/images/core-image-sato.bb RDEPENDS on or otherwise=
 requires it)=0A=
NOTE: Runtime target 'zetakey' is unbuildable, removing...=0A=
Missing or unbuildable dependency chain was: ['zetakey']=0A=
ERROR: Required build target 'core-image-sato' has no buildable providers.=
=0A=
Missing or unbuildable dependency chain was: ['core-image-sato', 'zetakey']=
=0A=
=0A=
Summary: There were 2 ERROR messages shown, returning a non-zero exit code.=
=0A=
=0A=
=0A=
Thanks=0A=
Praveen Reddy P=0A=
9989642189=0A=
________________________________________=0A=
From: Robert Yang [liezhi.yang@windriver.com]=0A=
Sent: Friday, March 11, 2016 8:52 AM=0A=
To: Praveenreddy Padamati; 'bitbake-devel@lists.openembedded.org'=0A=
Subject: Re: [bitbake-devel] Hi=0A=
=0A=
On 03/10/2016 03:10 PM, Praveenreddy Padamati wrote:=0A=
> Hi all,=0A=
>=0A=
> I need to add zetakey browser to the yocto core-image-sato. Can you provi=
de any=0A=
> data how to add this browse to the build.=0A=
=0A=
Add this to local.conf:=0A=
=0A=
IMAGE_INSTALL_append =3D " zetakey"=0A=
=0A=
Note, there is a space " " which is a must, then:=0A=
=0A=
$ bitbake core-image-sato=0A=
=0A=
>=0A=
> *Thanks and Regards,*=0A=
>=0A=
> *Praveen Reddy P**=0A=
> **HCL Technologies Ltd*| Lead Engineer | Alstom ODC| ERS-SS-SCS-Embedded=
=0A=
> Platform Lab=0A=
>=0A=
> P*hone:* +914443935173 | *Mobile:* +919989642159 | *E-mail:*=0A=
> _praveenreddy.p@hcl.com <mailto:praveenreddy.p@hcl.com>_=0A=
>=0A=
> *Company address:*HCL Technologies Ltd ,73-74, South Phase,Ambattur Indus=
trial=0A=
> Estate (AMB-5), Chennai - 600 058,India=0A=
> *Switchboard:*__+91-44-4393-5000  Web*Site:* www.hclt.com <http://www.hcl=
t.com/>=0A=
>=0A=
>=0A=
>=0A=
> ::DISCLAIMER::=0A=
> -------------------------------------------------------------------------=
---------------------------------------------------------------------------=
=0A=
>=0A=
> The contents of this e-mail and any attachment(s) are confidential and in=
tended=0A=
> for the named recipient(s) only.=0A=
> E-mail transmission is not guaranteed to be secure or error-free as infor=
mation=0A=
> could be intercepted, corrupted,=0A=
> lost, destroyed, arrive late or incomplete, or may contain viruses in=0A=
> transmission. The e mail and its contents=0A=
> (with or without referred errors) shall therefore not attach any liabilit=
y on=0A=
> the originator or HCL or its affiliates.=0A=
> Views or opinions, if any, presented in this email are solely those of th=
e=0A=
> author and may not necessarily reflect the=0A=
> views or opinions of HCL or its affiliates. Any form of reproduction,=0A=
> dissemination, copying, disclosure, modification,=0A=
> distribution and / or publication of this message without the prior writt=
en=0A=
> consent of authorized representative of=0A=
> HCL is strictly prohibited. If you have received this email in error plea=
se=0A=
> delete it and notify the sender immediately.=0A=
> Before opening any email and/or attachments, please check them for viruse=
s and=0A=
> other defects.=0A=
>=0A=
> -------------------------------------------------------------------------=
---------------------------------------------------------------------------=
=0A=
>=0A=
>=0A=
>=0A=

