Return-Path: <john.ripple@keysight.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49577CDB470
	for <webhook@archiver.kernel.org>; Tue, 23 Jun 2026 19:17:46 +0000 (UTC)
Received: from mx0b-003cac01.pphosted.com (mx0b-003cac01.pphosted.com [205.220.173.93])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.29056.1782242265717339159
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 23 Jun 2026 12:17:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@keysight.com header.s=ppfeb2020 header.b=gxC+lmMk;
 dkim=pass header.i=@keysight.com header.s=selector1 header.b=tpPs5vou;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: keysight.com, ip: 205.220.173.93, mailfrom: john.ripple@keysight.com)
Received: from pps.filterd (m0187218.ppops.net [127.0.0.1])
	by mx0b-003cac01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NEKW0v748106
	for <bitbake-devel@lists.openembedded.org>; Tue, 23 Jun 2026 12:17:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=keysight.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=ppfeb2020; bh=tjCXLQXcfQ2GyncLmEelp3
	yOK4ydnnCTODj1JtHD4cU=; b=gxC+lmMkpQkH0/Kkrle1tuRH0ribJxuZRwjdIS
	PcXUEUqZXh2P8car6JHbD0kt1/0IEqa5mVkpIB9/egvKgFJY+v/PNqzsksDcX6NR
	5U08RI15RxdfoBaCkGVthh97Zj7i1M7pqW8ta7lYrp982QmSvLKRCBbD/FPYMC6n
	0SOi5zgGm55fC0QKdTn3vTtCi+GDgjI51CANKTZLNJhCQMVpXxvsZIpiHNER9o0b
	zquTUYXjNsd0wpflafPTBGVp1J0Utt/1EcQS/HUmkPSaAv0oxzq8Wu09KXjMx6wk
	NIpD0Imh8gJ63kzaftS/6YO5i+3Yd5FbBy0yfYfuWYNjvd4w==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012046.outbound.protection.outlook.com [40.107.200.46])
	by mx0b-003cac01.pphosted.com (PPS) with ESMTPS id 4eyqe4a020-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 23 Jun 2026 12:17:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vKJlFLMXlHduxjzaS8kJGmH1/JNYUCG77+LTCapDoM3meD2538ZODX+ic3QRIU3Rcui5vaRuH1H5mP1L1NOqmd9gG9QEhcGjOjYQqtGpMWRuepAHKPJARMvu1uf6qqQjPdcQv74v/c93iWzz0JQ8XnHuDq2nZAT2e0K1JdB9Ldy14tQIiT2Y5tkrnfS/SmPqBohPF+BG3uyR3GlQDncWbT0BSFP+/M1hjC0sgI+f28a1Qfcsw/FFET0wymjkYFpZu/fVaMHxmPSgzaBnfxPg+a4DNp/ZJbCrlI0Lj0WdtXuXULIB3FNTE+HSIsEaBiMIXD7OYAYMurkWqjgySqZiRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjCXLQXcfQ2GyncLmEelp3yOK4ydnnCTODj1JtHD4cU=;
 b=tfIIW3UPDf7j4NuNZt/oXjicWaT8Nzr6TV15z7cN/CRM33FrJXTWvUu2iWvQ0pW+B+StITYwcMs7nP9/2WyHzUOX/Dexr6zRlZyDgQ4ehVTCHDa25aD9R/57IdHzwTQJfkRZ+7JAmxWcadUONlTQArvPrSBcej2L56Pleg1For/Uy8p0KJ1M4/pybvpkELaofOFT/3gVhDlr1H0MaBeazVu+G5WNo7lFaYX0lXUOInEZ+QA7v7fvcxrYB4z2Go8quxfvb21bZLF7Reig13s0fFqPW5ibo1u53sjx0RfNJ3QNO2w3tILYJYha6A8Vk/r3VnCXYVeO2DrmkuRJcBjCXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=keysight.com; dmarc=pass action=none header.from=keysight.com;
 dkim=pass header.d=keysight.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=keysight.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjCXLQXcfQ2GyncLmEelp3yOK4ydnnCTODj1JtHD4cU=;
 b=tpPs5vou+016tAaG5Y6IR/fIimcwZgRJE3rdbcz/CSOTnjXXWRG2jP26kcwhPv5Lt+OBKv7PJjkj910l8CvFgMcmItDBgZazcAJOKPkPpnIR5WW7CvTxwB7m6s6GGGL+8Y/KBRb8slf6rYn6sjFaLPkn8B8H0KMb62pzagFq7GU=
Received: from PH7PR17MB6130.namprd17.prod.outlook.com (2603:10b6:510:1f5::17)
 by PH7PR17MB6177.namprd17.prod.outlook.com (2603:10b6:510:1f2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Tue, 23 Jun
 2026 19:17:40 +0000
Received: from PH7PR17MB6130.namprd17.prod.outlook.com
 ([fe80::7052:ef05:ccc9:d9c2]) by PH7PR17MB6130.namprd17.prod.outlook.com
 ([fe80::7052:ef05:ccc9:d9c2%3]) with mapi id 15.21.0159.012; Tue, 23 Jun 2026
 19:17:40 +0000
From: John Ripple <john.ripple@keysight.com>
To: bitbake-devel@lists.openembedded.org
Cc: John Ripple <john.ripple@keysight.com>
Subject: [bitbake][PATCH] npmsw.py: Handle local tarball before registry
Date: Tue, 23 Jun 2026 13:17:29 -0600
Message-ID: <20260623191729.761661-1-john.ripple@keysight.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:806:20::22) To PH7PR17MB6130.namprd17.prod.outlook.com
 (2603:10b6:510:1f5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR17MB6130:EE_|PH7PR17MB6177:EE_
X-MS-Office365-Filtering-Correlation-Id: 22655586-7aae-464e-a1c4-08ded15c17b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	HrZ41Vjzot1wl968bF79h+kEgymaDPksFzBFW5afCFo034w38EyAHH6VLDTnmIK9IY/O/RJo2Hfujb932A34q1Y/gaasbfLgVeqS63LD1pF5VJzZ+/DqIe9a+8whchFFIuEYejjgtMau12uc5PhEptLd23JkbMIgH4PgbixgCOatbHQxcWu3YjNimhpaXLY0fMFV4umeSDtlJUYnRTqmf5Hv+rMUZnNPh+O7I6zLNDuDyoBY6eQ0j+5yU/TbO8s2e/x5Beo1TxycJaQkqhnQSfyZmznh0zW7TyrS1TVuWQRcq6zu5b4P9jtE3p+wssbYsVQtRNS21566fZ18cNA6pyl0hJlXVneuoJPVQDljQTXbxK9sJLBYAAC+CLac6L2Z0PJEPjoY4RbBA0Ryg8gkv/3gsPAupZ24W02YRuwL+jADXFCF1+FPi7Gm70FW6msqJl57QmjG1+O+nnlIDTjlPiNCp+Iq0KgdCdgqe2qQLoXR0rfD0tA0Pj/c2aQGn6HU93S3+KCxupFqjMahIFTbqRVe3qcDosK8lDES0mujwVXChEhYQMfIp4Kspg8xb8pSZ26p9DbgeCjadKF7Ge03TwojwGq7MGnQIHx11jNYoymPpBMFZ6mP3CNe7m3v8s4mIzaNCDTJX+UlJKoW2yfKcyDFJnNXshmHotvvSg2b2p4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR17MB6130.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?lpRONeuqCzNeyxZP5WkEVBgQz8p4aMc8Ba7x34ljiZ0m9ptjj52ZQW4CUkXa?=
 =?us-ascii?Q?Ck6Lck3Ew7QkOS3s50m5bF/Ui5pd2NS4ms/7YcboQ6964lLEnv0ktbNPBtQe?=
 =?us-ascii?Q?uo9mW/+RVUQRSYxYJMKcx3+5Pqpf5QTR+7wys2t57hSqd7YAMq/i0alILECF?=
 =?us-ascii?Q?k2+LuW+phaim1TrDgjZYzlvzrdJeGaqtDHJntu/mjr9p87FsICjALdTeb1pF?=
 =?us-ascii?Q?c7yYM+xrMwXInjYP4L2MclCkALDv3SdRh5/XMrBZN1RAeck6RU64a5CUhi3w?=
 =?us-ascii?Q?Jq3wQFrghd8sufOc9uRwazGDro2Njc9dOHE2uhejTzyERPdUNBLwXhU5vfuG?=
 =?us-ascii?Q?aXpQrnU2uhCV43PiTEbTmdpys8w08S0fASzElIMS3ejakAHE1NJ/0tEsko/+?=
 =?us-ascii?Q?ySS5GLgnY2x4e8zsjCU66qgL6tjhcOMt3xGTEQ0tYwnAk/ftxpXacK1NcDzr?=
 =?us-ascii?Q?4TlwUOCbEm+Vx21XnuY4YwqSuNFKhTORGfddDcKVA2DK7mgXbBGECidGFwlO?=
 =?us-ascii?Q?nuMjdWmn/5CdeO2tB4RdUJWD8SbqZWn6bEAu9+77q5w9WGK+LqvO1lqbatOr?=
 =?us-ascii?Q?85WazlaGTnB8Sd1C9a+ILFY5DbCSfdw0uC6+SyI47fiCKoXkAE//Jxy9Arh6?=
 =?us-ascii?Q?LQt7IppKdFQrt70D4eWsMraXS8iGKbpvZA//KOmCLRnAOAB1qDNV6Vfoq9VJ?=
 =?us-ascii?Q?rBrx5LZSS6uGD0aGaHnovBiqzwzjw/x44cM3SyOUOeucamQtfTu/QQK3s0OB?=
 =?us-ascii?Q?vRqc1+d/6cWzjYu8Yj1+3Wl9dn3MwRFNdg3kvBtSBj2ikHE9pyyczy2Diyb0?=
 =?us-ascii?Q?uUhOaP1KnAnsBse8qu9utq/VXAL/hzPQrZdX1qDZxfg/RU7PjkGEx5RK3t8W?=
 =?us-ascii?Q?u6OOt3T1hgHOesnOIYnB/IUXh4+CSAh9JU1Ym4fwbzRZ+Ntzbf2prFb22P5e?=
 =?us-ascii?Q?LTOEkv0ym+T2QTjy0A4c3p6Sj0TMSwThEyxLRHzmhNY4eZD10wGSYAA81U9A?=
 =?us-ascii?Q?iStCOf2PKSJ9BpsRnKQrhS01Sdfc7ZPPYnrL/yX5jfVjvpRNpxJ/v2Q1/B+B?=
 =?us-ascii?Q?iPYtFDa3/W5Vu9FLaxUPhJ7RjLOh8knABsv9wPXm0JUnumOAL3ztouZx226i?=
 =?us-ascii?Q?U7VkvSAgaLX8GxjzeypUkOcZrK3DZ9dvYvGRRg/XBxknTTghvzvpp+CMQmpP?=
 =?us-ascii?Q?lledCms2k5nLMYztsINPfvu3qDSbM024mhlG6oqFM+0yy/3JCwPILs37vkD/?=
 =?us-ascii?Q?8MKxeYROMqIms8myPgrb57C3M/FOIPZpOTlKBGuMOeHXOUHX8ygzDXZDLtrX?=
 =?us-ascii?Q?zy6teamsQM8/zIXQxXICmT2BiFcyG0HQpj2uW3kF97jnZK3xdhy/gVR/h9Xs?=
 =?us-ascii?Q?FobM5gHzxlKVocuzIycxmIY54LQoxP+JVssYnWD0C2C/4K0vo1uB3Hhow/Q6?=
 =?us-ascii?Q?KLw3bE9olVlcEur05CB6V7j79iXxVAFWY0K4TWiawG0Mlf+iktWU0V496WTt?=
 =?us-ascii?Q?RXhjbD+uiWupVJIXFSg/gm5DOjtN24FLNUkD1LFuwB86/bVhJNQSY+dgsoYK?=
 =?us-ascii?Q?DrSp1UoEnLW6hebylFCbPbYfLoGXsCSHxoVDB3tslRMEIuHQkqn45BbF9iFS?=
 =?us-ascii?Q?DneYsCkSsXeLobufNzr0EXdIjC96i0jQUsuQjMHA2sQ3qo333d9lqby6V/u8?=
 =?us-ascii?Q?n9sj2uIFP6q32MbbAHIrD4FN1lH6MWSxzoo6VUsUGed15US4rK9zxJkh0loL?=
 =?us-ascii?Q?mCg5BxAidw=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	IIIGHQuhUDPjKU9Wt8CLreHjatKJWqGSAzXHeQ+lj1gKlqKmBjuT+TPMAMnurJPB8BKFKOif6uqFbBXmjmv5IvvlaRezAkMKhcA1AwewBSvNfp3dCzqSsFdh00v4Yn3o2xywbsIZaL4KGYYuMfxxxSWCNs1IeIYj4eOTBupRRHY1sNf596MWAqnpCiLzE8Y0lTu8TDKDwmzwvJgfV+OWltTmH1tDskd+pCF7rUyaJsK5ptsOOOF5RkDaMBW80z3NhsdfoPSyma7lufcA5mjHTBkWqJ2KLQ65zaqkVRKicGYC/mu3KjxYOTCBlastgQ4KOtC+DwqsM3vBx8EltcIIKQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	rrfeI0JWwUG9T65QxrWkbH4DMMo6iudSc2hp5XCNCncQ0zs5Kg6d6DR9+zzGWYelIoTeZ+secg7x9k3YBdpAKAQtz3ccE4dMh2y8Z1uR0YsOmGEB6eMP5h4nP01B8J1wL6ZB4giwkPRSm3NOo9z7bWUqc7VwM+lnka4153q+kuz9hrI1zvX4LBF3DzMRq651278spxpUsGle1Cmx/YOn19Z6uq6GgzJyifQC2K+aBV+kt3gxgCNDOsArOa6fSQKIx466dRoETxbm6OT+womJ9Roh4Ujs3ngucfDYpY/5Yzl+vMIY4dooBhU02OLMdZK3Dq7qWk7otU5d1Gj41p1RKwCbcD9LAUiT1iKTMD/lWmQwY3QPisPbFvTARsTneI0zfOMgfqMyaqGVqs/QeuNjOVYoxwZja5QMFkWagWlYzEcDvhqtAEzND+kpQipkcGu6zWtqLR2eJOJDmv2GXWsgLNpE5I0WwNGaa8K/hlHHVywwc4ehq8UUFuDBsCyR76f8RAcsA7C88lPvGwFCpPhtGEqLBFOwk39Rn4PC6jlG4TA3Farb5zsN6lBTPD6I7JVnS9rqZilVtQATcFO10xsg+BxVYmh/VYK99BrqOJxgJiK/mFmRFMw5p/u4w2BtyTFS
X-OriginatorOrg: keysight.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22655586-7aae-464e-a1c4-08ded15c17b3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR17MB6130.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 19:17:39.9966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 63545f27-3232-4d74-a44d-cdd457063402
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bQaRnKADW7NVeQowBYFWUrOFbcPL0V29KWzaepgfRDjli9w/24bwthAB/ed/5YPzLSeo8aFvy9EVdhcDGjAyG0fOz7YvdaJHunK++HYZk9k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR17MB6177
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE1OSBTYWx0ZWRfX/DdTz09X/25V
 oY7v7M4CtPCoKDdMxxFk+jVs3uOgX9mMl/HruhZiySEEm9IPngDso5behPRwJAg08/4QEaly6Qd
 J9e06RbEURzDy4cREXmIvfGFXJ7HBzgySH8wz+Mc1IpoYUsPEOQOW8lsTUBbLRbX8n6lk28zUsA
 Yc8rniqaGswmohNhxJZhlJqm4uOQ83l8KQ1qoVN8mAIDiMPJyb+mJ14hsf0li+qYscOgfGek8IW
 iPFCtNMv2TK9GdBHHTkv3rF/evoaywQMuVsur+OiH+klutzjbKf3WotO+lrLVa5rvdvemeCqjLC
 mnhqZPblT4pFZdL3Z+5OeHEMRVL2PcJpmghGVS3jollqD1RKwDzo7zXlp6qpsrZ/lqtgp3iXGjJ
 4J/1F2Wut15LYc3VfSddTW4TOYsn765XdLQQlO9KcH6fzZjD7lzyV4mIGkmAyrec7zewb+6tY/f
 3N83GXxKaWfYommOq3w==
X-Proofpoint-ORIG-GUID: 7W65WJOWhcaFjmyqMXMVXCjGPTPvUTih
X-Proofpoint-GUID: 7W65WJOWhcaFjmyqMXMVXCjGPTPvUTih
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE1OSBTYWx0ZWRfX1brU0kBQ90s9
 cN1V0V488zxibcQlA4k30ATrl1Ih2zi1MYy0e1cnPaJ9cPDdxM9/YfrDzmztX41EQ/s8ezUjFbS
 PQTF+qr99nVWTaPT/aUUm517qX/IPN6pO9zyamQxG3NuNXz5PtZg
X-Authority-Analysis: v=2.4 cv=dbGwG3Xe c=1 sm=1 tr=0 ts=6a3adbd8 cx=c_pps
 a=KNS8ES/6Vao0xGfhhZwSfQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10 a=vu2TTH8h0NUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=FLoIbiw2ZNY34kqd41oa:22 a=hWGxauOIDdI-otBKxhKL:22
 a=Q4-j1AaZAAAA:8 a=F6MVbVVLAAAA:8 a=wajhhanJwTMSkHoZ2NsA:9
 a=9H3Qd4_ONW2Ztcrla5EB:22 a=6mxfPxaA-CAxv1z-Kq-J:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11826
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230159
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 23 Jun 2026 19:17:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19765

The local tarball source must be checked before the registry sources
because a local package can have a semver version and integrity field
which would otherwise incorrectly match the registry sources branch
producing a file:// proxy URL whose local.py fetcher leaves
lockfile=None and eventually throws an error.

This patch was based on the npm and npmsw fetchers with the improved
security from Thomas Perrot's patches https://lists.openembedded.org/g/bitbake-devel/message/19705.

Signed-off-by: John Ripple <john.ripple@keysight.com>
---
 lib/bb/fetch2/npmsw.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/bb/fetch2/npmsw.py b/lib/bb/fetch2/npmsw.py
index f09ea5794..122af4582 100644
--- a/lib/bb/fetch2/npmsw.py
+++ b/lib/bb/fetch2/npmsw.py
@@ -93,6 +93,10 @@ class NpmShrinkWrap(FetchMethod):
             if link:
                 localpath = resolved
                 unpack = False
+            
+            # Handle local tarball sources
+            elif resolved and resolved.startswith("file"):
+                localpath = resolved[5:]
 
             # Handle registry sources
             elif version and is_semver(version) and integrity:
@@ -139,10 +143,6 @@ class NpmShrinkWrap(FetchMethod):
 
                 localpath = os.path.join(d.getVar("DL_DIR"), localfile)
 
-            # Handle local tarball sources
-            elif resolved.startswith("file"):
-                localpath = resolved[5:]
-
             # Handle git sources
             elif resolved.startswith("git"):
                 regex = re.compile(r"""

