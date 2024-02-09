Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24ED0C48297
	for <webhook@archiver.kernel.org>; Fri,  9 Feb 2024 21:43:29 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (NAM11-DM6-obe.outbound.protection.outlook.com [40.107.223.41])
 by mx.groups.io with SMTP id smtpd.web10.25525.1707515007705552571
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 09 Feb 2024 13:43:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=F/PuPG2q;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.223.41, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4cC1C3td0wjJeUaIPezFU4FpPpdZx/m7rCMCtqX64CEd3rAoBTPHdGbjEu/vRxsiezlIEaegJICJIkgYjf+tP8GDDKh0tgEPFy8Z28m3Bune7cRkjYLfnKekL/tLCXuhWZftCuzDljYb/Lsc+HFqNaM1RFbvgJZj946FlMIjWZ6SAWhrCfg1yb+VMcTHxKtvw9t4DKXfb6n3BYfB5E33RgK7s8SUk9UYQOOS/fW8GNJeULkaucZW+ySh0ihc8XMFv4L8VvpjIX0W0V9q+TPpEUWvoNzrcvKFsgUCDsQyoVsVg6nLjk3GF0DUWs/xqjW1BUs/0ca6wa7d1MZKBsk+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfT09hCD2KN3+2laNwBFXFY9iVx7hp7aSh33MdNEe18=;
 b=EhFljoZj2xgxF1EAKeFbevUUrCdhoCoLccYOU8LL5KyQ2LTFpe2ngtROyA7vdxEffzje86qDPCKqKBQ2b0myttD+5q+GLI38nEQmqinHdqNmbD0O2G1cPnKqBdr2GfAUmIIhPD30mvrijPbvov6FDyHXri2WdZyIjYZ/7lgsHqM0FeDe+B3TJT3A6LpHwc4Tyzn+6u6npJJB0Ud+DZXGQ7ufnz8/N8mvEdYlMPcOTWe1iAs1/iKxYaOTnNwBuNQYc3W4awO1i+GeX78ZeU2cuwWCMgKz3isVUZfgctps4yczLMVTRXl7QP1ixO3PGBg1JxSJWo+parnGsIwiTkG/1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfT09hCD2KN3+2laNwBFXFY9iVx7hp7aSh33MdNEe18=;
 b=F/PuPG2qykyJ+ieXTiZJ9dpLjKcbqCsMoVcvZQ2d0o1w2RSe48Ady+USOLlzbTgCJwoWMOC69fmpnHYPBO5a8bAUYckem5cruGsGpBLVJBpeohGSZy3vrzIaYTMerWKMXpleMUYBKlde0eYOEo/+myfnqdhBhA6XvMDB+gEt6di1lag3sXfr947rgKJOUOevoeIhbNJpAx0uvFa94eHqsDRSCoootaS9SQAp23BXXn7OUeHy36WXZ8TtyCPA+W8m3Y62EBMm69nk9BMLP22MU3wAbPvecK6NSq2YHQ+VAdwvQV02DdCb+YoB5+qvOvJS57/mG+GwqWeXdJAAepXj2g==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 SN7PR12MB6909.namprd12.prod.outlook.com (2603:10b6:806:263::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Fri, 9 Feb
 2024 21:43:23 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::a0e9:1e42:58af:ba95]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::a0e9:1e42:58af:ba95%6]) with mapi id 15.20.7292.012; Fri, 9 Feb 2024
 21:43:22 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: "alex.kanavin@gmail.com" <alex.kanavin@gmail.com>
CC: Richard Purdie <richard.purdie@linuxfoundation.org>, Khem Raj
	<raj.khem@gmail.com>, bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] regression of 'world' performance?
Thread-Topic: [bitbake-devel] regression of 'world' performance?
Thread-Index: 
 AQHaRUYiPYr/ofNNNkqGs6ZtScLV7LDWFvoAgAAD6gCAAKV9gIArjOUAgAAFtACAAARfgIAAAdiAgAADDICAAAFyAIAASV5ygAAPhqA=
Date: Fri, 9 Feb 2024 21:43:22 +0000
Message-ID: 
 <DM8PR12MB54300AF8CEE589B8B5CB2E238B4B2@DM8PR12MB5430.namprd12.prod.outlook.com>
References: 
 <CANNYZj86b3GMtSVZMn8744HjMSMQVkzuXBTikLf4dFV0ULsvqg@mail.gmail.com>
 <0186f166a0ded0d97d5e19f64a3dd8e5ad44a92f.camel@linuxfoundation.org>
 <CANNYZj-cqQVJcs3AUvzE=Lw+mYMUWZO8JW1N-Ukz6BK3H2rchQ@mail.gmail.com>
 <CAMKF1soqnpKYkcGzkS1A2UGGiy7_Vbzym06rARRTqCnUc7gsCw@mail.gmail.com>
 <CANNYZj_r2S7b+3r4CEz8cGZSqT_wa785p1BtpZxb60CVvZJcAg@mail.gmail.com>
 <947006112712dcca07c607eb6b49b7e4e475c3d9.camel@linuxfoundation.org>
 <CANNYZj-V_bH-uVUBXmER30GxMLrfKN6g=pY-VSsgEfT6Fm7e_g@mail.gmail.com>
 <829c8fff2e6735297f036fdb878f4d244cf08f91.camel@linuxfoundation.org>
 <CANNYZj-3QDJMcqaVTSj+XRZo140O-hg5K9kM8e0mtF7yp=P9Tg@mail.gmail.com>
 <cf9339c32c0923068f0e4ae81fe1ebdb8153b20a.camel@linuxfoundation.org>
 <17B24084174823DE.15017@lists.openembedded.org>
 <CANNYZj-gbs6UmzcKaBt4DQ7G08EdJUNXZWWu3W8G=YJUub0gKg@mail.gmail.com>
In-Reply-To: 
 <CANNYZj-gbs6UmzcKaBt4DQ7G08EdJUNXZWWu3W8G=YJUub0gKg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=2e014206-3b8c-4d79-8d68-792ebd1bebb9;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2024-02-09T21:40:12Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|SN7PR12MB6909:EE_
x-ms-office365-filtering-correlation-id: 63403063-1961-4082-f6a8-08dc29b823af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 4GJT19b3Hvr1YP/Jn7D5WKxkSALV1GUvgvm17i18Z8GlFNGH4RoweuxlrorGVVNDAtXkJUtnu8RJcVWSZcE4mKssCvydJsofl5xkU1cdXGRiSRv3L9aKaOmYTeetjWz0FLgQAVA8QF+X0XlHwDyzo4E3q63Jd15dYTlMlEMAJL0TSwlOAXtyZTeg429Z6yVUdA8BPVfH7lc4KQXj3jkWJC/xkLAZCRwvdLKGvlnNPaUVFoeCKzEBNKBp8hDoRGEtAfpePpoEmznM4jYHLQtO0/xWKnlSX5ehhd9QBVhkVyWTvubR/2LgsKvTuDnMx0DVo+BtY1LoQpL+t70VX5cIViI2fxcgnv63AAbgLiMSGTYWrM8vStfV15a0qRdM10jx4kCaNuJ3oBV6JLgq2aWsF4pSMIfbHrPpg4xrex/y7R2mQYNb2NFaXHq7Zl7S9TeU4s5FotijJRVEhLKxfjktbecx9wiI0Y2r2+Bpt439RkQYNobUBw2c8N0+Mlj6EA2jXB4gvwCWwdrDZx3hOH0i3+EdBA7DAzQMX198cksMgtad5tb6Z5THqDElyzaq0jXWuBmgX7362wyXOF+/DLnGqaVdyC9apBKHZNOORQkTGn/i9Nk9z7tvUHGSqDB537UM
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(376002)(39860400002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(478600001)(55016003)(26005)(71200400001)(6506007)(66476007)(64756008)(86362001)(76116006)(66946007)(8676002)(4744005)(2906002)(5660300002)(66446008)(52536014)(54906003)(6916009)(41300700001)(38100700002)(4326008)(7696005)(122000001)(316002)(66556008)(9686003)(33656002)(38070700009)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?gAI6jRTK25zukOp4zGR+iiRQDb6Y03vjGEvHzyKkxvmk3EhVzmEhthgeHsWj?=
 =?us-ascii?Q?pJI2/XryFt1uEg26AEjk6fPZFhtYTMZPpnuFLYfEwmC+qhbxzmr1Y7jDCGqt?=
 =?us-ascii?Q?hV5TS3dvcihvmUIXYYx+zb9wrql6sbqvrTZVbrxQLsVQ1mrwN8+8f9kYWGZr?=
 =?us-ascii?Q?gbDWhcc8ttngt/kCP3T3SAjmUDiTRQV/9rsfXI1lhX81L3YxSUSMt7/Pdzrn?=
 =?us-ascii?Q?WNvur9Mloyw55UNSPJCoXCnHnm4JG2zOuny4dqv274Gyg4C9pYDVea1ntBg6?=
 =?us-ascii?Q?jakBRmTn1sxLcyLGi6d7bu2bPbfyu/UfeFRkCwJP77eiKhBfjEbYyjPfnCd5?=
 =?us-ascii?Q?793pWampomBGuVuqrDoWetG7qgQbN8iU57FBTURM4h6FSWiJ69I9zGRmd6Rz?=
 =?us-ascii?Q?AVCITgtfFAgxAzJR7FXBCBh+NHvcev+sy4vzogQfnBzKIXRcbHx2q/s5pwSv?=
 =?us-ascii?Q?vb3X+cROyc87ZhSc9b1E/cJHi2r9wlozTVuh2AWYE/or9PlmALpeenY7Cv96?=
 =?us-ascii?Q?DzjEJLIV+uGokYlDtw1YZIce74XZ3UCM9CGObgi4ougahaAqUL32MSVxRZOv?=
 =?us-ascii?Q?EQjPB6ISjDTNCcT80QBA3za+HCzB9+vX+AwxiDBGhEfWkUc49rWCaZNWVMMD?=
 =?us-ascii?Q?COLmt/KS5m46tv09/XLMuyZom1m0WbRJsIA90DGqi/UJems6dernf9GYhJga?=
 =?us-ascii?Q?l1aw3IQ2x8fsDfbdph8rtgZGF/noMYmhiT+VtT/I+J7lY255146pbMxtjdYP?=
 =?us-ascii?Q?HcvGQgvtcPHaYtikxBCo+929xE1OWjbVrSFQA5PHJx9QmtuYN1QuNR5RI5r+?=
 =?us-ascii?Q?/SHizsbKRU9XCKU8o5xvq+Zl1lDKwgAkKvAzNPubaZ5EAOgCl1W6yTaw9QLC?=
 =?us-ascii?Q?/xBJe7XkfjzVcThbnFBjMyWBfB9q+0VqJzip5Wv4zwJWFhCGuMd0qnTe8IkZ?=
 =?us-ascii?Q?YndoAk6O8aPejHk6YS2aWKj17ljUk67UaucVjmdVFW3QL+3qYvxJA/RkdI1D?=
 =?us-ascii?Q?TntP/OpdeV0UR/MrbGhGnpSzrlm5vJWg5njfnqmiJHIVlgtqjJnIyQZ+wk8v?=
 =?us-ascii?Q?+N8AFZ1i7BUNhjk4uMLPFu7tJ88Kxq/AdqRX6ObMipQgWzj5x24GV643DfQ6?=
 =?us-ascii?Q?QeYFbc9/XJou5xvHclSgNZXgcNRs3EyFZ0J1WtdgsofcMK/Mj3rHnFrnNvHX?=
 =?us-ascii?Q?Iysm/F7OCLD2LrDIa4abtb1nrWpls6atWfbnwIXCYRcv37s8QkEaOdvLyTSX?=
 =?us-ascii?Q?A8cMmM8sImQ65ORh7lQp6cs7m/67EdkPxL5I8CVGYZIW9SiwHdUk9CKgAbny?=
 =?us-ascii?Q?amGo6P8dxarawfoHdxx5L6OJfksqgTa3UjgFY8Kuk3qVq7X8y8GlGOpvI38e?=
 =?us-ascii?Q?o7lhdm3hPiomN1HrqKhKvOMfjZKYnzpS5BcsCvGszuCGWCB9S2xNdrClpXxV?=
 =?us-ascii?Q?sEM0DR2TuGOzVqCEOg0UTfgxiWaYfcMT5sMWNk/KguXie4Y+s+wHr+TsutFJ?=
 =?us-ascii?Q?+93jF57PNatXKkXVZparATkcQvQ3fdxyIQrKE/D2xLLe3jOlEnfhrp/aH4yU?=
 =?us-ascii?Q?UyVUJmUy7kAso0pxeF7oGrPwkeoplxKhKUgPbbS2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63403063-1961-4082-f6a8-08dc29b823af
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2024 21:43:22.9075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ujvSHDwYfhK8fGLLpqrSyGlg9IpI4b8NLhNozxpNO20bkupBEPsnIPQ1XMf6goRFOl8fDnU6xzm/lDW1WcTuNOw9DfsiweClmXSLLk963SI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6909
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 09 Feb 2024 21:43:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15866

> I pressed ctrl-c after some 20 minutes - I took a look into it then but s=
omehow
> couldn't find anything related to execute(). The two collected profiles s=
eemingly
> are just waiting on select().

Has anyone tried just using strace? I'm trying it now and will post if I ge=
t any interesting results.=20

For tracing the forks:
strace -f bitbake world

Thanks,
Chris

