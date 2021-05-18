Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.92.90.20])
 by mx.groups.io with SMTP id smtpd.web11.5643.1621325133018931657
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 May 2021 01:05:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@outlook.com header.s=selector1 header.b=Y5pQxJT2;
 spf=pass (domain: outlook.com, ip: 40.92.90.20, mailfrom: kweihmann@outlook.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbYBDmUPjUzhKMTSagSbAleorHkXq7Smr1P5XF+ZEJJThwPWMR2oK3zV6kBWb1G91u646kk3CrR1DUq/sk/3ykBksTLBJQl50MrWz2SLrFlQz0WOkMUWYJYlzOE3hLYeToVtwLrdAwTr9PwMP612eWXcjlomp3vgrEWuIFwDay5EA+4We3cavvRXvE2WHBm7AJL7DhCo31fuMZ94Kn47b9+46Bo64RpbXM/uFTnfHvjDQd2zHuSkFaj/8WTY9U8B+XoVNVwEqjag1J/14Facit5Gm5Om7LghldYWk6GhSt4AqMX5jHevroTbCCSMPFkvPI7ZWZhElP/GYnHh3DHxzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZB1FxgqFSCJo4fCaKCyOdreGmg6kSx107/ZOd/crpN0=;
 b=OxEMnUIAeVGSAtR8lSg1I2401PIcBwM+scZneUT4CULSHD3JsRkkIp6Ek8i6sZMyHjGfouxSNAKTJGPh4aGkfU9IsRUDPp7fVs4fGH7mHLiQkm26vSfmrxA1ZBwgED4jdlnRBOCPv48HwzZ7e0sPyvVm/ApWcKRWmgJDO+bDsAjlFtMzy45AGey/1HF+jD6MPLznHU61Bw+Hs/VRWXms5YXfPNyBBAk7TdMw/jsqbunh9G3gmQwfUQPU8fH0jLAMLBefBp7Ija71agrDoEZXcrNkbNcoL4zGChU7WEO9JS6NglHZux/HpcTUEnPabecejj1HuRERPdD2rFF9fNXcOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZB1FxgqFSCJo4fCaKCyOdreGmg6kSx107/ZOd/crpN0=;
 b=Y5pQxJT2PfvS56nidGNDEl1ATWSjFiYPoPm5W0kl4M1a4rwKe7ImPWJU0E9Ap6jedUeX1jl1LOZ5jQN2XItowlnRnCuAPjBuZHgDJZv1cTqmxX+C23RZa8aVcDqoV4fwOxHrUVgp+viMMNxDJDjatfF9E0GVvS9loiT2fvKP9Zvbis5fABfWARYGwVATX9gZPyqexw46uHyPyNDUFdpVe20D2nBtayh3412HGe6wdD5FNCRLXDBgxYV6shtXmOM1F8cHBn0JyIrX9j2rWVSXncW7F8ngA8Uibb4cEdfHA3vvF6m/9ZOumUzMo9HCVMN3Po9lRjbkrqIUohkOm9tFDQ==
Received: from AM6EUR05FT035.eop-eur05.prod.protection.outlook.com
 (2a01:111:e400:fc11::4e) by
 AM6EUR05HT188.eop-eur05.prod.protection.outlook.com (2a01:111:e400:fc11::295)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Tue, 18 May
 2021 08:05:30 +0000
Received: from AM9PR09MB4642.eurprd09.prod.outlook.com
 (2a01:111:e400:fc11::49) by AM6EUR05FT035.mail.protection.outlook.com
 (2a01:111:e400:fc11::422) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25 via Frontend
 Transport; Tue, 18 May 2021 08:05:30 +0000
X-IncomingTopHeaderMarker: 
 OriginalChecksum:4A4CA08F7991325F5D5862C6E9AC0751D323637FD4B0E7319A8581F89B09E557;UpperCasedChecksum:681B2C98CBBA2C0D6326554BA6E4830D3E0402D40D3F473558752F574FE461A2;SizeAsReceived:8996;Count:48
Received: from AM9PR09MB4642.eurprd09.prod.outlook.com
 ([fe80::9c9b:9858:17df:de84]) by AM9PR09MB4642.eurprd09.prod.outlook.com
 ([fe80::9c9b:9858:17df:de84%6]) with mapi id 15.20.4129.032; Tue, 18 May 2021
 08:05:30 +0000
Subject: Re: [bitbake-devel] Disable Reproducible Build - reg
To: Daniel D <daniel.selvan@jasmin-infotech.com>
Cc: poky <poky@lists.yoctoproject.org>,
 bitbake-devel <bitbake-devel@lists.openembedded.org>
References: <141358386.90607893.1621323974188.JavaMail.zimbra@jasmin-infotech.com>
 <1180155480.90839930.1621324248815.JavaMail.zimbra@jasmin-infotech.com>
 <AM9PR09MB46424A47140676C11DAD16D2A82C9@AM9PR09MB4642.eurprd09.prod.outlook.com>
 <1263831117.91201115.1621324764469.JavaMail.zimbra@jasmin-infotech.com>
From: "Konrad Weihmann" <kweihmann@outlook.com>
Message-ID: 
 <AM9PR09MB4642528B702DA9C6EF07A543A82C9@AM9PR09MB4642.eurprd09.prod.outlook.com>
Date: Tue, 18 May 2021 10:05:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <1263831117.91201115.1621324764469.JavaMail.zimbra@jasmin-infotech.com>
X-TMN: [d5Em1b7x9b4+s5QWcn9Xm0guV80ZY0zi]
X-ClientProxiedBy: AM6PR10CA0066.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:80::43) To AM9PR09MB4642.eurprd09.prod.outlook.com
 (2603:10a6:20b:284::24)
Return-Path: kweihmann@outlook.com
X-Microsoft-Original-Message-ID: 
 <6b8fff78-65f6-2a96-c854-a1fa6b463cd0@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.188.23] (87.141.92.134) by AM6PR10CA0066.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:80::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Tue, 18 May 2021 08:05:30 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 48
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: d765fa31-8e07-419a-724b-08d919d3b478
X-MS-TrafficTypeDiagnostic: AM6EUR05HT188:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	nKBrIDDfH50Id6/+kASSx3ixrpAeZU1h4kkYOtf9d5z0rW1PuEogipQ2qjuoK3hjTWS+7RzNaT6AABF8j5MIaD4RPhqTbK48iZqsJbfqWgO9Yvav7lit28a+R5e/7D+yK219tVPHZvC/TXwPqPdKtvwOvMO2qyLUUN9zq80m7UzoIQc3iuQ4+Dw8/CXOS1HpjaMDhpxCxXwYHI8vb1n/fJPHJJLVAiWk0W4g5h8oyiSmzqz1btFK+lC4IVZzgwxwSwGc3FX0x1RVdMTZQ+MVXUEhDCadkb9wrB8181ZkwbLylYFezf1MCJFrdsypmv41cgYC+2nBNqMlJtMbJHZ93zHPRnbn4AAuNjdUAa4xg0Gw721aMCcpQSWykLXOMYC2GbwvU0dzx/xO6BwucntsQw==
X-MS-Exchange-AntiSpam-MessageData: 
	jZJtloQjEBr7XNmsZRuycrkLwlJUoMqvZ0TTk0f3efsXWsifdeBocn1k5bbEV6oRezI4RRS6VhJB23UqAwF9tJ0gEQb/cnucmymhphqlCP7ucUdI4TyJ30BNA0GgIU6UorrgtAjnZnSzIIEtQM2byw==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d765fa31-8e07-419a-724b-08d919d3b478
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 08:05:30.9398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: 
	AM6EUR05FT035.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6EUR05HT188
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 18.05.21 09:59, Daniel D wrote:
> Hi,
> 
> I already added the line "BUILD_REPRODUCIBLE_BINARIES = '0'" in by local.conf yet if I try to add __DATE__ I get the following error: "error: macro "__DATE__" might prevent reproducible builds [-Werror=date-time]"
> 
> Can you comment on this?

That should be handled in the recipe scope I think, by adding something 
like `CFLAGS += "-Wno-error=date-time"` (assuming this is C code we are 
talking about)

> 
> Kind regards,
> 
> 
> Daniel Selvan D.
> 
> 
