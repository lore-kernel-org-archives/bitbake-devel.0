Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9CECA100D
	for <webhook@archiver.kernel.org>; Tue,  2 Sep 2025 06:45:45 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.136])
 by mx.groups.io with SMTP id smtpd.web10.71237.1756795538919452904
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Sep 2025 23:45:40 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=IL1umWqY;
 spf=pass (domain: weidmueller.com, ip: 52.101.72.136, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=neuk8Em00VZkwIiSvKeiVYgdV6LQ1GfB0StUPsYtm9hC75wRdh8dndYlT0ikGqSMbrppw5WnJobN96r4mJhnKDsPHmSNd9lcmxbLprz5skXGKE2yXM9HiLd8MBBSt93rXeK0jSNYCzrvWtbUnozG9BR2B8hlqCG5iXvXEdVHF36WsYvEyaFQTa3Y4YzhshbtCxtHQkUVjPl+F2qCPTX/y6g8TYxpwObIeDEm9sxVd7syqMZ74+9/f9axN9uzjA+975sniQMif0t4Ad/LksqAXERnZlToiA6caZiHTMJUIF1nZ1vU1x9Dw78Fz9XMowboUeyDYwZwzgArfbkxjNPpSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWsen5+maO7iXldAOS0Z8Rmitr3qMwt9Lr4fa7XJn+0=;
 b=HRJnud9NlTaEwH8zy+KpMMARROLZjJ/H4yUhmfU5OAKv0+dMjYBn82CcRiu12q5Qw/BUKgFLfQCZeXJjgOWkGKKee9/WhxpRn//YVLRcGaMCzsYl3U8/hfhHZ2Z90Z8Byez7TJAyeSEmgsCgakNEtPDWqf1s10r3MPNIZR+8SsToDzb5u9xNOAFFGevfbFfjb5qd/UEVD7DLiUb6QIB6Dl/8+k1LqWCd6XrznUkB/g/3d4SeXknQncwiiRBJLybg2beGwhMUXK+ucJ7TZYjaOrgsg0Pi9QQ/JWCzekMCmDqMKFG1Da/pyjhjy1SvsvJjKBpd8ELFX5lv7Qhp8Ui9CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWsen5+maO7iXldAOS0Z8Rmitr3qMwt9Lr4fa7XJn+0=;
 b=IL1umWqYGEZy0AtrncLV/Ft/r8j+vaZSV0DnPYE5Wi6F+HPc9U0Mcz0Uual2/x1XB1Qshn7TPO7rTJhPkJ4JtfmuBlguIFk/XsIg8N0xSpU5gCur/LtlfdU4Tb0r329D9dTalScHe4woo9vl+UNrdj6HZion68lvZ28SaqumfSZV1KTE+aFxRAVVnJ/9sH+pShIAJYetjS4G6qIseqNDftHGN8M5w8iFAO4l9qpxDUwnMVUXO1rCT9LAX8lsQKpmnYQ9II7fh6GJgUjMKfw6OsPpU+AyTUT7DRhuZ0e+8G4L9wES/AnJPxh4mm9t5KK9cgX0rjoHtyrC5VaSZuNLhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by DB4PR08MB8149.eurprd08.prod.outlook.com (2603:10a6:10:383::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 2 Sep
 2025 06:45:35 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 06:45:35 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 00/15] fetch2: gitsm: rework and simplify
Date: Tue,  2 Sep 2025 08:44:59 +0200
Message-ID: <20250902064515.30879-1-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0263.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::10) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|DB4PR08MB8149:EE_
X-MS-Office365-Filtering-Correlation-Id: e4fc241a-84b0-4e6b-b8f4-08dde9ec5199
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?y5GCxW0yyvV9h+2BEsOQitYazpErTE4SiyAG+7FBPyPLDmdjZGBroJVgpETi?=
 =?us-ascii?Q?FSSrJW8RJkU0CryO5eeFtTqYK224O4sZPKcWhneoGxWQuwLwkIOOc4jGGKvn?=
 =?us-ascii?Q?UOPXHnX0yDllLEMWIzB7YV4G5IETInHqLTHLe1mk7VT5Q3ZsntWJCd9Bw1E5?=
 =?us-ascii?Q?6UIN6aIEyZ2iKlmyh26YkM1MHzqNYU8ZJd0YzeIK5BU+1BQkWp/Yrz3SjyWf?=
 =?us-ascii?Q?VgbUtTMtZNk2CMLQ4mqNQ96r9IF+gJpMCwal3GBzML4dvm9CDVvwVybHAv86?=
 =?us-ascii?Q?oDrCPxDhYSngrg2y4jWNBf2CXKjG5T2GGRaW3HCPSm688LIwtssmljddzgto?=
 =?us-ascii?Q?1diAkn5PSROCGUcZs4JdEzwjsmFxCDF1kCJnJwPbRfDujXg/MNphb9g96K+t?=
 =?us-ascii?Q?89iOa3jkmqhI+Z2MaRwLH08Ja2UKmUxBMUeau3HfR6GxdzahVGDpdgnHDgof?=
 =?us-ascii?Q?05TuMsDvDF2NWsQyr6ZB9eRQKBjWntzfKdXdy3NRLmEf//9/xXoz6CiHVS4t?=
 =?us-ascii?Q?5Gy+0KPsIyXrBnYvSBYOmRAj7yhriarpFG+gTnZ6K6kzXpVXPLyZEG+rrkeA?=
 =?us-ascii?Q?bpxgsgiLf9rBhB5DIcXkph9zYA+Z/L+91mg9jDX2yHOWnXkEIP3MArF465aw?=
 =?us-ascii?Q?zsjrxUc3ONcElShwfNjRBjnC7MrwEDiHetVt9zaT0R9ZgpnUGlx32Khd8yop?=
 =?us-ascii?Q?pUBk8kX8pwKTnuE+4r77vJ/h/+PChjoaifk9vKrGms0FqmIgvr9Y64VFTPrq?=
 =?us-ascii?Q?KFCseFIutewNgzjRpl7Lp1yqhoXukTGUCv8TEdBmxHGuT14ODYtz6zdvb8GO?=
 =?us-ascii?Q?1sWm9w7l6CZihfHuB/pbNUSTdeTyIYoSHwsn6oIwIaICWoT8/dxWdwDd4ihM?=
 =?us-ascii?Q?VJj1Nnjin0M8x3B+t3UTcwMuucDhXaHTFUl9m0wobP0sEieeA2FBGnHq+Sq0?=
 =?us-ascii?Q?rjbAkesIhebMWUQge8CSP0fmZvdOBCRkeEvAJzTZzX53NH1SKylecrZI/S+U?=
 =?us-ascii?Q?3A5/xLiMyQah3P1BMhFBTxdt2/2pN+VAIYuEw2no44cm5/P5vsSmc/bBbOT7?=
 =?us-ascii?Q?zn2mgVj9VOuVrvRrMGjuVAc1cLEEGbGdW1lf7eh2/jqZeX7Vonryp0k2lEyP?=
 =?us-ascii?Q?Lb490ZMHoG/RXTtg6NkrE3mau/+M9batndytN7nBBQEvPcdelK7m4ShfhP0L?=
 =?us-ascii?Q?RXvs8wwahDcGEBv4pWPFxX2V9Ak/0ZRlqaDSAQ7A9RB96W2rDTPYFjs6FNxv?=
 =?us-ascii?Q?W+NVe3FYXxibiDP7bkPgc7HI5UJtoRnhQGwWH18ToMCn+1sm50g6nlPavaVE?=
 =?us-ascii?Q?MmOCyMLSJCSuvvP1fmTETY9S7D0rtLBk3hl227AjxjIqKfyZQAjg+IpFr8ag?=
 =?us-ascii?Q?vIKNY327WfJlTeuPFbVTzX6MWph031ahz/9NQjr051sOw5Qi48cYyjl3Gusw?=
 =?us-ascii?Q?w8YhwgpyPpmWngV1Xqn9AwVANez+2fUKnLSPwmxGjxmDuR3jB+Sghw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nsFUnKB3FXFmwWt7v/NMmK44RLySxfsbmElNpQtEtq0oC2nGyBHJSVnzDhiP?=
 =?us-ascii?Q?ZclLxJYJOFH5B6GvAnkff1UXjRVxYF15rGxwYBwYFBX0J0saL9TmHJ8muXsb?=
 =?us-ascii?Q?tZLsh+gkn5t9fNUshtTX8jhbP2zT1CM7Qs6Y2YMNTYqzg6Fzlx3/Jugsb83Z?=
 =?us-ascii?Q?VMP3uCmR0QXMx6Wec3BD9MYRE2EG7D6RidLMEn911LhAZwaX6S4LPzdceQVc?=
 =?us-ascii?Q?j6UpSr3MxOzIGBn4qwJC+odWI00UNJngRdMzDerdRp4LqxBzFrETmyMQUXR2?=
 =?us-ascii?Q?Uy+L12XyJywOZSIt8QpaC9gq1T12EivwuVk5YARsP6gjYi9vZFUNYsV55g5V?=
 =?us-ascii?Q?SlL85DVx9SneTtkj85LZWDA9/QAg856rMmFH0wC03PSP5b7UzAVf8VNCzgHF?=
 =?us-ascii?Q?Wpl5gngCWoYZqK7Xl7Pj5x5f0iRnxJHVEkpohZu59xQjKJNtzB+XHZCTRf2d?=
 =?us-ascii?Q?iJrpR/LV5WKia0kJMqRle7f4AWzjaxMmD3a+oEmCKJ3hx2xiUgE0aSa9nxbu?=
 =?us-ascii?Q?hzTO5CuRMc5qfEEX5KzKSoLJL+vfF01fPyS9WiiD4e9CoG1WQcc2WV6R5Z68?=
 =?us-ascii?Q?CLs0yJjGyVPiyZeDQjBF1XpwFtgnCCgWxCND/L5tNxCfNzgcprAilQCgSN83?=
 =?us-ascii?Q?VNYSW4C6nJnyKx/V9B1m8z5xtcbbhDRuzh1HYSTP2/0bCCEN7fHp/TtPvehT?=
 =?us-ascii?Q?47gQf0DsREEVDu8XuU2wp/RP5ODRLGca2xKwnI4B0d4jXUdEPN1ReA67fu8E?=
 =?us-ascii?Q?6XPg7nR07H2peI6yhVCN2z4TH3P+BlWEZIfo/eOV5PZ7zQVTcOovJ+tpvhRf?=
 =?us-ascii?Q?GQUOIzB+591434FePHX/ersmnpnA9FgEDTaAYbIyDWvs0O1MHmEF2uqozDn4?=
 =?us-ascii?Q?seWZ7pIy+eE3T19a0Y8dfO/97quQwt8N2TgRWFMp51tj5glFddKTKumr1LbF?=
 =?us-ascii?Q?tVx1Pv4NZkH+W/qcOUSSDPcjY5JEEr1CtFHBqw+j7Ox1yHDLiqZc5wWHmJNR?=
 =?us-ascii?Q?fEECTCnKZy16Ymu6+YMGIyJZW3kSPtXbQf26HwE+KXyCQQiSxn8hS3ibyEbf?=
 =?us-ascii?Q?FsYxRyrDO2z4XGjmluT3vyQ9sTDMVkxgFYje5UWBHM5kOrqApzbxMiM2gGnt?=
 =?us-ascii?Q?j5AgkuJ6/dRfdd5yH0/QQ7eG4wI55snjCm5zjq0xbvZ+QTK+JbXNCvZQ0s0z?=
 =?us-ascii?Q?Mh28GRaoSY2Cn8lJEw1Z3ascBV1/bqMpSgIX+AK9njhKzAQ+1JACOaeW/Qx0?=
 =?us-ascii?Q?y3Nk2WieDJGn09Uyxc+R6FXnn29SKDGeDh+7NvhzuqUo8Ss5zkU/BFclMwnf?=
 =?us-ascii?Q?U44nrQpxmcfMQ4cNrRDzyP3U0/5t8APueOu2/NtrVLwYT7axFlfKaQAKcaR+?=
 =?us-ascii?Q?/PnUnlibUkQCUwQcJm37z2Vb9T76OjjF52Y29PtcqVob/x560odafYdKodyo?=
 =?us-ascii?Q?aJdCcWZ1SdDVsx37pgbMonlWf2DsFJLFSY91UP6Niz4rGI7V/HCb4aBSehtk?=
 =?us-ascii?Q?dqPTijNop/+TH0WSmFiQBq2W+f2QnTFO9YTTDI//LAPHstGtFiMEJBX0+0nY?=
 =?us-ascii?Q?V1ik24p1XQBUrNkjbXDSt8Et9DrWVHcpGzUY05c6lcZbte7EbDrel6Cq8H5X?=
 =?us-ascii?Q?gw=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4fc241a-84b0-4e6b-b8f4-08dde9ec5199
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 06:45:34.9949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zpjgrx7KwQa+z2K0lpFHXmlXfCSX1e9s0Cx/NxTkPTkaGsQmNUKl6Fg092ppMFkAjR/WXyvfwzMFt99vG/i5lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8149
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Sep 2025 06:45:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17919

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

The patch series rework and simplify the git submodule fetcher. It moves
the properties of the git submodules into the URL and uses a single
private fetch object for all git submodule URLs. The series minimizes
the line numbers of the individual fetch methods and moves the git
submodules details into the parse function. At the end all methods of
the gitsm fetcher class call the corresponding methods of the git
fetcher and the private fetcher object. Only the unpack method contains
git submodule specific code.

The series is a preparation and motivation for the support of implicit
URLs inside the fetcher. The follow up series will remove most methods
inside the gitsm fetcher and only leaves the parsing of the git
submodules and the unpack functionality. Additionally, it allows the
gitsm fetcher to use the premirror only. The current implementation
leads to problems because the download of the git modules is triggered
via the download method with is called deeply inside the fetcher code.


Stefan Herbrechtsmeier (15):
  tests: fetch: add test case for local paths
  fetch2: support URL rev paramter for named URLs together with default
  fetch2: git: replace destdir variable with function
  fetch2: gitsm: remove dead code
  fetch2: gitsm: remove redundant set value
  fetch2: gitsm: remove needless SRCREV_FORMAT override
  fetch2: gitsm: use rev URL parameter instead of SRCREV variable
  fetch2: gitsm: remove duplicate code
  fetch2: gitsm: use subdir parameter for submodule
  fetch2: gitsm: add parentdir parameter
  fetch2: gitsm: handle submodules inside submodule unpack
  fetch2: gitsm: remove redundant check
  fetch2: gitsm: remove useless need_update check
  fetch2: gitsm: use TemporaryDirectory instead of mkdtemp
  fetch2: gitsm: remove indirection and nesting

 lib/bb/fetch2/__init__.py |   7 +-
 lib/bb/fetch2/git.py      |  25 +++---
 lib/bb/fetch2/gitannex.py |  10 ++-
 lib/bb/fetch2/gitsm.py    | 166 +++++++++++++-------------------------
 lib/bb/tests/fetch.py     |  21 +++++
 5 files changed, 105 insertions(+), 124 deletions(-)

--=20
2.39.5


