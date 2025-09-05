Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C06CA101F
	for <webhook@archiver.kernel.org>; Fri,  5 Sep 2025 06:44:44 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.128])
 by mx.groups.io with SMTP id smtpd.web10.15210.1757054683279460090
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Sep 2025 23:44:43 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=tjKch5Zw;
 spf=pass (domain: weidmueller.com, ip: 52.101.84.128, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KhtBaEW7oRmzeeqGzpOzBi6uRTgZq0/qs5o+eK8alAAYOo0pQCoeRjpTb/1rq3oBx4azpd/tG53sbiLQQVqBW0ThqB5HxzbKKnYUStL11wQUx4EnGcCJQal7pttAhwGtpI63QQCwCltWXBNlykgxjHokFvdCw9zzyHjrd07dx9KDZkEfHZEzScI92CmRqgaFmUrwLTYNYAG7XhBPQ0FyZlfTkamFCDdqBoZYLQ7FAyMMTEu2jLqDbhMDYgTGMXNMCq6+lNlOeWRDWfCLeCTobuXwdbAdD9sAu8Ct80HFZVSOvuECQgxdkf0oOKOyouidBZtRV9HYf/NhLEEAIRMB+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NSPo6hQdN+hm1+2iyN6eq761mRYodVFvXrXmD1KgGA=;
 b=PnxKZoC+c/Z3eaiRx6kF9D8Abpz0R9ITO3nfDHCmBtHEct8C8oDr5lUSiXlUnHdWBzgZd6KN/QjcaOa6oVIB/iJIleZX3uZRG4gqTD9Bb/379wP3prduiQTOQZ/AsT7iEpr9VtC8k3FFofn9k8zfgc7L0hdlO+lU0aHJfn4no9VphS8ROPXsH7NJVijfhht7i8H5LDkscm9wNeAAqAi60sx4Nu9Zv204jOMReeMJqfBC9i3xWEeBeGeCzr2fHgDXjYAa+pO3IwBlHsuJvsB++wSUorFjfoNkW2QuXjV5WsSoLd7FP9MzUBp32jXtgePDtZNI12d0lmDlzhXjwQrjJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NSPo6hQdN+hm1+2iyN6eq761mRYodVFvXrXmD1KgGA=;
 b=tjKch5ZwmYx8bnXOD9V5n2Q8chXoNOS0gwyt27FmgaG9moGc/aeLdjGcTyQ3aZM/8xBxEdhW9AC4L4x34efCKuqJmO3PIJorIWwoLAMbciW+olH9MSu+DKKghBAqbFr4qJEQK5LssoRp2bQA1r2AvbzVLuZXAxzIW8SXQ8DAeW6elapLfCQR31/j34BNl+PmaSjenyehr69jTLu9mnucUeEhesiUpU95PlWFiS1qwBBphBsE2dLVajKbSrEWCl0/ZW0cGwJLtP3aUf2/xmvNl9k37uOuqrdQs/nhfUH5j+wL2FJpmyNnEvitUeT7nfdMXseMrTRqinmzvqFlXnvQ1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by PAWPR08MB9688.eurprd08.prod.outlook.com (2603:10a6:102:2ea::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Fri, 5 Sep
 2025 06:44:36 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%4]) with mapi id 15.20.9073.026; Fri, 5 Sep 2025
 06:44:34 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH v2 0/7] fetch2: add support for implicit urls
Date: Fri,  5 Sep 2025 08:44:12 +0200
Message-ID: <20250905064419.2589111-1-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0167.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::8) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|PAWPR08MB9688:EE_
X-MS-Office365-Filtering-Correlation-Id: 77fa08d2-b552-4978-bd1f-08ddec47acd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?eAgk9YaqH6wtJNxvc5klEmJ6q2S+SgJNrkb1sJVzSqSWz59Rv1vCCm+aFZXd?=
 =?us-ascii?Q?WgyPRQAGm8n7qu/YD62JJsGNIulyjq96Q9RNjGqN3ht+Y45M27jP+kAvnMOs?=
 =?us-ascii?Q?1Wuql+bWt9PRMS02LOcxBjAp2RZWdaA9EjkOUcO/H5wzFBxozDDxpB7rql8S?=
 =?us-ascii?Q?d1zqkXRm65bAjiV9uljHPWF76y7t3+7cn0NGppDVCH3oRgYDVrUNlcJi47U5?=
 =?us-ascii?Q?XrYf6GjZNAOE64OaOBSOsPyzm/BaTcDBO2d60/MAR4YdVekNvsUUzcp/BshQ?=
 =?us-ascii?Q?AxkZ42n57BpBaZFdq0l2xgnZZySMEOxaFLsY7PDrEb5q2EfG3ftxlolc/RAB?=
 =?us-ascii?Q?EKxgvLeEm3VvpiFwKcn88XUjXrXhNiOmDkj/u01nqZRxNhIVs3EvFQMCUs8k?=
 =?us-ascii?Q?w+KDnEx1VyR6TaWMNABMFXDRMr75uknnoHUc6jGno5SupVzq1cWflC966A2C?=
 =?us-ascii?Q?Iy37XQHoQXpA9e71IZwt7pPd2Hd/Uwgtpshjuoqs+CviVAs1IetAud1eFuDU?=
 =?us-ascii?Q?pmzFnEgjtD2oc7b0b7OyDW2Du7QZxYIbw8kMsKM+BHj0IpvPGZLuIJuNJeyF?=
 =?us-ascii?Q?bFtVIFHHr3bCfgB2YzQJdu9x3FvHlworWo+ONmayyHvDkOxsow8Vsa/J4e3C?=
 =?us-ascii?Q?O1eIVTHY4xzvJ17mtqXMGyrQvfUUGW3dh5vuFAaD7Ux0leJNiCFMlvKn2vmN?=
 =?us-ascii?Q?pXfgLAG7AWeBqaJvf7qIqqVjsIeL3cO9wT0qJQSfMwEUgH14CL2qLwAk9hn7?=
 =?us-ascii?Q?g2LtdxDgJqDHIz6xHq1crjPRKm9VdV7iQBEhQzfYir2y+0NXIGYU9dHrG1pU?=
 =?us-ascii?Q?2qr5vLmJ/D8pED6qLR5hfo6MWb/wYUxzNV5GU4amKdK365NRSqrCU4jCF1j9?=
 =?us-ascii?Q?ly7ljwGLJM1sYg+gr7rHDWI9nh8SEA44aQ1ZVVIUFQUreapGbsA6crveZCXu?=
 =?us-ascii?Q?fVMHNjN8893UI80ioVSFd0DtvJaNzm+GO5qyOF8x0brqf4Fv/8Lh4q0bPC8k?=
 =?us-ascii?Q?DBuZyG3RG3JYLvRP1DnQgjsQr9rVIkjyZ2857lBkcYUw+L4oZzwNQ3ZdEA7/?=
 =?us-ascii?Q?+9Sj7ddivJGuAe/Wa6nNOIvpWfqd5FrZ7oWmmr8reyM5d0+tXVaxpa0zOugl?=
 =?us-ascii?Q?F/HKaQF2Jxn5wyub5ZoAFijsyMMrPyp2d8Xzeypr5aQzO/kTsJ8N31XIQhqs?=
 =?us-ascii?Q?X7KhlvfsWQJK+87luzxB1uG9OEKYNBOJPtHo3u8/WNSifX/aSF2m+2PGLboL?=
 =?us-ascii?Q?lrjb6RiM/u9vNNWOeJhuJ4awSmcDiPEWHb8NIrKKyUJz+KcsUr/iRyE+1N/h?=
 =?us-ascii?Q?v9gOGjF8FU0QUWwSbB7nstKo5IIZvT0aLQBQoN0NIDmEH2DovxoK1UQnjxts?=
 =?us-ascii?Q?B7QHzJo4nSwPcRhcZlPh8rt+JuZcytmvCz6rQ2EpLhJPMKuQtNulOME1rWx+?=
 =?us-ascii?Q?ho5AYWrWSYN8oppCQWYHWlXPTxlHVxgFM/Kpg6lx0hywOhdIeq03OA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?29kV3Q0f75Wu85w34CZcQzruaTIvWrmOqwiA3AViW/ml0bo4oquORCn1ZZjQ?=
 =?us-ascii?Q?6yTBTb0HVE8oaV9Lx7UAoSvK/ACu8+FD/eeTyAol9VP7e3pUeK44Rm8w/q3C?=
 =?us-ascii?Q?SRmEMqWivvi3K8BcMuubdK80MwvH9qNIBqnriduOir7mVxmLU8afPTX9NTh0?=
 =?us-ascii?Q?nU5oEIvDs+AdQsowWeLH8pvaEzYrYGFSfVQq6T0MWu9bgrP6qrKODYzUX9sY?=
 =?us-ascii?Q?5WxC/C0z0qm15VtZ0NX2apsXGQy/pcvIRX/cDOICITKFXwO9N3B99G97if8t?=
 =?us-ascii?Q?M2zWjb2cm762veiZOsP88mvjI5c2MjmeRDRHcyChH3tEqqJQMcMf1F4ZvGVG?=
 =?us-ascii?Q?0f/HPW2eOB1idCx49VPKPI7cxdio2bge8aY0Zbon9R5iPxPvL8eIG4ffJXhf?=
 =?us-ascii?Q?Yka3jdQ7rimziq3zOLV9oOHozpvtWhb0bc21+2i7SjBs+1nyMGInjp14Q7Ju?=
 =?us-ascii?Q?vxQJvThJPxMnCFRGwT0fl9teNOiA1zApMo6TRiRQA6cYBjggedfeKCv6pkTa?=
 =?us-ascii?Q?hxhmxlKUSkMggcNpGhWgE8Dwd3vHBf8w14dEjPTrLLrLPuYd5StzLA3GwLnB?=
 =?us-ascii?Q?6CZ1gmuYXugsO4twjpFdO1/YK5ztJnEbQeDohSQxWBai9B8oHDvKhkLVhQog?=
 =?us-ascii?Q?gV4zRfzuCMRNLDcpJb+VY74ibZq60c8FxJ7Ps/2xZ+G9D1Wbwz7xvzeT5L1z?=
 =?us-ascii?Q?3It+cLKhkB4IEyPNdWd9Sv1lDUEptf7/OZ2RbdG15ZpSydEgPwrZbqT6RoA3?=
 =?us-ascii?Q?pfLdIW7+sXlRxUKfmQWbwN74/22bf31msD40Y652wUfT8JIveKjVzlzUvNZ9?=
 =?us-ascii?Q?InfirNkmEA1Fi5dEytEECkU6Qr0g9TNPOequddWbGkKES2ZW/w9Y4JWNFXC/?=
 =?us-ascii?Q?50Zq3ChsSvaup0ROOfzH68dFwPJ2S8gvjBNygFSwAMi71qtxPWcTTJB9BqID?=
 =?us-ascii?Q?mgFM0zJx4FhCI+IE1m+UfN1kLhEgn9u+rnl65cMCR4uFpfRAn27GeOEgp23W?=
 =?us-ascii?Q?lrhWQCczXNTuQoNbirwJp9LY+xHk9DsoStBABHHCYfkORXJZ6UPoj2ckyUgv?=
 =?us-ascii?Q?LBczuYu0YncLRRL6B09bDE2lwa1zr42R9unTE4NkyMKh7ijyXXxyBw5LA3iO?=
 =?us-ascii?Q?tYFu8SdWqLI/CA/PTcd8SBUQruYMHOJR//iEwJvp0/rLlnh2UjGJbYmkxZHS?=
 =?us-ascii?Q?0VrllEXEd/VoE7v64GIL9YIjm7VrRWpTJ6uKQlSqMLNgyYhARP7dB1J+mC7y?=
 =?us-ascii?Q?98n8qcqmc+mgzwnfLutMq7mwXcrrwtLw+4g0y2RVyBoN2BCQewe+WUW+svNU?=
 =?us-ascii?Q?Bo5baZmwigJbOSCIWoSoCB5VSy3g7/tb7niG1CSSFtnYxYOwYBsA4PTzeC8X?=
 =?us-ascii?Q?wrCW3tRFIDoxCEOrH2znMAlI16A6Dm9AMTcJHQNQijOc/FxUuhOzaWG223gA?=
 =?us-ascii?Q?PdYHglwtQ4TntkehZI/GCLqyDpfe6lGjanM2La13kREzdGIsOQ8MV5Tryo7Y?=
 =?us-ascii?Q?+IyPvrFZ/PM2DGf7AtQI5PQyfZ3YfbKqlDXIDINEu9ZAHAizhewiHviT2/g8?=
 =?us-ascii?Q?4ePZY8+hjRjuZaPr/AbE06Mgg9oZsHtk5BPWWwZRafToIbhOnn1RAHJU6fyu?=
 =?us-ascii?Q?KQ=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77fa08d2-b552-4978-bd1f-08ddec47acd7
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 06:44:34.6451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X+sRG0Bf7vnoQ36Wsw4IW3dEovRR1cWdwRXUo1wJbkScAPnN6DFaY//EV8gqhi24F0gafZVZOu8Ob6cy5Micag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9688
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Sep 2025 06:44:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17976

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

The patch series add support for implicit URLs inside the fetcher. The
implicit URLs could be defined inside a source like a version control
system (git submodule) or a lock file (package-lock.json, cargo.lock or
go.sum). The integration of implicit URLs beside explicit URLs
simplifies the fetcher classes and avoid bugs because of iterations
between the Fetch and FetchMethod classes.

The series remove most methods inside the gitsm fetcher and only leaves
the parsing of the git submodules and the unpack functionality. It
allows the gitsm fetcher to use the premirror only feature. The current
implementation leads to problems because the download of the git
submodules is triggered via the download method which is called deeply
inside the fetcher code.

Changes in v2:
- Move test case for gitsm local paths into FetcherLocalTest class
- Remove implicit urls from localpaths
- Add commit to test the expanded_urldata function
- Fix UnboundLocalError of urldata in expand_urldata function
- Remove implicit URLs from localpaths for backward compatibility

Stefan Herbrechtsmeier (7):
  tests: fetch: add test case for gitsm implicit local paths
  tests: fetch: add test cases for expanded_urldata
  fetch2: rename u to url in Fetch class
  fetch2: call functions within loops of Fetch class
  fetch2: add helper to get urldata in Fetch class
  fetch2: add support for implicit urls
  fetch2: gitsm: use implicit urls feature

 lib/bb/fetch2/__init__.py | 127 +++++++++++++++++++++++++++-----------
 lib/bb/fetch2/gitsm.py    |  46 ++------------
 lib/bb/tests/fetch.py     |  59 ++++++++++++++++++
 3 files changed, 154 insertions(+), 78 deletions(-)

--=20
2.39.5


