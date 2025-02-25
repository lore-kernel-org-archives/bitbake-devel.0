Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79409C021B2
	for <webhook@archiver.kernel.org>; Tue, 25 Feb 2025 06:49:29 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.2848.1740466160422759926
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Feb 2025 22:49:20 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=41510c6688=qi.chen@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P651Wa019708
	for <bitbake-devel@lists.openembedded.org>; Tue, 25 Feb 2025 06:49:19 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 44y5j8b81e-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 25 Feb 2025 06:49:19 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uc4YGdy90hxQDk6PaSzVMnxmQmJufuDoCAwPUmT7HWRjejabjJ10WxjyUtOO+jYVL4AhsXIUqeQXpwbg+OGKcM9OWEzfAOURmI1yXStlgc3SIPVA3FSNyrC2I4I2Wsx586HYenmPa/i6VWfo2X9ROF8etJJctzxvyb3hgR393cPOUUxu+ltkepdlFdGbZI3S0exwF+cqbdAGGZh3WD7H65AjNJvDVdzfd0pZhnnHksR0S5RUBQy9iF0jCDH7dkIAL9ZYsS0fu2VkJJWZ3PGCrwsD2WC1G4aJx19JErKhY+DflX9PVkuGqgFHoTpScNPCLQ7uGdJ3QIjS/OWR14HbDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHyvdj62eg7llvvqW2d6AsKD4IE/1gPG+kf0yDlaB+o=;
 b=uMMT7sYXG9HPEkVIZqxtQovYa3KHSyrLTEfzetuPwZ7c+DgC/tL81H3fmhJD13sC2SOTeeKTZJkrziZLrilwI242GGiRdqzstOUnooWHxxeg39WXJinAzx/Rhi6Tld2PKSvs57g3oHXyiVKXS40DEko74J/f4Uz9XpKBsiXk/Ids2zTpJlGrmWKezkfOwckXMDEKAeItcbeuFh2MsA6BGzj71nwae9T+DftpJ2vRwRQLrp/rjV3Ls4uXw5f5ILCxq+EqbJxJJWblqmCXBtCVXS0v1gwjU37uPJDjiJPBL2FXFtFTKZ1GG4QFKuZ65UyE+4X4ZATgBjzGVTTZN5TK2w==
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
 06:49:10 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake-devel][PATCH 2/4] data_smart.py: fix indentation
Date: Mon, 24 Feb 2025 22:48:51 -0800
Message-Id: <20250225064853.2406575-2-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250225064853.2406575-1-Qi.Chen@windriver.com>
References: <20250225064853.2406575-1-Qi.Chen@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0113.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::28) To SJ0PR11MB5613.namprd11.prod.outlook.com
 (2603:10b6:a03:3ab::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5613:EE_|IA1PR11MB8829:EE_
X-MS-Office365-Filtering-Correlation-Id: 33d67230-d7df-4a45-95db-08dd556880a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?dbZ1SJUPNLuNo1y0Mj4OQoxz9fE2tC4gkfJdgVCszXDU8Bu+QczESZ8NsVyO?=
 =?us-ascii?Q?S98MLoecOxSCWXipZsIScCK4uc5xTZpdMYRXgAElCT0GnigDztd+TOmMbQuY?=
 =?us-ascii?Q?+Ix9M/RWX/ORhPtZbtP/M1nsjB5klPuyIr+HWkUQeXhVND83pElcVIVGnb2c?=
 =?us-ascii?Q?gw0uTRI1nGdLT/B0DkSfMnhRJZKrjQ/1Wbke40gbCZDUj6oTXcOhOIZwDYfk?=
 =?us-ascii?Q?Fo9aw52vch7zvSVDi+pbFaYUs41BK2/NuWTWoCgJcCBMbruxpwzz22opeKlI?=
 =?us-ascii?Q?NdxJmhigaPJo99ACELKpGm2yZzSE0I80j9xGEI7sJvxINOWBHJIuRDlvggFS?=
 =?us-ascii?Q?UsqPHoiUSJXuUb15yFrPop5koZALUzH3hSYDqMAok1G5Ai8aDxe4MjowIe6n?=
 =?us-ascii?Q?fGN5CB5ldo2OJ+eXv9F4DpxHIijmxQ0ULUql4GsnplgR6gPBfLGzI6EdxpT5?=
 =?us-ascii?Q?B4lIMm4Llf0SkXdUAp6KUf4nkW59LT/Q/MwAaWyGkQa2u08PICztiyo0vgD/?=
 =?us-ascii?Q?/+s1inYfktJbmLgRAYT1hCIftyA5fyfcQ2ZhhiQcEE3ne0yaO/rzxapCEhtV?=
 =?us-ascii?Q?10wsRKwPF/A3GuRYyfQ3E1DsEc3IZ+OukYGTZuaernFThLiepSvpJbvEbrc9?=
 =?us-ascii?Q?g84agBDyOHb+MIHEAmsM0AcYpQhmc8szD5LNYXN2YO/wt+gZ4JFPB0ZBxsZr?=
 =?us-ascii?Q?oxpktS+aO+xxtkCqrHCSd/qGdTnwQnaSwXJsrbinlQcK4NJyDfllH77Y2+Ve?=
 =?us-ascii?Q?d2aoVaWfeZFjPM814YIXQjzacssauZq3dFy/oOnrw9pHPs22EnYv3OpmSiuy?=
 =?us-ascii?Q?uO+eiw+jUNB8+klDvgfsxaWJ3uYwKiCJtTYlylzPWc5dvylRUDP611TosQ20?=
 =?us-ascii?Q?OVY0Fw2VzNtQswqCSWC9jp000uTXJgrN0xqaFIozKz+HSwfjo7TRPf5I4wsB?=
 =?us-ascii?Q?xY0qyJcEyPoCHu82EbZ6/7j9CtSz4TVB279lQdI0eR1r9S50SDx64oW4BHqy?=
 =?us-ascii?Q?4+MhdvIV1zVNv+hZt6tHRYer7I82m1fCBz18he+EsQkox325rOrp124WMyKD?=
 =?us-ascii?Q?LVHVxqfW/+Zy5MfrKdZ2L94DibzcrvzKsCVpFnBI+riTrlz5cKHo1Qo2f6X5?=
 =?us-ascii?Q?HiKuvbBnz4zhAgRHjRsQOCoPMwshAWT7Kc0vu24HMFznzD4p1qcWPQHSfGvp?=
 =?us-ascii?Q?q7t//CBx/5oJa7m/BRRTHAw1vOLDM5rZYNxmeH87vfQ32pZ3UuxAbJPU8KLE?=
 =?us-ascii?Q?Ce93mibeKwGolpKEhTMEZCEnDumwqe+a9SAEYOGiXeJv/o0NYFXoqMq3/sho?=
 =?us-ascii?Q?eRErIgOJa1oXweQtwWH69JGz7Ema7vSYch4RP7S753G8hXJnHc17We7RCs/e?=
 =?us-ascii?Q?6baDOeiE451gDWw7ZxC6DC0+siyojEc56SlI2rO41ArQvHUgEvk4kh7H6Jit?=
 =?us-ascii?Q?uB4QaamvFE/gn4wIGf8Q2SUShYoQuKgT?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5613.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ZM5qCc6li11KSKk+UAkhYvfYZqoSQqeiPG7q3KaoQBuUjkiMBcQrEVn13DyB?=
 =?us-ascii?Q?WLhgigKfwBS3tiGIO0YcX4TIuNBZzQ7E22/PJbg40t9EzKX139l+O0ZQYgJj?=
 =?us-ascii?Q?7S0QOwGvR4GecTidHQvwP6BQrLT0X1Yt7R2YOXRI7UiZv2jpJ4fSfb6n2REl?=
 =?us-ascii?Q?3+tibsDWG+HEsqu6glWaPeI6TbJdOWpy0sMJwrzPHdRt/s/eTgCermlKGNpn?=
 =?us-ascii?Q?3akNENcc4aS5pczvjkRQIE+aKuYpWg0BOpZ+Tbls3L9bwLrUgJench4/3IvP?=
 =?us-ascii?Q?NK9wlqeTzKcb6JkV8CUEfF8ZHUmlPc81RAkTb33XFu01QmHpabL7835/cHao?=
 =?us-ascii?Q?kht8NOOnx9grfczAqAIKNx78pjERtR4bQFszgfT9hJh9wcqXc+9Km7rW/sfE?=
 =?us-ascii?Q?ZEZeZWC4IxB9fPrZOB5o4rhV9bbVb7mmAbGgX/EbvnYowNTByneTkKsXOIU/?=
 =?us-ascii?Q?+2IZUJPq2EXbiF701rWHquHSViZcb4K+8qax8iCXM065mryk7PORXa62V0Qw?=
 =?us-ascii?Q?0Lx5DRHi3NES+XRrKBzvdSf/XFJK5oVbF7WETOKc6S7qsBiNqQcF8HAPkMrg?=
 =?us-ascii?Q?H7zy+1sCPhTCRw34dZau3AuuqYmZm6BhNEiuq1qhr+bf6FP/aLvU//QNmaZL?=
 =?us-ascii?Q?j+cEf9rrmdjVO+8LqtvfgtirQcr0cX2g78+AyZna63c1Cw05yhPCoXc0ysr/?=
 =?us-ascii?Q?6k6YL5OutjezzqRC8oXLEq2vwnpamwUZTWHoDDEwiaRaDPkBBp3lpJlCeCrG?=
 =?us-ascii?Q?a6ZD8DzgXJf5uUsOaRMAemxUQXeepe55KPIXgoNuUnW9sX29YVScGshVYKxp?=
 =?us-ascii?Q?mhlxcfyKdL6T80HMBnYDp1P0JlhpF/OoHDu+bUAPx0mIItRseuy4cjF3jasW?=
 =?us-ascii?Q?X0ORBUREq1QhA3SHIoFACMeETSu2JO/5EYtjdyih5PC0rd4pwgrxQtoxnnxp?=
 =?us-ascii?Q?kW08ZDbiLoi3j/iCLPxCv9HrCDjhi2cGi5moXwB2I2XoJ57KCm4nuAKUvOXL?=
 =?us-ascii?Q?LxAyaaGVzhxc1xZ7JWRdv1pfLZmMkHfPWK9M8FXHsmAwBv0q2TRHj4FFBa0Z?=
 =?us-ascii?Q?cnTyjVyGsGYN9EABFaD3MV0yT/3d4zcCNyhoHRoZ20R4IShvz1kBOK0yu0bC?=
 =?us-ascii?Q?AtP9L+jEirP+sjj6viyZdSp6AHTN2Wgt7jS5DNQ2WbremH1By5DyyM50/StY?=
 =?us-ascii?Q?15/cNAZOKrL7+qy0BvDi6iUgV7ylGQgtQmqMym0B22tj+03PetTzs38PA/Uy?=
 =?us-ascii?Q?DkyqoejWPi3B+aSf+ka0LJp0H6z3opURgcVSXuL40sFYz9mt3rioTP83aG1F?=
 =?us-ascii?Q?eroCVTuaWx80qXs92cKqs4MoK4Hkg7xGFwbna4Ep4rQf9RxwZrJ7p6vjNVJO?=
 =?us-ascii?Q?hxgT8sJHgOkIFLYnKxFQnRaNCxxknrt9A8UquTZliRy52DEtzABjiKp+TBUs?=
 =?us-ascii?Q?xUyY6MXZxSk0qX/6Ppy1CZ0lEj3em7A+jQyKuabsibNq9MB0Pg4fKp74gcWp?=
 =?us-ascii?Q?QXq/nRoNhGpS+yer3XjHUvXOLx/4ISK9Iq0Q5n0w3ALa86B1QVHP+2+aVG7J?=
 =?us-ascii?Q?T2nurn+2BJoKUyg8cJ+p2l5LeRqj0rm0mJOtfuNuhNmJL4hX4OhQJwmKf5Ey?=
 =?us-ascii?Q?Pg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d67230-d7df-4a45-95db-08dd556880a5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5613.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 06:49:08.1845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dLnlaEjIWq7Pfh4dE9L63yUWDQmN04yjVw0SvThQ2jqrlAC7yU6mmeQfos+6LxyFRPjJZIicSJAkGnWJTq35SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8829
X-Proofpoint-ORIG-GUID: Uq8vsTSq_KaOWjuRfqpGEN_cjNjgJhjN
X-Proofpoint-GUID: Uq8vsTSq_KaOWjuRfqpGEN_cjNjgJhjN
X-Authority-Analysis: v=2.4 cv=U+ZoDfru c=1 sm=1 tr=0 ts=67bd67ef cx=c_pps a=mXs27GP3B2XOU+bPH1EGlQ==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=T2h4t0Lz3GQA:10 a=t7CeM3EgAAAA:8 a=Dms5D4AWm9y5Qyzj9lcA:9
 a=JI9UvleF2b_vUXCkrjkF:22 a=FdTzh2GWekK77mhwV6Dw:22
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17299

From: Chen Qi <Qi.Chen@windriver.com>

Fix 8 spaces indentation to be 4 spaces.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 bitbake/lib/bb/data_smart.py | 80 ++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index 922d3f5b1a..fa7ddef74a 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -106,52 +106,52 @@ class VariableParse:
         self.contains = {}
 
     def var_sub(self, match):
-            key = match.group()[2:-1]
-            if self.varname and key:
-                if self.varname == key:
-                    raise Exception("variable %s references itself!" % self.varname)
-            var = self.d.getVarFlag(key, "_content")
-            self.references.add(key)
-            if var is not None:
-                return var
-            else:
-                return match.group()
+        key = match.group()[2:-1]
+        if self.varname and key:
+            if self.varname == key:
+                raise Exception("variable %s references itself!" % self.varname)
+        var = self.d.getVarFlag(key, "_content")
+        self.references.add(key)
+        if var is not None:
+            return var
+        else:
+            return match.group()
 
     def python_sub(self, match):
-            if isinstance(match, str):
-                code = match
-            else:
-                code = match.group()[3:-1]
+        if isinstance(match, str):
+            code = match
+        else:
+            code = match.group()[3:-1]
 
-            # Do not run code that contains one or more unexpanded variables
-            # instead return the code with the characters we removed put back
-            if __expand_var_regexp__.findall(code):
-                return "${@" + code + "}"
+        # Do not run code that contains one or more unexpanded variables
+        # instead return the code with the characters we removed put back
+        if __expand_var_regexp__.findall(code):
+            return "${@" + code + "}"
 
-            if self.varname:
-                varname = 'Var <%s>' % self.varname
-            else:
-                varname = '<expansion>'
-            codeobj = compile(code.strip(), varname, "eval")
-
-            parser = bb.codeparser.PythonParser(self.varname, logger)
-            parser.parse_python(code)
-            if self.varname:
-                vardeps = self.d.getVarFlag(self.varname, "vardeps")
-                if vardeps is None:
-                    parser.log.flush()
-            else:
+        if self.varname:
+            varname = 'Var <%s>' % self.varname
+        else:
+            varname = '<expansion>'
+        codeobj = compile(code.strip(), varname, "eval")
+
+        parser = bb.codeparser.PythonParser(self.varname, logger)
+        parser.parse_python(code)
+        if self.varname:
+            vardeps = self.d.getVarFlag(self.varname, "vardeps")
+            if vardeps is None:
                 parser.log.flush()
-            self.references |= parser.references
-            self.execs |= parser.execs
+        else:
+            parser.log.flush()
+        self.references |= parser.references
+        self.execs |= parser.execs
 
-            for k in parser.contains:
-                if k not in self.contains:
-                    self.contains[k] = parser.contains[k].copy()
-                else:
-                    self.contains[k].update(parser.contains[k])
-            value = utils.better_eval(codeobj, DataContext(self.d), {'d' : self.d})
-            return str(value)
+        for k in parser.contains:
+            if k not in self.contains:
+                self.contains[k] = parser.contains[k].copy()
+            else:
+                self.contains[k].update(parser.contains[k])
+        value = utils.better_eval(codeobj, DataContext(self.d), {'d' : self.d})
+        return str(value)
 
 class DataContext(dict):
     excluded = set([i for i in dir(builtins) if not i.startswith('_')] + ['oe'])
-- 
2.25.1


