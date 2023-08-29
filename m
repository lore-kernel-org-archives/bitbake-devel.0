Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160A2C83F14
	for <webhook@archiver.kernel.org>; Tue, 29 Aug 2023 16:44:10 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.49])
 by mx.groups.io with SMTP id smtpd.web10.1862.1693327440245696393
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Aug 2023 09:44:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@armh.onmicrosoft.com header.s=selector2-armh-onmicrosoft-com header.b=XoNZpTzf;
 dkim=pass header.i=@armh.onmicrosoft.com header.s=selector2-armh-onmicrosoft-com header.b=XoNZpTzf;
 spf=pass (domain: arm.com, ip: 40.107.21.49, mailfrom: ross.burton@arm.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7aYPSJnARIrYNO1/RuVHnx5ivolRjx7cyovEThKzJJQ=;
 b=XoNZpTzfagp9oSjz1XaT2ZY/0ckPGcqFl3hT9cI4AmYHJo0ftMZOdQdMuci6bTdIAmAD8o4tEJg2L/eFvbyrb4hsJ8+4rOpMWLATupGohoKidF+Rg7TkL3FqxYJMnC8NqKa1/2I570m4s4sQBX+4/FOgF59Q28YOchAERXOvzlM=
Received: from DU7PR01CA0021.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::9) by VI1PR08MB5535.eurprd08.prod.outlook.com
 (2603:10a6:803:13e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Tue, 29 Aug
 2023 16:43:56 +0000
Received: from DBAEUR03FT050.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:50f:cafe::1a) by DU7PR01CA0021.outlook.office365.com
 (2603:10a6:10:50f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.36 via Frontend
 Transport; Tue, 29 Aug 2023 16:43:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT050.mail.protection.outlook.com (100.127.142.250) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.18 via Frontend Transport; Tue, 29 Aug 2023 16:43:56 +0000
Received: ("Tessian outbound 0b7d6027328f:v175"); Tue, 29 Aug 2023 16:43:56 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f70082f058c11e0c
X-CR-MTA-TID: 64aa7808
Received: from 6aaf90bbf85a.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 86950A85-CABE-43C4-8DAF-5F46DC7CF41F.1;
	Tue, 29 Aug 2023 16:43:49 +0000
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 6aaf90bbf85a.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 29 Aug 2023 16:43:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLQsLOuocghwn5bqFncj8/7eWiEBE/OfZQ1MJzl7zimkVkhJIqvqNnPxICE3s6niT0RS64mc7NThS277V+XH5wcFCyBsqo8cNBsyhjojQNgnAsthYViB/+ta25SXz5EkH3Nk+l2RVewgrix1rBnJ6yq+IPUTE4GV3qVLJ1Rjm8b70mPw8aQ5hlOhmafObJ7xG4MNxpxAohvOaGAoXS8mfn9ehil34saRAykJ64gkk0YAXbN0/bwmLhQygj+RI/n+CPjAqUksi7AQV3pmjj9Q0CEZ8sLVz2tVTZ7Qdt1Wl+tnDlekowq/tjd2X1Zn2ggqBfCHlNmL4TJyNwJAeWlCtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7aYPSJnARIrYNO1/RuVHnx5ivolRjx7cyovEThKzJJQ=;
 b=Pc2Gaam7ZoN8/4+kYq2c0lakIL/S+rvEGNlqHeH4gf/0pIGERj4XQWY9oEiUAFAJa3t+NWBuW3qQ3QlUi2tZuyrvINuZcPF6Pl8bIdHWyOvW0S/iXRb24gcskCDRiOKDBfrdwSz676Gw0Jj3G8qxSqYcte0H4KDS1cHzma2nBD/G2SVDkZo+a5A0t0UfjFkcFIjBsDwLf58MgKgPZT+cRrIu2YNzzOd93ksdg3uiXG60STzlVQjCMjVWnCtYMsHAaKM+qqZt67LahkudM6hI8vOgouyl9wR5mSAu29NL8NTVt+wRv+JBGXCGKNZnRR27NttEbyqfFCsYyHdHAY9INg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7aYPSJnARIrYNO1/RuVHnx5ivolRjx7cyovEThKzJJQ=;
 b=XoNZpTzfagp9oSjz1XaT2ZY/0ckPGcqFl3hT9cI4AmYHJo0ftMZOdQdMuci6bTdIAmAD8o4tEJg2L/eFvbyrb4hsJ8+4rOpMWLATupGohoKidF+Rg7TkL3FqxYJMnC8NqKa1/2I570m4s4sQBX+4/FOgF59Q28YOchAERXOvzlM=
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com (2603:10a6:102:2a3::12)
 by PA4PR08MB7410.eurprd08.prod.outlook.com (2603:10a6:102:2a2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 16:43:47 +0000
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::4b8a:7518:c642:5727]) by PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::4b8a:7518:c642:5727%7]) with mapi id 15.20.6699.034; Tue, 29 Aug 2023
 16:43:47 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: "alberto@pianon.eu" <alberto@pianon.eu>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v4 1/3] fetch2: Add support for upstream
 source tracing
Thread-Topic: [bitbake-devel] [PATCH v4 1/3] fetch2: Add support for upstream
 source tracing
Thread-Index: AQHZ1qOo4NsXm/oUDEqJHQF2ll2vh7ABgqEA
Date: Tue, 29 Aug 2023 16:43:47 +0000
Message-ID: <2E8AC0F3-B562-4F63-8F17-625234AA2849@arm.com>
References: <20230824155655.448755-1-alberto@pianon.eu>
In-Reply-To: <20230824155655.448755-1-alberto@pianon.eu>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	PA4PR08MB7411:EE_|PA4PR08MB7410:EE_|DBAEUR03FT050:EE_|VI1PR08MB5535:EE_
X-MS-Office365-Filtering-Correlation-Id: 13211b73-ab34-4af5-5d51-08dba8af22e3
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 
 hM7C9mMk53ect7X9Jk1/BFCPzndji2bEy/oowp/J+j+tRzGRaPig8WQZVQemWcvF8RPFIUcEEP2sSETXwo01tdYQaOxYv+8S/6JLOZwKBX6vT5AF1G1m7O5rhKcbHRs8aO5Pz7SNqbk81LLIE/0WJBVz5v2o4RejoKRBCOYqpBzn0OpE262W5ie4lQw+gr+wiJ/5RerRI6yPyNq47arOJ9YfW7I0IQM0xai4W0xgzJ/3Z/zZ5bdLA5kdnK4a2IdyG0/gc3yGgCxHRW2LIcyDX/X0ieE09yOkeku6mh5PsqmKDHW/VnQF2cCEPVdunjY+rKEgOzqTVAx5TJvGJzMR8vvKCp63nHwnA7oFCOlOZEHse4u4pQPkBEIwVyr9hu84ddbCg9cutXrz0HnYEow8UiRkGvwrn4SuMx7mFqiOIWjoUxlGg/pbJdOcAK07gW13Dn74gZ5GpDAF2yLfoUVIgbp3QfSK+xKeK4DEwyrcozR4O2xMR+zEOYredDJm/Bea7DllJ43pfPVhxAyAOIoZ2w/J2MlRCWgHUxBRgTnCzjeb/Es58yIBa7+YyIso5Kx1BplDn+N3WD6dskbgGdZmkR+dhlLw+LaAKpDeWc8HzR8Kx1iKRnGPZ3ylAMONul/GdclLK/MfZ/bekZ1YeuIWLQ==
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR08MB7411.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199024)(1800799009)(186009)(8676002)(8936002)(4326008)(6916009)(2906002)(91956017)(66556008)(316002)(66446008)(64756008)(33656002)(36756003)(66476007)(76116006)(66946007)(5660300002)(41300700001)(26005)(53546011)(6506007)(6486002)(2616005)(6512007)(4744005)(38100700002)(122000001)(478600001)(38070700005)(71200400001)(86362001)(45980500001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <4380651874459847870794A28EC532D8@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7410
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 DBAEUR03FT050.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	614266ce-9668-40a9-53a9-08dba8af1d9d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5Y9es6c+WgvuxjbMgaLeDTzE8nt+EyCSeWIH7r87VLRrpTEOvivyBX+/DCkqRjnuOgfFMKPPJxjzNiWSUiVNKEyiPWnncy6V8IiUzj7SeyMqInAKvHGAy6VixnbiiASxF9BKwwAUFA3kUQlck7Kpw/iJOsJX27msCgOHGOtCjaOYcYd/SItL4Z+njowg8ENJGOJLSEi64g9yIvuF+rUT+L4FOhKGSblfyP//p9WTLgE8GjgNtbe+HPLobbWzdDbqPKxzC99mrprbnCepYJc4PcBW0/sjffN86M+d2YFMq2c7JNd3o8E6MPMaaTkUWeF9x0c6KRNFLLCH054Q5cz1uyqMFCaqwKZVo/aWa5Dcggp87X33v8r+UwPVoSPKVdZA4AiMDfv6yIXWgeuEBoQ2hIcRMApR7jn3Xkp9vucC4WKsE6btiaH6dvrNtnltv0UIWli61wKflKpqb97vCt0pIgZIDsDTqbZWen9NBRCDZXhuGfjZhOSd3vRl6zyXeiyAsDNpFxr0W1UQAAnaKTre2Nc4VMuqbFutq9sfjgGPKPBi4toJmHY8g8Zgq60uWTGvLe69SM0Febp7Hw0AwmfnB1Wf+eqqs5DPK3cul3BEDn3tdOM8/iXuo8VKs4X6kG2OSGULCFnQ0AwR24Fm8iRGD0qy0LtyKpcBxfT+eYVwZXjiOvPjrgy5hb29i2QFlie7qw19OxnH0tIMhk1QaIZtoMvzCjhyD3e2WOE12x6675vtIB8AfL1wq58WryQU/6/g
X-Forefront-Antispam-Report: 
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199024)(186009)(82310400011)(1800799009)(46966006)(40470700004)(36840700001)(70206006)(26005)(70586007)(316002)(478600001)(82740400003)(81166007)(33656002)(6512007)(41300700001)(86362001)(6486002)(53546011)(2906002)(6506007)(40480700001)(356005)(4744005)(4326008)(8676002)(8936002)(2616005)(40460700003)(6862004)(5660300002)(47076005)(336012)(36756003)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 16:43:56.0969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13211b73-ab34-4af5-5d51-08dba8af22e3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DBAEUR03FT050.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5535
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 29 Aug 2023 16:44:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14990

T24gMjQgQXVnIDIwMjMsIGF0IDE2OjU2LCBBbGJlcnRvIFBpYW5vbiB2aWEgbGlzdHMub3BlbmVt
YmVkZGVkLm9yZyA8YWxiZXJ0bz1waWFub24uZXVAbGlzdHMub3BlbmVtYmVkZGVkLm9yZz4gd3Jv
dGU6DQo+IExpY2Vuc2UgY29tcGxpYW5jZSBhbmQgU0JvTSBnZW5lcmF0aW9uIHJlcXVpcmUgdG8g
YmUgYWJsZSB0byB0cmFjZSBlYWNoDQo+IHNvdXJjZSBmaWxlIGJhY2sgdG8gaXRzIGNvcnJlc3Bv
bmRpbmcgdXBzdHJlYW0gc291cmNlLiBUaGUgY3VycmVudA0KPiBpbXBsZW1lbnRhdGlvbiBvZiBi
Yi5mZXRjaDIgbWFrZXMgaXQgZGlmZmljdWx0LCBlc3BlY2lhbGx5IHdoZW4gbXVsdGlwbGUNCj4g
dXBzdHJlYW0gc291cmNlcyBhcmUgY29tYmluZWQgdG9nZXRoZXIuDQoNCknigJlsbCBoYXZlIGEg
bG9vayBhdCB0aGUgYWN0dWFsIHBhdGNoZXMgc2hvcnRseSwgYnV0IGp1c3Qgc28gdGhhdCBpdCBp
cyBjbGVhcjogdGhpcyB3b27igJl0IGJlIG1lcmdlZCBmb3IgdGhlIG5leHQgcmVsZWFzZSBhcyBp
dOKAmXMgaW52YXNpdmUsIG5vbi10cml2aWFsLCBhbmQgZGlkbuKAmXQgYXJyaXZlIGluIHRpbWUg
Zm9yIHJldmlldyBiZWZvcmUgdGhlIGZyZWV6ZS4NCg0KVGhpcyBpc27igJl0IGEgcmVqZWN0aW9u
LCBidXQgYSBzaW1wbGUgbWF0dGVyIG9mIHRoZSByZWxlYXNlIGN5Y2xlLiAgV2UgZW5jb3VyYWdl
IGxhcmdlIGFuZCBpbnZhc2l2ZSBwYXRjaGVzIHRvIGxhbmQgZHVyaW5nIE0xIG9yIE0yIHNvIHRo
YXQgdGhleSBoYXZlIHRpbWUgdG8gc2V0dGxlIGluIGFuZCBiZSBwcm92ZW4uICBUaGUgZGlzY3Vz
c2lvbiBvbiB0aGVzZSBwYXRjaGVzIGNhbiBoYXBwZW4gbm93IHNvIHRoYXQsIGFzc3VtaW5nIHRo
ZXkgZ2V0IGFwcHJvdmVkLCB0aGUgcGF0Y2hlcyBjYW4gYmUgbWVyZ2VkIGFmdGVyIHRoZSBuZXh0
IHJlbGVhc2UuDQoNClJvc3M=

