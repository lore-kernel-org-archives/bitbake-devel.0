Return-Path: <Rasmus.Villemoes@prevas.se>
X-Greylist: delayed 3551 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 10 Jul 2018 13:02:50 UTC
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
	(mail-db5eur01on0109.outbound.protection.outlook.com [104.47.2.109])
	by mail.openembedded.org (Postfix) with ESMTP id DA7B86003C
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Jul 2018 13:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=prevasonline.onmicrosoft.com; s=selector1-prevas-se;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=egLfF6IzMgwOAwt1/tdshprZ4dVPjKfAWUR5x1Z8biw=;
	b=aCb7AZ1N60YP8LB+M3JhUfDTXmLdGyMGoDUn2EWcOIB9/I5trlp8sb7j4cS8WfV0d0et4ObavB5uY2RERA4YmXd9FaOFzvTrpE3B48aR6JEgPMFVr07uQEfcMwKqKrW1RzW//1DzK6/EU+Gak1/59+cbkTZwGbTN6HJWMyyMCEI=
Authentication-Results: spf=none (sender IP is )
	smtp.mailfrom=Rasmus.Villemoes@prevas.se; 
Received: from [172.16.11.32] (81.216.59.226) by
	AM4PR1001MB1332.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:200:98::22) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.21;
	Tue, 10 Jul 2018 09:31:16 +0000
To: bitbake-devel@lists.openembedded.org
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <08a61d76-d0b7-ce93-180c-5c4eab3ee150@prevas.dk>
Date: Tue, 10 Jul 2018 11:31:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
X-Originating-IP: [81.216.59.226]
X-ClientProxiedBy: DB6PR0301CA0050.eurprd03.prod.outlook.com
	(2603:10a6:4:54::18) To AM4PR1001MB1332.EURPRD10.PROD.OUTLOOK.COM
	(2603:10a6:200:98::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae1f66ab-0340-4014-7d9b-08d5e647e2f0
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);
	SRVR:AM4PR1001MB1332; 
X-Microsoft-Exchange-Diagnostics: 1; AM4PR1001MB1332;
	3:b8EYxSiif1AsREDaBXlM5McH63S2mM7oXoWn1zG6tIAZPFsl6RwEMiac75aKeMLmKnrqR4sdq17alEh+0KhEB1ChkAGYKNnJ7zp1lRdxKH2UwD+U34k61CWjhBAN5zT3aY2nv1GsVV2etVzD9HOmxOuN0bMCZHRswAhTelJPSxE+d/lXJ80yIKkMkzCXgu14oKKj6GwJhPnFe7+vK90iSxuY6Wei9cw8YCyvvtZ30Gp+hgwrC8sCp3DJLMLSdHeG;
	25:x7Xf5X+5Ii5HR4Lzb+7EnY/r/elXiU7p/v/bMgGLnnlggi+cS3o6dIWC3N4W4n/cq+82PTTX10l/C/CfFVdV9uwqtpYetss7y7ihID7gfroWlaT14kLZONbcHjootRIHV6fzOS8uuGNtndtEbuXSpA4RdAqlsHGl5cNMjUVYV7NItV1KMFeqvLAvxkU0ZQca2wZGtmyXXvZIfTvlYnvAZvW69YmNu28X8OyGuI9zZw6Kd9h5Ut2drpjVgHaD9NjMwaI25utnUwihkvv1Ec6IcZjSRrvZgR46Tb6eZOKis0GDerek0PHdpknYec32C3MyJnfHgK7Hj8atrPbh77iHRw==;
	31:S3t8y4Uqs+y/KVSqBXvRm4DsGK23tX3Tlh/i6i9AdbOyjxYLUfMydPUd2N0Hcgh2j+wLPD2jIiMGEMow9pHCS7HK7M9UoiwSSY/fyb+y8Khf/7MdtIpYySXOsVQsPhua7fysS6RL8pV3/s4Cqi1/rxCYUOcuK+dY+WzdZozAnptDfgtljq2UJRYrRtvSBTocStV3JGtxLImWv81YxkRu32Skdf6nSElz3Mynse+Ui1o=
X-MS-TrafficTypeDiagnostic: AM4PR1001MB1332:
X-Microsoft-Antispam-PRVS: <AM4PR1001MB1332A1E9E14AE671C1F16FA28A5B0@AM4PR1001MB1332.EURPRD10.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
	RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);
	SRVR:AM4PR1001MB1332; BCL:0; PCL:0; RULEID:;
	SRVR:AM4PR1001MB1332; 
X-Microsoft-Exchange-Diagnostics: 1; AM4PR1001MB1332;
	4:g8oOmCSr87MNUpl5GneqFw7/glEjEJ57ewqOz9f3IYNrhzpCEOmMGSj5MhD+5+0inkIi0GXdYvyyqidFLwZZsyIm2q8ACodwWHlyg59MmDHDvdHdHyae9BCT8dY+DvUBtNKXNhxG2osJZwDs8vCjs+/YH+HzZKujo18KJQQG0HJ/WE1k87dme/B9Kg3TDQWbg1qlpwD0cGpVXnINMAkO7Xpsi9OwNag9PzpA/uZXVOtiajOd9raCFKxz649pMqCNVK7+KUKfhYdpLNEddDSZqQ==
X-Forefront-PRVS: 0729050452
X-Forefront-Antispam-Report: SFV:NSPM;
	SFS:(10019020)(6049001)(136003)(39850400004)(366004)(396003)(346002)(376002)(189003)(199004)(50466002)(44832011)(65826007)(6666003)(6916009)(31686004)(5660300001)(6116002)(3846002)(36756003)(2361001)(956004)(476003)(47776003)(65806001)(65956001)(74482002)(66066001)(2616005)(97736004)(2351001)(486006)(230700001)(478600001)(25786009)(305945005)(26005)(386003)(77096007)(4326008)(105586002)(6486002)(186003)(42882007)(16526019)(8976002)(72206003)(68736007)(81156014)(31696002)(23676004)(52116002)(2486003)(52146003)(64126003)(53936002)(81166006)(2906002)(8676002)(316002)(14444005)(7736002)(16576012)(8936002)(58126008)(106356001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM4PR1001MB1332; H:[172.16.11.32];
	FPR:; SPF:None; LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: prevas.se does not designate
	permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjEwMDFNQjEzMzI7MjM6S3dTWnA1MDRvcXlybDMwTlQ0d1lOMnFC?=
	=?utf-8?B?c3ZjZkEycVIvbTJ0WjFpYXd4WEZyWi85QXI3TElMeWM2WkdIMGUrWVF5eEFr?=
	=?utf-8?B?bWtBS3k4VWhnWmtvYm50VjVvUDJDUURSUWM0bkY1YTVvNS9FdnVCNEk5Y3FT?=
	=?utf-8?B?cUptbXZXc281UU5kYVM4K1RSODRqMU9rUUZRUUtrWEVnTWRrNGZBMW9RSGRm?=
	=?utf-8?B?akRMVG1qdUNmV0xpWCszUXd3bFJSaStJcU1vSUFsMmtpTkh6TE54V1lidjgw?=
	=?utf-8?B?bWhJdGR2ZWo4c2piUCt3S2N5dHVuMFQwK0hZYXY2T3YzRDhLYm5vbGtpRXJ3?=
	=?utf-8?B?UTNFaHZvSkdoNTNkK2M2dythem0wY1ZWeEZXMHVaeU10K0pydWo4OEEvNlMy?=
	=?utf-8?B?cXNUTGVpOG9ac0pxa3E0dy9IUTA0emJSMEpBelhpZUs4ZW5ZcWZpWHV4bjVV?=
	=?utf-8?B?TXNxRXl2NEpoT2V4Sittb1lYdnZoWXNLWlZURVhkWmZNTW41L0pHVWN5UkhJ?=
	=?utf-8?B?R01CK1RRUnBvUGp6c01oM0Z3SG1BeFhhSmRkeGoxTStSUDFFUVhkQkpBZmlz?=
	=?utf-8?B?QVRFb2dkclBMNmQrYmFISGhibG40d1Erdk51NE16S1RrOVM5TUxBT2RRLzZj?=
	=?utf-8?B?TTM3QlA4ZEtHR3lyYmpySUV3dHFMSm8wM1BDVEhzaStSYjdPc1Y0WTBkOTlS?=
	=?utf-8?B?LzZUOXFpSy9SdG1WajZtM0VsUkNjci9URzUrU1N4VTBlRDllanVvc0p5ck8r?=
	=?utf-8?B?RndGMWtqR2g2MHRFL3YyencwdUdDZUhqSE52eHNwSVV4RjNiSUJ3S1pkWW5i?=
	=?utf-8?B?ZjdkTEliRW0rUkQrMmZWTzczN2RrMjBEMjFMeDQzNURBTlYyVkFIUFJaL2ZN?=
	=?utf-8?B?K0hCV29WY3RFLzQxa0EyalgyVGlzRjEvdnZscFJYRmYvcHNYeGFZTjZNUFEy?=
	=?utf-8?B?UGxHRVpFSFErYTg4bXBja3NJS1pyNEtvRm1zQWxOUWtzaW1wdDVIbzZnQXhh?=
	=?utf-8?B?V0VGTHlyQUtpWVJxNHNlWTF1YjAvc1NIV0h0cm1ZamRsTTAzeWZ2bzNyWnJi?=
	=?utf-8?B?MnpjejJJb0p4akdkWTNnZFdoL013aHdSdno2MVBrMERhL29nVWlaYXVTVGV3?=
	=?utf-8?B?NEUyakZDSFpDRFBPYUVObHJSUWZXZnRQd0w3cmVYRVJQTEd2YnNWNFpqb1Iv?=
	=?utf-8?B?ME9POXM2YStFL3ZuUzRQcHZ0UmdsbUpkWGJRZlpkOGZaZkQwUFF3MytPOXBC?=
	=?utf-8?B?WmdhU2VwemsrRHplUWhRdTJDWWUrT2dEZUZXOFdDdEpVUDlqNmJWZ3JHOEs1?=
	=?utf-8?B?TXluNGxEUVNvL241S29pbnkwVSsxbm9wNW85aFl2Nm9GZy9VdjM5VEtibW1L?=
	=?utf-8?B?eTZyVlZ1QzdxQXgvZGdWZWEyWXJ1aVR6bWx1cXh1QkRIRXI2cUtjRHp0L2hE?=
	=?utf-8?B?WjNSM3lHSm9nbU5ndEIrM0UvT05TYnVtZXZMSHZHQ1dQbVpJdXcrZDBXTDBD?=
	=?utf-8?B?NTFTVktOeFEyZE5TdXh2WGR2MFNYU1R0VlVsVzNxSTlOYnMrQWEvcUNjR25r?=
	=?utf-8?B?MXZTUUlGZ0N5ZnBHdWZxZTVUNCs0anhWeXZyVVozTWJubnVYMlQ4TndnWDgr?=
	=?utf-8?B?Qnc5SzFoL1ozbHA2NW5aeEJLcmwxRlpkdXJxZTNkT2xFdDhSRldjdittczRv?=
	=?utf-8?B?anRsaHF5UGUrZTczVnFMWTNVZWM4NW5nbzRYSlBhMzREQS81ajFJZGx5MUx2?=
	=?utf-8?B?L24yb0dwWTFoS2ZJajZ1RE4zSEU0bUlVM2JDSGVOL1lhcFpZMGIxSTF2cDZm?=
	=?utf-8?B?WmRXYlRSTmpJKzFseUhpaFRCUC96UDNxeEpZWG84UFdaeW9lVWVYUXJSZE93?=
	=?utf-8?B?QTh6WWQ3M2k2UXRNY2FxV1k2OWlvOW9Fa1FNY1pUd0k5V2dTWUZ0dnRGbG9p?=
	=?utf-8?B?WmVGQ08vY0JlNlE9PQ==?=
X-Microsoft-Antispam-Message-Info: Q4pAVkTO7eYWEaM/MApQcglUQKBN/bteEq/4ieWHFi62C11YVkB74eGpl+2IBscK+VG/GMtKuj+aVhAYWnFm2Ei42Q7PUGh+Kwj11fhcuhT61302GjCRQIflYlmrPRQSRME2wQr/qG5gsrhK2PpnX02haVbsDcqvpOvnVB4Pc46T5OWqjvBDqQ3lqCfMR6Zi+RsOl5PiZwfahiQ+/TnMnM22607+TOK1NPk2BcG2dZuPVULQgCujmlq8FYEFIfi4vY6eajuNErs3gomwYcmRSqdatGPwQe58Lnpr8TRmaU7JlXigW9ija/Xz4K7Cvf36bHjSDKRILgdgTUzTTcZbHTRwoq0OKPi0UvzRjhJcSak=
X-Microsoft-Exchange-Diagnostics: 1; AM4PR1001MB1332;
	6:4bcuZzXEtRTPjQE6MENF6U4LuKeW6oUeZrLjQy05LPCIXBq87SzfTQFcm5G0b5aSeWYkBly2VHMEofX3Ay4HpxuTx9t0GTlma+hzjGx6zQhWaaz+RkBomSACAF8CQVRZfZmPcQvrmQ4AAvNoyifojYFEuvEawtng9FaJfLChfJZcdvdvlZCNXOKTg8fz7SYsl0iGW3hdmj5YbvbmIzBZDrEq9sYljKL1gvAHQJBrPtd6ie/akwpKXJCYZ3J74xfLvAeU58F0FTDZvMH55jUAFdRvAPh66Ybm1JgIzX1L3PRFb6EYPARqKT/w1luVzYiodNK4vYr3wXw69zUqF1ztSfnSFA3+HdmmCM7FFz6KqM34D/AdIkZ0Em2pUcyPQb25Fjpy5upZzyiXOeG322nHlaCF0rvMkJf1gk0RT+ZT/nnJhvoLmpCjmW5zS/KFQelmgdm8qotk6qA4LzN7IohQzA==;
	5:/vCSXQquGyAxX/kecHEXyVcsbMw7g7/WzjeQ5tlJR7rG9aYlNzrO5ZP2uolzOqaOuLleztEQEoH+IfE4DVhJ9h67djfXq3/aRtY13UI0ldgpE9wPmX3In0PRcmjOME0yQA2ourP8PaKTtZu50KW4LUu7oSH9O1wv4W+JmgN/XKw=;
	24:7mD0cE8zmqsn5TNhAUpf0kg95IaQc1M7DG1wDYokyW8MUV/XUXGZg3/XmGvTS65L64HFZZFreegMdgAqllBg5gMF+BNV1vkLPB1FXx3TAaM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1; AM4PR1001MB1332;
	7:+W5e6HhHfmdmUcwzSBsJyNq1Y7riLzhOrdoXGaqmx2LQhLd5h58IzevUOJDxhvCkCjSjOWLUEQ5noV4roicnxH+YqjymS+iuHARqE0SyLzYFHEKKFHUUcQmaDvOEg1ZeyqW4nYI9t4HXsWyX99Kd9svEdkO3bU7Oo/HL62ani4/8Ql5OE6ZpQ6Lw2SaPaw8GSOe7Yta345BGFO9i70o3JBN2ARy02fSqeSDnwDAKftfHo8q0QWIfc8xhKMimRS8p
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2018 09:31:16.4338 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1f66ab-0340-4014-7d9b-08d5e647e2f0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR1001MB1332
Subject: commit 6c3281a14 / set_context broken?
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
X-List-Received-Date: Tue, 10 Jul 2018 13:02:51 -0000
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

AFAICT, set_context in lib/bb/utils.py doesn't actually set the
module-global _context variable, but just assigns to function-local
variable by the same name. Hence it is effectively a no-op.

The python fix would be to add a "global _context" declaration, but
since things have apparently worked for 5 years, perhaps one can simply
delete set_context and remove the calls?

Rasmus

