Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B60BC0219D
	for <webhook@archiver.kernel.org>; Fri,  7 Feb 2025 12:47:32 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.101])
 by mx.groups.io with SMTP id smtpd.web10.68438.1738932445099229225
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Feb 2025 04:47:26 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=W4YYi+Kd;
 spf=pass (domain: weidmueller.com, ip: 40.107.162.101, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ni7UwycAFOnm/AitBIajKY/a1ZtQHdFZWN4VG3ondoBmJqOvOOeA8hy8xhJzD3Gn2kueLn7191PfrLveJQd6RYWj5fXZ8rVrH8iHS12uGDWcigDY4yL7WQVqjBjVrK62+cg6zU9zCZI9QkMcAK/YNefL+/UaaCJTXov/Y8Zs71h2xw3MXaBGPBi5uR8JY1W+gsQherTB4yZfyFcglVuLZUBpiiw60bGmYuhF3fIfIQoZkUEkRhdtHHq09TYVrw1pHJA5INf/C4DH8yEOPZnplHsqnSjxSp9Jllyw6RbfTbY771sUoLnk07z/Bku3SunuErenS+0U6nbAT2byH9CMXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7UpTbXzEVX3ICLuHsgvcZJz98bCplkf+NZGS2XhO8s=;
 b=cI/bxE7y1Sz3KrW9EWTOiqepEUGSNIFDuRo++AhYW+4DiStDfw5p8PMKtPncZBhYH9qV3qMcWH+iR2kK3P/hTkBlobm1o7vNDOhlbeQImbuB6TmCjYaZ5moIPSI0m6oYeDj80gi0fA7BqQBP+t16iLvNqYGAVA2fGPi5EBRgsP7JAOAC08yROxWsIvXoEoAr4H8Shy5O7j62xQHo3CU+pjeGDwPBIXeiG2UcRtcwuhHReqOFwtWyKTZl1AThuQl52SPrfXumiDNLCvN//lmTPLGrchG2U1mrf2pdHQfcqNbSmL7j1HRo9He0IzVMSiTK8wJAGl1pZvIp/8fm/RV6Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7UpTbXzEVX3ICLuHsgvcZJz98bCplkf+NZGS2XhO8s=;
 b=W4YYi+KdCUDmnCK6S6/4SqvrMXy6c64Dsw9HkosV8Kt/tBLzHlQNUfRUHnzGPNmcM6VzSkiverP3DVa0adx/7fxCHfcw9w7BfAsk1bcRAkQFlXeup0gJy1FdiFi6JH4Wixz1xlssv14oZ0p+vE7RcMreLzZ8pcal2uTLaKR8Z9cAfbyJgfxRxlqQ0zPUqN5LuR6+jXKmXgHI7lhX1CjZon5x/ENVHM2qWM54ODXMHYmi4WQDTwaav+cFV2+TpSR2d9KwSTTPofcZjRJnSpoxq89+S4yzxDPhSJ5oowdH3ximJxv3g6BadlZmynAjlts65eSrSqTwv64fLxnocg1xVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by AS8PR08MB6390.eurprd08.prod.outlook.com (2603:10a6:20b:31b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 12:47:18 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8422.011; Fri, 7 Feb 2025
 12:47:18 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 10/13] fetch2: clearcase: remove double DL_DIR from localfile
Date: Fri,  7 Feb 2025 13:46:58 +0100
Message-ID: <20250207124701.14787-10-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250207124701.14787-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250207124701.14787-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::13) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|AS8PR08MB6390:EE_
X-MS-Office365-Filtering-Correlation-Id: 472d887d-cbe3-4a8d-4c39-08dd47758dc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?HFwuH03gha09FFY42xg2Q3EILv6cgfJjt2loWsppQt5bAmyptFbAEmypj4w3?=
 =?us-ascii?Q?kX8E2VnPg4aJsBIvjhVWAIpoSGqmdPVnI5etMO9zs6bZYW2LmT2OcbbMGuQn?=
 =?us-ascii?Q?QnZHzGDGxGF/JmU/cC5r9e32s3b67LQvixcWJ4tDWaMVvBd2aGHPXJy2009l?=
 =?us-ascii?Q?zLkVtW2goOyLiJNSDzz4LH9rO9g8hGK6M/bEsA0ZE/szoind950huWT8uaMK?=
 =?us-ascii?Q?wiPKzdRN3oWDO/thR+4tLs0bNmIbvFjFf76sGQxuEKEj3M22iVJO8avVqVOf?=
 =?us-ascii?Q?P+kNiBy4qGVdZHrU7zk9eBJPHIoFzQ5aC1OiEV0KgYoBxEG1jve7RWEFnr/1?=
 =?us-ascii?Q?kOOieDZNsWfrpGQvFSAcnYANddaOWnrTkZ/LqOEgY6xWedSUNWY8qjoHySmf?=
 =?us-ascii?Q?tJjC9R5KFD25pFUP8K+p3wRfPdjcYemG3Z/x+9rnL/Ji1QS50z37BtWmXsAZ?=
 =?us-ascii?Q?tcWlj9AZKorpiij5gYu3zwOI+IHSbfK2yjOeFJN63tcPAtWObm1PdCc6eyA9?=
 =?us-ascii?Q?FPTlNbtHprsF1tTAAd8i9eUCNINt55/C6Yqy7ZcC8PSP2nNl/sYmEt7tZeI7?=
 =?us-ascii?Q?+kYrHUSX6GGqCrFBEbuQFvIjLd+FmEkoxQ/pR4YGiAAShqsV0vMbRv1bsszn?=
 =?us-ascii?Q?U2LnNCWleH2eBGQ6Xy3ZvZVq7p5aW/dsHLPAj/P3I77R1+DjsXWt4dmhzJOn?=
 =?us-ascii?Q?Bniti3CyyOmEEUcZru/+rfHIYZtXRMTifCWFE2g/wZM8Rt38PXqsmWEnz23s?=
 =?us-ascii?Q?anbXQYbTG1a7WFuW8AWerkxfWZtcNBLPvBXeznHJDOO6FsUtjTfgAoYwlN10?=
 =?us-ascii?Q?q4lmujF3VVJTShiKPLOCPLqj/8J0m/R3c1C/bVma/Tm4tIx0B6gkdP+UdRJ8?=
 =?us-ascii?Q?T2jqoqkw6uNzVxunhVqFwq095UAKVTJQJqur/QLOyLeyiMK5+idGon+e5yFY?=
 =?us-ascii?Q?t2I3ZG3LRlvgQH/7Y+xf+WZAySQu38gQAPfuNSkh3DUSwYy2BLLdifD3U1f/?=
 =?us-ascii?Q?rpW/AJWCh9N27jr8f02iItL7p/YI7JNJ85AcnqsQL2OmI2EZ9Of8IIRs4HQN?=
 =?us-ascii?Q?RYlciUPyEjwQwproMbaM+bjHqckIbZL7SZW1SdSMi4xnffpedcnlwKGlsYVD?=
 =?us-ascii?Q?2kw+RPk5bOlKgJ1kUYnk5Pwwsi7jtk/hc8ropt+73t0w+QbZIRPOUbiL3itx?=
 =?us-ascii?Q?ciMDDhnFJSGq7KH49fn1DC3fpRPdCBFN5PO5GHFxjE7CaOBNpPXhC6qvFg+6?=
 =?us-ascii?Q?RPdtQ4lRsnRkQG4j+3aYkKG8kHNwHFSxVh02GBePGtuTPPXSrFFko+QgGnVn?=
 =?us-ascii?Q?eCUaYlkGV2ZURh06PaAqqs9oLrKDJ/Sl/XgQiBx4M2AUewJAzYoF2ku93cwd?=
 =?us-ascii?Q?BgI4xln7Z62heJkl9z92rLLNoft47P7JOuDqrUjQlMjkrv3yKYvOb8N1urOg?=
 =?us-ascii?Q?9ryM8bixAa/vfxF0M8EHPIgmnwbZJjrB?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?SrbADW5H/IDsJN2h67lYa4Mij6xA04IWQW1tlaZOzXYZa9pTtD48/0mLTvAD?=
 =?us-ascii?Q?HfwvOMqDBYAdtlOK6+oCp+744lwu3y6dLD4P/NmFQbZzxlsuGK8XRtd7E1fu?=
 =?us-ascii?Q?fhEJ0r0id9eUhAR3KPCOj0mHh2Nok3bYyFyMR189zkYJ4TNaZyBjnAqiFxht?=
 =?us-ascii?Q?kcVIanI3U5Z/70tue+/CdiWDcdprv+ANi+ZI9ltkrLLfUxGzPdXbhcog3O8u?=
 =?us-ascii?Q?YoqXG2SaHUVtO2D5n3vOG21H99uWns0zimtPI+jYPGqo12uvrTTRIwHoZT7I?=
 =?us-ascii?Q?/kn/URBbZn4qVRe8fjuHTeyDGEnozb4RHlTs/THSeyvnEoH2vnn32MpSYJxe?=
 =?us-ascii?Q?TL+pUT+65WLlcWmhuMX/ApraE+oW+QhNAjGEqTde2O/cbnFaUgzg9MViotMz?=
 =?us-ascii?Q?QClbS60DT16Bd3aPLy9sKHGy5cKJ/Xcc58olu0SCOaO/nsXhRRPfnCwpj+ih?=
 =?us-ascii?Q?pDuwQ8oUft9gQYxybnFGjUUfCv5rsZhcBhAVOTb5ULiZlTJFYSTZTMHhcbzc?=
 =?us-ascii?Q?UIh4X4BBxgMgqe0uJRDcQ45SwjavjWvtxZNxVi8g+B0wP2oLojbBaNu6qtjY?=
 =?us-ascii?Q?ryxtB8gfg+gEPHzGtiZYIVGIRI/TXgd/VHC3uwgTeL/WI0BwMLEliEfYg2gf?=
 =?us-ascii?Q?Mk6Fx7oZaKifisDWYj51UwhCEAnhEyvwV6PccC6gB4m4w5qo7WeOsMu5ZNDA?=
 =?us-ascii?Q?6sD0ie8O5uBV5n68yTuoLApiqKIClQgE4XVHCO9GcS8O5qTcAErcUU1TbIpR?=
 =?us-ascii?Q?Q45Wl5qhwMT7HsvxHmRWp8WP46f9nw2pDuja9XTYl39zQTh+27hZgP39nFBu?=
 =?us-ascii?Q?0HgdbayCHqHt2gXajLbfdazHDsQ0Mu/9WtgjSKvDeZuvpstuqGvA3YphZjSF?=
 =?us-ascii?Q?Xrk4zbrBW3eVyXwukgFlduAQIIZ9VHmhU18HNOIuPvON868wLU4MbYqKs3l2?=
 =?us-ascii?Q?6j8F+zE9+gUdPRZUscMoyHo/69gyp7ag4TJIc2pT/NGhG6h70cFArzCQJgSy?=
 =?us-ascii?Q?Maj3Yg9djWvpfUnHmtHlmcxQo+qXbf4SM++QtuoNTVTsSbcB/0+DDjzf+fIg?=
 =?us-ascii?Q?++bxdqHAO9NMaAqUL1xbMx3xK4BAH//FR3gO/Xvvsqjl9zM3j9/7pt0i9ObH?=
 =?us-ascii?Q?j8OrLKRS7UUFv8xhZVw228kk9gO2/lT76k/0DIAsu5cNJ2pCt0HPZ6w/tFov?=
 =?us-ascii?Q?zkGIyooj9dfoHJPddzYg1QXWQQmEaah3vSOhhg7RnheD/2y8rkM1gGHdNEmz?=
 =?us-ascii?Q?Ikb5po0pjO9+CRzqs+pmZ8PhnXCOecXSTZ2/rv3BBh1epbVIdbx7jljKh2OA?=
 =?us-ascii?Q?WoL9gKO3ojFufTKt/kvHu3kfBIYBStUKQlrRykcruVZ1OEiWPJaLXvMtMile?=
 =?us-ascii?Q?Vaj671bbmYde3eE+Vf8RLCURZmt4RC2xPgo+Hb1MAYA8/swde8uR20BrSFRA?=
 =?us-ascii?Q?+UzYdJKhihUjhNJX2PBImu7BVLY9cyBtiBEwfmHD3Rx0VrLDwTe/fLohgrup?=
 =?us-ascii?Q?OVTs5BviBIUr24P05hqTi0KskeJBKxk8aw3ehf54+sgRIxh2Aoy1ufdQjUBn?=
 =?us-ascii?Q?3F5VSNXqtu3LhLMJytTcKODfcO72czk7rvtJp447JjY7h0qcU6jcKo9xiRG3?=
 =?us-ascii?Q?Hg=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 472d887d-cbe3-4a8d-4c39-08dd47758dc0
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 12:47:17.3589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2dydNjrZVPms1+pXG8AKdvK1nYkoPbU9JwaYw1FVjTibBSM3zcedIksA+mrSl/YHcmaj8/IK+6WePKeEzymtBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6390
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Feb 2025 12:47:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17178

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/clearcase.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/bb/fetch2/clearcase.py b/lib/bb/fetch2/clearcase.py
index 2b3bd7069..17500daf9 100644
--- a/lib/bb/fetch2/clearcase.py
+++ b/lib/bb/fetch2/clearcase.py
@@ -130,8 +130,6 @@ class ClearCase(FetchMethod):
         self.debug("configspecfile  =3D %s" % ud.configspecfile)
         self.debug("localfile       =3D %s" % ud.localfile)
=20
-        ud.localfile =3D os.path.join(d.getVar("DL_DIR"), ud.localfile)
-
     def _build_ccase_command(self, ud, command):
         """
         Build up a commandline based on ud
--=20
2.39.5


