Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD987D59D71
	for <webhook@archiver.kernel.org>; Mon, 25 Nov 2024 21:01:26 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (NAM10-BN7-obe.outbound.protection.outlook.com [40.107.92.58])
 by mx.groups.io with SMTP id smtpd.web11.29746.1732568483908914328
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Nov 2024 13:01:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=B8qPP334;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.92.58, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qnnAUPZ7LKQCUmFrFeFxfIvdQYqE8uvrMgxcng8Ou13hauuIy8FMbny3qXV1LmTCGRe5z7u0OoL/04sHB8YuSzA4Eac87F09y/fFp4VKO0dYCKk5oN5sbZAr5F3+RIyyi2+ixu7EyV/VIKmWd7xsE+XBrUvhCR12JKo0U37YaNKTJi0FUXB2KAKiPftlsFtSxcQPOkl2rWa6GJSOh5Q/Eb69sXGK/hLe6oZ4vcFWNqdG9Ae735NHUC1T/9pvFJNHaI4J87hOKLHC7LUCdW25UuOCG/wMRQWQMDo8RXe8ByswNV45HhJ1QMyZ1Zu/oCMTwUonGHaHsOnderB/0AjQzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8AppbxfPicDDK/slomPY6McEbZL9W/IQt6Xt63KQUsc=;
 b=LHgKwMlwKSiTrQJRIwxgLqChjHO7MN8b5tp2dO91tNEOysnzP5fYiToRwWmEQyexp01Eo6+ba0Vfp+mShvbpwVRbVHufPv9Tb2ooXCZPg2BITj5oBnse5p9eFYLENMeNmX0zuUxXWglZEeUY6lMWkD/Hy3EdD6l7BwMSEWiEt0vlERlLyvOlEcfO0prGZJWj1EgJwCS8a6C22ENbr/u/JyE63dNnGevsTFDluDdaEbu4Vfei05XH4hBZiu20m3UdEGY1V62nODvDf54qucjGGUKqSPudXXTpfYoAa6LqaeBngLHrXmPFrtJeL8wUVevaf4KDaYweqGYRB4MtEnOt1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AppbxfPicDDK/slomPY6McEbZL9W/IQt6Xt63KQUsc=;
 b=B8qPP334caPLYfsXwJdd8Glz64WEFWIqoR2ZOntiM6q960eubvd0goLZNRWd/C2x5w9Fbb+pFNiTSfv4V5AC7vgDXDHM2uAPF1mVig6Sb0Ex6c0nffitO2BWMt7jBR3ojrML1t9mfOkYPw+YhiRZTGE5KdJ5vUTRbxIMBakemj7SWIGNx387dP3/nG6dszXqUTjYygJwApexVDz/fJSvJz1TDi/OUSs2InZZf+wRIps0Hod9PiLYWx0itfsZFlm1aV5KBKi87bn5ERBBdH9pBS31/3gu8oWsVD7PnfeVoLz+KoKKuk+gQ7rEkMjCpGTILCPefrHeBM5as/m3BxenPA==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 PH7PR12MB9066.namprd12.prod.outlook.com (2603:10b6:510:1f6::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.20; Mon, 25 Nov 2024 21:01:20 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7%5]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 21:01:20 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: "alex.kanavin@gmail.com" <alex.kanavin@gmail.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, Alexander Kanavin
	<alex@linutronix.de>
Subject: RE: [bitbake-devel] [PATCH v3 1/4] bitbake-layers: ensure
 tinfoil.shutdown() gets executed when tinfoil.prepare() fails
Thread-Topic: [bitbake-devel] [PATCH v3 1/4] bitbake-layers: ensure
 tinfoil.shutdown() gets executed when tinfoil.prepare() fails
Thread-Index: AQHbOdagWlqoFoEaBEegLyetAiJmJrLIg15AgAAC+QCAAAAx4A==
Date: Mon, 25 Nov 2024 21:01:20 +0000
Message-ID: 
 <DM8PR12MB5430F2E9A711209A8946774D8B2E2@DM8PR12MB5430.namprd12.prod.outlook.com>
References: <20241118162610.1423384-1-alex.kanavin@gmail.com>
 <DM8PR12MB54306FC322E76141FE4E05388B2E2@DM8PR12MB5430.namprd12.prod.outlook.com>
 <CANNYZj_4vEXMz-hcS2RijnycFJ48BSnHYDVHvn2in7dF7BPXoA@mail.gmail.com>
In-Reply-To: 
 <CANNYZj_4vEXMz-hcS2RijnycFJ48BSnHYDVHvn2in7dF7BPXoA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=fd93f390-9391-40e0-b9ef-d78e35365f34;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2024-11-25T21:00:49Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|PH7PR12MB9066:EE_
x-ms-office365-filtering-correlation-id: 59240cad-3037-447b-73c6-08dd0d944ff7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?QVIvMXpSYWhCS1VoUUlNUHFnRWtTVVJJc3Fhd25mRmFpRzROa2JvZE5pdXRz?=
 =?utf-8?B?dHFEUnVRUjNuejVDRkFrelpHbGJYQklmRFFtRWIyMkYrZUJrQS9TbUU2eHF6?=
 =?utf-8?B?SUh3TzI1NzNpUFI3RGdWdGtFdjMyWkI0Ykk0SzNyNFo0K1JDcEtMNmY5WkRT?=
 =?utf-8?B?ZEZTSk1odkJkVlRqN3NsN0xrTmU2eUg5OWkvc25nUGU4dmYraDdRU1Aydmto?=
 =?utf-8?B?RjFvb0c3VWZRekRTbFRlc0dHNHMrOFVoOHAwbit2RnlYdmkyR203TGxnOXhF?=
 =?utf-8?B?UW5vc2dFdGJDZHZwTVdOejJFd3hzRGlQVitLa2d0QzBOWGcyUitGV1ZkeThj?=
 =?utf-8?B?SDFpRTZOZ09ORHRaR2YrQmZOQ0hnWmhjaGszZ3lsa01QK0ZtelhERzRqdlo2?=
 =?utf-8?B?RkNqNjA5cWd4c0E5U0JuZTAxRGRyK1g5QWNUdGIvZVEwQUsrRVg0R0IzL0Zr?=
 =?utf-8?B?V3lyS25QNUlTZUtCc0pNemViaGdiUHkvRDRHTmhiVDZKWXhkNGNydUFGT2Na?=
 =?utf-8?B?OVpSM3dOQTZIcHNHL2crU3c0WGtXSysxQ01BMFhwSUZjSCt5S3hyUWFSd01J?=
 =?utf-8?B?LzhDNU1VQ1d0R2oyTTZ3ZmI1LzdNT0phbkxmSTZPYkRJMVVGOHVkWlpPUG1n?=
 =?utf-8?B?aDFGeFlVaWdmT212WmszSEczM3RtMnExclpjZjJrRzZXbFljenNzL0svRW5Q?=
 =?utf-8?B?Z2ZtMGhYczd2NkV2UktlK2FmVmY2SVh2QkxjeHc2SGg4dGF1aUdQa1AwbFM3?=
 =?utf-8?B?c1A3bGpUcTF1Tk5ZdXdKL2MxUkhNT2NIY0NIRWtYNjQrTTBnNUY1YWUrZ01Y?=
 =?utf-8?B?OHdVNjNOZ2Z6K2pGWVZJQzlSNDRNSGVocTRjem1ZcXlORUUyTGxUSDIyUnVz?=
 =?utf-8?B?V2lnd3NEQ3RRUi96Vk1YY3ZRWk9iU04yWVpNTnREcmFlanMyNUt2bVVQa2Qw?=
 =?utf-8?B?TzQ1RjN4b05GRWtjcTFCcG1NNGhsRFpPdncvS3dNVFZNajJkZ200T2lteEdm?=
 =?utf-8?B?SEk4dFNvdVQ4bkovaG82TThaY2J2aldMUzlOK3JXUjdMWHNzbnRVNHRrSmJ1?=
 =?utf-8?B?RG85MzlTckU5NnEvTHJQTmRFY29QM3VOcHhXVkppdkUvdnlCZVBha3Nsc2hS?=
 =?utf-8?B?eFloNkZjQzU1Z0RVbUpCRzI2dEErU1ljakI1RVo1M1ozcGFZQ1VudnN1VUta?=
 =?utf-8?B?bVB1RUtpYjh1bnFyd0lJR3Z3RDY2K09XUEwwTlBxYThWZVAzWWxDalpzMmlo?=
 =?utf-8?B?WHFTUWpGcys2dXhJdmJReG51MGs0RENBTDhkU1E0ZWVqR1Vjb29mZG9aV2tP?=
 =?utf-8?B?Z0NwMWVmZTVWSGtWcjBTOGRiays1RlpUSFVDU2lNODd4S0ZIOFlnWnpTckVr?=
 =?utf-8?B?cXRtUlZWMzNGUzYzLzJwWEhRVzN3UjVoaC8rWThFdUVWS1QzVEJKQmM2UEV2?=
 =?utf-8?B?RFdxYkZCckNubHJuLzZMaklpRmRBa3phcWl4cjlrdytUbEpsaHJkU3dPMHFF?=
 =?utf-8?B?TWM5MUNRZDNqcEloVFpXNnF2ak1wUmVWVkQ5b0xwdTNrZ0E3dThzU1dnYlJk?=
 =?utf-8?B?TXB6VXE1VkhjbHo3akZYNy82ZHN4S2ZkZk9zd3lqMTd0UHVRbHFaWFNKa3lE?=
 =?utf-8?B?RGRMbHpnVFVTNWlCUFpyRW1SQktucEdiZXBhSUhxNFZzN3RtVk0yd1ptMmpS?=
 =?utf-8?B?NHV0QlI4R2lDa1pvMlJ0c3BsRzExNEZEODFCTU1VT1E0dWxLb0d3UEpXc2gz?=
 =?utf-8?B?cStNZXBjV0E4cTZOM3NJWEhpV2I0alN5ZkxJNU5KTWZqdWN6M09hNnhPc0Vj?=
 =?utf-8?B?R3dRZ1hpcE1pWENIZVNTMnRFK2lZY2gvM3RCTGlGWlVoV2laZGcreUplZjVW?=
 =?utf-8?B?L1o0N000QmhVY0dReHVIaDBwd29pcHE1d0t0NVZ1YmtGeWc9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?YlVsT3I3UjBVdWxSeWVyTU1xV0VZZUJNVGhkNUVWNDBDNm9mZ2gzY0F5Zll5?=
 =?utf-8?B?djBzZjNPMm1GSFIzdWFUV3VQb2JySTB4dG5laGM5SWFaelN5RUlKblZ4TVNJ?=
 =?utf-8?B?YWg1RnRHckhoeCs0all6ZGsveG9Fazk1S3B2V1l4OXl2WmdGdmlKVzczMVNC?=
 =?utf-8?B?OExVWnZNeDN1TlNMOU1UOEdrNThEOFBjYnAwZ2tidjFSVzJDaXAxRWJ5Lytl?=
 =?utf-8?B?YnZRQlNPMjRtNnF2ZDVCaWIyOFVHYis2RnFiaitVaXd1ZzFvZElWOHdUc1ZI?=
 =?utf-8?B?dWNsTlZqeXpORXlsMHVLcC9BS1QxR1U1WlZocUFQYTBBRzY1N2oybVNNaCtT?=
 =?utf-8?B?TndUd1ZhZUlmaC9DZVlzckZaQ1B6Z2RPZTgvTDBGL0NHS0JhL3NvRDBLUHZh?=
 =?utf-8?B?Q0RhdTJROG5yUEo3QWJsNFpCNC92eUVwMG15ZkFrTjR4UDNnZ3U4K0Fiak1H?=
 =?utf-8?B?YWN5eU1HaXJFMWRhdm5OMWNFVW40VnVtWUNMNDc4SS92aWhjbG52UFhsVVZL?=
 =?utf-8?B?ZE5ZYXRnTHhRL29ENFNhRWg4dEdLUjdiTTZGUVl5cDZwTytZcVdlUktwRzJm?=
 =?utf-8?B?Y0tMMEtJUXU3UnZ3aTNLeTV5UUQwWnNocW9XZVdGdThMVytRS1JscTJvZXJN?=
 =?utf-8?B?S2t2Y0piUkRJTVNidTVERGwyZHQ3SElPTW8yYTIycEdXaDVBV21DZUF1YktS?=
 =?utf-8?B?S0ZWczZGaitpc3NWNUJnbSs2dytoVnJ2Z0JjM01QMkhkUnY3czhHYlp4b1dO?=
 =?utf-8?B?WWFhMll6V1VhZVZMM1lzSFdnTXYyL2IvTUJMcThBdFBqK29XdlphUnllTWtC?=
 =?utf-8?B?VHdMKzBkWlhERVlTeGNNbjhSTlo0UUZibnM1K3RuN3YzdmMvazh4M0pGK0dB?=
 =?utf-8?B?b0Zrbm40Vm9hNGQ1cThxam9UQWV4ZEYyZVRVMmtMK21wY3NsN0ovbHR5THVD?=
 =?utf-8?B?NGhVaHBkWFZHSVkvSXlsMzRHRG5ZWnhWRkpkUjFveW9lSlF3REp3MExydDN5?=
 =?utf-8?B?VUVhZ1UzSG1IZGt2R0hCdHZSVEFWRUFXQnZIRmZDMUpXTnZCaThNT1l6WkJQ?=
 =?utf-8?B?S1ovMkFQKzFudVpFZXBTY1JDSENvaFVyR1JmVjRma2xVRktjdFljVVBocjhS?=
 =?utf-8?B?aTA1U3NpZGlJM1JjeXdqVkozUUt3SkJHdE5MNXdaVmpEQ25MakRxWlA1eFdC?=
 =?utf-8?B?VEQyN05sQXpZOHp4L1J3NG85UDZlK0daZnAyUGNJWWFLamowdGFIWEZlNi9W?=
 =?utf-8?B?ay9XUEpFWXdVUGdiNVZmR0x3N2xtSVRKZXQ2dTRLdFMySTlyVWVOTkVQS211?=
 =?utf-8?B?RVo4VW9tdHVmODU5TWs5Qk0zeFZyQm93bXlLTVNTa1VKQXZWRkV4bGVIc3pO?=
 =?utf-8?B?cG1iVXUvWXIvUlowWXJJVlZsc0Yzai81S3F3WVlqdThPclVEQ01OR3NWZUxz?=
 =?utf-8?B?K1FsZXJTVWhoWnExNC9CQnNILzVhaGFyeTZ3ZEd5S2psV3BRMEs3TEJtRWpX?=
 =?utf-8?B?RzlRdS92cGRVYW02MTdwY0xnV2lDeXg1Qk42alhySXNuQTJxZyttMlJqTGVR?=
 =?utf-8?B?cEZGY1ZlcDR0em9KTzUrWnEwMDVlV3ZyYlUzc1Foa0FSTXVSQWpzTmQ4aFAv?=
 =?utf-8?B?SmNYWWJ6UHdBS3hHeHBVSFNmS25zdUhqdG5ZalQvdm5aa2RYTjVrbFhka0FX?=
 =?utf-8?B?WjRDMU5wZWlieGVEa0xrNVB5UnZybHlGWkczbFd6MFpQWldSZ0Y4c3k3eGpG?=
 =?utf-8?B?WHl2bk9KZHdmYlpRR1Q2TWNkSHV2K1JtYmFkTEdnajdXZVZ1V0c0dU1NZktT?=
 =?utf-8?B?N0xYTTNQY0FYeXEzcHFCODhsMmxzTWE4VHVEa3ZkMnRDT2I3cXpKY3JxZmZw?=
 =?utf-8?B?dVhQUytaOFBHbjZXUG1DWUEza1hlcUlUWWErVUp6QUMrUnQvZVEvbGExV3lr?=
 =?utf-8?B?Z0JHNnM3MS9Ob2dSc1g4TVAzTGpvZEFQQTlsRzJQN1dMQnNIYk8zZGxYallO?=
 =?utf-8?B?NUNPb1N1ZkU3b0puZzhQMlg3Z01UMVRQbjFTZ05oczVYeUlmdWN1TzhERUg2?=
 =?utf-8?B?SFNnTnVkaGZxNjl2bTdmZWNXNTNDSXNsaXRaNzFEdkEydlN5ZnA5N094ZHlE?=
 =?utf-8?Q?bn13TPYqbeYKr9K/miCg8L2T2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59240cad-3037-447b-73c6-08dd0d944ff7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2024 21:01:20.4109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uVs9zHpjWETWOlxHgrdhJ0sQqO7SdJvt1uvFWt3RQG7+XHHrODbslQmybQ5ujnrwSvVpubObzgOVUPQoKSyn47+RLJ9QPGvpdBlqbxGBvk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9066
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 25 Nov 2024 21:01:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16836

PiA+IFdoeSBub3QganVzdCB1c2UgYSAnd2l0aCcgc3RhdGVtZW50IGhlcmU/DQo+IA0KPiBQZXJo
YXBzOyBjYW4geW91IHNlbmQgYSBmb2xsb3d1cD8gVGhpcyBhbHJlYWR5IG1lcmdlZC4NCj4gDQo+
IEFsZXgNCg0KU3VyZSB0aGluZyA6KS4NCg0KVGhhbmtzLA0KQ2hyaXMNCg==

