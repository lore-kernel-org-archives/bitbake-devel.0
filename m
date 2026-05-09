Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA23ACD3447
	for <webhook@archiver.kernel.org>; Sat,  9 May 2026 05:30:29 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6866.1778304619872140219
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 08 May 2026 22:30:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=S5V6r3oS;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=95895a8adf=qi.chen@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 649501cl2311771
	for <bitbake-devel@lists.openembedded.org>; Sat, 9 May 2026 05:30:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=r44IPJCB3w0cNbc3A6UowOAOk7GCrQKZu5/4ohDoj+I=; b=
	S5V6r3oSaXgL7UCMPU7YXEaemOKSFGu/WxbfkrPXQN78dGydSeO7fwutGYmtwyRd
	XiMOHibbVlR/QuULqv0fesbJQkPd2ro1kMJLKNmvZsXQpTnpAxSC54x5LGtrKRfk
	A7CC4PCxg8QO/QwpF8URflhH8hc8uY3HLNn1dFN80H+pu8Yi1uz/3iXTEZoCbddi
	r6ADrzZMhkYIvnSrJjMaKs9yxBivkVSe+yxf9z2jyatpNSZFEQksj5sJFT+T+oyA
	LtSV+A1b3711mSpPbKIsmh6R3XySYpnsvIJnarKWUbeILw+vVGbZpgYdi/hyWg64
	Vtn3k0sJwdNxLj6oAp1g6A==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012068.outbound.protection.outlook.com [40.107.200.68])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e1uw6g3xe-4
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 09 May 2026 05:30:18 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YQ1ILq28hudiA860zSexAa/9qIby6naXx7F8j0NkiQ/6qpQVDUhOzd9kikYBY3FmW25H+KZzC/Mr1xLMzbEm9ae715syIx6zb0Qt+yYsMzxCqJq5SUUOpAu75qWabZfKuKtZN2nfcpIKtXdQnloWXdNPQknLUV6oViiup5dN18oMdM8EgwPfOduwA5IGBT63NXKV2YW76YPfMjAcXjEVz+NQk1GhoNg1j6e1dv183mtuLv0I3HCDtj8gcMgmo5tmWzj0lhBN77VWBXdW4zQKDCeJsM7+nNygQM4mQf4eL5W70ErM3F5vxIrLXLNGNVXAH7cOmAomHGajwFxSegSVew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r44IPJCB3w0cNbc3A6UowOAOk7GCrQKZu5/4ohDoj+I=;
 b=FTZlhv4dHmE76bqPgp529guDYf8S16nvLmEIepuXaAghE1YqtXIQHS2RGljl6DFeFEShbnFvVClLk7UCw1EpbgFGOKpKPQHOa5SFYfw9fMt/SPkOTzEC2q/+9kwkM2ihBV+kqsjngKRZOaDvZ9WjkBQzuruBice4HrAxosU6cs4HaPk4ZZUbblIF14TVpYjOpmK/0ss/4XRQPxWCrPBeynAJYhOwiYYUdw8GLr7TFO+XdzBKtLHr+q9u02+0X1k52gIU3ZvySf/mwh6t6HbymRA4mSWG2g5fiUILIJdI5toPMz8Qc4o5ccapT+WHMoAOa2buKOGzocW4c2b7nH7LFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by CH3PR11MB8657.namprd11.prod.outlook.com (2603:10b6:610:1ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Sat, 9 May
 2026 05:30:15 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%3]) with mapi id 15.20.9891.019; Sat, 9 May 2026
 05:30:15 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [bitbake-devel][PATCH V3 4/5] fetch2/__init__.py: add filter_regex to default latest_versionstring
Date: Sat,  9 May 2026 13:29:49 +0800
Message-Id: <20260509052950.1565384-4-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260509052950.1565384-1-Qi.Chen@windriver.com>
References: <20260509052950.1565384-1-Qi.Chen@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0087.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::18) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|CH3PR11MB8657:EE_
X-MS-Office365-Filtering-Correlation-Id: 468d6e70-0a04-4043-e970-08dead8c0c3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014|56012099003|18002099003|22082099003|3023799003;
X-Microsoft-Antispam-Message-Info: 
	4fVAs9eqeRFaTjeO/cIM88Sn2RXYy9b+BMziRF49hwP4CWE/eGywYdM+D8gfKRTfBmb5/WTwjnhQOnDUbg0xBxS4OWOEp+l7FpPt/wt2lus90t9vDVDEgYfr4ATpKqBLFdDzDVHJ8TKG91J+fcARVChgF6lfo6cJY2Mphs0T3ASQe/UjJ0Nh7/ITxB9BGHgZ/VA4S0VRtE6PjK3EK8frS0rNBRamMpHnCmie6/fzdZ9bF/ZOeouWGfv193DNSOaf4AMqbVjX14gi9uIakm+q6T5+k4JmskYaigTCZGIFxKpEprMCcbFPIE4lIuDLWov+b2fzdZeQK3lev74yN23mKXkooZ1VKg3SB/qMDffaX/B49djuSyblngaUU5aIH1rMN81Zi5X5Z5CAKvT0djfGwJtVsuG80AkGxbbz5d1hvZHz3TtkoGosSb6k+H9vaLqq8142gJQaE9ncxpZW4nDhVx5XBD5FzPpn43JPEs1r8+3DeVFH7XTG2brEzKGhXn7eKQdvgzfb3kq7oAvo7gyfkSsyXmlgBgfTfGakeAKcR84nO6Cc5DwUnnmGW4+mmqfYZsVZLbpBFbkozG2NRJyGg85dpvrnzgab6zoV/YUDGclIy9IzYTe3QmCD0/SoDfdu72M4B2qSG9aCl63+z/Vf/SjQaoirkqZccSnUWUMTKakhCG6A2ZLYEqtc2lPIydkk98RUVnnRpvjk3gB2DqKtkOZJP6IeUeBvpMkdlzoOzxWIBvPD/Y6z9z6NSSMNHv6q
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014)(56012099003)(18002099003)(22082099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?0IlGGG3brLR7tUKDeMlQAaYWnT4VpB21fcULSxE/5/KPhzZ+05YRzTAykmQI?=
 =?us-ascii?Q?fIGbgI7+zx9xsHzTkwll2xE1fM2c+DTR4pPszK6W7wwutJtrB0RXHnyYRItq?=
 =?us-ascii?Q?wJwlkOijF8z5+Mv0ui1GReu2Fm6+QCJQQ/Jb/VbCy8bZGOpopffJafLCdJmf?=
 =?us-ascii?Q?LuEr2nXCBsytg6KJTx6sM3CBaozG3t2sNIYL5QKAqs9NL+nQKKiDeOUP0jaj?=
 =?us-ascii?Q?hGuQhWW4VsHu6XkkYVGHGJe/gV1PZzVyqwS1KhSEaDcc59lckjc/4MERW7w+?=
 =?us-ascii?Q?KM8+su3oNh+4S5OWykAvnLWEGKPbNIoqr2UnOe5C3duqMzN3XQ4RKoDVtwxH?=
 =?us-ascii?Q?MRw4PYQdTG1UnSmIsSMgOZzfsowB0CU9kMVL6AvrlRLccoIWF2ody7+cMirn?=
 =?us-ascii?Q?xxrv39ClQApZP7GT903CnF3NEOV3KKLrXKw/R6gl0nxcgUnc5N6O8nkxqcjn?=
 =?us-ascii?Q?5MwSSrAPNSRVQrqe/9VYCPa9iHAnqhNzgxuYLfvalirchSzyLkaK6+1dVpmt?=
 =?us-ascii?Q?gca7qsmTmub4LHholjHjtPoJjOomDW5sCtKE3CRARd0wiTVEp78uoMa61//o?=
 =?us-ascii?Q?6LRuGp8Fn/rLWbgCh4kgPIxfQq7vDy18ksOmxGpfAFjgLezhWYZwm2T4zkGb?=
 =?us-ascii?Q?Yhk3ykr+FDsD7j91FRwsgJMjtSA8SETuBlN2mqcCwhBMcHunG0JbOUYTCjvY?=
 =?us-ascii?Q?9IXN8SaOAJko8sbW2p+LnJkTFpW9wxm4Eo5rBPWwZh7SzoDq+s1TSFz2TWGD?=
 =?us-ascii?Q?IadB+IO26gI8N2XJCY3CYHQfvwe56mrymPdvlbQNmNUu0JyZx/bb0uknyb3a?=
 =?us-ascii?Q?B1pwP3PcMxxQYd7D1gYd2DRbVVB3U+jEho+vgI+mbaybCEiUif8KlQMlnqlo?=
 =?us-ascii?Q?4OtwUqEKpcfXH7IGwYYYBpKuaB7Zbesehi+yt7UqsbK6LMGSPYsL0DSrvcyF?=
 =?us-ascii?Q?EVRQ1/6xoJEHOay0VqbOcqjOhzHG6KTnq+nfXjD4u95hMFStwzdVzoHLf3+0?=
 =?us-ascii?Q?ywDZ2YouskVDDcaJjLwAfGQ2LL+eSWLC9EWGtlNq3VTLYkBOjfoB0l8QlUzL?=
 =?us-ascii?Q?M4aqXrDFb8s/HBs64VjXhpCQ7G5yvcmMyrcbjN9Sa2PL3Fmb5fNpt9xd79qr?=
 =?us-ascii?Q?m06RsshVRdFiyahL2HKSE1GW/TrfDULbgmHvE2DzH9RL4spB906cPhUSgsjp?=
 =?us-ascii?Q?j2uRqLbNuxqJue3xY7+bngkIAIeDLsQUKM4WnlGVYiHN3Fp33T7zKIixUXAI?=
 =?us-ascii?Q?/PW/eYLAa2dMWsyfvIN4fy9CfTv0b8f9ALM2johd7Dv060lZ7jOzw6N/x7UM?=
 =?us-ascii?Q?ocE49QL/w+DjWlLUDFLRajmLRsBfpeO/A/ys9ziDXIqkdGzjU+ctqf132TN5?=
 =?us-ascii?Q?5s0un7V8OwPWJamY9njPtjf18+/G6EaorcdIWU7M6Ti3auKw0rQyzLqcOkIm?=
 =?us-ascii?Q?0ng0lPnMFfhO8mepXp7V1UpzGiZctEsd/hKB+fxawlkyspxbuscmCffiKuyk?=
 =?us-ascii?Q?sQjALR0atIGpqlV49+il7n+KZOsGZPKlOKhouzAB748meWDOaXuhIgAXwBTO?=
 =?us-ascii?Q?92jelpJYMzVj1deiDDbHjiVcrxvQqj+yvA+Wcn/xRJBOVG/GOU8Lr3PX6JAT?=
 =?us-ascii?Q?2/mo3m3Q0K4KnBeqqod8H+sXhl1Nah8ZbACBHkTLRoTou2rzf7fcaVTwjMKo?=
 =?us-ascii?Q?DNbuITgOxAUgJ7tzgsdtqs8POP+UtdYkT+fI2SOBIwRPwwGLqCKzLMNQASJX?=
 =?us-ascii?Q?urslsznWHQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	VQ0PaJMIihIxsOz8j80tTBkg2J6cfpxcQHG1BWen63T1iv/jzZzT5c+IzntV7YCO1TKAAVJL0IsX4gZGiPBDVf65IR9qA8/F8pk8IKVwLpfNsERSw6zfOk3DRv/L+wWzdy5ucrAPOB4KlDzXqBSovNDKOfw7Y1m2tPu6bhsQDOC3SpFzE6CDaEb+8RW+BVSh/StSzVQ4nlZSw5GQZal2FzGicEM5/fdzTrlSlX8CTppDs0jfM3O7mmxB7TJRV/TD26pvjJUSyvcM/ZS4EjF8aplVFdCS4Nh+kWw+UJbeOCT9g06L5YGM9XvcZaLKSwaGh88HihrwnpDyHr048gBpgA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 468d6e70-0a04-4043-e970-08dead8c0c3b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 05:30:14.7730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b5ENfDRbra8G62fNXZ6Ov1d1O5pc4B9HsLS4swaRTX44M84eh35q9xId42nk+hPdwW+5ucC5m8uzG1Psu0rTrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8657
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDA1NCBTYWx0ZWRfX+UMAcSqDEHp6
 P3iAPafp1YfFnNqRCCGGIMyGQ1vPyQn03lbbc2y9iNkr+xmcK6aadqMbXxl9Zkl6yaiLmctu7vY
 ckB1sLss/JaBnBo5Ix1AuaH63pLo+HwNfaJovfjscN53Mi7w5PP4ajQbJT+U6zCH2pOjAhykOnK
 CKr1Y5zY5jzR/6dxg/tvICIO4NdtMLtxZPHet/4bKBVQcn4ZiwdctT4xAzF014QrSMDxFWPbkDL
 Y3PH3am5ReZjLe1g0VGPQDs/AB5zQi6DMtjwDZmQ9tBxSGSvp603R8RGfxZIaPejxS1ZAP3v1j0
 eqdavqGHD4J7uIgTKVL7q2hIAurRFIL4bsVfQfpKXLzOZya1KvrlAht9iKHxCvbMjMjPy/9xFJi
 04+rg2XPgRrE/jozfMFtHFuNEcgALc/HYIxKoHxP/+shqNe5cN3YOfgiRSCg6hVIBehFj/pG0Eh
 LmByQacMlQ759QTxgVw==
X-Authority-Analysis: v=2.4 cv=d6nFDxjE c=1 sm=1 tr=0 ts=69fec66a cx=c_pps
 a=hdF+edV3qND9tYm1xB2jJw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=OUNPEJzuPeSuI0R0wQsA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: A1K4SCR9IzjrFoglJqoRYxSdx6WsnEVF
X-Proofpoint-ORIG-GUID: feldzT0hI-kG6Sz0lzkABo_-Zp0xCGQq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-09_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605090054
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 09 May 2026 05:30:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19481

From: Chen Qi <Qi.Chen@windriver.com>

Add filter_regex parameter to the default latest_versionstring
function so that fetchers that do not implement this function can also
take the filter_regex parameter.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 52d5556d3..7d1bc11d7 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1724,7 +1724,7 @@ class FetchMethod(object):
     def generate_revision_key(self, ud, d, name):
         return self._revision_key(ud, d, name)
 
-    def latest_versionstring(self, ud, d):
+    def latest_versionstring(self, ud, d, filter_regex=None):
         """
         Compute the latest release name like "x.y.x" in "x.y.x+gitHASH"
         by searching through the tags output of ls-remote, comparing
-- 
2.34.1


