Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5140BEE20B2
	for <webhook@archiver.kernel.org>; Fri,  6 Feb 2026 15:54:54 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.67])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.392.1770393288977961701
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 06 Feb 2026 07:54:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=VvJCf8ET;
 spf=pass (domain: axis.com, ip: 52.101.72.67, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJMmUPpQbmTiwY8TLitxf2set8ykGPMGr8KHwcxS0exMAqpqVPw4E4FCF9pxOUeJgXs8KuXMvocHK9oSu5wtkcrwnbDRy+p/2R1uNL0rCibhwRo73wzSN3NuD1ORS/D1BovkiwptehMBNbYOdqJqUISqKp9WylQXlgZqZHJLmM6fBpx2ssDWVMux1ZD05MCfIg4VMltoocOImZUZA8pyR9OfKrGbf/oDI5f5mQrlwamBkW7mT+ntWlWomkrpqSP/uS2c8ElQZMLgdE5zwyZbUjowhMQkSATRxxS2xghIqbQDDu19POcGM6MD2RnAWW/qkCqrRTtIQLV7JVy2DVCOKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oS5KhOk0vjl2jsEPtivg7E+5m9Wx4lf6+gsq2dbnNcs=;
 b=smUQ76X9oKZD7y2YFvX96W2/oI/HnSLQSwF52neMoMFn+vrra/RvS3ilQb1p3mookGXRybo8kQGWyDKzVrM3tQ0F6tAD4POQ+YMm87QbIqQJNOfX5gTz/9wMiKQq7Grgi6Zg0tktLA+VOHtZ5zqjsehKV6LYg+HDjczAG85zYqwWeXnxgY+Zk4skrpea0hl3Tdpju34sRABYKimUZyq0aJY9crKUcrv95MSyjc3JkOw1ova2cRZlk62gkU+GIbEMgW0pcXGNabI7HajLl3OauD82QqcoxSd5IdsBkDwtAXISys5102oE34ZGN4warZOkuRstWBdVVW4hZKwcTWXuLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oS5KhOk0vjl2jsEPtivg7E+5m9Wx4lf6+gsq2dbnNcs=;
 b=VvJCf8ETy1uBXLcty30LrtjRppMvH/nTCd9ZrdTE2mrhnB3hEyxDjqPTtqT644RG+76xYMqyIl3qU/jIazwXny3uPuC5tCDwu7J4Qlq9KYfKNIyZm7dHPheotesElM+Q8gKIGJHN2nurlnAw9cN6545p0Lo/aeohe05FOv5ZvIg=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by DU0PR02MB8619.eurprd02.prod.outlook.com (2603:10a6:10:3eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Fri, 6 Feb
 2026 15:54:44 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::e5b6:b9a8:2a5d:e0cd]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::e5b6:b9a8:2a5d:e0cd%5]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 15:54:44 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>
CC: "liuyd.fnst@fujitsu.com" <liuyd.fnst@fujitsu.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel][PATCH v2] bitbake-setup: Add strip to value from
 settings.conf
Thread-Topic: [bitbake-devel][PATCH v2] bitbake-setup: Add strip to value from
 settings.conf
Thread-Index: AQHclz3/orOg9bMl5Emy+pjj3iFyrLV1jgcAgAAQneCAAAh0gIAAKFRQ
Date: Fri, 6 Feb 2026 15:54:44 +0000
Message-ID: 
 <DB5PR02MB102132E8B67A9ED8A0770547EEF66A@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20260206075522.5620-1-liuyd.fnst@fujitsu.com>
 <CANNYZj-O91BPn5KMaO0FVcpLqdtU7MF5RfVLQmJQyXvEjfd0Xw@mail.gmail.com>
 <DB5PR02MB10213463E2A774597488AEC60EF66A@DB5PR02MB10213.eurprd02.prod.outlook.com>
 <CANNYZj_PMgx+FR9jMVSuJgTKCaYe3n0yDf=y4drtypZYi4wgAA@mail.gmail.com>
In-Reply-To: 
 <CANNYZj_PMgx+FR9jMVSuJgTKCaYe3n0yDf=y4drtypZYi4wgAA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|DU0PR02MB8619:EE_
x-ms-office365-filtering-correlation-id: 42828e87-fd85-4137-4c1d-08de65980c1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?M2oyYjk4dDZndzJQMDZhTFhpdThjMWdFV2d6UHpGNEJOYlp5blN2cGplZ3pT?=
 =?utf-8?B?NmFpNGNRSUNCMm1QcEdwM25YUzlnUFVDRGl5Yzh2YStON1dxQU9VTkZuVUJD?=
 =?utf-8?B?R1FmQmFpYlJBakw5VEJWT1J6RDdmSHhTcHl0b2hld2VMbjhKZ2x0ZDBta05s?=
 =?utf-8?B?aHpKMEI1RDJtVXplMWNUNDVXb1pncHB3Q1E3VDhJa0hVTUR0K3BINkkybXdt?=
 =?utf-8?B?KzByOFBhSHZVMmltUDA4MU5saFB4T05EOFpGQTdtVlJyOXlLVkhBUlR1a1ls?=
 =?utf-8?B?S25kcW5vQUlGZ28rUHVDUWNBMHQrM1E0OW52NkhESXl1ZmpSSy95SWNHS0I1?=
 =?utf-8?B?Y2RoR1NPYnFjcEt3b2d2OFU5M1lWb3lwV1gyWlltNU5ZdkFtZzZ3YjA1TU1H?=
 =?utf-8?B?eGtMNFVGTVRvZFdMdkwrMVhCUC9Wazcra3Y4R3dHQzkrS3p4VGVEcSsvdjRP?=
 =?utf-8?B?NVI4bjFPNkdqZUtFRHQ4WWdJaUZDM2pQNG4zNWR1QkhjN2RUVWo2ak9EeDBV?=
 =?utf-8?B?ekZpSWdXZzFmclkwYXVpUW1MWlY3YWtpKzJZRTExQVNWRksxbVd1RzE3VnlU?=
 =?utf-8?B?NGIzOW80VEgxcDFvM3p4L1drdVhTaEt5STVBZHZIRG5QQ1FNWHhCcXVyOENk?=
 =?utf-8?B?amcwWGxLb1RsMS8wUzVsQzhNOFZvckdWd29mYnFtTHhJY1VIR3drUUgrMnY4?=
 =?utf-8?B?TkNKQ0hCNExXWTJBSGRFLzJEWFdXdzBpdjZidFNXODgrTkh2WW1YM0RzYk1Y?=
 =?utf-8?B?azdBUjZhencrTVNjdEhpaGdIOW5JS1dvMktuUnUrYjdFUDBacnYreE5FTlBO?=
 =?utf-8?B?NDNtb3FZVGlFN3NSQjFtVHlrTGVtQ2RqTGFxUm0zR2Y1UWZWQis3bkZocmJn?=
 =?utf-8?B?Vnc3OGhYVFZqNXFBSDRuVUZ1TThsL2VCMERDWVNUYjJBbHVxdVJ3WmQxQUtG?=
 =?utf-8?B?eFE1WFFyUmx0V2paakZsY2tRdWNrMEM4a3hDRmp4a1Y2SUhINXZyY3ZqczQ4?=
 =?utf-8?B?c1AwUndVOWwwancvRU01Q09zaXd0dEFNQUVyZ01tQXFCdHRaWHM0WERRRDYx?=
 =?utf-8?B?TUVEMEgrM2g4RFFqSU1CRVVaSUZNc0dhWVpsSG5tY2hLaXZWeHpSSk5YckRK?=
 =?utf-8?B?NU1qM2c5eHgyMGNqT2hkMlg5QUhuTlpSQ0c4V1JINGNxcDhBSEh6Z1lQY3Ex?=
 =?utf-8?B?TkczTVp1emVPbk1nMFYyTlZJZkZuanc1RWhlWi9hSFhNTDk0eGk1TkdXelY1?=
 =?utf-8?B?aFhtQzNyUDVRaGxOUWl0cHVzUExtcGZzVjlWZWxzYkZDa24vZXFVVlZRZkVk?=
 =?utf-8?B?ek4wb3JHbXZmaWU2Vk1GSUgveGp1SmtKUHJvb0VtTERHY1FWNEU1eDA3ek1V?=
 =?utf-8?B?ekFuVDRDb0FMaWJYMWJQdU1ITEFuM25Va0dUY1dUT2hySDVDc0VNc1BWbmtr?=
 =?utf-8?B?MHluZzM0QUhTVTRUa2c1aTAxWm84Z0FaOUpDTVBPeEpyUUNiMVRHWXJDNk4w?=
 =?utf-8?B?ejFlVkRUNjBFVTBlZDQ4Z1Vsd00xeEpVSEdtdXVCMHRGZjlzN1FncDdxVmdR?=
 =?utf-8?B?QjdLQ09aSVVLNHo4eWEwbjR3Z2lGbXVGOVhvQjdTSmN2RGVPeEVsbzVmSjZF?=
 =?utf-8?B?ZHI3N2ZZSFhQcElCdUgyRFBmdXc0NHRjVlp6TXJTU3Vad0dyYnNSWkI2NXlD?=
 =?utf-8?B?UjFHUEhzMUZLbmJEcWY4QmJIVFp3TlhESWVwTWVtNnB4NnR6b3RsZi93WWp0?=
 =?utf-8?B?VG1NdHZYSGZUTG9iNjJUNWFXdmljbEdnbk0xSmk1S2g5N3BtdlM5NVlTYzc1?=
 =?utf-8?B?SnFCbDJ4RHRLS0dKZHYyaDFOcXVwUC9iZ1lwYk1QNHk4bWNKTm81a2pZOUFo?=
 =?utf-8?B?eVlNSlF1Z29pRkhQVkgwVHVJWHNvajNVc1kvZWNzNVBuV2oyOC9mcGZLSXZH?=
 =?utf-8?B?ZllnRzBSc1JVN1VWTk5KOXN5Z21ldXpERnlERjhOR29HQ3QvTEVkREdRT1dz?=
 =?utf-8?B?VWtyQXE5Nml5c3FHU21EUzBNdW1aeXNWaEo1VlhBS3hDWGJNamNrdy9sajRj?=
 =?utf-8?B?cWYvdDdqSlA0WUFyQlNQb0Z3cVBjZTUyb3lUVVBOL0pVOWpqbHZmblRjOHB0?=
 =?utf-8?B?MUJPTEphdGJmOHhiWk5qS2dnMkxxSVMrQmhzbzY5cXBjd2NyRVNNWG9vSld3?=
 =?utf-8?Q?xyiP64k08JQRIHTY12hrUoI=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?T1JZUlJJTVpwM1BZdVpGbnIvdnpjVjlmUUVyZnc4N3AvN3RhWTE5dXp1Zi9r?=
 =?utf-8?B?ZTNKMXJ3YjZvSmRyc0IxOVg5enIrQkFmQ1paMFUyTkJuVkxKRnNzanliLzY1?=
 =?utf-8?B?TjM0NGNPdHhlVkpJODhJODFUdkNiNTFYUkxzQUlkT2g5dUhLVUJqQVd6YjVR?=
 =?utf-8?B?MGU1cDd1STJVRWpxNEdleGZKaVhiZ0p4K0NGSDg3MkJsNThrUURabTl1YVVl?=
 =?utf-8?B?SmpxK1k5RDNoaFpNYTNIdDdNTzdFUXJyK0lIL0dlRlRueFU0TzVQZ0N5QzNE?=
 =?utf-8?B?OHNvTk5pVzRtVktjcTVLd29FbWZicmV5U2RxWlVDZ2h5ZEh4QWJXcUppZzgr?=
 =?utf-8?B?d1dGeWg3SEhXYXlMVm12ZXl4bUdFTUpnWkQvN1VTQzBUa0JOUWN4TjUyRG5U?=
 =?utf-8?B?M0F4WGJpeDVxbVNFSHpCMFBSMEZXeWlDZVFkNTF3NHhSazhBcTdZbnJ6bHky?=
 =?utf-8?B?dFM1TG90Rjk2S1Iya0ZmQTQ5YTdHcU96NmhhUkRDOWhtNmY4RVl6NkZzVmZ4?=
 =?utf-8?B?M0g3bkhHcWxibTdnMkg2a3J6dW55dG50S01LRU96WWhwbW1uRGtTK2x4SUs1?=
 =?utf-8?B?dG03YkI0M200QTErNnFERDJDTEp0Nk54NGlvU05zOEtYdTVpNVNpNloycVp3?=
 =?utf-8?B?UmdyYndSRGpCZTBwUVRiQlphc0ZHNkRxbjlwUW03Ui9GSFhRSVlNTTJVUnJC?=
 =?utf-8?B?QlNCN2hnWmtkQ0MvN05PcEZvWmxVVlJkS0ozUkpXYzhjTWxKM1lpanhsV05Z?=
 =?utf-8?B?R1I3NkttRVlRQ2ZldktkK3lYcjRqRnh0c3hPMFNjREY3MUd4cXVsU3pOU1A0?=
 =?utf-8?B?d0NQV2pucUl3SHo1ckVvUy82V01nMnMvSytHcmdlTTlQNE12N1lTQXJ2aDBJ?=
 =?utf-8?B?NjM1Y2Z3Ujd5OURaWUxxeFdkZGtYMDRFQTNHaVpYRXB4Z3hzTERxWENqRWRS?=
 =?utf-8?B?VDRybmpEOE92QzlBTmsyUHBQSUNkaGZGTW5XQTJvS1ZpSE9nbjhqakNTN2Fo?=
 =?utf-8?B?V2hwZTJOTWp6TWI2UFViWUlhRHJUTFo1bEpoRWNXWmZNWlQrY3ZFVldDQTJI?=
 =?utf-8?B?dk5rb0kxWlZSQ05PWUdpd0FTeDNGdGllTUNTNXJlUUxYcDBSbHVoQTlyY0Z5?=
 =?utf-8?B?eWcwTjNTbnh5T0o1WGRnT2Y1WkkxZWg0OFQ4eUtHVWdSMDdlSDJDZlJ0alRP?=
 =?utf-8?B?b3NPK0NSK0hzWUlJaEV4MjFnODFQemxzSjM2eEo4eHZ2a3FvQWd0ZXQ2SFRE?=
 =?utf-8?B?MlM1OE9xQ1NjTmdzM0NMVXorejdheTlVb1M4elRzRGE4dGhPWUJaTnMwNkkz?=
 =?utf-8?B?NEVNNVV1R2N3OGxtREFyMUV3TEZWUDZmT3lMSERnS3loclhLNCtIZVl5NEtS?=
 =?utf-8?B?Y3djYnhaVVVnWmpTUmNmR0s1V0lJN3FtTGFSL0FyRzBlYTkrWjloWGMzRUpn?=
 =?utf-8?B?S1l1V3RPaXhBamhYT1pHcXprbUZTSkl2cDg1V3Z5TWVLYmltYm5JTGxCZ3Zr?=
 =?utf-8?B?bElDTTZJaC9yczJqSDV4azVXd0tKYmtobHQxS2FLSUM0Wit2SFRoY1h5QUNY?=
 =?utf-8?B?MGwyWFNKSUJ6TkFhTERwMTJ5aTltdENSNkdLVWlxSkxUb0lCMmNZRXI3WWIr?=
 =?utf-8?B?S29NRWR1dUhLUHZPa0Rxa1ZEdy9EOWJiOFZHK2FXOWVxcGJvdTRRVGtNUE5i?=
 =?utf-8?B?L1N0eDJQeGszRzFLK29ReWRmWDhUNGxzekgwTnVLeXVsMWt3Rlp1ZWxzRFVM?=
 =?utf-8?B?MUdlak1MSHpabVNyVEQ5YXNlQjlkWVJ2RVZpcHZUSjNwRlpBZkYrZjFqM1dV?=
 =?utf-8?B?VEEzRnZrWWJnSHJqZkdoclJuUHpRNG93SVF3OCtDSnBaSFk0a3h2bC9jWllM?=
 =?utf-8?B?eUdUamRIOEdIYWVzUmZIU3lwaWJXY2dBTFNZY2xiY3B5VmFTNFN0RkNvc24z?=
 =?utf-8?B?ZGxxRmhHRVNQNXhWcUVEbmMyblRucjM4aUVFckRobmJRa3dIOW1OWU1TM282?=
 =?utf-8?B?L0FUaDFhTjRXWnVxaXdEYitubGRtTkxpKzdtcCtFYVlteGw4VTQyd29Ha25I?=
 =?utf-8?B?d3Z6bG4vSEl2d0RDQ29zUCtZclhXdjB0WVJKWXdLT3RicUJkZi82TlRVWkNN?=
 =?utf-8?B?dnB1cDM0OFBKaVMyT2EzcWxOZnU4bzJ2VXJ3MndGWFY4cC92L01PSGNjVFlO?=
 =?utf-8?B?YlB0K21VTmtMdjNjenVFeVVnZE1haER0Vm1SaE9Ba0JwdzhnSWxTTC8wa1hz?=
 =?utf-8?Q?YrF1omjfKkxEyUt4FbIgyNPvlwxPvfTtGjspZo75AA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42828e87-fd85-4137-4c1d-08de65980c1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 15:54:44.5467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2hJB/WO5zmH/TNNgxMcNJnPgV3yhPpXW9MU8WG8Y3fnCKa3REfXzKEQrjvaegPNC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB8619
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 06 Feb 2026 15:54:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18983

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4YW5kZXIgS2FuYXZpbiA8
YWxleC5rYW5hdmluQGdtYWlsLmNvbT4NCj4gU2VudDogZGVuIDYgZmVicnVhcmkgMjAyNiAxNDox
Ng0KPiBUbzogUGV0ZXIgS2plbGxlcnN0ZWR0IDxwZXRlci5ramVsbGVyc3RlZHRAYXhpcy5jb20+
DQo+IENjOiBsaXV5ZC5mbnN0QGZ1aml0c3UuY29tOyBiaXRiYWtlLWRldmVsQGxpc3RzLm9wZW5l
bWJlZGRlZC5vcmcNCj4gU3ViamVjdDogUmU6IFtiaXRiYWtlLWRldmVsXVtQQVRDSCB2Ml0gYml0
YmFrZS1zZXR1cDogQWRkIHN0cmlwIHRvIHZhbHVlDQo+IGZyb20gc2V0dGluZ3MuY29uZg0KPiAN
Cj4gT24gRnJpLCA2IEZlYiAyMDI2IGF0IDEzOjUwLCBQZXRlciBLamVsbGVyc3RlZHQgPHBldGVy
LmtqZWxsZXJzdGVkdEBheGlzLmNvbT4gd3JvdGU6DQo+ID4gPiA+ICsgICAgICAgIGZvciBzZWN0
aW9uIGluIHNldHRpbmdzLnNlY3Rpb25zKCk6DQo+ID4gPiA+ICsgICAgICAgICAgICBmb3Iga2V5
IGluIHNldHRpbmdzW3NlY3Rpb25dOg0KPiA+ID4gPiArICAgICAgICAgICAgICAgIHZhbHVlID0g
c2V0dGluZ3Nbc2VjdGlvbl1ba2V5XQ0KPiA+ID4gPiArICAgICAgICAgICAgICAgIHNldHRpbmdz
W3NlY3Rpb25dW2tleV0gPSB2YWx1ZS5zdHJpcCgnIicpDQo+ID4gPg0KPiA+ID4gSSB0aGluayB0
aGlzIGlzIG9rYXksIGJ1dCBzaG91bGQgd2Ugc3RyaXAgYm90aCBzaW5nbGUgJyBhbmQgZG91Ymxl
ICINCj4gPiA+IHF1b3Rlcz8gU29ycnkgSSBkaWRuJ3QgcmVhbGl6ZSB0aGlzIGVhcmxpZXIuDQo+
ID4gDQo+ID4gTWF5YmUgaXQgd291bGQgYmUgYmV0dGVyIHRvIGFib3J0IGlmIGFueSBvZGQgY2hh
cmFjdGVycyBhcmUgZm91bmQgaW4gYW55DQo+ID4gb2YgdGhlIHNldHRpbmdzPyBCZWNhdXNlIEkg
YXNzdW1lIHRoZSBzaXR1YXRpb24gd291bGQgYmUgZXF1YWxseSBiYWQgaWYNCj4gPiBzb21lb25l
IHNvbWVob3cgaGFzIGVuZGVkIHVwIHdpdGggYSBwYXRoIGxpa2UgZm9vLyJiYXIiLCBpLmUuLCB3
aXRoIGENCj4gPiBxdW90ZSBpbiB0aGUgbWlkZGxlLiBBYm9ydGluZyB3b3VsZCBhbGxvdyBiaXRi
YWtlLXNldHVwIHRvIGdpdmUgYQ0KPiA+IG1lYW5pbmdmdWwgZXJyb3IsIHJhdGhlciB0aGFuIHNp
bGVudGx5IGhpZGluZyB0aGUgbWlzY29uZmlndXJhdGlvbi4NCj4gDQo+IEJ1dCBvbiB3aGF0IGNv
bmRpdGlvbiB3b3VsZCB0aGUgYWJvcnQgaGFwcGVuPyBJJ20gbm90IHN1cmUgSSBjYW4gY29tZQ0K
PiB1cCB3aXRoIGEgc2ltcGxlIG9uZS4NCg0KT25lIHdheSB3b3VsZCBiZSB0byBzdGFydCB3aXRo
IGEgKHNtYWxsIGFuZCkgd2VsbCBkZWZpbmVkIHNldCBvZiANCmNoYXJhY3RlcnMgdGhhdCBhcmUg
c3VwcG9ydGVkLiBUaGVuIGlmIHNvbWVvbmUgaGFzIGEgdXNlIGNhc2UgdGhhdCANCnJlcXVpcmVz
IGEgY2hhcmFjdGVyIHRoYXQgaXMgbm90IHN1cHBvcnRlZCwgdGhleSB3b3VsZCBoYXZlIHRvIG1h
a2UgDQphIGNhc2UgZm9yIGl0LCBhbmQgdGhlIGNvbnNlcXVlbmNlcyBvZiBhbGxvd2luZyB0aGF0
IGNoYXJhY3RlciB0b28gDQpjYW4gYmUgaGFuZGxlZCBvbiBhIGNoYXJhY3RlciBieSBjaGFyYWN0
ZXIgYmFzaXMuIEkgZG8gbm90IGtub3cgd2hhdCANCmFyZSBpbiB0aG9zZSBzZXR0aW5ncyB0aG91
Z2gsIHNvIGl0IG1heSBiZSBoYXJkIHRvIGRlZmluZSBhIHNldCB0aGF0IA0Kd29ya3MgZm9yIGFs
bCBvZiB0aGVtLg0KDQo+IE5vdyB0aGF0IHlvdSBzYXkgaXQsIEknbSBub3Qgc3VyZSBob3cgcGF0
aHMgd2l0aCBzcGFjZXMgaW4gdGhlbSBzaG91bGQNCj4gYmUgaGFuZGxlZCwgYXMgdGhvc2UgZG8g
bmVlZCB0byBiZSBxdW90ZWQgb3IgZG8gdGhleT8gVGhpcyBjYW4gdHVybg0KPiBvdXQgaW50byBh
IHJhYmJpdCBob2xlIDotLw0KPiANCj4gQWxleA0KDQpXaGlsZSBoYW5kbGluZyBwYXRocyB3aXRo
IHNwYWNlcyBpcyBvZiBjb3Vyc2UgdGhlIHJpZ2h0IHRoaW5nIHRvIGRvLCANCkkgYW0gbm90IHN1
cmUgeW91IGFjdHVhbGx5IG5lZWQgdG8gaGFuZGxlIHRoYXQgY2FzZSBzaW5jZSBPRSB3aWxsIA0K
ZmFpbCBiYWRseSBpZiB5b3UgdHJ5IHVzaW5nIHN1Y2ggcGF0aHMuIEJ1dCBtYXliZSBiaXRiYWtl
IChhbmQgdGh1cyANCmJpdGJha2Utc2V0dXApIGRvZXMgaGFuZGxlIHBhdGhzIHdpdGggc3BhY2Vz
IGNvcnJlY3RseT8gSSBoYXZlIG5ldmVyIA0KdGhvdWdodCBhYm91dCB0aGF0Li4uDQoNCi8vUGV0
ZXINCg0K

