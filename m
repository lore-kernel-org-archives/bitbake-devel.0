Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1F5C369C2
	for <webhook@archiver.kernel.org>; Fri, 25 Apr 2025 12:45:59 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.69])
 by mx.groups.io with SMTP id smtpd.web10.5683.1745585158584954241
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 25 Apr 2025 05:45:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=xUTOGmZ3;
 spf=pass (domain: siemens.com, ip: 40.107.20.69, mailfrom: peter.marko@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c8ahYzGuzfCcbaXQM6t518mLlA6UES2Yjc31uHGMPhVHVZNNaSaUWLSjKGusQqx13l2T/V9FBDdWwQ+kRnyqx2gJb9qXZlM06lPXLmROgdKaerq+3jrBnpY2SYq8BrcPqCeMMjsgg9Jzwt8LzwzPeZNsxQtgNFVHHbJQhiXt9BjWbK7+sMH8h63zqaLBhfUw4NlJYyIkx15wFmNQVZzkWiiC/vNAn3DG2YhKbb6dLeoCT7VpRztwUIt59CAfGOOXfA0a7mL/quWe3UzenfY6A/D9OCrZKO/DnSHknMQZocRNfUfzM7PoRsp602TzRAW+sLYGKSC6vlqCDr65h9KRiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzGi3MxD4GSZ28+KAlr2+oDsnaz5+4LQH8KY98Ctn5o=;
 b=q1/3iujIWiUsWYizmA+to8SChKSYQeuEIrZ7/Gs6E1f6JRB721b1h7iKxmcmNsH7A4ZdFtRT+TiOQkaXEW9xlUSF/2elmkgwdK3Su2FZxdJ3SB/iNgnNrlzChstT2nDSnBwN2pxmLQYn7iNyi/u8oPY/t9rLZgXuDAuAS5f8SmvnZLkkUIok0vlG9C8o57CEFq5RDcbV40zWnW0cx3dHGRNkK4/oLqiKYYbFdn+N7hiZ6k/8tAhiTi6aSS86gsXy6eLI65Zz+4v/D15CnjJxzBqtrK6sE/fLm2u4ir/hsNRSoXr/73WuPM8XJCrwgcJgKlLYtnw4R1Fn2sKhEAxgNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzGi3MxD4GSZ28+KAlr2+oDsnaz5+4LQH8KY98Ctn5o=;
 b=xUTOGmZ373F0Kvktp65gc8xL+JW9l1sSzlTozNwAmGbL1wuxd7wt5wTkKixjd2GnLr4dGTZZIFLFUph6+EmDk2N5VfbJGQqaFQgG6ZULDsAKFUw5qB/lkOl1UWjRxwPNK4VOmtVOLnXBTm5B5O06DkgN+OnqRkgoqRCdy7eLXAIjougt0yeUkF3DvgV4vIE4qSnQH0rdihm35aRmtPMPFUUe6uIXo6viHv12Eu/CpDn8s29svMf2+O5UTiwfAXLimgtl5Bsi1xnx/9mKieKnAmiDDQVnOUcmCQqbFtEV2lSGeLak2PYdTizeYwCelRUUu4pShrQnbxv3BwSPkppnsQ==
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:479::20)
 by PAVPR10MB7403.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.38; Fri, 25 Apr
 2025 12:45:54 +0000
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c68:267b:6fd1:d3f2]) by AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c68:267b:6fd1:d3f2%4]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 12:45:53 +0000
From: "Marko, Peter" <Peter.Marko@siemens.com>
To: "richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
	"philip.lorenz@bmw.de" <philip.lorenz@bmw.de>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
CC: "mathieu.dubois-briand@bootlin.com" <mathieu.dubois-briand@bootlin.com>
Subject: RE: [bitbake-devel] [PATCH v2 0/8] Fix gitsm LFS support
Thread-Topic: [bitbake-devel] [PATCH v2 0/8] Fix gitsm LFS support
Thread-Index: AQHbtctuMhFsyO8yp0m9lOBZj5XR67O0UYWAgAABaeA=
Date: Fri, 25 Apr 2025 12:45:53 +0000
Message-ID: 
 <AS1PR10MB569750ACF9183A75F2389811FD842@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
References: <20250425101155.2905972-1-philip.lorenz@bmw.de>
 <522a15ccc1ed1597a5a6b92803536484a3f008a4.camel@linuxfoundation.org>
In-Reply-To: 
 <522a15ccc1ed1597a5a6b92803536484a3f008a4.camel@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=7c92b518-dba2-44a6-b00f-088c8bf1bb60;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-04-25T12:40:43Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR10MB5697:EE_|PAVPR10MB7403:EE_
x-ms-office365-filtering-correlation-id: 9cfb4a73-9c74-4304-f023-08dd83f71df8
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?STJsWXczNkdyVzNneWFUMkJMSHgxZksydkc5U015ZWoydlFsZWduWStTcDRN?=
 =?utf-8?B?ck9OWlRXNTFsNkhPQTdRSS93TmphcmdURENKYlhvN0d2eG16bnQxcEczRTUx?=
 =?utf-8?B?Z21aaFh1TXN1Q0ZpTWF3WjBvVHBXZG5mQnBNb3h4OTJPS2dzbHBoU2pMQTB0?=
 =?utf-8?B?RnRYeWRjVmp6UzJORll1N1VDQUZ3bTlTbHdrczdIdUxkVUtXbVdlMXJFVXU2?=
 =?utf-8?B?VVlzRlQrVEZSblZKQ2FYSzVVVXU3Q1JQNTNQdGVwOGZVZGxlODUwcTN0Sm42?=
 =?utf-8?B?c0IzS09paVlvTDV2SkhUdmppVlVFNVZTeURZQ0QwQlpleVpySDZWM2ZOdHQr?=
 =?utf-8?B?N1M0VldRYzhTdEUzbWtSNmhhUFdnSVJYeVZQRm5zYWVGWjA3dEhkNndRVjlp?=
 =?utf-8?B?a2FpaW8rNlUvMExGSjZONkdKZnhhWkZZYktzVlV4ZXgzdWZwdUhiUDNKZFpW?=
 =?utf-8?B?d3l1c29SeWNGc2VkemplWGhRR203SWs5VFVhdFQyR0hLTzNnVStGR0ZEdU54?=
 =?utf-8?B?eVM3TVljdEFjWC9VcytMYVIzWnpUWUhKK1ZRZjljbXhHYVIrQ29yQ1ZyMVhF?=
 =?utf-8?B?T21IdDF6NnBsL25sUjhXOWtyaFl0OWlmWU0reVVKbGswZHMrcEQ2UU9CZVN4?=
 =?utf-8?B?dFo0K3dqRm4vU3pkbTVhbzdSN3JVQlNwNTE2Si9sTGd6Q2U5dC9BV1JSOFVm?=
 =?utf-8?B?QUVJdkNYZzdwdHR5UkpOeXhJNms5Q2VJWXFuUkl3WVo4OUt1OWFmSnZMWERn?=
 =?utf-8?B?UkRRaXdnUkcwT0Z3VmMrWnl4dUl6Y2dqU0hPT2ltUmpGR2JCWGhOODRvVFFn?=
 =?utf-8?B?L3UwdmpQam1RZGZXY0lLQ1hobkdkRUc4WGdTNUt3SUxTa29WTE9nVTVGUFA3?=
 =?utf-8?B?Z1NDVkkzQWhPVm1XUzJpSzY1NTBDeVNBd2xOQUNlQ1lUemx0RnkydTBPdVBG?=
 =?utf-8?B?UnRySDVXT0IraGlnYTcrdzhTNHJRcWFDaXFmWDNxelZ3dHJaUEY5UmprN21T?=
 =?utf-8?B?c3Q5RkEyV3FaOFlHalNjNHMyTStYblFMelI5VlpGRTkvanZJSzFObGFneEo5?=
 =?utf-8?B?ZlFCdU9keVBXUW9DcStoa2hHbzhXdUwyc3p2N2NWZlh0Uks1V1c2ZWpCYnNW?=
 =?utf-8?B?M00vNEgxSzN4TWZVd2laemQ4aXJlOWovT0FibDI3VERBbWdGYUE2UHVQUjJi?=
 =?utf-8?B?WDZ0eTcrd1VXK3MrNTcrdUdsL2RrTEowRTVxUmV0VG1IN2dmQUlhZlQ0cGI4?=
 =?utf-8?B?OTJrd2FIcGprVVhId3orM1Jic2V6NmJnRXNtQlNmeVljZjhjVHkzUXMwOUx3?=
 =?utf-8?B?TmtiMWxlSHk5Y0pTM1FKSFpPY3I1bHJpQkRXME0zb0hoUEtvY1ZGcmNEaUlY?=
 =?utf-8?B?blJTUXJkWGxGR3dyVzBDUWprdUUxeXNxSTBLN1l6MkJWdWh4MzMwTURHeDhS?=
 =?utf-8?B?Q3d5RFE1UlNrVFRSRkthenNsdFA2ZnA2N3RqVmhTeTBESVdIN3QySzUvcURv?=
 =?utf-8?B?cGxJQnpzcVQ4MUdaWTUrRkkzT0FGZ1F4Ry8xdVVBcG1kdnQ2clRQWmxudWhj?=
 =?utf-8?B?NVpKRk50dVYxY2hYb3JMRGxLbVlNTXBCcFdiOUJLVWsxVlZ1L0YvVVlJSGdL?=
 =?utf-8?B?eE9XTXlDUW92akxzQkNJb01KUGZJTzJORjhtL3BOeWRKcWs1ajZTVytjZzQr?=
 =?utf-8?B?c0NyWkhyaXd4MG9PRWx3WHdCSk9XWnI0VXBScnFWbzdEOGRpVGFDYmxDSE4r?=
 =?utf-8?B?VEZheEN2MUlqS2hLZ0M2Y242NnRpV1RtUEVUbTVldjk0THV0UWgralE4Skl1?=
 =?utf-8?B?NjhPZGFqaCszTmNtNk5ueEJBaktHUVRBYjFrWDRKM0d4QTNiZW00K0VmdXFB?=
 =?utf-8?B?eWxzbm81RGpaRnEwRXA3TmdNMnVpNXpBOFZsRVVLMXhlTGNRdCtQZ20ybzZV?=
 =?utf-8?Q?/4lebQwec0w=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?enQ3VnVxblJXMWpQNUI0MFBOekdjbkJGZU9pV2xEYjJWWWp5OHB1Q3YyRnJD?=
 =?utf-8?B?czJCQzNYL25ZRFpnUU5KTWpBSkNEUmFPM2R4czdDUzRtQlJMUDdtQktHa2VB?=
 =?utf-8?B?T2dTbjJBSm5TVUdqOXhTZEFnbTZ5Wkh3ZDYvZGczcVRWVTkvMkIvK01wYWww?=
 =?utf-8?B?TXVLZjVXUEpJRjA0Wk5oTGQwZ0NIWW13Wm9IeXNXbW5ONTBlM3NkMUhXY1p4?=
 =?utf-8?B?dmxGRGZJZ0N1d3R5T284L25PVzRKRDBBbmoreGRKNVFZWjQ4VXhiZGltSmFS?=
 =?utf-8?B?MDk3TkZCQjdjSlo2STZSK1k5WVpmNElQdGFEenk4N09YSFhCa2lrV1lDd2Jt?=
 =?utf-8?B?My85aFpMOWR2UzFOeTMwblJZT0QwNXJZNDVIL1kzM1ZwbFdGMEhlZkI0b2lr?=
 =?utf-8?B?V0hRMGRQRVlMdmwxOXZ4RXM2YURXSTg2NUxpUlBsN3drZVltSzEzSm5XSGk5?=
 =?utf-8?B?aHVoZ0tQTHlmZTUzak1QZTZ0OFpaT3RzQkZDVEl1S3Mxak1PYjlMNDR1SmNU?=
 =?utf-8?B?aEE0Z0RQTXExVGtkMmhZajBHaFVmYS9ITTUxUXI0cC9qVEpVVWI5alFwWGY5?=
 =?utf-8?B?WDB1YndPZCtteDd4UjZUanVXZ09JZXBLOWZZaVdaVnd5T2pzM1VrR2RSU1Js?=
 =?utf-8?B?MytwbjF1aGJVMTVSNzh4c0Y0QnloMnNPRCtKbjNxSzFWbWVtZ3BvMHVDZEhC?=
 =?utf-8?B?SHNCaUNpYnB3c00vb2lsVjR3QjJXdXoyblpzajNzaFdyMWxoelZqY3FDZ1Fp?=
 =?utf-8?B?eEdHMENTS1U4SndtVjlyK0NYckd1akdsdUZzSC9mYzRqTHlZS3ZSdDBxQ2Zl?=
 =?utf-8?B?dUVWc09sT3FacnBTT1NkZ0RkeUU4b25JcG14cTFBWFgyQkczQkU5SU1rTmJB?=
 =?utf-8?B?ZDR3cGRVb0FvYVl2NVN0NHpFa2k1d1lmYTM0Nk9PUHBIdmg2ci9iMitKZTF4?=
 =?utf-8?B?N3I3UWRpbU1PQndwNnM5NDJqZ0RZL3lTNTNzNG8wQnJUK2xHRWg0enN1MkFF?=
 =?utf-8?B?enB3UU1yZHBtaE5YMmtaNHJLcStETDVZazhCS0liT254Vyt6aXMvU2pPWU0z?=
 =?utf-8?B?WnNMbk12aVRvY3IzaFdrV2lQL3dHNE9GVmp5SXBNSWJpdzRpcGhsL0ZDT2tJ?=
 =?utf-8?B?RWE0azlnQ0szcjJFa3BXN0FyZGJpMEltaWpseXlwUFBiWFRyc0xTZGpqOGN2?=
 =?utf-8?B?aTk4bmtSRnk1TnIvcmlWZ1dkVlo5d2c2ZzMvaTNJRGpleVFpbWdPYm1xRm1F?=
 =?utf-8?B?TVYxOHY5VVoxWXVKcjdrbktmdk1VamcwSEt1SVoydDRQZGtWWVcxOUx4QXln?=
 =?utf-8?B?RmRCM0lLT0pnb1EwanZFWWl4amhPdUNxTUppQ0h6WWZMa1pYM2JIdDRaU3NP?=
 =?utf-8?B?OVpPWTlDTkhBRUsvdmQ4ZWRJQnMwdHNiTUJxckZRUFY2KzJlT2xMVFBqK2Iv?=
 =?utf-8?B?LytKTHMveTdldTMvRlQ5dFF1S2lPMEVQOGhocDJUdnBOKzVQaXVIYTdoSHpO?=
 =?utf-8?B?OXZiTTB2cDZrRnRLTlFDRSttSmd4NTFmSEwwQlFsY1lkSTA0QnNRbDV0Q1JM?=
 =?utf-8?B?Vit0eEw4dDVsVzhQOUdvdXgzQTdPa1lYQzRwVGgyVElYdXRMYklHTTZVcHBT?=
 =?utf-8?B?T25hODV6aDBNclJiekdMK0gxK3VHVDVDSGFjalIwTFl4RWl4N3AwbHN6dSta?=
 =?utf-8?B?TWgvdUFqalUvdXpQYm5JeFNkb01ZOG5kMTc2RlF4bHVNeTdvNjMySk1LYjNE?=
 =?utf-8?B?UnI1ZDExcllyOTlsZzdmQy9kWlM1UTh3UnZFc1FCRDEzamxXYzk5VFlkdnJO?=
 =?utf-8?B?Z2ovRmRCNGg1Umo2ZzNxdEZHeVRSbzZjL2R2aE5BNktVZ1JvbExwelp4QXd3?=
 =?utf-8?B?aFlabXpNMmpRQjhiTFJRWEtyYW94b0k4cEdkOTJpVVlhUDZSZkl2UGxVb090?=
 =?utf-8?B?c0Y3YWRSV1BzUm9qam5taXBVOVdDK3ZqV1ZOemthUllRN01Sa0hrUGFhcUY1?=
 =?utf-8?B?Yk9PM2dnbWJFWGFHSEhXZStobmZBUmJOdnRaeGJzVmdzWW9BOGREMTl4c3VK?=
 =?utf-8?B?clJNR2VxbGJVY3FRRmZSZit3OXpRaXVkRlJUdnlQOVZueUtDYXhTNGsvaEVC?=
 =?utf-8?Q?iAfcOtRrXYHiBLJ7Eayv1mid8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cfb4a73-9c74-4304-f023-08dd83f71df8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 12:45:53.9376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DdnhV85BloGfIoCi4fGuMcd9WY+jLrlOczBlo3HmOgJBCgsjbVqEbi7lUzbP9Xxh4ADOv3yWHbY/6I6V4ExRPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7403
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 25 Apr 2025 12:45:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17566

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogYml0YmFrZS1kZXZlbEBs
aXN0cy5vcGVuZW1iZWRkZWQub3JnIDxiaXRiYWtlLQ0KPiBkZXZlbEBsaXN0cy5vcGVuZW1iZWRk
ZWQub3JnPiBPbiBCZWhhbGYgT2YgUmljaGFyZCBQdXJkaWUgdmlhDQo+IGxpc3RzLm9wZW5lbWJl
ZGRlZC5vcmcNCj4gU2VudDogRnJpZGF5LCBBcHJpbCAyNSwgMjAyNSAxNDozNg0KPiBUbzogcGhp
bGlwLmxvcmVuekBibXcuZGU7IGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZw0K
PiBDYzogbWF0aGlldS5kdWJvaXMtYnJpYW5kQGJvb3RsaW4uY29tDQo+IFN1YmplY3Q6IFJlOiBb
Yml0YmFrZS1kZXZlbF0gW1BBVENIIHYyIDAvOF0gRml4IGdpdHNtIExGUyBzdXBwb3J0DQo+IA0K
PiBPbiBGcmksIDIwMjUtMDQtMjUgYXQgMTI6MTEgKzAyMDAsIFBoaWxpcCBMb3JlbnogdmlhIGxp
c3RzLm9wZW5lbWJlZGRlZC5vcmcNCj4gd3JvdGU6DQo+ID4gVGhpcyBwYXRjaCBzZXJpZXMgZml4
ZXMgYSBudW1iZXIgb2YgaXNzdWVzIHdlIG9ic2VydmVkIHdoZW4gdXNpbmcgdGhlDQo+ID4gZ2l0
c20gZmV0Y2hlciBpbiBjb25qdW5jdGlvbiB3aXRoIGdpdC1sZnMuDQo+ID4NCj4gPiBJJ2QgbGlr
ZSB0byBoaWdobGlnaHQgdHdvIHBhdGNoZXMgaW4gdGhpcyBzZXJpZXM6DQo+ID4gKiAwMDA0LWZl
dGNoMi1TaW1wbGlmeS1naXQtTEZTLWRldGVjdGlvbjogSSBjb3VsZCBub3QgY29tZSB1cCB3aXRo
IGENCj4gPiDCoCBnb29kIHJlYXNvbiBvbiB3aHkgdGhlIGNvZGUgc28gZmFyIHByZWZlcnJlZCB0
aGUgY29udGVudCBvZg0KPiA+IMKgYC5naXRhdHRyaWJ1dGVzYCBvbiB0aGUgcmVwb3NpdG9yeSdz
IGJyYW5jaCBpbnN0ZWFkIG9mIGFsd2F5cw0KPiA+IMKgIGNvbnNpZGVyaW5nIHRoZSBzdGF0ZSBv
ZiB0aGUgdGFyZ2V0IHJldmlzaW9uLiBQbGVhc2UgbGV0IG1lIGtub3cNCj4gPiDCoCBpZiB0aGVy
ZSdzIHNvbWV0aGluZyBJIGRpZG4ndCB0YWtlIGludG8gYWNjb3VudC4NCj4gPiAqIDAwMDUtZmV0
Y2gyLVVzZS1naXQtbGZzLWZldGNoLXRvLWRvd25sb2FkLW9iamVjdHMucGF0Y2g6IEkgY291bGQg
bm90DQo+ID4gwqAgcmVwbGljYXRlIHRoZSBgZ2l0LWxmcyBmZXRjaGAgYmVoYXZpb3VyIGluIHZl
cnNpb25zIGdvaW5nIGJhY2sgdG8NCj4gPiDCoCAyLjEzLjIgcmVsZWFzZWQgaW4gMjAyMS4gVGhp
cyBsZWFkcyBtZSB0byBiZWxpZXZlIHRoYXQgdGhlIGlzc3VlDQo+ID4gwqAgbGVhZGluZyB0byB0
aGlzIHdvcmthcm91bmQgaXMgbm8gbG9uZ2VyIGluIHBsYWNlLiBIb3dldmVyLCBpZiBhbnlvbmUN
Cj4gPiDCoCByZW1lbWJlcnMgdGhlIGFjdHVhbCBpc3N1ZSAvIHZlcnNpb25zIGludm9sdmVkIEkg
Y2FuIGFsc28gcmV0ZXN0IHRvDQo+ID4gwqAgY29uZmlybSB0aGF0IHRoZXJlIGFyZSBubyByZWdy
ZXNzaW9uLg0KPiA+DQo+ID4gLS0tDQo+ID4gVjEgLT4gVjI6DQo+ID4gKiBUaGUgY29ycmVjdCBw
YXJhbWV0ZXIgaXMgbm93IHBhc3NlZCBmb3IgZWFjaCBzdWJtb2R1bGUgVVJMIHdoZW4gTEZTIGlz
DQo+ID4gwqAgZXhwbGljaXRseSBkaXNhYmxlZA0KPiA+ICogU211ZGdpbmcgZm9yIHN1Ym1vZHVs
ZXMgaXMgbm93IHNraXBwZWQgd2hlbiBMRlMgaXMgZXhwbGNpdGx5IGRpc2FibGVkLg0KPiA+IMKg
IFRoaXMgZW5zdXJlcyBjb25zaXN0ZW50IGJlaGF2aW91ciBpbiBzZXR1cHMgd2hlcmUgZ2l0LWxm
cyBpcyBpbnN0YWxsZWQNCj4gPiDCoCBidXQgc2hvdWxkIG5vdCBiZSB1c2VkLg0KPiA+ICogVGVz
dCBjYXNlcyBhcmUgZXh0ZW5kZWQgdG8gdGVzdCB0aGUgTEZTIGRpc2FibGVkIHN0YXRlLg0KPiA+
ICogRXhwbGljaXRseSBpbnN0YWxsIGdpdCBsZnMgaW50byBzdWJtb2R1bGUgaW4gdGhlIHRlc3Qg
Y2FzZXMgdG8gbWFrZQ0KPiA+IMKgIHN1cmUgdGhhdCBnaXQtbGZzIGlzIGFjdHVhbGx5IHVzZWQg
Zm9yIHN0b3JpbmcgdGhlIGZpbGVzLg0KPiA+DQo+ID4gUGhpbGlwIExvcmVueiAoOCk6DQo+ID4g
wqAgZmV0Y2gyOiBDbGVhbiB1cCBubyBsb25nZXIgdXNlZCBuYW1lIHBhcmFtZXRlcg0KPiA+IMKg
IHRlc3RzL2ZldGNoOiBNb3ZlIGNvbW1vbmx5IHVzZWQgaW1wb3J0cyB0byB0b3ANCj4gPiDCoCBm
ZXRjaDI6IENoZWNrIGZvciBnaXQtbGZzIGV4aXN0ZW5jZSBiZWZvcmUgdXNpbmcgaXQNCj4gPiDC
oCBmZXRjaDI6IFNpbXBsaWZ5IGdpdCBMRlMgZGV0ZWN0aW9uDQo+ID4gwqAgZmV0Y2gyOiBVc2Ug
Z2l0LWxmcyBmZXRjaCB0byBkb3dubG9hZCBvYmplY3RzDQo+ID4gwqAgZmV0Y2gyOiBGaXggaW5j
b3JyZWN0IGxmcyBwYXJhbWV0cml6YXRpb24gZm9yIHN1Ym1vZHVsZXMNCj4gPiDCoCBmZXRjaDI6
IEZpeCBMRlMgb2JqZWN0IGNoZWNrb3V0IGluIHN1Ym1vZHVsZXMNCj4gPiDCoCB0ZXN0cy9mZXRj
aDogVGVzdCBnaXRzbSB3aXRoIExGUw0KPiA+DQo+ID4gwqBsaWIvYmIvZmV0Y2gyL2dpdC5wecKg
wqAgfMKgIDY5ICsrKysrKy0tLS0tLS0tLS0NCj4gPiDCoGxpYi9iYi9mZXRjaDIvZ2l0c20ucHkg
fMKgIDEzICsrLQ0KPiA+IMKgbGliL2JiL3Rlc3RzL2ZldGNoLnB5wqAgfCAxODMgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0NCj4gPiDCoDMgZmlsZXMgY2hhbmdlZCwg
MTYzIGluc2VydGlvbnMoKyksIDEwMiBkZWxldGlvbnMoLSkNCj4gDQo+IFdpdGggdGhpcyBzZXJp
ZXMgYXBwbGllZCwgT0UtQ29yZSB0aHJvd3MgYSBsb3Qgb2YgZXJyb3JzLCBzZWUgYmVsb3cuDQo+
IEknbSBub3QgY29udmluY2VkIHdlIGhhdmUgdGhhdCBtdWNoIExGUyB1c2Ugc28gc29tZXRoaW5n
IHNlZW1zIHdyb25nLi4uDQo+IA0KPiBodHRwczovL2F1dG9idWlsZGVyLnlvY3RvcHJvamVjdC5v
cmcvdmFsa3lyaWUvIy9idWlsZGVycy8yOS9idWlsZHMvMTQ2NS9zdGVwcy8xMy9sb2cNCj4gcy9z
dGRpbw0KDQpJIHRoaW5rIHdoYXQgaXMgd3JvbmcgaXMgdGhlIGRlZmF1bHQgZm9yIGxmcyAoZW5h
YmxlZCkuDQpJdCBiYWRseSBjaG9zZW4gZGVmYXVsdCBpZiBsZnMgaXMgbm90IGEgcmVxdWlyZW1l
bnQgYW5kIHdob2xlIGNvcmUgYnVpbGRzIHdpdGhvdXQgaXQuDQoNCkFkZGluZyBhZGRpdGlvbmFs
IGNvbW1pdCB0byBzd2l0Y2ggbGZzIGRlZmF1bHQgdG8gZGlzYWJsZWQgc2hvdWxkIHNvbHZlIGl0
Lg0KSSB0aGluayBpdCB3aWxsIG5vdCBicmVhayB0aGUgY29yZSBpdHNlbGYgYXMgdW50aWwgbm93
IGl0IGJ1aWx0IHN1Y2Nlc3NmdWxseSB3aXRob3V0IGdpdC1sZnMgaW5zdGFsbGVkLCBidXQgbWln
cmF0aW9uIG5vdGUgd2lsbCBiZSBuZWVkZWQgZm9yIHRoZSBjdXN0b20gbGF5ZXJzLg0KDQpQZXRl
cg0K

