Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026B8CA100D
	for <webhook@archiver.kernel.org>; Tue,  2 Sep 2025 06:45:56 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.112])
 by mx.groups.io with SMTP id smtpd.web10.71238.1756795540688708917
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Sep 2025 23:45:46 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=MF6/5EUm;
 spf=pass (domain: weidmueller.com, ip: 40.107.162.112, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IhXiHpW3ME9cvrLFnD8QIec7B9ABfa1ljIet60pakT3aUREtc4WIoEsPjmBh+776xabwRCTXef1LffwaS/VkgyN1r8r9JczJUhKDwCddOvO3yC5KuzZmnLAZCP3NF5YqW+DAnO4rqt70Ih9mLyPszGWmYfQmU9Z6V/iG0Bo4eBZMwf9Guschd9V7Vl6bA7kdu3Dq1iDpoL08dOsCqbqix9Q9fHQD0S2UmkeJyvxb7t0FaUIWoEhrgcrq6cPiU002iNKVv74/rExeCqe0TYkgZEtDZIJBjBaQBt963v8e+RcMxNlskfruUY7QQGFRlo/bmflzQrfqSVbHVfaVvyZtmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1AkRJOCsf5CvL6iulhr0a7lsE6ljW6DefLvM7o2zvs=;
 b=P+UcGVGaYoIpYBXKTOc/UWWOf/NgGJ7N14M+jvvjXoXRdxTTcRmiCQ/CHDIDVqLny1DAA5JfyapnAQuw5TxvJbsidqGuS1ZzxTBQNe6d4IDGDh1PDV20lpu6/N6JhasVJqmuyv9efcb/lUnwNT3HgEpuibM+k3N5/jc4qz4C9qGHhGcIrAJIBKEW+wAlDACsuE0kLtxTCwl3xWzJKjvQxxfrdrQLJiKfuL7HISBpY/H8lt+oqjaNhrInKZHn1ntjCdAhAOR3nuafbE1fo0XS5l8dak40UEaV21mPnBrmw0xHWjRaaJTS4sF5jPLjkgvXvAMZepeUtv4NHO+vD4HsEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1AkRJOCsf5CvL6iulhr0a7lsE6ljW6DefLvM7o2zvs=;
 b=MF6/5EUmsxZ0MjjiV04wSu/ISrRa8QBBreTwOINjWpWKWqIccCqVfAeRkTpzLjg48trWcKdupXO5u5pSgUDZQKHcxM0DQfXtDpM0nU7JFOWg2OWkEoRCH7ZhcN7KPaEq2u+O9glUoC4AyuvWsXzaTbe9XfqX5zR3MFQE1DGiZTDaCqf0IqE3vRq0xiZVuT0JcRHztEHjP/AqiFWK7CzVkKZA121vZJR2TTzUpOf19sgSK8Hd6Zp+SjwM6hyaV88Bs+AZtKRacxYOrfYgCIaNqny/jyCUo3Ykmqa1jqVpZhe3gM4krEC/jTTwi3HYFfBwTPT3Eu6fmpfR0FqVqCO7zA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by DBAPR08MB5591.eurprd08.prod.outlook.com (2603:10a6:10:1ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 06:45:39 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 06:45:39 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 06/15] fetch2: gitsm: remove needless SRCREV_FORMAT override
Date: Tue,  2 Sep 2025 08:45:05 +0200
Message-ID: <20250902064515.30879-7-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250902064515.30879-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250902064515.30879-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0263.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::10) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|DBAPR08MB5591:EE_
X-MS-Office365-Filtering-Correlation-Id: f5de5051-943c-4775-c67d-08dde9ec5395
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?2cvidWKdAQ+PhRG0GkL4VXO2hmI6kHEdO8Q2dURYy0OwZB6G6ByXxN0cHUpN?=
 =?us-ascii?Q?Y+CRkxjMkMilLW2gZWJkGNAP28TppX/eiATB7zDkByeQyUYk0MHq42J4siRg?=
 =?us-ascii?Q?80DTPugxp+D0+zZ0tsuiqQgjiJcP5j9ATLYKLBCK37Kje2yp8t0nUouYAo/p?=
 =?us-ascii?Q?Lk+gnbivESEnqPcE1GWxXDSPRaxj/poyxRVBoc+9esuwrNtaQHoJDRQk3mMq?=
 =?us-ascii?Q?Y50yz5Y+8kJo1O3VfVEDG0BsgDqayEgDUisEZFyXDQfE/dIunDvYVxpIdf2q?=
 =?us-ascii?Q?JhYyVdlCsGE5rok2jtknOnSybf74qXnVZWI0W4XGEf2CZfO+SvF7Bpbnvvvw?=
 =?us-ascii?Q?a3z1oSpWavKj6hO371m0AU0sD79lc8bVJzf3Ut3VaH80sHNLr9M2k2FYM++r?=
 =?us-ascii?Q?sG5NGeomHJycLD3zcqbCfVCbJ+6cUxTbX2qdoYJEesDpBfsyu5eDDiWSJEJh?=
 =?us-ascii?Q?xqiWRbx9AZ2aJJZOlmQXsuX6HAdQgZL8Z91XIWPbhRAiCyKPKfV0d5ktDvBk?=
 =?us-ascii?Q?B8PTv6uebZepNguMkKUfhbZE0JS+kz1bT3QA1favvb6Yz5iIp6ZnfLwSRXlE?=
 =?us-ascii?Q?yaOKQGBbDAiJOMnJb3G5tZ6XbOifk6v2DxtGcSCdvab+MJ5Wy3fX6qt8fkTY?=
 =?us-ascii?Q?KRSa8TbiSVH+Fvn0PD9y0BnknczE2lKRgGR0ou8qrFS9TADXxdoLgKFXy5e0?=
 =?us-ascii?Q?mStCrdVnc9V6GDpwm4JnSkEuUtz5qRqdi0PmxzRi0Fm928S9xAziJ0X4jukL?=
 =?us-ascii?Q?Cvbdec06C+OE0eU3J49SxWMmBfFarpEYk+WQb5l9UsiL7SLy/lFZ1OCgplau?=
 =?us-ascii?Q?HSfpou7JImsRXeRcBRCJmKGQxViPl4+/y/3nZi4ti6ue7ybfuX8xfep6XsCB?=
 =?us-ascii?Q?r7IcIUJsywoSty+ovQ7juQS6XxapBmjdOk/q+v6ybjGxn8s9IFBikBPs/BPD?=
 =?us-ascii?Q?qbFRudLcnn77KZgdnA/fPB5XLAOFyi6EYhhg63aSDkXJM7WEO9C5Me1lOr7v?=
 =?us-ascii?Q?04OjJswalbdmx/+L4CKH3eUIsFL7Ve5wRt6qmUtZb06HvTs/H/TwGdP0E/aH?=
 =?us-ascii?Q?UiADKNmcqVcsxvcJPr1taOVwHENAhVa+dOvCYgrIpp+2+PHLTkkhEm2kN3pK?=
 =?us-ascii?Q?5i43TL6zN77B8jResFjYx6URQaMPDGrzdFrH9uzw+Mu+6rJxizBw3vpTdfLE?=
 =?us-ascii?Q?HbtrW4Y1Qxb10vWVyk3wWfNQDFMI0xPlexPCvt809nVaj98ARhn1w56aLLVo?=
 =?us-ascii?Q?3baAYz/yKyrdZjXGeveV06OlMLBmlqIES7PkJdS8oW6LKSAKOJMHHV63QnW0?=
 =?us-ascii?Q?1It+eHoYEAadT6WoeHHjji0eL9tUCtZz3Zk7t2vVf6+TSBRlGZLrYtWV1s/2?=
 =?us-ascii?Q?LLZafngo8urkurau9OdLX6N7o7Gq/rfHPW9N6gznUC64FVHw6ZAnF12Iv/cc?=
 =?us-ascii?Q?dmS+KEYZPjv/qh62Fh5PtffEI/xEVfshsrB3qRJvjhn0kuNp4mNk5A=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5q0WrIpiJXJI72BTC1CDZ9UPWbNl+XR4e7qwgWcVz80ptvsAQi3+EbGoi3qN?=
 =?us-ascii?Q?Nx8STSFkCwqiCuqjzaGq3dgB3TKmQ1zeOIyIWZRDL7qaNzYR9letU/grwVKX?=
 =?us-ascii?Q?p3m6Uv2XIUILXlQVcNizzuCUnzP0lMpeMjPdea10VcwOmzXGtafyJ8a23SYz?=
 =?us-ascii?Q?UvMghAV7y7Foag17en4+Llfnh0kNlyOSo0wugKc9MUHRtK7mmCEU2rtleAXV?=
 =?us-ascii?Q?kvt4JkI85ENSKV+TmB7uA+XDyLx01whCz82NW6V4fQq5sqfZrq/swaEjIy3b?=
 =?us-ascii?Q?NLjbV+63aga/ftNkNo1REu8olQ5RRTgGjIbgAmCONSM1aQidQ61irHiWUnCf?=
 =?us-ascii?Q?hhXUVyv+n86wsMG+6ZyakWJ7J+rJXgNSwHse74J8f46akLJiaALRuO7gRgCw?=
 =?us-ascii?Q?bUtonYZ96fsRlxH4isIUSwExBafZ7bb40K3WNPIUv6X4kNeZ+awnyV3a/GS6?=
 =?us-ascii?Q?SndiD4kV23SAG1S5pC5Y4FZP62WGQ5Ds75k2d7rKP7awYJzdzi2+zNPVy1wf?=
 =?us-ascii?Q?RHoF84UAcWn3aaJDX9XKJakxP0pTXeCdB1AWfe4OfMDUqBpZxxYrEVUowbnt?=
 =?us-ascii?Q?L+ZDeH/2gZ6/jOXyETV0o6KV9xaIKFEHOeQ7a5Vwa14gvJZnJGOuUZi5tSxf?=
 =?us-ascii?Q?5vyN2uMxGcY5vJDFwAQcNv+pXr5iBKb3itNSkyME1IONtXYD0zyOW8IkkBIH?=
 =?us-ascii?Q?xATG3n+3Hn5ijGi+IW9aFYPPEj9+J4vy6gITpynrlLtXAAv8s546+Bou+5cb?=
 =?us-ascii?Q?j7EErjX9qCs7yEj6YgTf6449rNavbqrKNoyTT0RCCiYmLG1YMdhfLA+7c7pS?=
 =?us-ascii?Q?wawAq3XznheuYwyRkgfOEcv1um2r0x1sCn6ZmVeluWuFHy/iezq+P/iM8XTr?=
 =?us-ascii?Q?7RwyZtpiU6qDx8SQGMknLCie0ZCC74pQYjvJv0LT5vR1ZUjQ2oS+oChbNWF+?=
 =?us-ascii?Q?mzYgTpA8vVym892MVqRnjd911moOHRElH85fkNBjCQY3m0IYduZ/kFBVnO6p?=
 =?us-ascii?Q?ekXMbZ6O5ZT8+WIAvbLYSvQtYDFBdo9WBM24Fx7WsnYg8wvSwZ0LjP0Ky63G?=
 =?us-ascii?Q?ncnt+8+K3leVXIATr/zXC9UgwJOhGyh4KDMtCuYP+ru5RAMa1RfWr9kwmPPo?=
 =?us-ascii?Q?Fv9cdt5dTqlMkcth62ZGb7wWG1hAv/ngLXZRVW9LqY6iesdhwS8/hfeITAXz?=
 =?us-ascii?Q?k7vstwk3NzTAZpthLny2vQwlWzTCQmAM/aEvQ4b056OvLFlNLrjjsr4AZNaj?=
 =?us-ascii?Q?7gIWJAghQ5eEGO/BvJfERGr0nocblTB9WkPimYmai+ptr8uo6HWfKwgL4MfC?=
 =?us-ascii?Q?rfkoYcpKoUrXdRI0Bx1mFCHOBWDPZiMPuGl9clEAH1vKymTFxE/KmnB5rRU2?=
 =?us-ascii?Q?ArmMZ8qWOsVcqYBkCgyrNLKU+lEFDI3ebdGA6PF/BFkzKQ7hLp0l8OMWTo1A?=
 =?us-ascii?Q?Xj7kpNRZYdoZfn0smpvO/jZDUwYmhnMe142vjBEcPL7iB/8Y+LYKRsBaWeAD?=
 =?us-ascii?Q?3Y+FK35I4NiGulwy50H7wuSftmmQ0GnACCS7t6LxU8Qe8JGEfN+tx5CKQl67?=
 =?us-ascii?Q?LmQXRrbHFKz3teoHZ24l9p5kLoc7qjuhsIPGNyv5CYRaKOusmhB3WHUcbOCx?=
 =?us-ascii?Q?cg=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5de5051-943c-4775-c67d-08dde9ec5395
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 06:45:38.2825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wnVr0Lzzk/dL9p7hCgG310r6VyKxrF+Qd2KliWIKwWAp43JrLT3c4GjYvJeNYoU+FCRg/t+aPUnTOom7HfahEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5591
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Sep 2025 06:45:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17925

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Remove the SRCREV_FORMAT because it is only used together with the
SRC_URI and not implicit URLs.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/gitsm.py | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 15b9c3740..bda9864ee 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -136,11 +136,6 @@ class GitSM(Git):
             #ld.setVar('SRC_URI', url)
             ld.setVar('SRCREV_%s' % module, subrevision[module])
=20
-            # Workaround for issues with SRCPV/SRCREV_FORMAT errors
-            # error refer to 'multiple' repositories.  Only the repository
-            # in the original SRC_URI actually matters...
-            ld.setVar('SRCREV_FORMAT', module)
-
             function(ud, url, module, paths[module], workdir, ld)
=20
         return submodules !=3D []
--=20
2.39.5


