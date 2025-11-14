Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EB5CDE00A
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 06:02:37 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11950.1763100155910567611
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Nov 2025 22:02:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=VEoPmwa6;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=3413a291a4=qi.chen@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AE4Qjj41883245
	for <bitbake-devel@lists.openembedded.org>; Thu, 13 Nov 2025 22:02:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=UkVu+UTUM
	gFtHQTjZtIuulH2ps36tSUCaQdjMWgsuNQ=; b=VEoPmwa6KRck6vZMYKcd5UNtC
	mMNrV9g/RlRUUbC+NL36gmMjY8Dhzz43w3GN7ouQ8CQdgutbJozpTaZ1V8tzJve2
	S/siOSK/IMmBuvD7UHxx6Jcm4NFfDn70MV2lFAal1paFK7uLVCoE0WhCDfYZTHgL
	AOVshTayEaJ3qMG9MkYvOJ8vqaXWcwjpQBRHjd+oj2nHA31upS1g2drmQJ/3PHQQ
	XGrHxu4O3T3Wu7aCPgNDihH1MgF80BU25+ouZYr+3GuM9Tr9jHRPu/nVW/57JjQT
	XnxI1eN5ECNPmTFrauZ7VvRlvEWMyhdw7m24AssyRUN7OP1fGpGY6HCUtwI4w==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012061.outbound.protection.outlook.com [40.107.209.61])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4adtk6r64b-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 22:02:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hr1jJfNlaRODsPztkcOK7KgW3ZQDEP/GACzg5sDPdbfmOEDsZKVf1sM56FO1nrVZN+BFtqSSm25cRqQEZIX3bU8ti8TmRFfZ/6MSHWoHNtc3Ojf920gOg/B21Zl2oqp0GPZVAR76c07/FkV5OYaz/dVjg0uCtxAJnUT/HT0W/lvpRzCFZFdres/ktJoGyf+BfxdW94Bbv/GCpLjnbkB8X27qgr5xsNGux5azqSluRYKfqC/jwj1VDucSzyUySY1sLs61FBnRCCa2coJgxto1biuteUpWY3C1kzt0UHIMFzhd1DgbhYvjly+4TYE80A7H6My4UNnYrYA0uF7J7aFkEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UkVu+UTUMgFtHQTjZtIuulH2ps36tSUCaQdjMWgsuNQ=;
 b=dhrs1q2WxoxUKbJTWNktVh9qnQRtm9GQC2lv8lSoAWia+kG0U94vZWl512wM4KJxMSiOsMt4VFv8sCMzKLzoq78liDTi+9Ae9FRIQB3xU5z9ESkBx2gEeiKLOCZNuOgyRB/A/IUh/N3CvcuGbDrWN0JzGbWEe/uZeTF/wBIv//Kc1DGKXjmuCyr+E4+Vfq6FcfLP4cKFp//0h5Sp2PREQNZN5n/GVlylW5keQjMdTmMxV9LzFGKNyHJBQ8qbGVRabtpH60Yz0bPGwb6HSTiNL0eiCZB329Bjaym1RtVnaqOqRmn2h33a2vxDwxYX/8mbDTF6Fcps3l1sx5v8TPnjXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by IA1PR11MB6266.namprd11.prod.outlook.com (2603:10b6:208:3e6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 06:02:32 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 06:02:32 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org
Cc: alex.kanavin@gmail.com, richard.purdie@linuxfoundation.org,
        qi.chen@windriver.com
Subject: [bitbake-devel][PATCH V2] lib/bb/parse/ast.py: error out for internal fragment in case of a previous value
Date: Fri, 14 Nov 2025 14:02:11 +0800
Message-Id: <20251114060211.1742728-1-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0212.apcprd04.prod.outlook.com
 (2603:1096:4:187::8) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|IA1PR11MB6266:EE_
X-MS-Office365-Filtering-Correlation-Id: 35d1e98b-e2c6-4e9a-28ae-08de23436651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?sG+ExSyovD9MbfT+5H+5vv/UDRS4KwNpe8ZA/GRRHDhpXdUl3wVrRzNG4Bp9?=
 =?us-ascii?Q?BAIpxeYLRREI7PbngLBQ/yp12RuPXLOkzyGZwTJ2e2d9334mVxu4ANQSSMDO?=
 =?us-ascii?Q?5VWHjrgEeurGx/kVoDvVCCTPYv1Qc9OXQLM3y+rHxVrol5ttnAK1TFRYn42y?=
 =?us-ascii?Q?0IqxlPIni/aVOBeyQSvgcWG1yS+nz4RGPKAwD57bciI/O1n7FwlotyKo5Zoy?=
 =?us-ascii?Q?QRkbn0MBownsjGhl6H00svPjh5+MSNlOqCswk39S33SJQUQy2PUDQ3tAqYo8?=
 =?us-ascii?Q?TSZe1x+DW/uVbLe6tsifHxodfakpQTL/ZNcBOxzBCf13a9t6t2FR7cuy9Cko?=
 =?us-ascii?Q?EpaqwscbNp7odqkgXXzOFuGDaSAsiMuH0ZokNmyRFSNolFHgiWh6M//GDhOT?=
 =?us-ascii?Q?x/jiKBl2Oe4VDbNDuuhEUkb11AW7UOcUNMWRJCnihggxB6uCffojOCm6vled?=
 =?us-ascii?Q?vxfwqbg/W5gluSYrp/HG38WV8+UwVCi2uR29kDExOrkFEErDVnTpNgAG1YXx?=
 =?us-ascii?Q?/xuFcI+YLKEgtG75ilTooTjK8lTCx7DwuxHoW0xnBdyk5ijZYZZikp87JKqc?=
 =?us-ascii?Q?E62cCYu1IE952qobqdAe9D1q8EBYFze9crssHwC/doO1qfWbdXWL4vwwDWxN?=
 =?us-ascii?Q?kT+XaSrOJWKubgDufuTWQ5/loW+ZNfGyuG7EfQvCUEUKbNzv7ZKfgaQwSNfF?=
 =?us-ascii?Q?DpI/e5tCGMtmepi42WH2G9uaxajOEu8unvJl+h5DfskIBmj/cD6UDSEXFhVX?=
 =?us-ascii?Q?ErVOL1hW2kksnrx4B0Jrjj4UJiJlmQTS8pOdwnjnOviD5kbMzN1J663TvHid?=
 =?us-ascii?Q?IeFdBE8uanMsscHvsQb5NV3LFjRGVODDEV7Xz3Rx1AU9wz82vHgivEXVoAIp?=
 =?us-ascii?Q?QLvB3X3JmrRHKycTNTVlCK/Y5f76pGLAyOjgt9N6O9m+3NYoA+a03UNpRCv9?=
 =?us-ascii?Q?mYOn6qbAhEwNGtro1mQ/Iidbg5vn6Zt6l5PZ4gzPA/s4bty02nVcLmIHc+/J?=
 =?us-ascii?Q?Xj+fzKWGpt67KWcSJ4/VIuGvs0pjMNgJt7dbIVFbyNTOOs+XSIoX1uFi4yzx?=
 =?us-ascii?Q?Q2Vm9ElffK/h4+jOW02Al29g3Zg3BL3PEXh/SEkweOCqPOtGceSPzjSdgCTI?=
 =?us-ascii?Q?nIKQ+eEplUi/2kKuZ4WPsSoXQqI4npdsRuNIgH3AUYLuiC9tpjplYcSwfcYp?=
 =?us-ascii?Q?hIEWgKxh+KdrVppNZ08j09t1rjuJcY4EWSUcTT8J9eWBnyrlKU93fPuDBUrY?=
 =?us-ascii?Q?gxWlQsNpUnICYEhLtsu/I17Ks2gytLUgT4Ez+Bi1vCHgVwtnk0bzQiBWYST9?=
 =?us-ascii?Q?tsqE+khbLtDFJOxVNLMG/ogrfw+So/uHWPCOw7C0fVfkpM9yCFEPFkYwxZk/?=
 =?us-ascii?Q?kb1SOd79jYgf5pBsn04WzITIdmlCBri5wPvca2vAmBq8jRmprYQd/MbHxHJ3?=
 =?us-ascii?Q?JgFsNw9Gr68VmsHMqhnSkPrKsaeJR4T0LfwyTCQy0u6/hxYK0hEuQ/JAhlpm?=
 =?us-ascii?Q?QkwUUqvbr2wW7ar7n1/tPbnnkCENRxGjDr0v?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?SFVOUVskOdDth48G21YDRDMPy5eIkmWxDU81PQJbbC4qJ2TGrbS6mSXQ946x?=
 =?us-ascii?Q?x72xVujUtY0IxhH9ClenZThQe8Gkh/EQesrcsxmmuGU1AX4svtUYy8J9g7Vv?=
 =?us-ascii?Q?KEN5maGpQVxMGpDmwWaOCtOxmS4KzwOK6u8dHQq18g61xcXAjMjIcYtu7123?=
 =?us-ascii?Q?w7T2S1BnQgs8rNZVAtv3nYnykfO6gDuGyL4mn61BnkZM5MgJJObaG5AGbQQF?=
 =?us-ascii?Q?5DqS2RxZ0Z+E210CoL9aqy/hySNUAAyagnXdsYHe3aZRe0YTMLRTgzkHUVSU?=
 =?us-ascii?Q?+APueAJM+x6fjNd+wBBLImEW/G7V2YsI090+JHQiQ/QgqQP+BqqtULiwur0Z?=
 =?us-ascii?Q?2P6dJ8vJ6XO4zpOx3nGVjBTk2vc7b/WjyN0oWWbrRW3SpXHcv2mkCUw97T7M?=
 =?us-ascii?Q?+ovLlJK1OKSHQytp8sSjqGS3dXNQoLJ6ZDQ9Z9LdjQawpBF2GuTuEaT5PW/j?=
 =?us-ascii?Q?bXfjLK4qpkjJ5t6zYnYMerG45Y3i23BdRIdpnGBbqeopdDOxclvjnAczumQk?=
 =?us-ascii?Q?sfMdfhh4zd0OvlwJOuYdVUyARkrGT3iRFEqp0vQOJb2l1Wb1rYlzqbWkTJlL?=
 =?us-ascii?Q?GRIqVcQc7DFctF8MMZwCFDpg+MdX+sYOBIRMNuQ6wkLgfVTmU2SPrFairHjQ?=
 =?us-ascii?Q?b7u2cuivpus0PTBLAicWyiUb5Ot+SenPos9aDXCycOEFbq0jaHNugsto/qX2?=
 =?us-ascii?Q?aKvf58W3YBc8F8g09/p+UkikqCJp9pn35DU+2Uyf5xAZT8GA3O/b9rg2Y6ho?=
 =?us-ascii?Q?c6fZEgv6REFxOV3lTtkaiLZMO8JSK7TXl79KY+AJo8QwNGYKxDC8KBpQ69B/?=
 =?us-ascii?Q?HGPkf2YQNca5QpnstEp/KqYU2L0bDPa3utekXcoKgE6K4jsX+e6uDjou0PY/?=
 =?us-ascii?Q?OmUKQBw+PN/0S4nqBltPFGxG/kB0V/ByaDVSQy42UMVqdj1JWKcnQ7krYqhq?=
 =?us-ascii?Q?i6LevUZjDF396W+DXUXHytnLkEEyA3+/dCuxCzIPsdSDac2dmN7dOxiSlsvf?=
 =?us-ascii?Q?jLb+5G/yyNjPKixtZSq6AesxbQFlsEJ+rGzefKxuW6H4gIQPs9V6B4wgSm/2?=
 =?us-ascii?Q?quGb3IIpe3VS4vNGwP8YK+0wPh2dIqHofKRnFVycjOHatw+DeaVBqigUBoed?=
 =?us-ascii?Q?asACHY82d75vtA/87THpGyEkoaW8wQh8m3q5CxCXdUXWUp++2F/nyTPg1vkQ?=
 =?us-ascii?Q?Ks4V+ZuxzZcEfIbG6fDD/N5zf0A610tWOSl7aTKz2zOiowOByAjJZ7iihQKS?=
 =?us-ascii?Q?8v1Rh1qLoQmK7OOd4U7u3rzAschQgjl4poVDVEcNqMUZYw4Ze6mEk9nUHXhg?=
 =?us-ascii?Q?q7Oexo29oZr0f7cDTKuDc9HAhbq6uA1EKgIHatNZM4vbrSEf1arUyOfEAcIr?=
 =?us-ascii?Q?qU7MI4OuJny9lcm/E2Ch8VORJbQ/QIC1hrGViauwDPtA7FBvhezYi/Juos37?=
 =?us-ascii?Q?05YCtqVyQwJvxf295qsTLK4CWBYxyPUFgmFpzsPqri0rtcXhFJJ51eA/XFqX?=
 =?us-ascii?Q?/qS3PpNzaGSA6mul0ylqCAF9/eF1bB6YZAGRVyJ2nBk6SSEpgXAY1aWrPrFd?=
 =?us-ascii?Q?sTeDSVkorefDNWM/GCs9C1/YiYRhzRfOhcMgYgtZ?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d1e98b-e2c6-4e9a-28ae-08de23436651
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 06:02:32.1652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ehqCuY4ZOXTzBg/VxyeSWrcOwJkn7L/ifSVDUpFOZknuTPxqtF3zVXcmsE2tFhajL1JKcmvs1mXqiiNUpgqMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6266
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDA0NSBTYWx0ZWRfX38DMlvAj6UHF
 AXo6nV7nrkTBcth0BwD5veVxP3PZmu80ARxktfRrFbijYOMGeC83xwLSseWKBrivkdI3LF++fbK
 N+lC4ODOMuq4DF0oBHTyjLxm1d0I0pLoiDFnCVTubkgH/LaPilVkhj7ksWybtPUnX6vZPPMBNkx
 wYZ0JeYk9HfS7/b/kZJ/9UczW7o+1QjOdbtR2/wLUOVv2nRDFlnQ4MU0DDDnfGaePYx4quGm2J0
 n8bc7mA/e2pGNiZGZHUdvagMPpIgWHTGNcP5FUARtLNV8Wvuzyvq99aZSdvgG98kBkSwBwTU66H
 4gVroAthjvWRtDuKuCFakPMFc2MmH1/49yYGeKP26+l5zNEw4MqOGZyg5E81a1B5qkGh/njfL2+
 7djMixBvVf0e39IyNSE1lSKs3rCkPw==
X-Proofpoint-GUID: 1WXUeiyXWK_4td_tOLwZO5Ix3ElsZ-1Z
X-Proofpoint-ORIG-GUID: PmsTxNWDW1MeSXYiSNeB1g4J2_MDVAw-
X-Authority-Analysis: v=2.4 cv=YsQChoYX c=1 sm=1 tr=0 ts=6916c5fb cx=c_pps
 a=RA+XJ41QLaSqwPGKFjpXOA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=HvlrrJGs30CXpD3u:21 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=t7CeM3EgAAAA:8 a=vvUlqzJSIlC8BXIo5LwA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_01,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511140045
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 06:02:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18381

From: Chen Qi <Qi.Chen@windriver.com>

When an internal fragment is enabled, and there's already a value
for the corresponding variable, we should error out to avoid any
confusion.

For example, when 'machine/qemux86-64' fragement is enabled, and
we get some "MACHINE = xxx" in local.conf or env, we should error
out and recomment users to use 'bitbake-config-build disable-fragment'.

We should be tolerating weak assignments. For example, DISTRO defaults
to "nodistro", and when 'distro/poky" fragment is enabled, there should
be no confusion.

The implementation hacks the environment variable as a way to tell
bitbake that we're using 'bitbake-config-build'. Because we recommend
users to use bitbake-config-build, then it should not error out.

Fixes [YOCTO #16060]

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 bin/bitbake-layers  | 3 +++
 lib/bb/parse/ast.py | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index 341ecbcd9..c4569c6c3 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -64,6 +64,9 @@ def main():
         if global_args.force > 1:
             bbpaths = []
         else:
+            if toolname == "bitbake-config-build":
+                os.environ["BB_ENV_PASSTHROUGH_ADDITIONS"] = os.getenv("BB_ENV_PASSTHROUGH_ADDITIONS") + " _BB_INTERNAL_RUN_BITBAKE_CONFIG_BUILD_"
+                os.environ["_BB_INTERNAL_RUN_BITBAKE_CONFIG_BUILD_"] = "1"
             tinfoil.prepare(True)
             bbpaths = tinfoil.config_data.getVar('BBPATH').split(':')
 
diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index e6ff1ff76..70a2a37a6 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -364,6 +364,13 @@ class AddFragmentsNode(AstNode):
         def check_and_set_builtin_fragment(fragment, data, builtin_fragments):
             prefix, value = fragment.split('/', 1)
             if prefix in builtin_fragments.keys():
+                if data.getVar(builtin_fragments[prefix], noweakdefault=True) != None:
+                    if not os.getenv("_BB_INTERNAL_RUN_BITBAKE_CONFIG_BUILD_"):
+                        bb.fatal(
+                            ("A builtin fragment '%s' is used while %s has already got an assignment.\n"
+                             "Please either disable the fragment or remove the value assignment.\n"
+                             "To disable the fragment, use 'bitbake-config-build disable-fragment %s'."
+                             ) % (fragment, builtin_fragments[prefix], fragment))
                 fragment_history = data.varhistory.variable(self.fragments_variable)
                 loginfo={}
                 for fh in fragment_history[::-1]:
-- 
2.34.1


