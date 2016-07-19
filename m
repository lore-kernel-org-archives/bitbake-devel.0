Return-Path: <sai.pavan.boddu@xilinx.com>
X-Greylist: delayed 1040 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 19 Jul 2016 08:06:06 UTC
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
	(mail-bl2nam02on0088.outbound.protection.outlook.com [104.47.38.88])
	by mail.openembedded.org (Postfix) with ESMTP id 4752273166
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Jul 2016 08:06:06 +0000 (UTC)
Received: from SN1NAM02FT030.eop-nam02.prod.protection.outlook.com
	(10.152.72.51) by SN1NAM02HT198.eop-nam02.prod.protection.outlook.com
	(10.152.72.63) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.539.16;
	Tue, 19 Jul 2016 07:33:06 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
	smtp.mailfrom=xilinx.com; lists.openembedded.org; dkim=none (message not
	signed) header.d=none; lists.openembedded.org;
	dmarc=bestguesspass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
	149.199.60.83 as permitted sender) receiver=protection.outlook.com;
	client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
	SN1NAM02FT030.mail.protection.outlook.com (10.152.72.114) with
	Microsoft SMTP Server (version=TLS1_0,
	cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.539.16
	via Frontend Transport; Tue, 19 Jul 2016 07:33:05 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
	by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
	(envelope-from <sai.pavan.boddu@xilinx.com>) id 1bPPWW-0004eB-MV
	for bitbake-devel@lists.openembedded.org;
	Tue, 19 Jul 2016 00:33:00 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
	by xsj-pvapsmtp01 with esmtp (Exim 4.63)
	(envelope-from <sai.pavan.boddu@xilinx.com>) id 1bPPWa-0008Lv-Tp
	for bitbake-devel@lists.openembedded.org;
	Tue, 19 Jul 2016 00:33:04 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
	by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id
	u6J7X2Gn020430 for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Jul 2016 00:33:02 -0700
Received: from [172.22.159.26] (helo=XAP-PVEXCAS02.xlnx.xilinx.com)
	by xsj-pvapsmtp01 with esmtp (Exim 4.63)
	(envelope-from <saipava@xilinx.com>) id 1bPPWY-0008Ku-7t
	for bitbake-devel@lists.openembedded.org;
	Tue, 19 Jul 2016 00:33:02 -0700
Received: from XAP-PVEXMBX02.xlnx.xilinx.com ([fe80::6c95:7dae:8014:5ca1]) by
	XAP-PVEXCAS02.xlnx.xilinx.com ([::1]) with mapi id 14.03.0248.002;
	Tue, 19 Jul 2016 15:33:01 +0800
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: recipetool issue with empty bbappends
Thread-Index: AdHhjaFuXJfinANjRq+NoSA0G3Bv2Q==
Date: Tue, 19 Jul 2016 07:33:00 +0000
Message-ID: <4025671C58A6E340B47F5CA342BC783A42BF96F4@XAP-PVEXMBX02.xlnx.xilinx.com>
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
	SFS:(10009020)(6009001)(7916002)(2980300002)(438002)(199003)(189002)(47776003)(8746002)(7696003)(86362001)(81156014)(81166006)(55846006)(5250100002)(8676002)(2900100001)(110136002)(2930100002)(63266004)(8936002)(102836003)(2351001)(5890100001)(92566002)(3846002)(450100001)(23756003)(33656002)(50466002)(19580395003)(2906002)(87936001)(31430400001)(107886002)(2920100001)(4326007)(54356999)(50986999)(586003)(2501003)(106466001)(4001430100002)(229853001)(5003600100003)(356003)(7736002)(189998001)(7846002)(305945005)(11100500001)(6116002)(107986001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:SN1NAM02HT198; H:xsj-pvapsmtpgw01;
	FPR:; SPF:Pass; PTR:unknown-60-83.xilinx.com; A:1; MX:1; LANG:en;
X-MS-Office365-Filtering-Correlation-Id: 7b9ffebf-089e-45ee-f777-08d3afa6ecf3
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0; RULEID:(8251501002);
	SRVR:SN1NAM02HT198; 
X-Microsoft-Antispam-PRVS: <48b50f3e03e1404ca04e2f109afa569f@SN1NAM02HT198.eop-nam02.prod.protection.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
	RULEID:(601004)(2401047)(13018025)(13023025)(13024025)(13015025)(8121501046)(13017025)(5005006)(10201501046)(3002001)(6055026);
	SRVR:SN1NAM02HT198; BCL:0; PCL:0; RULEID:; SRVR:SN1NAM02HT198; 
X-Forefront-PRVS: 000800954F
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2016 07:33:05.9682 (UTC)
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;
	Ip=[149.199.60.83]; Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1NAM02HT198
X-Mailman-Approved-At: Tue, 19 Jul 2016 08:56:05 +0000
Cc: Manjukumar Harthikote Matha <MANJUKUM@xilinx.com>,
	Vineeth Karumanchi <VINEETHC@xilinx.com>
Subject: recipetool issue with empty bbappends
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
X-List-Received-Date: Tue, 19 Jul 2016 08:06:08 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I see an issue, working with recipetool, which  basically gives error when =
I point out an empty bbappend file generated form recipetool itself.
Below are the steps
recipetool newappend meta-saip/ linux-xlnx
recipetool setvar -r meta-saip/recipes-kernel/linux/linux-xlnx_4.4.bbappend=
 XSCTH_PROC "arm"
Traceback (most recent call last):
  File "<path>/yocto/scripts/recipetool", line 116, in <module>
    ret =3D main()
  File "<path>/yocto/scripts/recipetool", line 107, in main
    ret =3D args.func(args)
  File "<path>/components/yocto/scripts/lib/recipetool/setvar.py", line 52,=
 in setvar
    patches =3D [oe.recipeutils.patch_recipe_file(args.recipefile, varvalue=
s, patch=3Dargs.patch)]
  File "<path>/yocto/meta/lib/oe/recipeutils.py", line 258, in patch_recipe=
_file
    if tolines[-1].strip() !=3D '':
IndexError: list index out of range

But I don't see the error if, bbappend file has atlease one line

Regards,
B. Sai pavan




This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.


