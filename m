Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A353C021B8
	for <webhook@archiver.kernel.org>; Tue, 25 Feb 2025 06:49:29 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.2847.1740466159910199752
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Feb 2025 22:49:20 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=41510c6688=qi.chen@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P651WZ019708
	for <bitbake-devel@lists.openembedded.org>; Tue, 25 Feb 2025 06:49:19 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 44y5j8b81e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 25 Feb 2025 06:49:18 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x6KEByjdKS4BtN4Y5XF2LdEJdW/EimH72ckM23dxhsv4nof5v91DePAbqF9MqvGiAvnzr8OVl/1lKgqheGwQK/2vgOOAvJf1UJY55HU2270kaBzsBkIRJVkaUmlpUQulM8FMQyWEMSQBRrUduQ04J4/Eb0LyH2UYVyZIIOIWaWFkXd3XzSRvZwFgtjHwQ0Orcg0X5Ev3IQ3dLhH/jp78bNo7yTACQPzVpKjuVTWGp4VGCFe6azR/wQAgGZysvNsGm/xSyg2FWIfFGkUADSDxcYZB6frsqFeR3oT65UPmHtADvvnKDrR9PO34kdEgTQ2U1iHUy/15CZwmYgcsW+IH7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93LfKjqJXm+WXGaIUzldO/7ThlEZmVHyJPqISfh7z0o=;
 b=wMpdhlHh3ADDpFz4asKTMJCAQV2sgiNFPzDNxZSyjCoD7oysp1QzeVH13NxHvvOkf4fkUC4I1ni6yWJvcgWJqBhXiE+aZpVlTD26ZN/vkT2VPsBKDaENIHFaNZhIYZ/2MVj+Uo/Q/L1OfXn9YUvY7EJXWA/8T/LCyN0ZjIqE2vFokJ/WhIKwbTE54c9JJNLTwXmMgT+GedptW00bTogzF2uBMtdrZjWpYDSX9oqQTdMm/oqG/fiomOVTDrFfNZ/+F75ZHimf+hYKhWCAyw5ukcMAZBQ5JrjvDNuPglG1wOmEcBEA1ydPWuW9muy/aeiiCxUVgAQvi43YpXSLNJId/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com (2603:10b6:a03:3ab::12)
 by IA1PR11MB8829.namprd11.prod.outlook.com (2603:10b6:208:59b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 06:49:10 +0000
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::615c:ca2f:d093:16a9]) by SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::615c:ca2f:d093:16a9%5]) with mapi id 15.20.8489.018; Tue, 25 Feb 2025
 06:49:07 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake-devel][PATCH 1/4] data_smart.py: remove unnecessary ? from __expand_var_regexp__
Date: Mon, 24 Feb 2025 22:48:50 -0800
Message-Id: <20250225064853.2406575-1-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0113.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::28) To SJ0PR11MB5613.namprd11.prod.outlook.com
 (2603:10b6:a03:3ab::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5613:EE_|IA1PR11MB8829:EE_
X-MS-Office365-Filtering-Correlation-Id: cada3d9f-2990-4310-8aa5-08dd5568807a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?JIEEopRVSqjNRcayUzFtIlqQD8vBJS/U1HtIc9E0lDW4Z3VXcSQmef5GaHJQ?=
 =?us-ascii?Q?afG+tApG+zAk440/lFXUX/D8jb4n4cqbKhrBlio7amCHjzrWldl88//oiatr?=
 =?us-ascii?Q?kSyI5VNs86BJHk83rHJ3uMATcJJcEfyHam5vThzF1snjLY7tM+pAjASUKX+j?=
 =?us-ascii?Q?2aWFnJJPV3GeMH8i2QN9aQs6xdN7AWB2tStOVT5eqRJpa5DB6EbFVXk3yPY0?=
 =?us-ascii?Q?IjR03gZtQ8VJZc4Abyv4VCsUk6XhWFu5gH4DMp+dRn/8W9RpuZH2EwQVQ2Mi?=
 =?us-ascii?Q?2jPYKAu8/txSUeM7mm/FCNHu/kGbWYeV2XbfQ0hyuVR4vrMm31RaqIdiTG/E?=
 =?us-ascii?Q?Cu8bIGdcy/LXVLt4A02LxBLp8dKZceCavi4rLCKkbtBJkSqBmXgv9DeNVdZ5?=
 =?us-ascii?Q?IKIF1KsWwVAzaOIzqaaSIjDIymn1Pk5rG+8dOlFM6IlBYMg4tZQ/9asf+HKJ?=
 =?us-ascii?Q?mfezwgEr9YmToab362kiQxZAa594dUB4uahmPuYrTyfiQZglSjPo7VhxayfK?=
 =?us-ascii?Q?G96woc48E2DX0neTITOTH4Ydv7pJM0kT5Aw0Dl4cVim4m/3ZEJLoAO8OOHIF?=
 =?us-ascii?Q?n/V93AIeMhSjfrldGdgjOnYT7Ggy/g3TvHJ8UYrBjgLaTO3KwU+KsRv/2cMI?=
 =?us-ascii?Q?ya4T3wE2hbkfLFkhG4o1/3w+YWTmC/3jMPO9lZbryIokm/D2kWrN9DvJCfGb?=
 =?us-ascii?Q?C2MVTCqZeVjJSUNSffBbjVTvaB+4jRSXFDcxu8jU8ocYvxOtpOe7RbFmaBFT?=
 =?us-ascii?Q?6TCdAnO9Wg09soAX30mD6ehqDdfsodRmg3qIHNVDlDfP5BEhmkvyHqYgbMcW?=
 =?us-ascii?Q?9wvD1lZkceQ1OMXVwYGCT5YSwS9qJ/p3OsJP4G7oLhSjILOEHZtgRmgdanS2?=
 =?us-ascii?Q?kUQvB7nZaUgn5vuXXdBXvFmNkgdIK1hgRdY8KISbZKosktU7AE+418VtgSaN?=
 =?us-ascii?Q?ASEljCKEM1sf9AFzT/6c7Do80rljZSn9Z1BtMsKXA2IYWI59yRSkvn1xMSOX?=
 =?us-ascii?Q?zeJylQgJeF9lfPj9OpuoFyhoZqQ2Brwm99D23O7x9Z4tw23Dn2K972O8wDo6?=
 =?us-ascii?Q?vBOH6O7PKbPLeV2ZGJp6jiD+vWx2rtiqKU8+o/e89aYPSfiCW3Tfbqprdnda?=
 =?us-ascii?Q?sCH9I63QxaSzTQl9guSQ9PYQ5SLy6C08lSCpt6U07L91PCchclix3GINesxt?=
 =?us-ascii?Q?99WG9KDOy80nAqmz0JKEnrudfowZyU3wE+DOS49577DZO0vgRSjffZdRXmcH?=
 =?us-ascii?Q?COgS+MAeFS7TlB+Ton9sw0HG2JqOcYUVEnt0qAkdBH6pqgIG3UK6+aE8HBnT?=
 =?us-ascii?Q?VK5QbnOEAm88tHCaa5Ef9ZcTbihY8zHyW4cQGqYNllTLPApqVWl21zAcToK0?=
 =?us-ascii?Q?DQnfVNPTQuGi8ewkjVriEMg2niQ5dpAbWBVigwtwMubdpwqdnHBlhWx3wPDK?=
 =?us-ascii?Q?m0o0JKQRDPNwJHLo0cdO39r6GmWtiGpY?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5613.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?IJfnI4N/FHc0SPC30pmuAkNVab83aR41TfmQykkzKtDR1AY4tSR15J6LIXC0?=
 =?us-ascii?Q?ocB2a0NQCodZUfLl2EoT/oxjvsSBpjI6bnb3cye+5im/cl3cfXuDYx7VBo/9?=
 =?us-ascii?Q?GkyAJFHaeD+AcCN6fiLzMTzfJFnWSohhvNLzE45q6ZNeGHxXl4qwlAgcYqqD?=
 =?us-ascii?Q?npInXTYBFFtesYM+0EZ1A59D8Elwd2MXam2l8bE87FjWbyp8pQWx9IZA8xLo?=
 =?us-ascii?Q?4NWknZDORKWEFktivIRYm7dXRKmISQG5gTfFA2flucnOikBqyOLAd61CPWC0?=
 =?us-ascii?Q?OwDhrj9dSjs9XL7kMIHA4dFMllri3van9GDRrDRZyJJd925LoR8E339jM7f4?=
 =?us-ascii?Q?0Ew+83xg9EOLpqpSUruGWDq+MC/dmLexpZeuqmZUJsiIgeIgUTF2N2NnKi0B?=
 =?us-ascii?Q?K6sXsBY7SS/J/VSNlEHUvj5R061OSClA6bJ8NJ8AakbIbG4s3yfdSZMmHOHJ?=
 =?us-ascii?Q?sZEippsoIhMe5+UiIeGruahrGwpnWm9YjjQkwbAmQ+rFHlWgumxU48Pm34rI?=
 =?us-ascii?Q?Z8Kp7myTM668x3rYnhK9+66b17cnzmVIYfwQX4h6Z9+KgATZzQR5SnNe4b87?=
 =?us-ascii?Q?3KeyjQKk4SLQugFshQy79ysgkxNfhZP8RGTTx0iGmSsqGlkUum7efzvDTQlA?=
 =?us-ascii?Q?/Is9ySARCSSFoyf2spbvFen1VQxGyJp0TbD/soEyyFBaEXiiKCLgrXY7kJc3?=
 =?us-ascii?Q?BNsIzNv2NtsdtFiXYuY99FBlGah6ZnPG7SomcrrChd6CzSwracb2lVedklNo?=
 =?us-ascii?Q?BUMb40pRR5oEjmNsvCQKRHpmE3qs/qNkLCJejHv6b7Y/AoVWxnqzOcDWEDCB?=
 =?us-ascii?Q?cVXAhRp8R228mepOAXwLz2jRaUbKD4eAN0SsjsM7RTvSbaXrBOcRE4yzIaLA?=
 =?us-ascii?Q?YX2g8o1cshwxeanJ8yiBgal2yEtw63VFO1fwaFoWaBBrTfNww15WceKOm98T?=
 =?us-ascii?Q?0hOC4mzmbv0SIlB8oeVHN0VNrRyXCa4yM4ryeRKGYORlDy4sO6JnjeB3fKe+?=
 =?us-ascii?Q?QcekYi6hKjWeG1N+MsthLqZqWZTyjdBbApG1udUppLCeXg8wMrR++2lfkiIU?=
 =?us-ascii?Q?GHGgu79kBmP3r0zQsc8NLCPPlPAMhcHrW9ZSuq39hgxqcnp+HENnyBH1JqAx?=
 =?us-ascii?Q?XH4I9o217LonE/lIjTc57ASk3/0m8s0nf8YlNSm4Q148JNjMH9BoKSEErokT?=
 =?us-ascii?Q?T0TSijumdWnXq2Qnn/Wi8l0SqkkkhSfRpW5RJVh+ZIcfmQK9dbFVaWW3oiOH?=
 =?us-ascii?Q?MO9rUuUnwZH4U47lJgjmW6hnzcbLwDN8iMAKWQdjDFrqNoAjqLYC9aVQbzU9?=
 =?us-ascii?Q?NS8nwRsmsbjVLv5lsQYzjPLu4yYsnacdVwtw/dxA7RIpBeDVfYZnRY4dsMFN?=
 =?us-ascii?Q?nlfM06ZGOP9UmVGxy0JRebonhVCXMzCLF4HYyAR9mpRNpMrotzYLExXBwel3?=
 =?us-ascii?Q?6ocDihVBXY6jEywJNztyuRa9EiESGsCZui53wWz2wq7BiFazQo3dGtQGz5FI?=
 =?us-ascii?Q?TH78F5p8ysGgti8bGMhKO0tUy5IhdOnFf0TFqWzk4bOr/EIU4B2XB6xPKmUp?=
 =?us-ascii?Q?uXHECuDnaZKsdRCNQ+BIuFlooGrr+XrTt9iuBGML?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cada3d9f-2990-4310-8aa5-08dd5568807a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5613.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 06:49:07.8425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7qmxFCEjwzVg/kqUHxcwgvU+PJoyQmA2n/rOO5ZEHuhAcMi2i0z46rqbVeOdJqhkwjDjCNkKQDd6B82nV8Qc6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8829
X-Proofpoint-ORIG-GUID: LDyOv1LmE5ljjZLqKN8Yh6NxFMNWmhdI
X-Proofpoint-GUID: LDyOv1LmE5ljjZLqKN8Yh6NxFMNWmhdI
X-Authority-Analysis: v=2.4 cv=U+ZoDfru c=1 sm=1 tr=0 ts=67bd67ee cx=c_pps a=mXs27GP3B2XOU+bPH1EGlQ==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=T2h4t0Lz3GQA:10 a=t7CeM3EgAAAA:8 a=pXojlrJOueeHKX4IJ5IA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_02,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 impostorscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502100000
 definitions=main-2502250043
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Feb 2025 06:49:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17298

From: Chen Qi <Qi.Chen@windriver.com>

The non-greedy modifier suffix ? is not necessary here because } is
not in the character set [a-zA-Z0-9\-_+./~:].

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 bitbake/lib/bb/data_smart.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index 5412596566..922d3f5b1a 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -31,7 +31,7 @@ logger = logging.getLogger("BitBake.Data")
 
 __setvar_keyword__ = [":append", ":prepend", ":remove"]
 __setvar_regexp__ = re.compile(r'(?P<base>.*?)(?P<keyword>:append|:prepend|:remove)(:(?P<add>[^A-Z]*))?$')
-__expand_var_regexp__ = re.compile(r"\${[a-zA-Z0-9\-_+./~:]+?}")
+__expand_var_regexp__ = re.compile(r"\${[a-zA-Z0-9\-_+./~:]+}")
 __expand_python_regexp__ = re.compile(r"\${@(?:{.*?}|.)+?}")
 __whitespace_split__ = re.compile(r'(\s)')
 __override_regexp__ = re.compile(r'[a-z0-9]+')
-- 
2.25.1


