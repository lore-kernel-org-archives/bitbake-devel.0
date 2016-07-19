Return-Path: <sai.pavan.boddu@xilinx.com>
X-Greylist: delayed 8865 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 19 Jul 2016 10:00:52 UTC
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
	(mail-sn1nam02on0059.outbound.protection.outlook.com [104.47.36.59])
	by mail.openembedded.org (Postfix) with ESMTP id 0CB11606D1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Jul 2016 10:00:52 +0000 (UTC)
Received: from SN1NAM02FT038.eop-nam02.prod.protection.outlook.com
	(10.152.72.60) by SN1NAM02HT065.eop-nam02.prod.protection.outlook.com
	(10.152.73.226) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.539.16;
	Tue, 19 Jul 2016 09:46:28 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
	smtp.mailfrom=xilinx.com; lists.openembedded.org; dkim=none (message not
	signed) header.d=none; lists.openembedded.org;
	dmarc=bestguesspass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
	149.199.60.83 as permitted sender) receiver=protection.outlook.com;
	client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
	SN1NAM02FT038.mail.protection.outlook.com (10.152.72.69) with Microsoft
	SMTP Server (version=TLS1_0,
	cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.539.16
	via Frontend Transport; Tue, 19 Jul 2016 09:46:28 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
	by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
	(envelope-from <sai.pavan.boddu@xilinx.com>)
	id 1bPRbb-0001s2-9Z; Tue, 19 Jul 2016 02:46:23 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
	by xsj-pvapsmtp01 with esmtp (Exim 4.63)
	(envelope-from <sai.pavan.boddu@xilinx.com>)
	id 1bPRbf-0005AW-Gk; Tue, 19 Jul 2016 02:46:27 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
	by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id
	u6J9kRIU016544; Tue, 19 Jul 2016 02:46:27 -0700
Received: from [172.22.159.26] (helo=XAP-PVEXCAS02.xlnx.xilinx.com)
	by xsj-pvapsmtp01 with esmtp (Exim 4.63)
	(envelope-from <saipava@xilinx.com>)
	id 1bPRbe-0005AS-Ka; Tue, 19 Jul 2016 02:46:27 -0700
Received: from XAP-PVEXMBX02.xlnx.xilinx.com ([fe80::6c95:7dae:8014:5ca1]) by
	XAP-PVEXCAS02.xlnx.xilinx.com ([::1]) with mapi id 14.03.0248.002;
	Tue, 19 Jul 2016 17:46:25 +0800
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Thread-Topic: [bitbake-devel] recipetool issue with empty bbappends
Thread-Index: AdHhjaFuXJfinANjRq+NoSA0G3Bv2f//nXyA//90lhA=
Date: Tue, 19 Jul 2016 09:46:25 +0000
Message-ID: <4025671C58A6E340B47F5CA342BC783A42BF995A@XAP-PVEXMBX02.xlnx.xilinx.com>
References: <4025671C58A6E340B47F5CA342BC783A42BF96F4@XAP-PVEXMBX02.xlnx.xilinx.com>
	<12775485.NNVrWsqQxr@peggleto-mobl.ger.corp.intel.com>
In-Reply-To: <12775485.NNVrWsqQxr@peggleto-mobl.ger.corp.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.23.93.41]
MIME-Version: 1.0
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.0.0.1202-22460.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; IPV:NLI; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(6009001)(7916002)(2980300002)(438002)(199003)(189002)(377454003)(13464003)(24454002)(8746002)(86362001)(81156014)(81166006)(55846006)(5250100002)(8676002)(2900100001)(110136002)(189998001)(3846002)(15975445007)(92566002)(6116002)(102836003)(8936002)(50466002)(47776003)(7736002)(33656002)(23746002)(19580405001)(19580395003)(106466001)(31430400001)(4001430100002)(586003)(2950100001)(2920100001)(7696003)(107886002)(54356999)(4326007)(50986999)(76176999)(2906002)(87936001)(5003600100003)(356003)(7846002)(11100500001)(305945005)(63266004)(107986001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:SN1NAM02HT065; H:xsj-pvapsmtpgw01;
	FPR:; SPF:Pass; PTR:unknown-60-83.xilinx.com; A:1; MX:1; LANG:en;
X-MS-Office365-Filtering-Correlation-Id: dc083d27-ce91-4691-4023-08d3afb98e80
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0; RULEID:(8251501002);
	SRVR:SN1NAM02HT065; 
X-Microsoft-Antispam-PRVS: <469e7f01239f4cb6acef5e9c89a189ce@SN1NAM02HT065.eop-nam02.prod.protection.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(264703809997249)(192813158149592)(228905959029699); 
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
	RULEID:(601004)(2401047)(13018025)(13023025)(13024025)(13015025)(8121501046)(13017025)(5005006)(10201501046)(3002001)(6055026);
	SRVR:SN1NAM02HT065; BCL:0; PCL:0; RULEID:; SRVR:SN1NAM02HT065; 
X-Forefront-PRVS: 000800954F
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2016 09:46:28.2545 (UTC)
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;
	Ip=[149.199.60.83]; Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1NAM02HT065
Cc: Manjukumar Harthikote Matha <MANJUKUM@xilinx.com>,
	Vineeth Karumanchi <VINEETHC@xilinx.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: recipetool issue with empty bbappends
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
X-List-Received-Date: Tue, 19 Jul 2016 10:00:54 -0000
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Paul Eggleton [mailto:paul.eggleton@linux.intel.com]
> Sent: Tuesday, July 19, 2016 2:55 PM
> To: Sai Pavan Boddu <saipava@xilinx.com>
> Cc: bitbake-devel@lists.openembedded.org; Manjukumar Harthikote Matha <MA=
NJUKUM@xilinx.com>; Vineeth Karumanchi
> <VINEETHC@xilinx.com>
> Subject: Re: [bitbake-devel] recipetool issue with empty bbappends
>=20
> Hi there,
>=20
> On Tue, 19 Jul 2016 07:33:00 Sai Pavan Boddu wrote:
> > I see an issue, working with recipetool, which  basically gives error w=
hen I
> > point out an empty bbappend file generated form recipetool itself. Belo=
w
> > are the steps
> > recipetool newappend meta-saip/ linux-xlnx
> > recipetool setvar -r meta-saip/recipes-kernel/linux/linux-xlnx_4.4.bbap=
pend
> > XSCTH_PROC "arm" Traceback (most recent call last):
> >   File "<path>/yocto/scripts/recipetool", line 116, in <module>
> >     ret =3D main()
> >   File "<path>/yocto/scripts/recipetool", line 107, in main
> >     ret =3D args.func(args)
> >   File "<path>/components/yocto/scripts/lib/recipetool/setvar.py", line=
 52,
> > in setvar patches =3D [oe.recipeutils.patch_recipe_file(args.recipefile=
,
> > varvalues, patch=3Dargs.patch)] File
> > "<path>/yocto/meta/lib/oe/recipeutils.py", line 258, in patch_recipe_fi=
le
> > if tolines[-1].strip() !=3D '':
> > IndexError: list index out of range
> >
> > But I don't see the error if, bbappend file has atlease one line
>=20
> I've just reproduced this and have filed the following bug for the issue:
>=20
> https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D9972
Thanks Paul Eggleton.

Regards,
Sai Pavan
>=20
> BTW in future for issues with recipetool / devtool could you please use t=
he
> openembedded-core@lists.openembedded.org (or yocto@yoctoproject.org if yo=
u
> prefer) since recipetool isn't part of BitBake.
>=20
> Thanks,
> Paul
>=20
> --
>=20
> Paul Eggleton
> Intel Open Source Technology Centre

