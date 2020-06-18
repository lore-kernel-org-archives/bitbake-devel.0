Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.92.89.78])
 by mx.groups.io with SMTP id smtpd.web10.1555.1592507782289222465
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Jun 2020 12:16:22 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@outlook.com header.s=selector1 header.b=aq4SVzT9;
 spf=pass (domain: outlook.com, ip: 40.92.89.78, mailfrom: kweihmann@outlook.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PbrOuWTeMbAwoYxQ3Ar+M1Vl6aiB8wLX8kAzfXfRSim9oKxbjwiHpqLOgmSvIYl2GvIOvLc7tKqsAOqhwO4kDqkTLS+GXcyITgNMooDcYwyvfhwbdX2ru/c0XGGr3Rm2Vhms6sxCWYaLlJHeusIGwb2LExzChsemD+hYbkU3G09fZlP3O0S0B3K8RT4lNs2Nv4nC9hHIXgBePB1pDNg6BOLcA8+bUZmcwNyi03VkBHv3LVDBytD1yyb0W4fUsyccBiitdRlkBniwb6b41vLKGE9usRo893aP0+79OUdsy3TtRI7NuWSd5hmBbZboohJYX9qk6sk8RcG5TawuIVpxXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/WCmXhrkcRycQpf7n94pn21n/NEBvydsYZzLjy6fcg=;
 b=Cud4gdkc6cLsrcTdLAbfsVG9e4/SojUo5SBrOTAIfa+PUo6TsHWg35sEzFj0Ffs9K3WBTfKqk8DOXrcTglLZnoqx1iUmzM2pkK58iFRS5QglxMKtqSQrciRja1GQwrxNrPM258ICaY/cn9v8nGEwKtQLm74ynPyXDFs8iLglNwnWfqqn4M3cTfB5bXmX4iV+8yVv86rqONoGZMbjE3LHYJIwbWmoT4V3y8khvKLxHJlmqRkwF85tG6X/Isv7bqoZIzJOn01e8KQtI8+DknuyUopyVNcUBoiDRbiZXnVB54RdZ83Dm4WhkSMnL/hgpu5UsVf50uC05Ue7oZFRI11a+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/WCmXhrkcRycQpf7n94pn21n/NEBvydsYZzLjy6fcg=;
 b=aq4SVzT9gwJljK9bCAAtH+kq2c44sBHvTnS1Yf3EYKA/AD+4UVAne6m46m7WHuUiNRZablFAkJW0T5g0IvSA9fwOHbnYauERT6jWs8vhHMttubEhIsDxb6V5y/CiRmNGQRHvH8U8plMgeTotuUuffPRMWZDVUgtyUOs+EI2LHZYPLTELGkMKIOeAgeay4Wa8mBG5SPMWF8++Ol8I1uyT17/HpSgbtbkxK/V1vteUsSSwFBMuSErMaWKIeSFNTflLhR2FTio5aL91feuLt+dWrQ76mMjF3nGh4p16J9EDAkeVW5XDQgft5utyDl2Iji7zHZyI6GwK4EB45vtStFsssw==
Received: from VI1EUR05FT043.eop-eur05.prod.protection.outlook.com
 (2a01:111:e400:fc12::47) by
 VI1EUR05HT257.eop-eur05.prod.protection.outlook.com (2a01:111:e400:fc12::418)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 19:16:20 +0000
Received: from AM7PR05MB6881.eurprd05.prod.outlook.com
 (2a01:111:e400:fc12::4f) by VI1EUR05FT043.mail.protection.outlook.com
 (2a01:111:e400:fc12::351) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend
 Transport; Thu, 18 Jun 2020 19:16:20 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:4EF886A5B6D8B3235DBD1AD73FD119839F024C97E5C406F28FE399E93C83CDE0;UpperCasedChecksum:03B551F9B60999708644ACE115D1FC5976B389FD4517D038008DE23C2EA1DE4A;SizeAsReceived:7532;Count:49
Received: from AM7PR05MB6881.eurprd05.prod.outlook.com
 ([fe80::2c81:794e:63ae:e722]) by AM7PR05MB6881.eurprd05.prod.outlook.com
 ([fe80::2c81:794e:63ae:e722%5]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 19:16:20 +0000
From: "Konrad Weihmann" <kweihmann@outlook.com>
To: bitbake-devel@lists.openembedded.org
CC: Konrad Weihmann <kweihmann@outlook.com>
Subject: [PATCH v3 2/2] bitbake-user-manual: add BBFILES_DYNAMIC
Date: Thu, 18 Jun 2020 21:15:53 +0200
Message-ID: <AM7PR05MB688115C537E8320F1079FD3DA89B0@AM7PR05MB6881.eurprd05.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200618191553.32023-1-kweihmann@outlook.com>
References: <20200618191553.32023-1-kweihmann@outlook.com>
X-ClientProxiedBy: AM6P194CA0066.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:84::43) To AM7PR05MB6881.eurprd05.prod.outlook.com
 (2603:10a6:20b:1a9::19)
Return-Path: kweihmann@outlook.com
X-Microsoft-Original-Message-ID: <20200618191553.32023-2-kweihmann@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ICKE-EDGE.fritz.box (79.215.3.204) by AM6P194CA0066.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:84::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Thu, 18 Jun 2020 19:16:19 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200618191553.32023-2-kweihmann@outlook.com>
X-TMN: [ApRskjMhXHslZ6Oz/if+NUd6gnJ/F7aG]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 49
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: e3df46e6-eaeb-43fb-ad6b-08d813bc150d
X-MS-Exchange-SLBlob-MailProps: 
	NS9Gj58uCj3dMAbMr3beVc3lTrrQ91IaVRW4ACPuToyFEefnlOVEgdFtGGBfyVRO3A63k6SzRi91nBCvH3c3reyHRCsW7S/PDCgg1pEuc4Z+QpXfiUxW4J+h+rq+b2XJX+swK/M2oAtBVFRRBQNYY3MBrsjQqGOEdVGjHanvrywokQX8ljpSrO2WEccJdXpcTn0XjRCEognKgvdFWkTvdfCTYsD53pK7FjxiqfhReaAKWwNzrVg8K0BxcN/+qu5FZt4EN5tHe98TbOMoiSxewQ7hQ90gLNTuS9cte1rVlXaZoHdKhR92I8tghQ9WRE7aQbVPjXamYvkmD09cGOzNefnOmVnFITEuiA2VJsUPriLrB+Vuw+7kzfrSRMYHXv0/nKFR0esTFhJscqFaHdkqAsjzG11HlAxY1Dr1b5XLsqqD/1S2V+oW5p3XuuTFZYQgB6FzuoJ6AL9D041fRwrrz2Nqs2uNv3Z0EAEIcnxiPlXyMIdzhzi6cTRH3ov5RZzSV0g0kZz1MvmtADVoPi0ulPy2+LKtVVYm0+8PetiBifGaw2tecYRsNJSbBp95IYHekCTL7MyydDgcTbGudXsWIimPDYZPFgH5KAWQb6Z9UB4iZNSHckt/+V7tAOPC7A5p2zwDTPDhH29Ga7OB8f8mINHKgvBhP1MT1qs4BFndPsH9qIO6VAxIpbseDx0rTHaTiz81ChpeCi423InKCXbBzg==
X-MS-TrafficTypeDiagnostic: VI1EUR05HT257:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	XTimt8CKUO/bhUMGlab2oP3PhSMxBwkosIupTutLdL0mbR7rGxDqaoYCdOUfxsdMORqi3glR3UjmH0jSADN2x8TBFSscnUr78sfmHvBwclH0oHQIFONL6FHEzMG/duPGuwN3NPOVhBts1Dbs6ULFauSc5WXlBgMzMmveaPkiZhqjX2rNAaNGwRWwB/0BPVnZi92xgnmXrtM9qdV+LMlniw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR05MB6881.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: 
	rXKdPhnCs0TTu0eLVxe/TlgFgHj/NQb4gBlTD5SqELaaqGwcE7CrI+F/WhZVkqScjEUhXMhcCbctlvaOpEDa13+DGm1+UeIu3uiK5erzPt0CVAXOtIM23RuphQD+SY/IzJnHsuw+grgHh07CoUSAZQ==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3df46e6-eaeb-43fb-ad6b-08d813bc150d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 19:16:20.3272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1EUR05HT257
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

- add missing entry for BBFILES_DYNAMIC, backported
  from poky
- add description for the new inverse mode

Signed-off-by: Konrad Weihmann <kweihmann@outlook.com>
---
 .../bitbake-user-manual-ref-variables.xml     | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml =
b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml
index c4bd1f25..4c29b246 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml
@@ -1124,6 +1124,67 @@
             </glossdef>
         </glossentry>
=20
+        <glossentry id=3D'var-BBFILES_DYNAMIC'><glossterm>BBFILES_DYNAMIC<=
/glossterm>
+            <info>
+                BBFILES_DYNAMIC[doc] =3D "Activates content depending on p=
resence of identified layers."
+            </info>
+            <glossdef>
+                <para role=3D"glossdeffirst">
+                    Activates content depending on presence of identified =
layers.
+                    You identify the layers by the collections that the la=
yers
+                    define.
+                </para>
+
+                <para>
+                    Use the <filename>BBFILES_DYNAMIC</filename> variable =
to
+                    avoid <filename>.bbappend</filename> files whose
+                    corresponding <filename>.bb</filename> file is in a la=
yer
+                    that attempts to modify other layers through
+                    <filename>.bbappend</filename> but does not want to
+                    introduce a hard dependency on those other layers.
+                </para>
+
+                <para>
+                    Additionally you can prefix the rule with "!" to add=20
+                    <filename>.bbappend</filename> and <filename>.bb</file=
name> files
+                    in case a layer is not present.
+                    Use this avoid hard dependency on those other layers.
+                </para>
+
+                <para>
+                    Use the following form for
+                    <filename>BBFILES_DYNAMIC</filename>:
+                    <literallayout class=3D'monospaced'>
+                        <replaceable>collection_name</replaceable>:<replac=
eable>filename_pattern</replaceable>
+                    </literallayout>
+                    The following example identifies two collection names =
and
+                    two filename patterns:
+                    <literallayout class=3D'monospaced'>
+                        BBFILES_DYNAMIC +=3D "\
+                            clang-layer:${LAYERDIR}/bbappends/meta-clang/*=
/*/*.bbappend \
+                            core:${LAYERDIR}/bbappends/openembedded-core/m=
eta/*/*/*.bbappend \
+                        "
+                    </literallayout>
+                    When the collection name is prefixed with "!" it will =
add the file pattern in case
+                    the layer is absent:
+                    <literallayout class=3D'monospaced'>
+                        BBFILES_DYNAMIC +=3D "\
+                            !clang-layer:${LAYERDIR}/backfill/meta-clang/*=
/*/*.bb \
+                        "
+                    </literallayout>
+                   =20
+                    This next example shows an error message that occurs
+                    because invalid entries are found, which cause parsing=
 to
+                    abort:
+                    <literallayout class=3D'monospaced'>
+                    ERROR: BBFILES_DYNAMIC entries must be of the form {!}=
&lt;collection name&gt;:&lt;filename pattern&gt;, not:
+                        /work/my-layer/bbappends/meta-security-isafw/*/*/*=
.bbappend
+                        /work/my-layer/bbappends/openembedded-core/meta/*/=
*/*.bbappend
+                    </literallayout>
+                </para>
+            </glossdef>
+        </glossentry>
+
         <glossentry id=3D'var-bb-BBINCLUDED'><glossterm>BBINCLUDED</glosst=
erm>
             <glossdef>
                 <para>
--=20
2.20.1

