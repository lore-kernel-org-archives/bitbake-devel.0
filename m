Return-Path: <Edmund.Nadolski@microsoft.com>
X-Greylist: delayed 14494 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 04 Jan 2019 07:09:24 UTC
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
	(mail-eopbgr730130.outbound.protection.outlook.com [40.107.73.130])
	by mail.openembedded.org (Postfix) with ESMTP id 591917BDCB
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Jan 2019 07:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=su1/Amz03Pdf9sDnqrlMbxR/ze/5BdM0gzcQIvpWjtg=;
	b=DN2fuHIE3O18heVZL5tT5vIfu1C1GVZrFDBpfbHsbQH4awLqZC/yXp5ahiPAwTUoorGL/QR7kXLsHfOn5znPMy95Z5bcf9sKYdrJGII8IWRzXTO9pjwULeJhx4V8dTLige3hOejVEm57lgoJ6kiFVehKmWTgYfW5Jh3O9wcB8BI=
Received: from BN6PR21MB0497.namprd21.prod.outlook.com (2603:10b6:404:b3::7)
	by BN6PR21MB0497.namprd21.prod.outlook.com (2603:10b6:404:b3::7) with
	TransportReplication id Version 15.20 (Build 1516.1); Fri, 4 Jan 2019
	01:35:23 +0000
Received: from DM5PR21MB0172.namprd21.prod.outlook.com (10.173.173.135) by
	DM5PR21MB0507.namprd21.prod.outlook.com (10.172.91.141) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1516.1; Fri, 4 Jan 2019 00:32:13 +0000
Received: from DM5PR21MB0172.namprd21.prod.outlook.com
	([fe80::49e4:b431:7f09:e456]) by
	DM5PR21MB0172.namprd21.prod.outlook.com
	([fe80::49e4:b431:7f09:e456%10]) with mapi id 15.20.1516.000;
	Fri, 4 Jan 2019 00:32:13 +0000
From: Edmund Nadolski <Edmund.Nadolski@microsoft.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: Bitbake staged builds?
Thread-Index: AdSjw7tKoTx34YG8SsCGW1SVOsfRcw==
Date: Fri, 4 Jan 2019 00:32:13 +0000
Message-ID: <DM5PR21MB0172A8E3D4C986EF15D71AE7E58E0@DM5PR21MB0172.namprd21.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
	MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
	MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=ednadols@microsoft.com;
	MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-01-04T00:32:12.0318496Z;
	MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
	MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft
	Azure Information Protection;
	MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
	Sensitivity=General
x-originating-ip: [50.46.223.142]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR21MB0497;
	6:+XFHDmJ4xtL3GIdpQyhVSi/LlMkg7mvwCCDyn79FNHyutEfoh+q1XfI4suNk8gRzhy5YJUBrw7z0/UBfiAgFFg0233JSaFx5Svfw7qBNS10qDgKAqDV64lXGvWbyyIgqO/jjO3PtItyfneo8smQAFI1AYGT4NFEwHkV1UxPH3j7StcKFe4UC9U2zwIRpWT7GduJqKKImnlw8PXZnMfTLvzacoJUWovDYajeddyvM28asbR0hFNbAwuvU7M5AjhrSWOQsHpxeNGsT2YUIAd7ll5czNFfNatUWH200UcejPXGamSnDe2IlGEZVEw6CKDayUoGOCHBpgXcjhzxkVQklnftSsb4nDm4wbf/ckD9Dpx1G174dyJ5JVwWNXWSgs6eeptvgLeAKPkh/AJlGG15GCDiHOvPb+bR/FsQHSsEvAQ3OgniDqvx8kLBKSG5sYRKTMe7VEjaj5hFq4oH+dmJLUw==;
	5:iFeLi5GkyQNd4x+JOwpm7aYwApvAEHmAfEoxcq+nAmKrUNqN76bzK64NvYnj+WZ07limJeB6qQ/qGouJgIH+2A61YEVzTUpCDsnBj2tyzeYdRnNy37OJ7G7Q1ZIDtWEWH1G2PuQ47JoyVDSC37tUt9q2RMa5wl5LhT5Z9PSteRmXn8S1q/8oWOTpEzuuEEJSGSqukRCXXQxF0x9NysRDgw==;
	7:+y27nT5tk04YRg/ULngVVBlMcueXQ76aqqh46nPkkBRLhlvVMndYQ3sPM5g77vE3STKoF6tjM3GLR9++3IYuVZXQeIpQSyZnVjQCDJFFVTw5dv8DNEzbSR1HACGZYfiBjkJMynk4ud+XqvczyLH16A==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ed58b1a4-6b76-4b72-3de8-08d671dc1292
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7193020);
	SRVR:DM5PR21MB0507; 
x-ms-traffictypediagnostic: BN6PR21MB0497:
x-ms-exchange-purlcount: -3
x-microsoft-antispam-prvs: <BN6PR21MB0497B9243B01989BCE626093E58E0@BN6PR21MB0497.namprd21.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(10201501046)(3231475)(944501520)(2018427008)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);
	SRVR:BN6PR21MB0497; BCL:0; PCL:0; RULEID:; SRVR:BN6PR21MB0497; 
x-forefront-prvs: 0907F58A24
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(39860400002)(366004)(396003)(376002)(346002)(136003)(51874003)(199004)(189003)(6506007)(25786009)(102836004)(6346003)(5660300001)(26005)(186003)(305945005)(476003)(7736002)(8936002)(68736007)(9686003)(6116002)(3846002)(74316002)(33656002)(81166006)(81156014)(8676002)(2906002)(7696005)(53936002)(6916009)(99286004)(66066001)(7116003)(256004)(14454004)(97736004)(10290500003)(2351001)(72206003)(71190400001)(71200400001)(22452003)(478600001)(2501003)(316002)(6436002)(486006)(105586002)(10090500001)(106356001)(55016002)(5640700003)(8990500004)(86362001)(86612001)(3480700005);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR21MB0497;
	H:DM5PR21MB0172.namprd21.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
	permitted sender hosts)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Edmund.Nadolski@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1PKmTgfV+sc0rX9f6bQyTSZCmlEr+9ALYT3SDc5b4fpJXr7SRtlEovwkOLy3K3d7qpCal0BW0TBijeI4DbQ7yCrNTpe7WwcApqFD+7jDooGNG4ZbOYL442B5Ap5rx0U6wpoQeWtKuU94SMIH9nRRucklegpDwZWpPLCNNb0vOHXXPc4zdqn1B7+IC3IsMXQUQdaRq8/BP1rWxsouFBYr6cjlsqCdzXEVg5/tdOTG3sK+d+qv0a4NrGMa2xhTvomXvolDVXGjDsoG4RrXv9ZY5Ti8Wo9NrYuehP1az3l/0+OebxxTTGHRD7Z6wRktWpCW
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed58b1a4-6b76-4b72-3de8-08d671dc1292
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2019 00:32:13.5850 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0497
Subject: Bitbake staged builds?
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
X-List-Received-Date: Fri, 04 Jan 2019 07:09:24 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello list,

(My first post, pls. advise if this is not the appropriate list.)

Does bitbake support the notion of a "staged" build?  By this I mean a user=
 making an initial invocation to run a series of tasks, then subsequently m=
aking a second invocation to do a second set of tasks, and so on until all =
the tasks for a build target are completed.   The main idea is to be able t=
o run additional steps (outside of bitbake) between the invocations.  Is 'a=
ddtask' a reasonable mechanism to implement this?

Thanks in advance, and/all advice greatly appreciated.

Ed Nadolski




