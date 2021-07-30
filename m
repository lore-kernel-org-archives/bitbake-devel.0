Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.74])
 by mx.groups.io with SMTP id smtpd.web12.24328.1627654276884401574
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 30 Jul 2021 07:11:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherrycloud.onmicrosoft.com header.s=selector2-cherrycloud-onmicrosoft-com header.b=NYC0jjia;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.20.74, mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UosQbPMQjlSWtSlTOP8g+jG/x6PTjUG3Gi5OqKj9Ocjk90wbsL+IqCj7BUPlOgG/emss1WG7k3KrjCCEdV+Potu5uhyeURN5KxiTC2G4njyIGXgjYmDgWDOCarSaa8lch16OcG0VVJkSc1YWMPZJlAVJg2SHyDIrCedkAlzVWayswzVM7rv3ePQeuq7H4l1mUN88eK5Bx5a2ef8hxZzvg3qAmx3jrSxcY8C31fIHnTKUr7nwYXni94nVLlPbnnDHWlxS1mBD+ZQnpo9yeWwuxc4SnsfpO43JxmYQSvxPxm3I5BVQcLTbpaj9xb+PZEG+puZ+n2BAfBpDTfRuygCjhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zclH1OKUUU/0qkjGc47eGDoFzuEAnLTlE+n9bWDd4+I=;
 b=AUNCw5GTl9fzJJxlH0oO4vgTDLtDN5Y/SN+gPCmKHU+wreADs2roqok+4C8Bgwi1AfRB84AUcnTQz6g06mZPaNNV0pW454IHyCi29HkoyTCfXvLcEQ/R0MFNxzYMilOBjf7vJSgRvs7pMhpf+N2K124BUklbknktX+S0fL/UJRcbn/pCUFHQ5cry2Oj7Xvpq8DP6+vutVwLhdk+YsIpQhz1NIXQUsJLT/LT3aOG6ziQ0A8Una6HLAVPzrolczHcpWFr9H7+SdQit03O9LES3Mgn3qAChAa++jGmhPVlgkHEor+0RBinivSk0xYsjebjUqWgWdPCeAi47EiuD0a0cjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zclH1OKUUU/0qkjGc47eGDoFzuEAnLTlE+n9bWDd4+I=;
 b=NYC0jjiawa7exdpCVLg2zegWoOvE+dHv8xwm686SKMYU1UweQYwyRTvCKJZVw1iq7Zo3CqQh+BtCUOUGIXdlqMrIT4jJi4CaunRcVhVhYuPypSWREc0hZ1H+LMzgfZJaPz9o0p1KLKCijUgpSEncVUGwGEgYVzDelsPifokYsOM=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=theobroma-systems.com;
Received: from AM0PR0402MB3348.eurprd04.prod.outlook.com
 (2603:10a6:208:24::24) by AM0PR04MB6193.eurprd04.prod.outlook.com
 (2603:10a6:208:140::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17; Fri, 30 Jul
 2021 14:11:15 +0000
Received: from AM0PR0402MB3348.eurprd04.prod.outlook.com
 ([fe80::459d:3240:1c4e:b920]) by AM0PR0402MB3348.eurprd04.prod.outlook.com
 ([fe80::459d:3240:1c4e:b920%6]) with mapi id 15.20.4373.021; Fri, 30 Jul 2021
 14:11:14 +0000
Date: Fri, 30 Jul 2021 16:11:12 +0200
From: "Quentin Schulz" <quentin.schulz@theobroma-systems.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH 3/4] doc/lib: Add fixes for issues missed by the automated conversion
Message-ID: <20210730141112.7j6n4pdpgfykp3vx@fedora>
References: <20210730134706.3360651-1-richard.purdie@linuxfoundation.org>
 <20210730134706.3360651-3-richard.purdie@linuxfoundation.org>
In-Reply-To: <20210730134706.3360651-3-richard.purdie@linuxfoundation.org>
X-ClientProxiedBy: PR0P264CA0152.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1b::20) To AM0PR0402MB3348.eurprd04.prod.outlook.com
 (2603:10a6:208:24::24)
Return-Path: quentin.schulz@theobroma-systems.com
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fedora (92.42.140.82) by PR0P264CA0152.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1b::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Fri, 30 Jul 2021 14:11:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a43cf60-8d14-4448-7ab6-08d95363e458
X-MS-TrafficTypeDiagnostic: AM0PR04MB6193:
X-Microsoft-Antispam-PRVS: 
	<AM0PR04MB6193FF8BE846CDAD7B07607DC2EC9@AM0PR04MB6193.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Htq6+NDV2Y1mRp7FeeWHHqq0HPjPY14oQGfUA8QHZhAzgVhp9JYOOBwA+LEgXjbfJj1d8NpQk9/yUYEblOysPKXWDHTFVYv5hqVtX3+I74Gr3vzi6XUxU1Jbn5VpSvbuFYJnSKheMaIbhga7x3aY5WR1X8pSe6EZbSeD8vcArH3FhubzhlSAr7F9CDW+bzSoon4QR3WhRBikW0eksec2rxUhsqPWEh2dnD1xmo3lSFGNy380mAsy6ooxVCGSB5+gQTuPJhdwaNh8L501u9JRFaGF9TXCwJn1aKylYw8WzqPPlGLrOGDrQMihKf0b7B4gW0YSKktiJ0GNqb4DWY+QBishWwNo0YrxlOZN65vSqNXvL/M+vCIX1WKkVm7nxgNoSjByZMD3uxc55qKOwP27XRx1+xFJpecwDHlkSDxgstG6a5/DHVDn80jANHJH2lhsSdSap7hZ3D8Faaf2j9WgDY/5gJ8dDNnGuC0jPK2OnFSRP3XqwV2ccu/7SieUDnjWHwvE+14WPhtX1tBPonDbELZychlEENyfhWj9LmobrI0NX9NOhZ2GyPC+K1JFLBhy9gC5vV07Wyv2tc01N6U9WVUMs92ombNyzXGSZh/yNvwa5/VJq3KSi5yzgL7eYe/3O67Nz39u8kDNAgNKcH0+UBwfBuB3X+CC8kff9wjq1Sm+ssQE1FOVj7twqwHVGYOroCbnHo7QGRjlYIV67JscgA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3348.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(366004)(396003)(39840400004)(52116002)(9686003)(8936002)(55016002)(4744005)(6496006)(2906002)(38350700002)(9576002)(33716001)(186003)(38100700002)(44832011)(26005)(956004)(86362001)(478600001)(4326008)(66946007)(8676002)(66476007)(6916009)(316002)(66556008)(1076003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8oqLlMbvG//xfPaPfT6qQ18YH42fuJ1i6kAva7qTWYQBBLJfZYyGZJFU7qql?=
 =?us-ascii?Q?KfoZvGu8Pg+eWPqqGSW5ZinCpZvPP9tqukHjzwa7hszqZ7W3SwaqWhUssfdw?=
 =?us-ascii?Q?qXJituUUlTYdteulbraDWPHKYA0UjFEjK+mrL2mQ1vo16lLV3BdnKdrunUx+?=
 =?us-ascii?Q?sHPOVmNlnfvI6NkdRV6JSM4jVPi3/374SoT6ypOlz8bI2d6DNfs7R8F1LcT2?=
 =?us-ascii?Q?/9QvoaN5MdT+8R4lN1IiSMaIhiqDErQZpXHf0ORgiMfff172/Uv9kKvHZOiv?=
 =?us-ascii?Q?PNw6Wjv3jtTuK9RHweY09KlegBLreQZexsELoS5jzC+sZLP2HPFZz1zibUSe?=
 =?us-ascii?Q?eywFTkkpvlxBv6I1kdCUYtzQJcMiEhruWL90R4p5aGk4aLK5m39DbzrTJ10w?=
 =?us-ascii?Q?gWmZyzMpPi8Z4pOCrW2sjQnfaL6VGOXeokif1UdOcNucsyV5umt1+QwLutlU?=
 =?us-ascii?Q?cPNHazCigSQqbTXq75dJXlkSYZEzKLJHM2pyTmSTxfKT05t1AxAx7c7aZLPG?=
 =?us-ascii?Q?WxOmJcR23fyZ3Bp6us5FymWj/e9HgFOmHtHHlBFxT55Tv9b/f11KAPL8eUIM?=
 =?us-ascii?Q?2M+hTkgum2waR6ZYDqEAr7KhoDuUVaNPaIWWH5u2BWVp7k9wkNbxbkHhAiTQ?=
 =?us-ascii?Q?lNvFYlyLJWaoqH/6xRsWwtdbPOPsRWF5lQVo3/347QO5SvyQnOhbtUSwOoCw?=
 =?us-ascii?Q?YilRRbJLtrOaPjJDdPtsWfVbiwS6mMglZcvwJ23JSzSM17v+lX6qNoClojSI?=
 =?us-ascii?Q?YHxKU2Kx++4myNZumlEFSx4IFkXOueZboRukY3u96j4+Nm2wQpmxj6rcId2n?=
 =?us-ascii?Q?SJ+ppw0L84NDc2A/fwr3v5NkbFCTvvpE6sJOuh+wBRb2yNVgdp983LxbuuzL?=
 =?us-ascii?Q?7LSG+nxBoQerwOa6qfQtMrKWMSTC9iRbdlL+xq2Zj9h8B0rVWYTFXTH7nVKA?=
 =?us-ascii?Q?xeyFGIpf2fVMnmXtokvPJSPhr9We56TLASrp+u1UYjbeGh0EWAltmJsMR2pV?=
 =?us-ascii?Q?qANQAttVX1auKbUHBfEY/X6HYa2oDS53KJP2KlfRTkCmXcq/YrtCYW/BJk0X?=
 =?us-ascii?Q?RpLpw1USgaXIZa/5pM1hJeGwzOT5r3Jz5LPrR2zmcFtiZc1SSE9OCHYbyyHR?=
 =?us-ascii?Q?EuFzqC1j//J7K1J7AmRwEVU6ckHDVj1a12xoIQVNqjFIXWkg9ytMIWEO0T+d?=
 =?us-ascii?Q?1XIuu6Dmqeqre9oxnKCQFa7OuUkaX5pMUPFxgPFJu5alCMqK7fqHQJQNVx/k?=
 =?us-ascii?Q?CT5fgI4h/tJDV3XBBeLlGaftoKAtfivA9GpDM35rdT94Y/OoCkYrgnAm2RoB?=
 =?us-ascii?Q?uKUMKWL7cPj/TGwvQ/XCIIfN?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a43cf60-8d14-4448-7ab6-08d95363e458
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3348.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 14:11:14.8336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N7bP5sQwuGHkLpKc4FnixOt/JZkys0SjurRfTvX+J3NxU+rib4wh+D6rRTRVNaxCL1N8+83w+ZpugMdpwYa5wQAWJNfoqn+NlYqvNu/Bvn3OScj7Q5L3oVLIZ5GIU0xy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6193
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Richard,

On Fri, Jul 30, 2021 at 02:47:05PM +0100, Richard Purdie wrote:
> The examples and tests use non-standard override names, convert these to
> the new syntax by hand.
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
[...]
> diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py
> index 02a5c4952a..1b6b6d412e 100644
> --- a/lib/bb/tests/parse.py
> +++ b/lib/bb/tests/parse.py
> @@ -144,7 +144,7 @@ PN = "bc"
>  
>  
>      classextend = """
> -VAR_var_override1 = "B"
> +VAR_var:override1 = "B"

s/VAR_var:override1/VAR:var:override1/ ?

Cheers,
Quentin
