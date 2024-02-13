Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D74EC48260
	for <webhook@archiver.kernel.org>; Tue, 13 Feb 2024 10:49:44 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.75])
 by mx.groups.io with SMTP id smtpd.web11.8996.1707821379759380507
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Feb 2024 02:49:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@armh.onmicrosoft.com header.s=selector2-armh-onmicrosoft-com header.b=W7nsT6wP;
 dkim=pass header.i=@armh.onmicrosoft.com header.s=selector2-armh-onmicrosoft-com header.b=W7nsT6wP;
 spf=pass (domain: arm.com, ip: 40.107.6.75, mailfrom: ross.burton@arm.com)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=bbIBjelCyia+t3FPViPPMnjYHYFsEXnHl4xZwlSVp90+j8+pUVn3ykl5s1igIb7cnlf2gdq1NalbTIxTLUlEYhFilQo2jLOOyS0zi8r7fY3npBa7FN2YHrndwd0CZrkGhgrOJG75vtuHLBOFM2Flnmj9LXNdB/V4jhj5IQ7T7Z9sIAwHX1Oorqy5C93KRZYsZYUQsLpgxGpx+53hgSn94oMQmUdj3NVlTKOUi1Qg+veXZ/8pS9jIkI1gYTM3BNrUb6JlT2ytbFrlXC0WrI2Y/bJDwS26aK7J0JCb1aKUEjsWPy78skDBy9QNvhSZxmWyzYksemgriPFxvkzzWlRq2w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uczgfM3FXonN1NoOR39XEPRk40Nbz1Mb513lWweBhzM=;
 b=NNbzB2/M1p23t+/rCPYLGOdUix2szerMTFugVNNnt6Mq7d5bkqt/sLyygHEHWIbCkAlk2LmPkxeHesn6ogIhKKQPLBEK4ws/5AxRmQalBzXFzHUu3GigvkhqJITsNcDPbSSrF60yr/yhytqraewcnzjKXp4ENM/pC5jWdicwocJYCmV2Uaj5hxOMk+WO3yl6xQC2CRAeo8p49hTymvL9Q8VjfQG236D+CaD+5andMBEDtwRpxoCvi3yZlBOOb9RwE+1UViMrSA+IyfXz1qJSUsvtXf2NA1RWs8KSA7hU8vSnVsXJgSw1A/iPSCbYfut/RfEFac7n4FxjNZMh1cwTiw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.openembedded.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uczgfM3FXonN1NoOR39XEPRk40Nbz1Mb513lWweBhzM=;
 b=W7nsT6wP0P6gg44FsVPl5awmlULmg5aCpPWu1nMo8y3N5E2rMJmB1YzRAomUqpH5kKTe49LrqoJZ/tJV2qER/dEFSvPfGic/Q9IlmDANNrLj6mj0+NQ2Yz71ssroiTpuvnAHweWO98LwUoIUt3sHWtd8nqoIPrCV22cjj49GwA4=
Received: from DB8PR06CA0050.eurprd06.prod.outlook.com (2603:10a6:10:120::24)
 by AM8PR08MB6529.eurprd08.prod.outlook.com (2603:10a6:20b:354::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 10:49:36 +0000
Received: from DB1PEPF000509FF.eurprd03.prod.outlook.com
 (2603:10a6:10:120:cafe::8f) by DB8PR06CA0050.outlook.office365.com
 (2603:10a6:10:120::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Tue, 13 Feb 2024 10:49:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB1PEPF000509FF.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Tue, 13 Feb 2024 10:49:35 +0000
Received: ("Tessian outbound 1076c872ecc6:v228"); Tue, 13 Feb 2024 10:49:35 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 95e3473b7ec7b2c4
X-CR-MTA-TID: 64aa7808
Received: from 8b5c12cc2ba1.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 4F9B0044-479A-464C-88FF-0682C6A02B38.1;
	Tue, 13 Feb 2024 10:49:29 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 8b5c12cc2ba1.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 13 Feb 2024 10:49:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kpy+rTz1RQiC2WutC/inprZvMTFxU1fqTsYcC1oUfnCJVQoBd29G9y7v1ln0lJQvYDTZYXwOcaN68G8m7uotCiovRMz2vjjDFuBDTX1hsmjQJIeL4obrJrKYhbkqoiNQxgrWc6/vYPzv9BGmLtPs9dOzgEwqDnBY8DPFRbP1tshvxRK780k2jbEueYtXZ2F1RxtvHtM3hsxNHiwU0PPyuZM/6vY5rDCSQIcoNdFT4sQiWlCTvT/PitpB3+Ssh5TUMf7xH209CXDH6Nu6r0tdXXZwl5Pg248Xf09vhUHCrLQvX3CfIQzDxUD/A5SkqcOj5QGIVNr01dH0iF6CcsDtVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uczgfM3FXonN1NoOR39XEPRk40Nbz1Mb513lWweBhzM=;
 b=d1WtYC4/NcjbKFKzn57M5AcjUltZ0W8bHyxaP0t6vIzMg5Xp3awqPvHdgYLWWsTSpQk6EREaum6U2j1LdWim3RwQ8Hcf6nQSk5qdZ09GqvtWK2NW2VDE8y96LBFZBv0PiUVa+ysj44s9o2NnpoSjhr4M6r2vjGN5rsgQ0cZrwtwwTSBAoGBcvl9pEYQDN7HU0kE/4swu8sbmG1Fq2v8cThBJQ1JL6i+gYOHEZ0gMX/gwhtU8PVeJbmS0RoC6oMl53zHNz+IE94r3aLh3ToOjc8RryW/EgceJ4WPZCAiCSiF+Aw1OWXwcw13PymtPHcH7NV0KIWPhL8cUO7oFTk912g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uczgfM3FXonN1NoOR39XEPRk40Nbz1Mb513lWweBhzM=;
 b=W7nsT6wP0P6gg44FsVPl5awmlULmg5aCpPWu1nMo8y3N5E2rMJmB1YzRAomUqpH5kKTe49LrqoJZ/tJV2qER/dEFSvPfGic/Q9IlmDANNrLj6mj0+NQ2Yz71ssroiTpuvnAHweWO98LwUoIUt3sHWtd8nqoIPrCV22cjj49GwA4=
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com (2603:10a6:102:2a3::12)
 by AS8PR08MB9291.eurprd08.prod.outlook.com (2603:10a6:20b:5a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Tue, 13 Feb
 2024 10:49:27 +0000
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::740e:ab01:e66a:61c9]) by PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::740e:ab01:e66a:61c9%3]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 10:49:27 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>
CC: Richard Purdie <richard.purdie@linuxfoundation.org>, Khem Raj
	<raj.khem@gmail.com>, bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Randy MacLeod <rwmacleod@gmail.com>, Mark Hatle
	<mark.hatle@kernel.crashing.org>
Subject: Re: [bitbake-devel] regression of 'world' performance?
Thread-Topic: [bitbake-devel] regression of 'world' performance?
Thread-Index: 
 AQHaRUYl1oFzvY2DzE6Pi8O428KKDrDWFvoAgAAD6gCAAKV9gIArjOUAgAAFtACAAARfgIAAAdiAgAADDICAAAFyAIAASW9NgAGUul2AAqAEAIABbisA
Date: Tue, 13 Feb 2024 10:49:27 +0000
Message-ID: <2EFB6610-C5FF-4CA0-9309-596601D44393@arm.com>
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
 <17B255DB2CE33879.588@lists.openembedded.org>
 <17B257441406400D.588@lists.openembedded.org>
 <17B2894C95E031D0.14481@lists.openembedded.org>
 <17B29B2072FF51A8.14481@lists.openembedded.org>
 <7bb8798da40488ad8f79f472775e2ee2c2a9c8e2.camel@linuxfoundation.org>
 <CANNYZj_gJnswnprhj-bM9fhaJwv4phi-Mi6WJbX90wAw3shZEA@mail.gmail.com>
In-Reply-To: 
 <CANNYZj_gJnswnprhj-bM9fhaJwv4phi-Mi6WJbX90wAw3shZEA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	PA4PR08MB7411:EE_|AS8PR08MB9291:EE_|DB1PEPF000509FF:EE_|AM8PR08MB6529:EE_
X-MS-Office365-Filtering-Correlation-Id: 5269a009-4207-4b3b-befe-08dc2c817817
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 
 esL2B1ey5sePEPHyb/OcJUkPUvFtMtJ0niT5QsVBt9UtdMkPW82xM3hRLK++c1MnIp6HtYTHEkCcMRJg8XhBbNTW1PN7S4Z6lGBgXJwJJ1opdN1bar680CzXuMyIz9uQ5qIP5JyBwJMO/MPD8uQm7mUSeiknWL0C9HPHG4cwJnOjryJOdDQd/HmLrlCiSpZft1aeR0+EmSz3/zkYlV84nC2uJ6itpebd8BqpshGHwwJXxtvsu3g/baxeYzlq+nfuuNOHqNVySowi6UpjG8cep9mQ9VFaVgT3TDaWfmoO/+aQAo2U+bJo83bCMtE11FMENIAZMdzs5vQRJABecCZTWnvXsoruGAaWH2JmpQaTGtEgXylo6My+JX9VOV2PtHuSQg/gNOIZUYlVswyIQz/39918tG6f2zMt8V91t29ufP9IQpJUP0rsLD0DTyfPnJNMF7IyWB7xxsdu1eiZLedrLNoFJJoCtDy7O79yAXCoZeDwVA4Eb6/xkcIpymJpBiMNHRU5WVTAApoaUaOzBEESomABxPBHY1nKapwV1KQnBkYU2O1iyP8nvuphD38bb7FcOQ+bQGp1wMA5pHWPd6nGKvtufQRdpgKpN4lqcJG4lh0=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR08MB7411.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(136003)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(41300700001)(966005)(6506007)(86362001)(6512007)(38100700002)(122000001)(66476007)(66446008)(2906002)(64756008)(66946007)(478600001)(6486002)(71200400001)(66899024)(53546011)(2616005)(54906003)(26005)(83380400001)(38070700009)(5660300002)(36756003)(8936002)(76116006)(33656002)(66556008)(316002)(6916009)(8676002)(4326008);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <072222321955D94E8F65117036328607@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9291
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 DB1PEPF000509FF.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	e1457c41-384f-4e0c-8f77-08dc2c8172f3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5vj44azyLdrPj1+GfTyfmAWjZDhXcd0pQzNeWZg3RcmSTZmlw/9JnPBWWnIBrZ+2SEelOCjtsyhAzXFGwvgj53aGRpkaZ41prrzUA5cfER/gr5a+dUE1DQHRuZgFyiMclR3WqTqgNhVY5rus8GkeA/khIHxnRo/z6Nr5o6MsUezHNE0YP2RRqF+ZRP5wqi0Q1c/oC9xEjfoDx/SS8imV9Tv5vRZDH6ZbFSlqWdntcrlpnaF3Dw9vI555OLgp8t7aBtGQYLJJPqpIiNM0oBb2/lybH3tT4W1Kmzu9sZ06hxxTwUeuk85tgMbh+BSJqvf3ZhOrqLZkXnIWAv2KNGPpYEaSHC978Wl5KojS5GRe79G9IAur5NOvNBMU7vyq0PzLVbq3v29aVybwJvBgFjvyi0Hyd55gObmPjCYQ3YXolhLw1XF8Jw4PXpKEOuE3XqNAIwiF/+ivy0+GY4aTb0g1+SO7kfYTYv0gGwWH+SciSxnL+coWFp83FPSz542fMG/Q6UzbRT1JVydEQcYGIbT7Qc0mdIlAO69HMXhMuUB9okOF3d8t5aSraLOawZ5ptjfkFTMQauPIyDBPeRJ71CFnYg==
X-Forefront-Antispam-Report: 
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(2906002)(82740400003)(33656002)(5660300002)(66899024)(356005)(86362001)(81166007)(2616005)(6506007)(53546011)(6512007)(107886003)(83380400001)(336012)(26005)(70206006)(54906003)(316002)(36756003)(70586007)(8676002)(4326008)(8936002)(6862004)(478600001)(966005)(6486002)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 10:49:35.6993
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5269a009-4207-4b3b-befe-08dc2c817817
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB1PEPF000509FF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6529
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 13 Feb 2024 10:49:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15885

V2hhdCBtaWdodCBiZSB1c2VmdWwgaGVyZSBpcyBmaW5kaW5nIGEgaG9zdCBkaXN0cm8gd2l0aCBQ
eXRob24gMy4xMiAob3IgdXNpbmcgb3VyIGJ1aWxkdG9vbHMpLCBhcyBQeXRob24gMy4xMiBoYXMg
cGVyZiBpbnRlZ3JhdGlvbjoNCg0KaHR0cHM6Ly9kb2NzLnB5dGhvbi5vcmcvMy9ob3d0by9wZXJm
X3Byb2ZpbGluZy5odG1sDQoNClBlcmbigJlzIGRpcmVjdCBwcm9maWxpbmcgbWlnaHQgYmUgbW9y
ZSBhY2Nlc3NpYmxlIGFuZCBhY2N1cmF0ZSB0aGFuIHRoZSBwcm9maWxpbmcgYnVpbHQgaW50byBi
aXRiYWtlLg0KDQpSb3NzDQoNCj4gT24gMTIgRmViIDIwMjQsIGF0IDEyOjU4LCBBbGV4YW5kZXIg
S2FuYXZpbiB2aWEgbGlzdHMub3BlbmVtYmVkZGVkLm9yZyA8YWxleC5rYW5hdmluPWdtYWlsLmNv
bUBsaXN0cy5vcGVuZW1iZWRkZWQub3JnPiB3cm90ZToNCj4gDQo+IE9uIFNhdCwgMTAgRmViIDIw
MjQgYXQgMjE6NTMsIFJpY2hhcmQgUHVyZGllDQo+IDxyaWNoYXJkLnB1cmRpZUBsaW51eGZvdW5k
YXRpb24ub3JnPiB3cm90ZToNCj4gDQo+PiBMb29raW5nIGF0IHRoZSBjb2RlLCBwZW9wbGUgaGF2
ZSBhbHRlcmVkIG5leHRfYnVpbGRhYmxlX3Rhc2soKSB0byBhZGQNCj4+IHBlciB0YXNrIHRocmVh
ZCBsaW1pdHMgYW5kIHByZXNzdXJlIHJlZ3VsYXRpb24gYW5kIHRoZXkgZG9uJ3QgcmVhbGlzZQ0K
Pj4gaG93IG9mdGVuIHRoYXQgZnVuY3Rpb24gY2FuIGJlIGNhbGxlZCBvciBob3cgZmFzdCBpdCBy
ZWFsbHkgbmVlZHMgdG8NCj4+IGJlLiBOb3RlIHRoYXQgdGhlIHByb2ZpbGUgYWJvdmUgZG9lc24n
dCBpbmNsdWRlIHByZXNzdXJlIHJlZ3VsYXRpb24gYnV0DQo+PiBpZiBpdCBkaWQsIGl0IHdvdWxk
IGJlIG11Y2ggd29yc2UuDQo+PiANCj4+IEl0IGNhbiBiZSByZXdvcmtlZCBidXQgaXQgaXNuJ3Qg
dHJpdmlhbC4NCj4gDQo+IFRoYW5rcyBmb3Igd29ya2luZyBvbiB0aGlzLCBvdmVyIHRoZSB3ZWVr
ZW5kLiBJIGp1c3QgcmUtcnVuIHByb2ZpbGluZw0KPiB3aXRoIHRoZSBmaXggZm9yIHRoZSBtYWlu
bG9vcCwgYW5kIGhlcmUncyB3aGF0IEkgc2VlOg0KPiANCj4gMS4gVGhlcmUgYXJlIHRocmVlIHBl
cmZvcm1hbmNlIGZpeGVzIGluIG1hc3Rlci1uZXh0LiBXaXRob3V0IGFueSBvZg0KPiB0aGVtLCBw
cm9maWxlIHNob3dzIHRoaXMgKHByZXNzZWQgY3RybC1jIHdoaWxlIGl0IHdhcyBzdGlsbCBub3QN
Cj4gcnVubmluZyBhbnkgdGFza3MpOg0KPiANCj4gTW9uIEZlYiAxMiAxMjozMjo1NiAyMDI0ICAg
IHByb2ZpbGUtbWFpbmxvb3AubG9nDQo+IA0KPiAgICAgICAgIDcxOTgzNDQ2IGZ1bmN0aW9uIGNh
bGxzICg3MTYwNjk0MCBwcmltaXRpdmUgY2FsbHMpIGluIDE1NDYuMTE4IHNlY29uZHMNCj4gDQo+
ICAgT3JkZXJlZCBieTogaW50ZXJuYWwgdGltZQ0KPiANCj4gICBuY2FsbHMgIHRvdHRpbWUgIHBl
cmNhbGwgIGN1bXRpbWUgIHBlcmNhbGwgZmlsZW5hbWU6bGluZW5vKGZ1bmN0aW9uKQ0KPiAgICAg
OTQ0OCAxNDYxLjUwNyAgICAwLjE1NSAxNDkxLjk5MSAgICAwLjE1OA0KPiAvc3J2L3dvcmsvYWxl
eC9wb2t5L2JpdGJha2UvbGliL2JiL3J1bnF1ZXVlLnB5OjIxNDcoZXhlY3V0ZSkNCj4gOTUxMC85
NDQ4ICAgMTQuNDM3ICAgIDAuMDAyICAgMTQuNTMwICAgIDAuMDAyDQo+IC9zcnYvd29yay9hbGV4
L3Bva3kvYml0YmFrZS9saWIvYmIvcnVucXVldWUucHk6MjY3MihzY2VuZXF1ZXVlX3VwZGF0ZWNv
dW50ZXJzKQ0KPiAgNTI1MDYxMiAgICA3LjQxNCAgICAwLjAwMCAgICA3LjQxNCAgICAwLjAwMA0K
PiAvc3J2L3dvcmsvYWxleC9wb2t5L2JpdGJha2UvbGliL2JiL19faW5pdF9fLnB5OjYzKGJiZGVi
dWcpDQo+ICA1MjE5NDg5ICAgIDYuMDkwICAgIDAuMDAwICAgMTMuNDcyICAgIDAuMDAwDQo+IC9z
cnYvd29yay9hbGV4L3Bva3kvYml0YmFrZS9saWIvYmIvX19pbml0X18ucHk6NTcoZGVidWcyKQ0K
PiAgICAgICAgMSAgICA1LjkwNiAgICA1LjkwNiAgIDE4Ljk3OSAgIDE4Ljk3OQ0KPiAvc3J2L3dv
cmsvYWxleC9wb2t5L2JpdGJha2UvbGliL2JiL3J1bnF1ZXVlLnB5OjY0NChwcmVwYXJlKQ0KPiA0
MzgyNy8yMzQ2MyAgICAxLjY2MiAgICAwLjAwMCAgICA0LjE5OCAgICAwLjAwMA0KPiAvdXNyL2xp
Yi9weXRob24zLjExL3JlL19wYXJzZXIucHk6NTA3KF9wYXJzZSkNCj4gDQo+IFNvIGl0IGlzIGlu
ZGVlZCB0aGUgZXhlY3V0ZSgpIGxvb3AgaXRzZWxmIHdoaWNoIGlzIHNsb3cuIEl0J3Mgb25seQ0K
PiBsb2dpY2FsIHRoZW4gdGhhdCB3aXRoIHRoZSBmaXJzdCB0d28gcGVyZm9ybWFuY2UgZml4ZXMg
YXBwbGllZCwNCj4gbm90aGluZyBjaGFuZ2VzOg0KPiANCj4gTW9uIEZlYiAxMiAxMzowMzo0MiAy
MDI0ICAgIHByb2ZpbGUtbWFpbmxvb3AubG9nDQo+IA0KPiAgICAgICAgIDY3NTc2OTkwIGZ1bmN0
aW9uIGNhbGxzICg2NzIwMTQ4NCBwcmltaXRpdmUgY2FsbHMpIGluIDEyMjYuMTQzIHNlY29uZHMN
Cj4gDQo+ICAgT3JkZXJlZCBieTogaW50ZXJuYWwgdGltZQ0KPiANCj4gICBuY2FsbHMgIHRvdHRp
bWUgIHBlcmNhbGwgIGN1bXRpbWUgIHBlcmNhbGwgZmlsZW5hbWU6bGluZW5vKGZ1bmN0aW9uKQ0K
PiAgICAgODcxMSAxMTQ3LjQ5NiAgICAwLjEzMiAxMTczLjMyMSAgICAwLjEzNQ0KPiAvc3J2L3dv
cmsvYWxleC9wb2t5L2JpdGJha2UvbGliL2JiL3J1bnF1ZXVlLnB5OjIxNDkoZXhlY3V0ZSkNCj4g
ODc3My84NzExICAgMTIuMjYxICAgIDAuMDAxICAgMTIuMzQ3ICAgIDAuMDAxDQo+IC9zcnYvd29y
ay9hbGV4L3Bva3kvYml0YmFrZS9saWIvYmIvcnVucXVldWUucHk6MjY4MyhzY2VuZXF1ZXVlX3Vw
ZGF0ZWNvdW50ZXJzKQ0KPiAgNDQ5ODUzNyAgICA2LjMwMyAgICAwLjAwMCAgICA2LjMwMyAgICAw
LjAwMA0KPiAvc3J2L3dvcmsvYWxleC9wb2t5L2JpdGJha2UvbGliL2JiL19faW5pdF9fLnB5OjYz
KGJiZGVidWcpDQo+ICAgICAgICAxICAgIDYuMjM4ICAgIDYuMjM4ICAgMTYuMTM1ICAgMTYuMTM1
DQo+IC9zcnYvd29yay9hbGV4L3Bva3kvYml0YmFrZS9saWIvYmIvcnVucXVldWUucHk6NjQ0KHBy
ZXBhcmUpDQo+ICA0NDY3NDE0ICAgIDUuMTQ5ICAgIDAuMDAwICAgMTEuNDE4ICAgIDAuMDAwDQo+
IC9zcnYvd29yay9hbGV4L3Bva3kvYml0YmFrZS9saWIvYmIvX19pbml0X18ucHk6NTcoZGVidWcy
KQ0KPiA0MzgyNy8yMzQ2MyAgICAxLjY2MiAgICAwLjAwMCAgICA0LjIzOSAgICAwLjAwMA0KPiAv
dXNyL2xpYi9weXRob24zLjExL3JlL19wYXJzZXIucHk6NTA3KF9wYXJzZSkNCj4gDQo+IERvIG5v
dGUgdGhlIHF1YWRyYXRpYyBncm93dGggaW4gdG90dGltZSB0aG91Z2g6IDk0NDgvODcxMSA9IDEu
MDgsIGJ1dA0KPiAxNDYxLzExNDggPSAxLjI3DQo+IA0KPiAyLiBXaXRoIHRoZSB0aGlyZCBmaXgg
KGFsbG93IHRoZSBsb29wIHRvIHdvcmsgdGhyb3VnaCBhbGwgaXRlbXMpLCBJDQo+IGZpbmFsbHkg
ZGlkbid0IGhhdmUgdG8gcHJlc3MgY3RybC1jLCBhbmQgdGhlIGRyeSB3b3JsZCBydW4gY29tcGxl
dGVkLA0KPiB3aXRoIHRoZSBmb2xsb3dpbmcgcGljdHVyZToNCj4gDQo+IE1vbiBGZWIgMTIgMTM6
MjE6NTEgMjAyNCAgICBwcm9maWxlLW1haW5sb29wLmxvZw0KPiANCj4gICAgICAgICAxNTgwNzMw
NzEgZnVuY3Rpb24gY2FsbHMgKDE1NzY1ODE4NiBwcmltaXRpdmUgY2FsbHMpIGluIDk3Mi44MTAg
c2Vjb25kcw0KPiANCj4gICBPcmRlcmVkIGJ5OiBpbnRlcm5hbCB0aW1lDQo+IA0KPiAgIG5jYWxs
cyAgdG90dGltZSAgcGVyY2FsbCAgY3VtdGltZSAgcGVyY2FsbCBmaWxlbmFtZTpsaW5lbm8oZnVu
Y3Rpb24pDQo+ICAgIDM1Nzg0ICAzMDcuMDEzICAgIDAuMDA5ICA1MTMuOTMzICAgIDAuMDE0DQo+
IC9zcnYvd29yay9hbGV4L3Bva3kvYml0YmFrZS9saWIvYmIvcnVucXVldWUucHk6MjI1KG5leHRf
YnVpbGRhYmxlX3Rhc2spDQo+ICAgIDM0MDkyICAxNjAuODk1ICAgIDAuMDA1ICAxNjguMTI2ICAg
IDAuMDA1DQo+IC9zcnYvd29yay9hbGV4L3Bva3kvYml0YmFrZS9saWIvYmIvcnVucXVldWUucHk6
MjQzOChidWlsZF90YXNrZGVwZGF0YSkNCj4gICAgMzU4MDcgIDExOC4yNjUgICAgMC4wMDMgIDEx
OC4yNjUgICAgMC4wMDMge21ldGhvZCAnZGlmZmVyZW5jZScgb2YNCj4gJ3NldCcgb2JqZWN0c30N
Cj4gICAgNzE1OTIgICA1NC45MTAgICAgMC4wMDEgICA1NC45MTAgICAgMC4wMDEge21ldGhvZA0K
PiAnZGlmZmVyZW5jZV91cGRhdGUnIG9mICdzZXQnIG9iamVjdHN9DQo+ICAgIDM0MDk2ICAgNTAu
MDEwICAgIDAuMDAxICAgNTAuMDEwICAgIDAuMDAxIHttZXRob2QgJ3dyaXRlJyBvZg0KPiAnX2lv
LkJ1ZmZlcmVkV3JpdGVyJyBvYmplY3RzfQ0KPiAxNzYzOS8xNTk2NCAgIDQ4LjIwMyAgICAwLjAw
MyAgIDQ4LjQ4MCAgICAwLjAwMw0KPiAvc3J2L3dvcmsvYWxleC9wb2t5L2JpdGJha2UvbGliL2Ji
L3J1bnF1ZXVlLnB5OjI2ODUoc2NlbmVxdWV1ZV91cGRhdGVjb3VudGVycykNCj4gICAyOTg4MzQg
ICA0NS42OTAgICAgMC4wMDAgICA0NS42OTEgICAgMC4wMDAge2J1aWx0LWluIG1ldGhvZCBfcGlj
a2xlLmR1bXBzfQ0KPiAgICAzNTgyNyAgIDIyLjA5MiAgICAwLjAwMSAgIDIyLjA5MiAgICAwLjAw
MSB7bWV0aG9kDQo+ICdpbnRlcnNlY3Rpb25fdXBkYXRlJyBvZiAnc2V0JyBvYmplY3RzfQ0KPiAg
ICAzNTc4MyAgIDEwLjYxMCAgICAwLjAwMCAgIDEwLjYxMCAgICAwLjAwMCB7bWV0aG9kICdpbmRl
eCcgb2YgJ2xpc3QnIG9iamVjdHN9DQo+ICAgIDM1OTU3ICAgIDkuNjQ5ICAgIDAuMDAwICA5MTYu
NjEwICAgIDAuMDI1DQo+IC9zcnYvd29yay9hbGV4L3Bva3kvYml0YmFrZS9saWIvYmIvcnVucXVl
dWUucHk6MjE0OShleGVjdXRlKQ0KPiANCj4gZXhlY3V0ZSgpIG1vdmVzIHRvIHRoZSAxMHRoIHBs
YWNlLCBhbmQgdGhlIHRpbWUgc3RhcnRzIHRvIGJlIGRvbWluYXRlZA0KPiBieSBvdGhlciBpdGVt
cw0KPiANCj4gMy4gSSdtIG5vdCBzZWVpbmcgYW55dGhpbmcgb2J2aW91c2x5IGluZWZmaWNpZW50
IGluIHRoZSBleGVjdXRlKCkgbG9vcA0KPiBpdHNlbGY6IGl0J3MgbW9zdGx5IGRvaW5nIHN0YW5k
YXJkIGRhdGEgc3RydWN0dXJlIGxvb2t1cHMuDQo+IFNvIEknZCBzYXkgZXhlY3V0ZSgpIHNob3Vs
ZCBiZSBhbGxvd2VkIHRvIGhhbmRsZSBhbGwgdGhlIGl0ZW1zIGluIGENCj4gYmF0Y2ggb3Igb3Ro
ZXJ3aXNlIG1ha2UgaXRzIG93biBkZWNpc2lvbnMgYWJvdXQgd2hlbiB0byByZXR1cm4uIFRoaXMN
Cj4gcmVzdWx0cyBpbiBmYWlscyBlbHNld2hlcmUgYXMgeW91J3ZlIGNvbW1lbnRlZCwgSSBkaWRu
J3QgeWV0IGxvb2sgaW50bw0KPiB0aGF0Lg0KPiANCj4gQWxleA0KPiANCj4gLT0tPS09LT0tPS09
LT0tPS09LT0tPS0NCj4gTGlua3M6IFlvdSByZWNlaXZlIGFsbCBtZXNzYWdlcyBzZW50IHRvIHRo
aXMgZ3JvdXAuDQo+IFZpZXcvUmVwbHkgT25saW5lICgjMTU4ODApOiBodHRwczovL2xpc3RzLm9w
ZW5lbWJlZGRlZC5vcmcvZy9iaXRiYWtlLWRldmVsL21lc3NhZ2UvMTU4ODANCj4gTXV0ZSBUaGlz
IFRvcGljOiBodHRwczovL2xpc3RzLm9wZW5lbWJlZGRlZC5vcmcvbXQvMTAzNjgwNTI4LzY4NzU4
ODgNCj4gR3JvdXAgT3duZXI6IGJpdGJha2UtZGV2ZWwrb3duZXJAbGlzdHMub3BlbmVtYmVkZGVk
Lm9yZw0KPiBVbnN1YnNjcmliZTogaHR0cHM6Ly9saXN0cy5vcGVuZW1iZWRkZWQub3JnL2cvYml0
YmFrZS1kZXZlbC91bnN1YiBbcm9zcy5idXJ0b25AYXJtLmNvbV0NCj4gLT0tPS09LT0tPS09LT0t
PS09LT0tPS0NCj4gDQoNCg==

