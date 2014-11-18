Return-Path: <Nishanth.S@Altiux.com>
X-Greylist: delayed 949 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 18 Nov 2014 06:46:22 UTC
Received: from APAC01-HK1-obe.outbound.protection.outlook.com
	(mail-hk1on0076.outbound.protection.outlook.com [134.170.140.76])
	by mail.openembedded.org (Postfix) with ESMTP id 03D10718EA
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Nov 2014 06:46:22 +0000 (UTC)
Received: from [172.16.0.96] (111.93.235.83) by
	SIXPR06MB0575.apcprd06.prod.outlook.com (25.160.238.18) with Microsoft
	SMTP Server (TLS) id 15.1.16.15; Tue, 18 Nov 2014 06:30:29 +0000
Message-ID: <546AE780.7070208@altiux.com>
Date: Tue, 18 Nov 2014 12:00:24 +0530
From: Nishanth S <Nishanth.S@altiux.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To: <bitbake-devel@lists.openembedded.org>
X-Originating-IP: [111.93.235.83]
X-ClientProxiedBy: SG2PR03CA0030.apcprd03.prod.outlook.com (25.160.233.40) To
	SIXPR06MB0575.apcprd06.prod.outlook.com (25.160.238.18)
X-Microsoft-Antispam: UriScan:;
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:;SRVR:SIXPR06MB0575;
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:;SRVR:SIXPR06MB0575;
X-Forefront-PRVS: 039975700A
X-Forefront-Antispam-Report: SFV:NSPM;
	SFS:(10009020)(6009001)(6049001)(199003)(189002)(50986999)(59896002)(54356999)(87976001)(23676002)(110136001)(102836001)(19580395003)(31966008)(92566001)(101416001)(21056001)(80316001)(4396001)(83506001)(87266999)(65816999)(106356001)(122386002)(97736003)(2351001)(105586002)(33656002)(46102003)(99396003)(120916001)(107046002)(66066001)(65956001)(20776003)(107886001)(47776003)(86362001)(92726001)(64126003)(64706001)(42186005)(40100003)(62966003)(450100001)(229853001)(95666004)(50466002)(77156002)(77096003)(65806001)(36756003)(7099021);
	DIR:OUT; SFP:1101; SCL:1; SRVR:SIXPR06MB0575; H:[172.16.0.96];
	FPR:; MLV:ovrnspm; PTR:InfoNoRecords; A:1; MX:1; LANG:en; 
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:;SRVR:SIXPR06MB0575;
X-OriginatorOrg: Altiux.com
X-Mailman-Approved-At: Sun, 23 Nov 2014 21:58:57 +0000
Subject: how to update a package on yocto project
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
X-List-Received-Date: Tue, 18 Nov 2014 06:46:26 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit

Hi

board : Intel Galileo Gen 1

I use yocto project for build image/tarball for the board.

How to update a existing package???

I mean, I use openjdk-6 on my board.

But I need to change it to openjdk-7.

I edited local.conf by adding following line.

preferred_version_openjdkXXXX = XXXX


-- 
Regards,
Nishanth.S


