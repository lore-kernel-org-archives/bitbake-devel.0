Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E41CCFA1A
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 05:57:53 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7007.1762927072556386978
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Nov 2025 21:57:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=GnbYY7jL;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=3411dc7477=qi.chen@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC4KpLM921727
	for <bitbake-devel@lists.openembedded.org>; Tue, 11 Nov 2025 21:57:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=liPv3EN2N
	J0OHI3xL9isJr3z/+ZUT43/L0YQJ6CzIOc=; b=GnbYY7jLJsuNJxK0TfG84hQ4N
	ndaJnrIcWqf8tr8Z6SAYoJy9ko6SdnUphPjBEDSwd9vKJ1+NOuZNpzNO5HXNaRvH
	WNf3qZ29mtVJRI37aE+V+Nt4Kgb/8YyWvYHpXWGV5EAS7IYBnrRrRlC1J62EAbh0
	uJGb1fcX83ttaAyFxXMKVjeLSh6XL5Y1NGafbvwm8TWMV8LmHsZwQ8Uf9qMZxSlg
	R1MFR51RMcMAX+Mt6+KwkC7N3BRB4t3dhJ87ojXjTcZLbjo967ScuTAiiugb1qab
	q4zU7jQaFyDOo3NWCMYjAOFQ+2qYHEqHtNt26ql5g5bbob/alr5I/xJh1Wzpw==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013047.outbound.protection.outlook.com [40.93.201.47])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4aa68jm99y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 21:57:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QV6HL3/F0b+126yfRBv4V1duvyXptXfNksTovgIkIbY0J24YnltrtGsGUX19JYh2BLADobrt/s5VAFi4QXexlMznjXqVymOZDNI2VkenebsFJbiJoqglWntolj7G+qi3M0N8N8Rj9+2MAfEDnqEvzSRp3hmxxVlvZCmFV9uojqUOHrI8n0h2LZJKprn4JaFNpWqrH51s7lKXX2uDXumVNihHae57w6V22lLCybbrRIQVSHcipx1sG8nvqJcZkh8zDIE5Tey+3xqjKgdXLZMMERD9o3/Ir26sXtcDCaI4grgTjby7DaPhxWViHIDYR1R8nwGONkd7zfD8V9X7Se4I3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=liPv3EN2NJ0OHI3xL9isJr3z/+ZUT43/L0YQJ6CzIOc=;
 b=JJ5KHmABPEh6vMxqCCVdqU8tjKWxKZTv+sjVvpGKL4zhlhj/7DI6MR3yPRe1MSdvS+PTnJnM6048mTcUM+1kU6Bl8rknMFvZouKElm7ywf0ncqaw0VDNIIVXjfyorIM5qWuXfMO6TdWvfMKy3iOBOEyZBt0ncsQgCi2S6mHaEoxA9pt/YNjDqhWRYXb32w3rCtFToAnrxQfBX2YqjtcTJMwxdj3AopuxwpS/zKSBEexwXcrmftOmdPtw5UixXFDv3ULG/sogUmbs6DyB9IdpV9H9NhIsL6rUH+p1RkknfKD6ZV/ztG0kq8X+HC2pqGvOoN++fCqFhdUy6JkR3Rpnzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by SJ0PR11MB4911.namprd11.prod.outlook.com (2603:10b6:a03:2ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 05:57:49 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 05:57:49 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org
Cc: alex.kanavin@gmail.com, qi.chen@windriver.com
Subject: [bitbake-devel][PATCH] lib/bb/parse/ast.py: treat internal fragment setting as default value
Date: Wed, 12 Nov 2025 13:57:36 +0800
Message-Id: <20251112055736.3078776-1-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0086.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::12) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|SJ0PR11MB4911:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c73f978-354e-4ffb-850b-08de21b068d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?wiBvQkVQACUYXuTsdKb8ycR1xjfXq5NTfu4hFlkAK3KK/5v5O7HGhwOKJb69?=
 =?us-ascii?Q?sUS7vqOQrEBK6pU6pAYtS5xjifQU6ChuV9yWiHo3ZxGmm+O0STKzqSfwMDWE?=
 =?us-ascii?Q?9fEvgN29nEdCRPFusBUAyU3CapwDBZDiuk7fiQl5j6UeyM/MpR/x1q5Ug5eV?=
 =?us-ascii?Q?FzKJxOQuewhdbhgl554mZt3eENABFyK8Nh0jG90S5gTKQ/jwlsQdc0tYXf13?=
 =?us-ascii?Q?HbbSyScZnmanLms+AMmVNV0OnXxWDUYJ4MXpRgdc6+bTLybEqwv1NON0UBJU?=
 =?us-ascii?Q?ouI0SnWPyLNKJ2mBpQ6fgQ7XJUiZ96wtiJjPkWysUJXC3MVlAsVBwrb9k9UH?=
 =?us-ascii?Q?mi5iUac+QZKXh50tBW9jCVPXrewHv8F8kYzcYG8Eo/uNNbeZZTFJG6GNUjqD?=
 =?us-ascii?Q?UZA8pygKmyCrqKvUnD3z3ok3Qw9hgxTh66ESacDss2zfZWAAnivbt1q746Wv?=
 =?us-ascii?Q?RV9IUb2cObAIJC09cls2TsOoVdXJvDk+f6CwLwJZmq4p13U/B6/Xggew7gQP?=
 =?us-ascii?Q?od/mayjXtVBcSGFiW0kqzlS/tlO2qsV//xLgAVv4AD99etuEaL5FukZHAWc8?=
 =?us-ascii?Q?0aOaKvxkIPN3LyPJr4Hap680tEyGbf/K1iVgv90SvT8FmJn3C7CUupR75aQ/?=
 =?us-ascii?Q?G12Rguba2dIGsfiV0G9PD7yb6eqHxb21YAyS6+MA8jbUUqCKyWvzMIWn3A27?=
 =?us-ascii?Q?fTU7HCnkc0eXBmOrlTEff0MrFkWMKPHIesMZxa5DYblf4lR6ZY0Bg0wVENzl?=
 =?us-ascii?Q?q+ExeCFUzs9+XJYiQg7M4nsTXyPHjRRZF/pLtSt32xiMcn1QlltJY7K9dkzG?=
 =?us-ascii?Q?48a8G1gIjgcr7GyU4J1JomxzfXuS71P5AXmlbY9acNN6gGoOLOJUI7bExGGb?=
 =?us-ascii?Q?zB5z1gGXsZiXpGChn53P/BThFl7mD2Sk7tJxNg8HAqL8Po7axpusSI788+NW?=
 =?us-ascii?Q?d+iW6HzBzVA6ZSDHsWEuro10Eizl7g30uJYAMgMN2jjv/I+dtOuLYmhDekkF?=
 =?us-ascii?Q?xfkY0FBLaR8UIg55Ymlnn6z7XvbtAFQr5adx19XFcSIfh/zfIH7jdjdtLMQQ?=
 =?us-ascii?Q?AzfIwkx8miTM5edK9GzQ04i1nop/OPbd2VPSHAYHJQer5ow+3tTWjAym/qk+?=
 =?us-ascii?Q?QZLA+kVdf+ufGiSIFotkHxJXmd229aVUrF0WVzYdJX9cmgZLtXwjIajbTZQu?=
 =?us-ascii?Q?cWD8MdhhzPQ78+1dOjY53zngHVLLOo1480VTBy6WRMuKEBgVe2i77mk4PaJ4?=
 =?us-ascii?Q?MpTpFrBceNPmz+IOUw0lztoBROF5VBM5azOrs+J1GFLpN70+s0EQObaDIaQV?=
 =?us-ascii?Q?73VFqDnZ9TBClxyozxI75KX+tDG266uS9z6vKesbgp98kmMuUOP0a8XDk56g?=
 =?us-ascii?Q?84JGUxFBKE3iMb31/QYRVreEUT3nTcOzMM8kh4Smz0mwwPVeWJi0QHMdHlzs?=
 =?us-ascii?Q?0DgVge4J52dTPZlXk0FF+iulZz8g7PbKx7MQg/dkNPTE7iCDjtQSaoCMejCR?=
 =?us-ascii?Q?/LG574SmPxMRiK5IkqqKA+6U59n0OZn1JCNU?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?HirhfgpLE4vlJgNp6dr7lsCFPag2A8etTz0hZQbgEW1ScW/mI5VucIRJaSU0?=
 =?us-ascii?Q?rqwfUV9/fJhh9YxkbezLlAV/umAE4MY9Q6zRVE6SkFcGhHG7KIF3zOQG+uPo?=
 =?us-ascii?Q?Xgvmr7wDNeUQP1IIgmyuGh1XMXoaNbDdOXF77pmi5SSf/fTdI9E3c5BY22Yc?=
 =?us-ascii?Q?0qqHEdiRrz6pZQPiPMrVW0RMHo4kR7SK/w6074H/DcQfrzZrne3XjaAoTccj?=
 =?us-ascii?Q?8UW6FtwTSJt7bBzDbjYnBK1GgoIS5/MMTpzt6PZhNrJXlO0u+nYC+s4e2BXN?=
 =?us-ascii?Q?mElsj0NgAoe+Btgsr7qc/LK/oX8nyLvixEKwmCGBZl04hO3pAuxygfCFmnow?=
 =?us-ascii?Q?GqeBaITErhfYg5Kv0/2ImzkUWu6T400JXvRKLwgGz/9Sf5pos3grrKARJnS8?=
 =?us-ascii?Q?M+C55pGIl0H5HRGLtcI6xZY7UpG66LFnRqApzOFQ8eSjSTf3elmDIRSnlLFP?=
 =?us-ascii?Q?k7KEVMCvHMjh9U2PS+bWbR+UiHa+ljcjg2Kv0JtgF0pDBHIP/Mh0+FWPvupN?=
 =?us-ascii?Q?ccz9DCOdmMVTRreDu+WI0qg/p6PngUd7UdpYuTClQDnXmuxIBtly8CVy0Qba?=
 =?us-ascii?Q?Y7wThlX8ZyL87da++IeRdsDxX8FEb9niJURo3qDtIUyQNnut+J47wBFSffsu?=
 =?us-ascii?Q?C/dpRrX7l7oEoYMnD3RCh4mLpOz70s0kpe4ftVCI3222FAzR5eqmXBLXjS8n?=
 =?us-ascii?Q?1Nk9UZ8e4P0LSpDR7ChPvUFWwLeCbilf0AjonrPwRchYpB21wuV+rOAPe/5Y?=
 =?us-ascii?Q?E8wTOcA54Rpxk9/QEEaTCBGgo5n3NT2ZkyLGPX6rv0GsLFEp8Q+7Lc5cU607?=
 =?us-ascii?Q?ucz49IqxiNH+9Rjr/0ROtfsiMaQ7vH/XEWjds8KUIdgAq77LWdf1FHFs/Ang?=
 =?us-ascii?Q?0nXdru4ewUYCGrM8CBcJDxef6AopFGZ/sqIxeRRSxp3MeAS+NGDX+L3XUtw9?=
 =?us-ascii?Q?S8zGZutXidJKogfgU2KPG+NH0DEB7T4hvesPIzrdfNNsDpp2RAr3A432Aiw/?=
 =?us-ascii?Q?ldpIejYQgjQVRWXVDhiNgeIhRoubJuJmFVhCaxe5aElrr0NowumuBTDQV3kI?=
 =?us-ascii?Q?RdwfhOLzjvIu56uW3XHGZipgxl/K8yo8WTo8WpEzwMpod+D/QR0RCb9qJMUI?=
 =?us-ascii?Q?wMXwPL8HorSfhjind/Aw2PK1fsWuIl3nwSPQM3GQG2Uc4WtX6818M828nLqD?=
 =?us-ascii?Q?ZDgO3mOpojVjrvZZBqmyjHJ/vK0ZvmEKFXZGCUy3lYCMf6qiuPcQzXkoOfpU?=
 =?us-ascii?Q?1zIJ8gq8rXXuwln+v1tbfkjqrKliepgCZHIBGGXkXNpHrr52kedVMshRbDgl?=
 =?us-ascii?Q?fbNXNiAkXPjgsLnFAFyLNIdV31NBL+AIN++JC4Ll06TiPVuXap02hcqAZdO9?=
 =?us-ascii?Q?UHQfY9/F09Up6L1p60TYob4YYkzKDLi+h5ZgFdNP1FHTLoWi61yH4uaBPWC3?=
 =?us-ascii?Q?OTkEZdoHEgWphi8pxYx79FevKRyGLt5mCm6t0tnwzT6yxTsFxfq7Gf7cajm/?=
 =?us-ascii?Q?i1ekpMMbUBxN0YfSRK2hBK+QEp6GvsjSORPGCO2XGj8vEgKWz4eDZNoYeGuV?=
 =?us-ascii?Q?y9i6IkpX2I7z2WUx3U0Eth5iGgIHBd/35F0i3pUN?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c73f978-354e-4ffb-850b-08de21b068d7
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 05:57:49.3680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P41dezLM4N9fJUjJkcrPRp13ekpj/ewcp73imE81I0mQWlLlC8XLbEpFabi22ZxwkKV+dO8NNfBoqJfdmG5kbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4911
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA0NCBTYWx0ZWRfXw2Xcn6XoaY5Q
 0Ls9E6y6IL6dl+P8yVw2ddH5ERops34KxceVrfXCwf+g1Sl2HKMQnTSmQiS5r6rv/UoEd3dZ4YW
 vm3t8QmtGQycsacZRk77QQ6oVY/cKu2VDFftwuL4PDSyjDbWfycEvvxJlIyZJDs8WS4AelKRlCl
 9ijk9dj4fAJYA/tLaeA4Yegr1k436+UqyaZy+LICsAFohTxpCSVr2foO3aLhkE286oRlOwzJqgF
 6pXGbf/IW7GXlAiD/KPXlI39dekuhClGa7Shbx6RxfmgRQukZ1BpCtxKFkmuuRfd3Ma85JpeNG5
 tNtz8nkJdTTirGmeZCMrTawaUmmrryflLWAXhxpk6TBrMtQkpVXBYpgVzOyvyGMwJLP6fAHkWiR
 +5+ydWFM/z4Wa4X3GRdS9sgQJ2JxRQ==
X-Proofpoint-GUID: Kz9xJTwfOQfB4j9nd_TDL8GAwtl70tRP
X-Proofpoint-ORIG-GUID: iHAbfXR9edlyiE34dwq4HZrTCl_ZwFUq
X-Authority-Analysis: v=2.4 cv=ef0wvrEH c=1 sm=1 tr=0 ts=691421e0 cx=c_pps
 a=rV7DuXtNeKhYS0+Ag8nf3Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=t7CeM3EgAAAA:8 a=-h4ODiLfa67QOMPSS30A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_02,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120044
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Nov 2025 05:57:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18343

From: Chen Qi <Qi.Chen@windriver.com>

In this way, users can continue to override settings such as MACHINE
via local.conf and env vars with plain '=' setting.

Fixes [YOCTO #16060]

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 lib/bb/parse/ast.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index e6ff1ff76..f9d93aa0f 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -373,7 +373,7 @@ class AddFragmentsNode(AstNode):
                         loginfo["detail"] = f"{value} ({self.fragments_variable} contains \"{fragment}\")"
                         break
                 # parsing=True since we want to emulate X=Y and allow X:override=Z to continue to exist
-                data.setVar(builtin_fragments[prefix], value, parsing=True, **loginfo)
+                data.setVarFlag(builtin_fragments[prefix], '_defaultval', value, parsing=True, **loginfo)
                 return True
             return False
 
-- 
2.34.1


