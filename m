Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F014E8B38B
	for <webhook@archiver.kernel.org>; Wed,  4 Feb 2026 02:23:53 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10394.1770171829554579880
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 03 Feb 2026 18:23:49 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@windriver.com header.s=PPS06212021 header.b=KN81tmKI;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=6495392723=qi.chen@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614276ea2705825
	for <bitbake-devel@lists.openembedded.org>; Wed, 4 Feb 2026 02:23:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=2DFm1cNaIp3YKWD/0FhVD1FWo3Nr6SImUjFk8DgqvCE=; b=
	KN81tmKI15k49+gWzYBzbQ2q/N1SvgMOhIYJl26t//ActgUOoOqQJsCy9xZyMlLV
	o2h9Ob/onBIbIgt57XJKuJk53Pk+1BBvpvVuDlmFiDuYD8z1TEQsF5R7FJXZ9OPD
	EL4pw9s+oCd9oD6R9teGbzy2fPbVoeZU3bRneu9zDXIYoGcoEHk/ZVP8+d1IH0A5
	+dXe/X3YteRHO8J5rDVUTsICBCQRi8PPAFihr4W/xtrb+TN5HpTc3O/UhSSc2pcm
	Fr0yC8JEF7/6pCgQ16SiLx2o4ewEQ3TW4oDOPEPk8KfxJgQOcnajl/qf/tbU0BUY
	tLythpiAJbLx9xHNA9UjYA==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010050.outbound.protection.outlook.com [52.101.193.50])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4c3vcj01gd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Feb 2026 02:23:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jt26bZ+UsBciycDf13wws7UXHqygdu+SLfVZTtux/WDSxUsxcNu08bNNIrWaQeWefv+/CKXmcSBO7quPm5JxCOuDVhF8tXi0jTxOkYh/b9Qnwde/n0vEMyfAtVb1zlQQTrw9HA02oySZLhZoJrulAHGUoHzyuJGjZUS7j4oBFaPgI2jT2HfdIdQgpDA2ocYyvkwz2e9ScfIM6zOQpT0RI80mM4BBnaeCHnexmnMhMzGUfUYuFeK+x7tvjXKDcJotHS6cOczaTOTa4zoyok19RBeAOWSv4nu/X/7+SQZg9tA84vdBEvgGpRW4NhWrAh52yMesalcWgvao2/0tGExNuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2DFm1cNaIp3YKWD/0FhVD1FWo3Nr6SImUjFk8DgqvCE=;
 b=XPl+NFndr71QfZIje1MMepWa4I65EpPLuIMjVEbv0m8ytDXNRO+tlOSLAkHysX7JDA6GRIDrGPQL8f2d2I8Lm/0Zr2cJTgsxJR3P8ECftpwPp5DXwCE8ob60UtvAW47kX4aCX0R4GiyNkoOgoOpgvJT2r6rP45v3HUuxqer/Plhzd0cjlIJB4hG+oNlgzSB6qsVdsNth/OrvOAJUeCwCtB7+uAAqkrX+nxJWx64aYeMHV2HkQQyIj7H4bwWyiqn3IKxbT7p5cXdtXEa3slEimFIuJaZ8yvPbrdNfW+VZdqQqcFiZAjuZPWUwnIsK+Sr7zEF2v4WS6FiYar+bZb68Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by CY8PR11MB6963.namprd11.prod.outlook.com (2603:10b6:930:58::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 02:23:46 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9564.016; Wed, 4 Feb 2026
 02:23:45 +0000
Message-ID: <be5f86b4-22ca-4690-8438-8541843d4c05@windriver.com>
Date: Wed, 4 Feb 2026 10:23:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel][PATCH] fetch2/git.py: fix update_mirror_links
To: bitbake-devel@lists.openembedded.org
References: <1885DEB2FD4F0640.2047557@lists.openembedded.org>
 <188C9E9E281EE6E7.3547823@lists.openembedded.org>
Content-Language: en-US
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
From: ChenQi <Qi.Chen@windriver.com>
In-Reply-To: <188C9E9E281EE6E7.3547823@lists.openembedded.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: KL1PR01CA0128.apcprd01.prod.exchangelabs.com
 (2603:1096:820:4::20) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|CY8PR11MB6963:EE_
X-MS-Office365-Filtering-Correlation-Id: c5a78f22-5010-448e-a692-08de63946c14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|4022899009;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QnV2cHVCUHUzdmxLNmZYRlgrY0RFcWNRYjBXUmVuRUk5VVh3YlZMSnBQMkVo?=
 =?utf-8?B?dXBRdDRpcllibUY4QVN2WlpjZlZFRUR0YmpaMHFnQmFEODhkcVFIcFN0SUVh?=
 =?utf-8?B?QXhSVUpjZlRqZ3c3VE9VRE5WVmdsMEtzRlR6SVJ2NXBON2xHb2wzakVhU0dT?=
 =?utf-8?B?YUNpS3FKSnNwUEJhQ0VRcEVMUXBtODN0UUJjWVVrMDQ3SzQ0dXJqcDlYZnZy?=
 =?utf-8?B?a0dVNkc1RVczRVM5R0hZcXRPVEFHVmxKR1NNSXJzNmFaUmpLVGZjNWw2VW9n?=
 =?utf-8?B?bHJaWmNUSE1KR3FuZzV4NGVGajM0bWRkSmJUZFA3L292YmN3RUZ0dkk5V0Ur?=
 =?utf-8?B?QmxkL3NmQUdFQXQ0YjJUTis0OXA2SmQwZTZoUlBkTnZBZXNCbUVSaEp5Nmt4?=
 =?utf-8?B?cDArZXVDUzNUNjNYbHd6MFRpU2FyS20xZ3k3VXZIK3VWN2J5M2dlOUhKSGQz?=
 =?utf-8?B?dGM2cXhycldnSm93SVdCdk5FWStzeVVITXZYNzEwM2hzVUs0U0g0VEl4Q0VR?=
 =?utf-8?B?RklGWWFRUzJzVVplczVpdU1hVXhBTFhmM3gzakFzZ1N1WjVqbTNNWjlJRjdk?=
 =?utf-8?B?c0J3MVVFcEhYSnhYcnV2Q3FlWXlPSFZIM3J0aXl3OE9CZ3NlUGErbmdMM2NX?=
 =?utf-8?B?RWdPVDl0dWt4Sm5iam9HaUV3T2JhWlhRQ3ErbjFFbE9MNDhCS2ZtRXkwTDN5?=
 =?utf-8?B?Q1NkbDhaL1lDMzBldzRBWHVIZG02dmNvaEdwTVp0NlhqYWtVOGRlY2Z2MDdJ?=
 =?utf-8?B?MHNwdnAzZVlXb3dTSXJ2ZnRaMjJKWWhoM1d3QjdwVTFlakJhang1YjNkWkJ6?=
 =?utf-8?B?M1B0NmVCd2Y0UFRBU0tnZWFCeWJuWDdQZ295ODFEd2RCR1hsRUt6NEw4TS9j?=
 =?utf-8?B?TmVyQytKOTBSTXM2azR6TXB1d3BnMWFVangzK05WVi9lb2x1TGVURWFwekFE?=
 =?utf-8?B?ZDc0YVZCd0EyTlp3a3FYT01ja1dMSUxVVTRTZU05VXJmcmZLUmtsM1lFYU5W?=
 =?utf-8?B?ZGllb2N4Y2Evckh0Z2dNTGM4R0N6TkJKalhiNXlRVjgrczJ4Z3p5ZnhuZW1r?=
 =?utf-8?B?RnNEWlo5TVRJYndGVU1qSXlIckNxU3hYUGZ4Z0hYOTVnV1BtVi9PNEJ4cm1Y?=
 =?utf-8?B?b3llRUFabFFaNVdLRGw4aVFMZUxLZnZhbnJzakk2SEJCenZBUCtoamlNdEEx?=
 =?utf-8?B?cGJqcmlzVEpkSEx2SnBCYnJYUThGcWZUSGxwcCtpNXNRUTdGQkpZdmpib0NH?=
 =?utf-8?B?Qkx3NmtGaWlYaXdOWEpKUTg2ejhFS3hxMm83dldxZmRGZW10dWNkTll0emhE?=
 =?utf-8?B?eE1wejRFU3ZpUmFqTVp5a1VsK1A2RHQxdUd3TXNVZm9BbTNoLzF6Q1FLK2Y5?=
 =?utf-8?B?R1lwSm95QnFWVHFxWmplR1pYN3lxOVdYNVByWFJjUTVrYnhNYWt1UnQxUlA2?=
 =?utf-8?B?dWVOUUhBU2VrajFZNjd3bGRxWnMrTFFiOFVqK3NaR0lMdlZNRURmdzhLdWl0?=
 =?utf-8?B?QURPTTFSRkNhVG4zdkdKVGFJamExK2M0SmVBUnZhWE13WXRZdDh5cDM0bnZr?=
 =?utf-8?B?L1dDWHA5U1p6ZStoSituRGRPRFFoa1JkR3VkQSs2Qm9yeEw2N3FMRi9ubnNR?=
 =?utf-8?B?VGJVVzF2WFdnM0R5dnR1d2dFMzdhbDkrbEJMMG1UaDFYT08xcUJYdVlRc3pT?=
 =?utf-8?B?emQ4bVlEVkpOcHE5N3Irc09oSlk3T1pzcW9FaGVydWhCMm1MMmh5QUFqTysr?=
 =?utf-8?B?V1F2Wk1wNWdFVGl3V0N4T0x5U0RCbHVjckhEeEZtZytrSk03NE1TaDZTMUFN?=
 =?utf-8?B?dUJOeHRIWTZuVml5M1poNmo3dDU5MkE1Zm4xOVl0VnhTNzRjQ0x5TkN6NTlx?=
 =?utf-8?B?ZllUU0JORUFackFobVd6RkJBaGc1MnJyU2Z0dzZhYzZKSTQ4ZS95ZElqaGNS?=
 =?utf-8?B?R1Y5N1YzOUpraWlBTWd0d3U5NHJDUVBVWjhFeWFCMTlCNUpWT2kxdUlyWE1i?=
 =?utf-8?B?S25wazFUN3E2NnNheEVsMklIY09vZHg5aHI0UWtCZEJka3hiQ1Y5dWdpcExK?=
 =?utf-8?B?NldPSGNCK3dDeTNqY1IxNlNPbnRHckd6S3hFY0UwbXp1dEg1Sjh1ZllmSjJH?=
 =?utf-8?Q?ANiQdyC5hx65CZ5VnFRgW1PBt?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(4022899009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eDRCcmgzLytpRkx6OXd0MC9jNEVKZ3BFNi9xRXErN0QwY1VsTzQ5TFJ3VXZN?=
 =?utf-8?B?RGp5SXhsVldYSUpBcmd1c2E3RHRLMlVCS2ZtSy9SUEh6RGdFK2JXbjI3QTFK?=
 =?utf-8?B?bEc5QzduTmFQTHU4enNtY2JNSnFmTm1Cc3FqalN4ZVlRVFBjVFJZdkFZclhw?=
 =?utf-8?B?THdGQVpISEVjRXYxc3RYcmgzWXJCdzk0VWVsc1VHY1MvdWR2OEIzeGZUK01l?=
 =?utf-8?B?N1ZSbkc3ZEl5U1llTm1RQjArcUZwRlh0NVg3bjduNHBtUnlaN0Z4YnlGRDVE?=
 =?utf-8?B?MGlMOHA4ZW9IS2xTZTk3c3lvN3habnBFU2JnQXpWa0N6eFIwVUZ2NEp3VjFi?=
 =?utf-8?B?ekwrR3lDbWJHSUhJbjN6eFVIbXk1OS8zamtHTGVUWFZBRlloSVR1bVZnY3lS?=
 =?utf-8?B?OG5qWXVEY3JkUkdvenQ1NTVOOTl5OW5HajFQVDQ1MFdmRXpKQ1o4dEt4UXJP?=
 =?utf-8?B?OWZrSVR4Y3NENGNOeEg3M3RYZjBrNW5mMGJDQ3RnZGJ0My9VZDdnaWR6UlRM?=
 =?utf-8?B?a21IbVphakhoKzFLeHF3QUxDMmlzUUM1MkpTSW50V3d5RXpJWDVSOEtqSksw?=
 =?utf-8?B?ajVNdnNzQ2NBZlNDR0VtWUtGYUZDTFIxK0ZnTVFITGZhNTJOZVZJc0ZPOFh3?=
 =?utf-8?B?Q3c0N2lOaDhmREI0OUFRUEVBbE5GNFB5d3Y1VS9odWdJQ2JjeXRHTkZBbnU1?=
 =?utf-8?B?QkdZbXNKYWtLVmxDRkdoME91NEFtYk1vSGE1Znl1dGZJY3ZKR3pUc2w5bmlj?=
 =?utf-8?B?by8rNDFoSCtUK0VCUzc0b2pCU3I2SkNtNkcvNGw2SDNRaHVZRkVyVEg3cStw?=
 =?utf-8?B?QXpXQXF3SDVmNXhMMEplY0Y5elAvS1hOay9FUlJzUzNXbjU5ejJnK0JoY3Nz?=
 =?utf-8?B?YlJScHlPS1JsYXVtcjh6MUp3cDhWclE2TE4wTjZDYjV3aW82Rm14RTZwMDk4?=
 =?utf-8?B?UktreEpZUTNNVWZBVVI2dVFCenROM2xvclcwTmg4c3VldVBPbFhydHd4S3Fn?=
 =?utf-8?B?WEdkTjJxZ0FCU2ZlUXNrckNzbW5SY3JCLzdkdlhkOTVOTWNiZm83a0dPWW9N?=
 =?utf-8?B?dU5TSlpMRHdPNFloVGRRZElOdmptbmM0eVlFRExFYzFzY1I5aCtkUlFhMDFX?=
 =?utf-8?B?bVFhYUp3S0FwSE1hc25LZnZsVElDMGRuR0ZRNUtxN05OL3U1Z0lROFNzWHQr?=
 =?utf-8?B?S2FLUFRVVmVpYmgxM3VxM1BBWUdYcWV0V1FKKy9DRXhReVViTC9Oa2J0N2sv?=
 =?utf-8?B?Rlo4bFdrVFBVVWgwanU3Z2k3Q1I0a0s5R2ZUMEM3TjU4bWxyL1JYemN2eGVG?=
 =?utf-8?B?NjNsc2JVbjIrZzFmb0RXRENqNzN0UzdXR2R1SjVacnZIMmQrdUllMmpDWE5J?=
 =?utf-8?B?WU5zWkt1NWFyaWlHS3RONVkyU296QS84Y3RmWVpEL0xJMkxwVDRybDhsd0Q1?=
 =?utf-8?B?cUxXeTVLZnB5RHlncGVuVXRESElzVHVySDZoZ0FjQXpOM3YzMk5pdFN2blZl?=
 =?utf-8?B?YUNMU2hDTFpXN3VkK2hHY1ZPcHpvVzE2ODQvRjdxWWZBOEtrbjc5Z0FobFlI?=
 =?utf-8?B?L0p5cDVHa1BtZFVodzNwcll2RGxVVEVNcTg0MFhsMlBvVitaTTZvWEc3T2RW?=
 =?utf-8?B?VTMyRWE2Yzl5Kzd0WVpJaitocnJXaG1yMjdzR3RTMzVVSjJhT3JhajJCeFhk?=
 =?utf-8?B?ZVZFU3kxRVYraUtmdEZOakQvTGw4L2dmQVgxK2VRTTZXVUZwNkR5bkd5ck5w?=
 =?utf-8?B?SDc2OXFwYnFQUC9CTGFkUGZORDlScmRURm1QbHQ0TE1zY3p6d2RBa2JSaE5o?=
 =?utf-8?B?NHhWMWFBb083OWdLUzk0VlJhUFZPQkJIS0UrdEthTWg3OFVYd0pLTFNSbGJp?=
 =?utf-8?B?NVAvc1gyRG95OXY3eTYrVWt2V0VBZFdvbzNGUEh0WXZpcCtZZEpWTEJHNlY4?=
 =?utf-8?B?UG90a202Um42NHVxdzlKWHZXVDJXdWNrNVErMFQ3TG9XOVltcjRvV1pSSzBv?=
 =?utf-8?B?bTRtU1R4UEdxSFQzUjQ3RStjRis5M1RURSswY01wRWRQV1RLWHBOTFNIcE02?=
 =?utf-8?B?SFp2Qlg0K2NUK2RoemNrZGJFZEN4NHdKRGRlZm1ydUVpYk1UblZmejNDZVJT?=
 =?utf-8?B?R2ltSTMxVTRuUmt4MU9Od0JnTlFDQ0hFZmFINi9lTGhQaHp1SEVOdGcwRjVN?=
 =?utf-8?B?TFBSYTVMd0tLT1V4aXhBNFBYbC9mQy9va3Eyem9kV01GNTJ2eGlsbDNCSXN4?=
 =?utf-8?B?enFxdno3a1BEWmllZWJhNUpsd2FVM2xIRFE4eXNYRE5vTEY5TkQ5bTR0YWJG?=
 =?utf-8?B?Z0RWeGxEc1A5NExWRno1RnJKRGVWS1k0RFhWVXJHTUJqNzA1MWdvZz09?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a78f22-5010-448e-a692-08de63946c14
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 02:23:45.9398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UHwOsLvcXM0ENfaGhAC8ZCi3v0LaeICS4cS+SVRZxxRZ0TOe8rkbiO1wm1VKquaf1ndCJ8ugH0kCxczpbgPktA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6963
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDAxNSBTYWx0ZWRfXzvAOE0tasnKg
 HRxHp1uarYv0Y2hFmfFRNEL4DK6AkiP6FO7DICBVL5tWUakTkQZWc3VqAcZYf1CPVsX8GN/RUJX
 7GRTbTqfaOxH4JcakXFDKPpkTVT2T5b/579lou38c/b6pPFOEOKQLW4IeDkL1aYlUrmLcr+QxsJ
 5d/LRwnyq8RPKjohaTw4DaUabBjlcfq/hokJiMXAer/jH87I+eAeGLFkZZ2PbPtPS0M3CORGYUq
 lw54nc6kTFEC4jjFj3Xig2Dv4rEEOH9KyCdZdvfUJ0Hw2kXfCqJPJENAgM1djdUBQxdjav02Bg7
 E/Epg1Jev1yQTflgLh6WP8BhCPRiwfm/VcA6GbwhWR5NwGEP0+rhsicZVzLc8zYJ+ocKWQlg/2C
 wPXQP/0mU0X7xcEkK7ZRsDXOU/R6GoAt2qc8oHCJD0Gqxs7pBLZjQ3WZBgAgrzfByxMukMVVfRZ
 tViG0jbv4KUklAPnh2g==
X-Authority-Analysis: v=2.4 cv=VaH6/Vp9 c=1 sm=1 tr=0 ts=6982adb4 cx=c_pps
 a=sZdM9mINdKJOQAUOT6RFRA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Q4-j1AaZAAAA:8 a=t7CeM3EgAAAA:8
 a=aP6P5Bge4m19kfaaKRUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=9H3Qd4_ONW2Ztcrla5EB:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: Z_y2gqN3HXXKzSrYlCxWjeiniFMDwScn
X-Proofpoint-ORIG-GUID: OOQVVF2bD5P0_OKhZUO-jP2L5zXhJAph
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_07,2026-02-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602040015
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 614276ea2705825
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 04 Feb 2026 02:23:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18946

ping

On 1/21/26 10:39, Chen Qi via lists.openembedded.org wrote:
> ping
>
> On 12/30/25 10:54, Chen Qi via lists.openembedded.org wrote:
>> From: Chen Qi <Qi.Chen@windriver.com>
>>
>> We cannot assume ud has the same fetcher with origud. For example,
>> if we set map git:// to file:// in PREMIRRORS, ud is using local fetch=
er
>> and origud is using git fetcher. In such case, the ud does have the
>> 'shallow' attribute. And we'll see the following error:
>>
>> =C2=A0=C2=A0 Exception: AttributeError: 'FetchData' object has no attr=
ibute=20
>> 'shallow'
>>
>> Looking at the logic of this function, I think it's the origud's shall=
ow
>> that should be checked. So the logic becomes: if origud is using shall=
ow
>> and its full shallow tarball does not exist yet, symlink to ensure it
>> exists. This should make more sense.
>>
>> Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
>> ---
>> =C2=A0 lib/bb/fetch2/git.py | 2 +-
>> =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
>> index 709c692a8..f288afb51 100644
>> --- a/lib/bb/fetch2/git.py
>> +++ b/lib/bb/fetch2/git.py
>> @@ -359,7 +359,7 @@ class Git(FetchMethod):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 super().update_=
mirror_links(ud, origud)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # When using sh=
allow mode, add a symlink to the original=20
>> fullshallow
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # path to ensur=
e a valid symlink even in the `PREMIRRORS` case
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ud.shallow and not os.p=
ath.exists(origud.fullshallow):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if origud.shallow and not =
os.path.exists(origud.fullshallow):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 self.ensure_symlink(ud.localpath, origud.fullshallow)
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 def try_premirror(self, ud, d):
>>
>>
>>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18823): https://lists.openembedded.org/g/bitbake-de=
vel/message/18823
> Mute This Topic: https://lists.openembedded.org/mt/116993661/3618072
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [Qi.C=
hen@windriver.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>


